import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';

export const load = (async ({ locals }) => {
	const { user } = await locals.auth.validateUser();
	if (user !== null) {
		return { user };
	}
 
	throw redirect(307, '/login');
}) satisfies LayoutServerLoad;
