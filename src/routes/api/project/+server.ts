import { changeProjectStatus } from '$lib/server/services/project-service';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async (evt) => {

    const data = await evt.request.json();

    const res = await changeProjectStatus(data.pid , data.status);

    return json({
        ok : res 
    });
};