BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "startup_analysis" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "startupName" text NOT NULL,
    "industry" text NOT NULL,
    "stage" text NOT NULL,
    "ideaJson" text NOT NULL,
    "reportJson" text NOT NULL,
    "analysisMode" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR startupsense
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('startupsense', '20261014134959008-startup-sense', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014134959008-startup-sense', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
