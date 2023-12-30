import { getProjectList } from '$lib/server/services/project-service';
import type { PageServerLoad } from './$types';

export const load = (async () => {

    const projects = await getProjectList();

    return {
        projects
    };

}) satisfies PageServerLoad;