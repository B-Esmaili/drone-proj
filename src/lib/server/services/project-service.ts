import { eq, inArray } from 'drizzle-orm';
import { db } from '..';
import { invoice, project } from '../schema';
import { omit } from 'remeda';

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
		minute: 10
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

export const getProjectList = async () => {
	const projects = await db.query.project.findMany({
		with: {
			customer: true,
			pilot: true,
			invoices: {
				with: {
					resource: true
				}
			}
		}
	});

	return projects;
};
