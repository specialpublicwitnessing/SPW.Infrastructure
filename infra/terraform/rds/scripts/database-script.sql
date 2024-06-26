DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS "special_day";
DROP TABLE IF EXISTS "congregation";
DROP TABLE IF EXISTS "circuit";
DROP TABLE IF EXISTS "validity";
DROP TABLE IF EXISTS "schedule";
DROP TABLE IF EXISTS "point";
DROP TABLE IF EXISTS "announcement";
DROP TABLE IF EXISTS "holiday";
DROP TABLE IF EXISTS "domain";
DROP TABLE IF EXISTS "availability";



CREATE TABLE "domain" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR
);

CREATE TABLE "validity" (
    "id" UUID PRIMARY KEY,
    "start_date" TIMESTAMP NOT NULL,
    "end_date" TIMESTAMP NOT NULL,
    "status" BOOLEAN NOT null,
    "domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "circuit" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR,
	"domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "congregation" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR,
	"number" VARCHAR,
	"circuit_id" UUID NOT null,
	FOREIGN KEY (circuit_id) REFERENCES circuit(id)
);

CREATE TABLE "user" (
    "id" UUID PRIMARY KEY,
    "name" VARCHAR,
    "creation_date" TIMESTAMP,
    "email" VARCHAR,
    "phone_number" VARCHAR,
    "gender" TEXT,
    "birth_date" DATE,
    "baptism_date" DATE,
    "privilege" TEXT,
    "congregation_id" UUID NOT null,
	FOREIGN KEY (congregation_id) REFERENCES "congregation"(id)
);

CREATE TABLE "special_day" (
	"id" UUID PRIMARY KEY,
	"name" VARCHAR,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP NOT NULL,
	"circuit_id" UUID NOT null,
	FOREIGN KEY (circuit_id) REFERENCES circuit(id)
);

CREATE TABLE "schedule" (
	"id" UUID PRIMARY KEY,
	"time" VARCHAR,
	"domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "point" (
    "id" UUID PRIMARY KEY,
    "name" VARCHAR,
    "number_of_publishers" INTEGER NOT NULL,
    "address" VARCHAR,
    "image_url" VARCHAR,
    "google_maps_url" VARCHAR,
    "domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "announcement"(
    "id" UUID PRIMARY KEY,
    "title" VARCHAR,
    "message" text,
    "domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "holiday" (
    "id" UUID PRIMARY KEY,
    "name" VARCHAR,
    "date" DATE NOT null,
    "domain_id" UUID NOT null,
	FOREIGN KEY (domain_id) REFERENCES "domain"(id)
);

CREATE TABLE "availability" (
    "id" UUID PRIMARY KEY,
    "week_day" TEXT,
    "point_id" UUID, 
    "schedule_id" UUID, 
    "domain_id" UUID, 
    "status" BOOLEAN NOT null,
    FOREIGN KEY ("point_id") REFERENCES "point"("id"),
    FOREIGN KEY ("schedule_id") REFERENCES "schedule"("id"),
    FOREIGN KEY ("domain_id") REFERENCES "domain"("id")   
);


INSERT INTO "domain" ("id", "name") values ('c24d74b5-6571-4e0b-ae40-8c8a703c6c08', 'TPE - Mauá');
INSERT INTO "circuit" ("id", "name", "domain_id") VALUES ('9879e3de-6e79-4e4b-9312-d952d54ee2e1', 'SP-002', 'c24d74b5-6571-4e0b-ae40-8c8a703c6c08');
INSERT INTO  "congregation" ("id", "name", "number", "circuit_id") values ('31101712-771f-4604-bc16-9b2d1eb660d5', 'Central, Mauá', '4267', '9879e3de-6e79-4e4b-9312-d952d54ee2e1');
INSERT INTO  "congregation" ("id", "name", "number", "circuit_id") values ('3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Jardim Itapark, Mauá', '4267', '9879e3de-6e79-4e4b-9312-d952d54ee2e1');

