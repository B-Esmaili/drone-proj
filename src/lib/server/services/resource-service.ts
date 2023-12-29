import { db } from '..';

export const getResourceList = async () => {

	const data = await db.query.resource.findMany({});

    return data;
};
