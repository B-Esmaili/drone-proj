import type { AuthRequest } from 'lucia-auth';

declare global {
	namespace App {
		interface Locals {
			auth: AuthRequest<Lucia.Auth>;
		}
	}
}

/// <reference types="lucia" />
declare global {
	namespace Lucia {
		type Auth = import('$lib/server/lucia').Auth;
		type DatabaseUserAttributes = {
			email: string;
			password: string
		};
		type DatabaseSessionAttributes = Record<string, never>;
	}
}

export {};