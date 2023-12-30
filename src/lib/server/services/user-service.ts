import { SQL, and, eq } from 'drizzle-orm';
import { db } from '..';

export enum UserType {
	Admin,
	Pilot,
	Customer,
	Mayor
}

export interface UserFilter {
	type: UserType;
}

export const getUserList = async (filter: UserFilter) => {
	const list = await db.query.user.findMany({
		where: (usr) => {
			const params: SQL[] = [];

			if (filter.type) {
				params.push(eq(usr.type, filter.type));
			}

			return and.apply(null,params);
		}
	});

	return list;
};
