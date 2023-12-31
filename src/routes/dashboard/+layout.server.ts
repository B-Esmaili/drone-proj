import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { UserType } from '$lib/server/services/user-service';

export const load = (async ({ locals, request, url }) => {
	const { user } = await locals.auth.validateUser();

	if (user !== null) {
		if (
			user.type === UserType.Mayor &&
			!['/dashboard/mayor/projects'].includes(url.pathname)
		) {
			throw redirect(307, '/dashboard/mayor/projects');
		}

		return { user };
	}

	throw redirect(307, '/login');
}) satisfies LayoutServerLoad;
