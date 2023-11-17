import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async ({ locals }) => {
    console.log(locals.auth)
	locals.auth.setSession(null);

	throw redirect(307, '/login');
}) satisfies PageServerLoad;
