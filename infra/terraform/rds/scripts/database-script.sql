DROP TABLE IF EXISTS "user" ;
DROP TABLE IF EXISTS "special_day";
DROP TABLE IF EXISTS "congregation";
DROP TABLE IF EXISTS "circuit";
DROP TABLE IF EXISTS "validity";
DROP TABLE IF EXISTS "availability";
DROP TABLE IF EXISTS "schedule";
DROP TABLE IF EXISTS "point";
DROP TABLE IF EXISTS "announcement";
DROP TABLE IF EXISTS "holiday";
DROP TABLE IF EXISTS "domain";

CREATE TABLE "domain" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR
);

CREATE TABLE "validity" (
    "id" UUID PRIMARY KEY,
    "start_date" TIMESTAMP NOT NULL,
    "end_date" TIMESTAMP NOT NULL,
    "status" BOOLEAN NOT NULL,
    "domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "circuit" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR,
	"domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "congregation" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR,
	"number" VARCHAR,
	"circuit_id" UUID NOT NULL,
	FOREIGN KEY (circuit_id) REFERENCES "circuit"(id)
);

CREATE TABLE "user" (
    "id" UUID NOT NULL PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    "creation_date" TIMESTAMP NOT NULL,
    "email" VARCHAR NOT NULL,
    "phone_number" VARCHAR NOT NULL,
    "gender" VARCHAR NOT NULL,
    "grade" VARCHAR,
    "birth_date" DATE NOT NULL,
    "baptism_date" DATE NOT NULL,
    "privilege" VARCHAR,
    "congregation_id" UUID NOT NULL,
	FOREIGN KEY (congregation_id) REFERENCES "congregation"(id)
);

CREATE TABLE "special_day" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP NOT NULL,
	"circuit_id" UUID NOT NULL,
	FOREIGN KEY (circuit_id) REFERENCES "circuit"(id)
);

CREATE TABLE "schedule" (
	"id" UUID PRIMARY KEY,
	"time" VARCHAR NOT NULL,
	"domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "point" (
    "id" UUID PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    "number_of_publishers" INTEGER NOT NULL,
    "address" VARCHAR NOT NULL,
    "image_url" VARCHAR NOT NULL,
    "google_maps_url" VARCHAR NOT NULL,
    "minimum_user_grade" VARCHAR,
    "domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "announcement"(
    "id" UUID PRIMARY KEY,
    "title" VARCHAR NOT NULL,
    "message" text,
    "domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "holiday" (
    "id" UUID PRIMARY KEY,
    "name" VARCHAR NOT NULL,
    "date" DATE NOT NULL,
    "domain_id" UUID NOT NULL,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "availability" (
    "id" UUID PRIMARY KEY,
    "week_day" VARCHAR,
    "point_id" UUID, 
    "schedule_id" UUID, 
    "domain_id" UUID, 
    "status" BOOLEAN NOT NULL,
    FOREIGN KEY ("point_id") REFERENCES "point"("id"),
    FOREIGN KEY ("schedule_id") REFERENCES "schedule"("id"),
    FOREIGN KEY ("domain_id") REFERENCES "domain"("id")   
);

INSERT INTO "domain" ("id", "name") values ('c24d74b5-6571-4e0b-ae40-8c8a703c6c08', 'TPE - Mauá');
INSERT INTO "circuit" ("id", "name", "domain_id") VALUES ('9879e3de-6e79-4e4b-9312-d952d54ee2e1', 'SP-002', 'c24d74b5-6571-4e0b-ae40-8c8a703c6c08');
INSERT INTO  "congregation" ("id", "name", "number", "circuit_id") values ('31101712-771f-4604-bc16-9b2d1eb660d5', 'Central, Mauá', '4267', '9879e3de-6e79-4e4b-9312-d952d54ee2e1');
INSERT INTO  "congregation" ("id", "name", "number", "circuit_id") values ('3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Jardim Itapark, Mauá', '4267', '9879e3de-6e79-4e4b-9312-d952d54ee2e1');