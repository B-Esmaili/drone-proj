ALTER TABLE "project" ADD COLUMN "status" integer;--> statement-breakpoint
ALTER TABLE "project" ADD COLUMN "target_users" varchar[] NOT NULL;--> statement-breakpoint
ALTER TABLE "project" ADD COLUMN "message" varchar;--> statement-breakpoint
ALTER TABLE "project" ADD COLUMN "desc" varchar;