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


		if (
			user.type === UserType.Admin &&
			!['/dashboard/project/list'].includes(url.pathname)
		) {
			throw redirect(307, '/dashboard/project/list');
		}

		if (
			user.type === UserType.Customer &&
			!['/dashboard/customer/projects' , '/dashboard/customer/edit-or-create-project'].includes(url.pathname)
		) {
			throw redirect(307, '/dashboard/customer/projects');
		}

		if (
			user.type === UserType.Pilot &&
			!['/dashboard/pilot/projects'].includes(url.pathname)
		) {
			throw redirect(307, '/dashboard/pilot/projects');
		}

		return { user };
	}

	throw redirect(307, '/login');
}) satisfies LayoutServerLoad;
