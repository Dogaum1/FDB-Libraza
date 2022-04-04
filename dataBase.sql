BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Address" (
	"id"	INTEGER,
	"type"	VARCHAR(255),
	"name"	VARCHAR(255),
	"number"	INTEGER,
	"district"	VARCHAR(255),
	"city"	VARCHAR(255),
	"state"	VARCHAR(255),
	"zip_code"	VARCHAR(255),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Company" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cnpj"	VARCHAR(255),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Confiability" (
	"id"	INTEGER,
	"amt_allowed_books"	INTEGER,
	"amt_borrowed_books"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Location" (
	"id"	INTEGER,
	"stand"	INTEGER,
	"shelf"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "User" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cpf"	VARCHAR(255) UNIQUE,
	"phone"	VARCHAR(255),
	"address"	INTEGER,
	"email"	VARCHAR(255),
	"birth_date"	DATE,
	"confiability"	INTEGER,
	FOREIGN KEY("address") REFERENCES "Address"("id"),
	FOREIGN KEY("confiability") REFERENCES "Confiability"("id"),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Author" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Book" (
	"id"	INTEGER,
	"title"	VARCHAR(255) NOT NULL,
	"author"	INTEGER,
	"edition"	INTEGER,
	"publisher"	VARCHAR(255),
	"year_publication"	INTEGER,
	"num_pages"	INTEGER,
	"barcode"	VARCHAR(255),
	"genre"	VARCHAR(255),
	"location"	INTEGER,
	FOREIGN KEY("location") REFERENCES "Location"("id"),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Loan" (
	"id"	INTEGER,
	"user"	INTEGER,
	"book"	INTEGER,
	"start_date"	DATE,
	"return_period"	DATE,
	"return_date"	DATE,
	FOREIGN KEY("book") REFERENCES "Book"("id"),
	FOREIGN KEY("user") REFERENCES "User"("id"),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Employee" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cpf"	VARCHAR(255) UNIQUE,
	"phone"	VARCHAR(255),
	"address"	INTEGER,
	"email"	VARCHAR(255),
	"birth_date"	DATE,
	"registration"	VARCHAR(255),
	"password"	VARCHAR(255),
	FOREIGN KEY("address") REFERENCES "Address"("id"),
	PRIMARY KEY("id")
);
INSERT INTO "Address" VALUES (1,'RUA','FLORES',42,'CENTRO','PRINCESA ISABEL','PB','58755-000');
INSERT INTO "Address" VALUES (2,'SITIO','MACACO',0,'AREA RURAL','TAVARES','PB','58753-000');
INSERT INTO "Company" VALUES (1,'INSS','01');
INSERT INTO "Company" VALUES (2,'BANCO DO BRASIL','02');
INSERT INTO "Confiability" VALUES (1,1,1);
INSERT INTO "Confiability" VALUES (2,2,2);
INSERT INTO "Location" VALUES (1,1,2);
INSERT INTO "Location" VALUES (2,3,4);
INSERT INTO "User" VALUES (1,'ASDAD','123132','6363463',1,'SFS@EMAIL.COM','12/12/2002',1);
INSERT INTO "User" VALUES (2,'QQQQ','WWWW','99999',2,'WWWW@EMAIL.COM','01/01/2004',2);
INSERT INTO "Author" VALUES (1,'ADOBE');
INSERT INTO "Author" VALUES (2,'LAMPIAO');
INSERT INTO "Book" VALUES (1,'MANUAL DE SHAMPOO',1,1,'PRINCESA LIVROS',2022,20,'L001','MANUAL',1);
INSERT INTO "Book" VALUES (2,'TIRINGA CAÇADOR',2,2,'MANAIRA LIVROS',2021,300,'L002','AÇÃO',2);
INSERT INTO "Loan" VALUES (1,1,1,'01/01/2021','02/02/2021','20/01/2021');
INSERT INTO "Loan" VALUES (2,2,2,'02/03/2021','07/03/2021','05/03/2021');
INSERT INTO "Employee" VALUES (1,'DOUGLAS','000.000.000-00','(83) 9 9999 9999',NULL,'douglas@email.com','12/12/2000','1','123');
INSERT INTO "Employee" VALUES (2,'GISELE','111.111.111-11','(83) 9 8888 8888',NULL,'gisele@email.com','11/11/2000','2','321');
COMMIT;
