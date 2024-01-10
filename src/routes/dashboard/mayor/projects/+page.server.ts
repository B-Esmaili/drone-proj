import { getProjectList } from '$lib/server/services/project-service';
import { UserType } from '$lib/server/services/user-service';
import type { PageServerLoad } from './$types';

export const load = (async (event) => {

	const { user } = await event.locals.auth.validateUser();

	if (!user) {
		return {
			projects: []
		};
	}

	const projects = await getProjectList({
		targetUser: [`@${UserType.Mayor}`]
	},user);

	return {
		projects
	};
}) satisfies PageServerLoad;
