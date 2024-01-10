import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { changeProjectStatus } from '$lib/server/services/project-service';

export const POST: RequestHandler = async (event) => {
	const { user } = await event.locals.auth.validateUser();

	if (!user) {
		return json(false);
	}

	const body = await event.request.json();

	const result = await changeProjectStatus(user, body.projectId, body.status , body.message);

	return json(result);
};
