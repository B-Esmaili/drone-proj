import { getResourceList } from '$lib/server/services/resource-service';
import { UserType, getUserList } from '$lib/server/services/user-service';
import { setError, superValidate, superValidateSync } from 'sveltekit-superforms/server';
import type { PageServerLoad } from './$types';
import { z } from 'zod';
import { createOrUpdateProject, getProjectById } from '$lib/server/services/project-service';
import { fail, redirect } from '@sveltejs/kit';

const projectSchema = z.object({
	id : z.number().optional(),
	location: z.string(),
	serviceTypes: z.array(z.string()),
	dateValue: z.date(),
	timeValue: z.object({
		hour: z.number().default(0),
		minute: z.number().default(0),
		second: z.number().default(0)
	}),
	pilotId: z.string().min(1),
	customerId: z.string().min(1),
	resourceIds: z.array(z.number()).min(1)
});

export const load = (async (event) => {
	const resources = await getResourceList();

	const pilots = await getUserList({
		type: UserType.Pilot
	});

	const customers = await getUserList({
		type: UserType.Customer
	});

	const projectId = event.url.searchParams.get('id');

	const form = projectId
		? await superValidate(await getProjectById(Number(projectId)), projectSchema)
		: await superValidate(projectSchema);

	return {
		resources,
		customers,
		pilots,
		form
	};
}) satisfies PageServerLoad;

export const actions = {
	default: async (event) => {
		const form = await superValidate(event, projectSchema);

		if (!form.valid) {
			return fail(400, { form });
		}

		const dateTimeValue = new Date(form.data.dateValue);
		dateTimeValue.setHours(form.data.timeValue.hour);
		dateTimeValue.setMinutes(form.data.timeValue.minute);

		const project : any = {			
			resourceIds: form.data.resourceIds,
			customerId: form.data.customerId,
			pilotId : form.data.pilotId,
			time : dateTimeValue,
			location : form.data.location
		};

		if (form.data.id){
			project.id = form.data.id;
		}

		const result = await createOrUpdateProject(project);

		if (!result){
			setError(form,"خطای سیستمی رخ داد");
			return fail(500, {form})
		}
		
		if (!form.data.id){
			throw redirect(307, "/dashboard/project/list")
		}

		return {
			form
		};
	}
};
