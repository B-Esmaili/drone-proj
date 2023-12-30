ALTER TABLE "project" ALTER COLUMN "service_types" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "project" DROP COLUMN IF EXISTS "time";