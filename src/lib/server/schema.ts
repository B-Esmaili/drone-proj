import { relations } from 'drizzle-orm';
import {
	pgTable,
	bigint,
	varchar,
	boolean,
	text,
	integer,
	time,
	serial,
	date,
	timestamp
} from 'drizzle-orm/pg-core';

export const user = pgTable('auth_user', {
	id: varchar('id', {
		length: 15 // change this when using custom user ids
	}).primaryKey(),
	email: text('email'),
	password: text('password'),
	type: integer('type'),
	displayName: text('display_name')
	// other user attributes
});

export const session = pgTable('auth_session', {
	id: varchar('id', {
		length: 128
	}).primaryKey(),
	userId: varchar('user_id', {
		length: 15
	})
		.notNull()
		.references(() => user.id),
	activeExpires: bigint('active_expires', {
		mode: 'number'
	}).notNull(),
	idleExpires: bigint('idle_expires', {
		mode: 'number'
	}).notNull()
});

export const key = pgTable('auth_key', {
	id: varchar('id', {
		length: 255
	}).primaryKey(),
	userId: varchar('user_id', {
		length: 15
	})
		.notNull()
		.references(() => user.id),
	primaryKey: boolean('primary_key').notNull(),
	hashedPassword: varchar('hashed_password', {
		length: 255
	}),
	expires: bigint('expires', {
		mode: 'number'
	})
});

export const project = pgTable('project', {
	id: serial('id').primaryKey(),
	location: text('location').notNull(),
	serviceTypes: text('service_types').array().notNull(),
	time: timestamp('time').notNull(),
	endTime: timestamp('end_time').notNull(),
	pilotId: varchar('pilot_id', {
		length: 15
	})
		.notNull()
		.references(() => user.id),
	customerId: varchar('customer_id', {
		length: 15
	})
		.notNull()
		.references(() => user.id),
	confirmed: boolean('confirmed'),
	status : integer('status'),
	targetUsers : varchar('target_users').array().notNull(),
	message : varchar("message"),
	desc : varchar("desc")
});

export const resource = pgTable('resource', {
	id: serial('id').primaryKey(),
	name: text('name').notNull(),
	price: bigint('price', {
		mode: 'number'
	}).notNull()
});

export const invoice = pgTable('invoice', {
	id: serial('id').primaryKey(),
	resourceId: integer('resource_id')
		.notNull()
		.references(() => resource.id),
	projectId: integer('project_id')
		.notNull()
		.references(() => project.id),
	price: bigint('price', {
		mode: 'number'
	})
});

//####################################### Relations ############################################

export const resourceRelations = relations(resource, ({ many }) => ({
	invoices: many(invoice)
}));

export const invoiceRelations = relations(invoice, ({ one }) => ({
	resource: one(resource, {
		fields: [invoice.resourceId],
		references: [resource.id]
	}),
	project: one(project, {
		fields: [invoice.projectId],
		references: [project.id]
	})
}));

export const userRelations = relations(user, ({ many }) => ({
	projects: many(project)
}));

export const projectRelations = relations(project, ({ one, many }) => ({
	pilot: one(user, {
		fields: [project.pilotId],
		references: [user.id]
	}),
	customer: one(user, {
		fields: [project.customerId],
		references: [user.id]
	}),
	invoices: many(invoice)
}));
