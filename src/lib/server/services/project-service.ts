import { SQL, and, asc, desc, eq, inArray, arrayContains } from 'drizzle-orm';
import { db } from '..';
import { invoice, project } from '../schema';
import { omit } from 'remeda';
import type { User } from 'lucia-auth';
import { UserType } from './user-service';
import { ProjectStatus } from '$lib/models';

export class ProjectFilter {
	customer_id?: string;
	pilotId?: string;
	targetUser?: string[];
}

export const getProjectById = async (projectId: number) => {
	const project: any = await db.query.project.findFirst({
		where: (prj, { eq }) => eq(prj.id, projectId)
	});

	if (project) {
		const invoices = await db.query.invoice.findMany({
			where: (inv, { eq }) => eq(inv.projectId, project.id)
		});

		if (invoices) {
			project.resourceIds = invoices.map((i) => i.resourceId);
		}
	}

	project.dateValue = project.time;
	const dateValue = new Date(project.time);

	project.timeValue = {
		hour: dateValue.getHours(),
		minute: dateValue.getMinutes()
	};

	return project;
};

export const createOrUpdateProject = async (model: any) => {
	model.serviceTypes = [];

	await db.transaction(async (tx) => {
		const prj: any = omit(model, ['resourceIds']);
		const result = model.id
			? await tx.update(project).set(prj).where(eq(project.id, model.id)).returning()
			: await tx.insert(project).values(prj).returning({
					id: project.id
			  });

		if (model.id) {
			await tx.delete(invoice).where(eq(invoice.projectId, model.id));
		}

		const resourses = await tx.query.resource.findMany({
			where: (rid) => inArray(rid.id, model.resourceIds)
		});

		const exProj = Array.isArray(result) ? result[0] : result;
		if (exProj) {
			for (const res of resourses) {
				await tx.insert(invoice).values({
					projectId: exProj.id,
					resourceId: res.id,
					price: res.price ?? 0
				});
			}
		}
	});

	return true;
};

export const getProjectList = async (filter?: ProjectFilter, user?: User) => {
	const projects = await db.query.project.findMany({
		where: (usr) => {
			const params: SQL[] = [];

			if (filter?.customer_id) {
				params.push(eq(usr.customerId, filter.customer_id));
			}

			if (filter?.pilotId) {
				params.push(eq(usr.pilotId, filter.pilotId));
			}

			if (filter?.targetUser) {
				params.push(arrayContains(usr.targetUsers, filter.targetUser));
			}

			return and.apply(null, params);
		},
		with: {
			customer: true,
			pilot: true,
			invoices: {
				with: {
					resource: true
				}
			}
		},
		orderBy: [desc(project.id)]
	});

	return projects.map((p) => ({
		...p,
		isTaget: user && p.targetUsers.includes(user.userId)
	}));
};

export const changeProjectStatus = async (
	user: User,
	pid: number,
	status: number,
	userMessage?: string
) => {
	const up = await getProjectById(pid);

	if (!up) {
		return false;
	}

	if (
		user.type === UserType.Admin &&
		![ProjectStatus.AdminReview, ProjectStatus.AdminFinalize].includes(up.status)
	) {
		return false;
	}

	if (user.type === UserType.Mayor && ![ProjectStatus.MunicipalReview].includes(up.status)) {
		return false;
	}

	if (user.type === UserType.Pilot && ![ProjectStatus.PilotReview].includes(up.status)) {
		return false;
	}

	if (
		user.type === UserType.Customer &&
		![ProjectStatus.CustomerPay, ProjectStatus.CustomerEdit].includes(up.status)
	) {
		return false;
	}

	let nextStatus: ProjectStatus | null = null;
	let targetUsers: string[] = [];
	let message: string | null = null;

	if (user.type === UserType.Admin && up.status === ProjectStatus.AdminReview) {
		nextStatus = status === 1 ? ProjectStatus.MunicipalReview : ProjectStatus.CustomerEdit;
		targetUsers = status === 1 ? [`@${UserType.Mayor}`] : [`${up.customerId}`];
	}

	if (user.type === UserType.Admin && up.status === ProjectStatus.AdminFinalize) {
		nextStatus = status === 1 ? ProjectStatus.Final : ProjectStatus.Cancel;
		targetUsers = [`@${UserType.Admin}`];
	}

	if (user.type === UserType.Mayor) {
		nextStatus = status === 1 ? ProjectStatus.PilotReview : ProjectStatus.AdminReview;
		targetUsers = status === 1 ? [`@${UserType.Admin}`] : [`${up.pilotId}`];
	}

	if (user.type === UserType.Pilot) {
		nextStatus = status === 1 ? ProjectStatus.CustomerPay : ProjectStatus.AdminReview;
		targetUsers = status === 1 ? [`${up.customerId}`] : [`@${UserType.Admin}`];
	}

	if (user.type === UserType.Customer && up.status === ProjectStatus.CustomerPay) {
		nextStatus = status === 1 ? ProjectStatus.AdminFinalize : ProjectStatus.Cancel;
		targetUsers = [`@${UserType.Admin}`];
	}

	if (user.type === UserType.Customer && up.status === ProjectStatus.CustomerEdit) {
		nextStatus = status === 1 ? ProjectStatus.AdminReview : ProjectStatus.Cancel;
		targetUsers = [`@${UserType.Admin}`];
	}

	if (status === 0) {
		message = userMessage ?? '';
	}

	await db
		.update(project)
		.set({
			status: nextStatus,
			message,
			targetUsers
		})
		.where(eq(project.id, pid));

	return true;
};
