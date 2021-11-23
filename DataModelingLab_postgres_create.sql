CREATE TABLE "public.users" (
	"user_id" serial NOT NULL,
	"display_name" serial(255) NOT NULL UNIQUE,
	"first_name" varchar(255) NOT NULL UNIQUE,
	"last_name" varchar(255) UNIQUE,
	CONSTRAINT "users_pk" PRIMARY KEY ("user_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.auth" (
	"auth_id" integer NOT NULL,
	"rec_key" varchar NOT NULL UNIQUE,
	"user_id" integer NOT NULL,
	"email" serial(305) NOT NULL UNIQUE,
	"hash" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "auth_pk" PRIMARY KEY ("auth_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.recipe" (
	"rec_id" serial NOT NULL,
	"user_id" BINARY NOT NULL,
	"rec_text" varchar(500) NOT NULL,
	"photo_url" VARCHAR(500) NOT NULL,
	"serve_size" integer(10) NOT NULL,
	"date" DATETIME(20) NOT NULL,
	"rec_instruction" integer(20) NOT NULL,
	"rec_name" integer(20) NOT NULL,
	"ingre_name" varchar(20) NOT NULL,
	CONSTRAINT "recipe_pk" PRIMARY KEY ("rec_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.rec_instruction" (
	"rec_ins_id" serial NOT NULL,
	"serve_size" integer(10) NOT NULL,
	"user_id" integer(10) NOT NULL,
	"date" DATETIME(20) NOT NULL,
	"rec_name" varchar(100) NOT NULL,
	"ingre_id" integer NOT NULL,
	"ingre_name" integer NOT NULL,
	"measurement_type" integer NOT NULL,
	CONSTRAINT "rec_instruction_pk" PRIMARY KEY ("rec_ins_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.recipe_auth" (
	"rec_auth_id" serial NOT NULL,
	"user_id" integer NOT NULL,
	"rec_key" integer NOT NULL UNIQUE,
	CONSTRAINT "recipe_auth_pk" PRIMARY KEY ("rec_auth_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.measurement_conv" (
	"measurement_type" serial NOT NULL,
	"cups" integer NOT NULL,
	"tea_spn" integer NOT NULL,
	"table_spn" integer NOT NULL,
	"liter" integer NOT NULL,
	"pound" integer NOT NULL,
	"pint" integer NOT NULL,
	"ounces" integer NOT NULL,
	"gallon" integer NOT NULL,
	CONSTRAINT "measurement_conv_pk" PRIMARY KEY ("measurement_type")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.ingredients" (
	"ingre_id" serial NOT NULL,
	"ingre_name" serial(255) NOT NULL,
	"user_id" serial(255) NOT NULL,
	"rec_seq_id" serial(255) NOT NULL,
	CONSTRAINT "ingredients_pk" PRIMARY KEY ("ingre_id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "auth" ADD CONSTRAINT "auth_fk0" FOREIGN KEY ("rec_key") REFERENCES "recipe_auth"("rec_key");
ALTER TABLE "auth" ADD CONSTRAINT "auth_fk1" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");

ALTER TABLE "recipe" ADD CONSTRAINT "recipe_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_fk1" FOREIGN KEY ("serve_size") REFERENCES "rec_instruction"("serve_size");
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_fk2" FOREIGN KEY ("rec_instruction") REFERENCES "rec_instruction"("rec_ins_id");
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_fk3" FOREIGN KEY ("rec_name") REFERENCES "rec_instruction"("rec_name");
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_fk4" FOREIGN KEY ("ingre_name") REFERENCES "ingredients"("ingre_name");

ALTER TABLE "rec_instruction" ADD CONSTRAINT "rec_instruction_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");
ALTER TABLE "rec_instruction" ADD CONSTRAINT "rec_instruction_fk1" FOREIGN KEY ("measurement_type") REFERENCES "measurement_conv"("measurement_type");

ALTER TABLE "recipe_auth" ADD CONSTRAINT "recipe_auth_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");










