import { getResourceList } from '$lib/server/services/resource-service';
import type { PageServerLoad } from './$types';

export const load = (async () => {
	const resources = await getResourceList();

	return {
		resources
	};
}) satisfies PageServerLoad;
