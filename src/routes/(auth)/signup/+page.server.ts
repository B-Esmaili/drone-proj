import { z } from 'zod';
import { superValidate } from 'sveltekit-superforms/server';
import type { Actions } from './$types';
import { auth } from "$lib/server/lucia";
import { fail } from '@sveltejs/kit';


const schema = z.object({
    email: z.string().email(),
    password: z.string(),
    type:z.number().default(1)
});

export const load = (async () => {
    // Server API:
    const form = await superValidate(schema);

    // Always return { form } in load and form actions.
    return { form };
});

export const actions: Actions = {
    default: async ({ request, locals }) => {
        const form = await superValidate(request, schema);
        
        if (!form.valid) {
            return fail(400, { form });
        }
        try {
            const user = await auth.createUser({
                primaryKey: {
                    providerId: "email",
                    providerUserId: form.data.email,
                    password: form.data.password
                },
                attributes: {
                    email: form.data.email,
                    password: form.data.password,
                    type : form.data.type,
                    //displayName : form.data.email
                }
            });
        } catch {
            // username taken
            return fail(400);
        }

        return { form };
    }
};