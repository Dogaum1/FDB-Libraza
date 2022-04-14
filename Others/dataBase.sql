BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Company";
CREATE TABLE IF NOT EXISTS "Company" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cnpj"	VARCHAR(255),
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Confiability";
CREATE TABLE IF NOT EXISTS "Confiability" (
	"id"	INTEGER,
	"amt_allowed_books"	INTEGER,
	"amt_borrowed_books"	INTEGER,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Employee";
CREATE TABLE IF NOT EXISTS "Employee" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cpf"	VARCHAR(255) UNIQUE,
	"phone"	VARCHAR(255),
	"email"	VARCHAR(255),
	"birth_date"	DATE,
	"registration"	VARCHAR(255),
	"password"	VARCHAR(255),
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Location";
CREATE TABLE IF NOT EXISTS "Location" (
	"id"	INTEGER,
	"stand"	INTEGER,
	"shelf"	INTEGER,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "User";
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
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Book";
CREATE TABLE IF NOT EXISTS "Book" (
	"id"	INTEGER,
	"title"	VARCHAR(255) NOT NULL,
	"author"	VARCHAR(255) NOT NULL,
	"edition"	INTEGER,
	"publisher"	VARCHAR(255),
	"year_publication"	INTEGER,
	"num_pages"	INTEGER,
	"barcode"	VARCHAR(255),
	"genre"	VARCHAR(255),
	"location"	INTEGER,
	"cover"	TEXT,
	"description"	TEXT,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Author";
CREATE TABLE IF NOT EXISTS "Author" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Address";
CREATE TABLE IF NOT EXISTS "Address" (
	"id"	INTEGER,
	"type"	VARCHAR(255),
	"logradouro"	VARCHAR(255),
	"number"	INTEGER,
	"district"	VARCHAR(255),
	"city"	VARCHAR(255),
	"state"	VARCHAR(255),
	"zip_code"	VARCHAR(255),
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "Loan";
CREATE TABLE IF NOT EXISTS "Loan" (
	"id"	INTEGER,
	"user"	INTEGER,
	"book"	INTEGER,
	"start_date"	DATE,
	"return_period"	DATE,
	"return_date"	DATE,
	FOREIGN KEY("user") REFERENCES "User"("id"),
	PRIMARY KEY("id")
);
INSERT INTO "Company" VALUES (1,'INSS','01');
INSERT INTO "Company" VALUES (2,'BANCO DO BRASIL','02');
INSERT INTO "Confiability" VALUES (1,1,1);
INSERT INTO "Confiability" VALUES (2,2,2);
INSERT INTO "Employee" VALUES (1,'DOUGLAS','000.000.000-00','(83) 9 9999 9999','douglas@email.com','12/12/2000','1','123');
INSERT INTO "Employee" VALUES (2,'GISELE','111.111.111-11','(83) 9 8888 8888','gisele@email.com','11/11/2000','2','321');
INSERT INTO "Location" VALUES (1,1,2);
INSERT INTO "Location" VALUES (2,3,4);
INSERT INTO "User" VALUES (1,'ASDAD','123132','6363463',1,'SFS@EMAIL.COM','12/12/2002',2);
INSERT INTO "User" VALUES (2,'QQQQ','WWWW','99999',2,'WWWW@EMAIL.COM','01/01/2004',1);
INSERT INTO "Book" VALUES (1,'Triste Fim De Policarpo Quaresma','Lima Barreto',1,'Lima Barreto',1945,100,'L001','Romance',1,'https://images-na.ssl-images-amazon.com/images/I/918ojG9v8oL.jpg','O Triste Fim de Policarpo Quaresma, de Lima Barreto, narra a trajetória de Policarpo Quaresma, um patriota ímpar, que causa estranheza nas pessoas pelos seus ideais e coragem. O livro é dividido em três partes. A primeira começa descrevendo a rotina do Major Policarpo Quaresma.');
INSERT INTO "Book" VALUES (2,'Macunaima','Mario de Andrade',1,'Mario de Andrade',1928,259,'L002','Romance, Ficção, Humor',2,'https://m.media-amazon.com/images/P/B01H6A95ZM.01._SCLZZZZZZZ_SX500_.jpg','Personagem principal do livro, é individualista, preguiçoso e faz o que deseja sem se preocupar com nada. Além disso, é vaidoso, mente com a maior facilidade e gosta, acima de tudo, de se entregar aos prazeres carnais. Maanape: irmão de Macunaíma. Tinha fama de feiticeiro e representa o povo negro.');
INSERT INTO "Author" VALUES (1,'ADOBE');
INSERT INTO "Author" VALUES (2,'LAMPIAO');
INSERT INTO "Address" VALUES (1,'RUA','FLORES',42,'CENTRO','PRINCESA ISABEL','PB','58755-000');
INSERT INTO "Address" VALUES (2,'SITIO','MACACO',0,'AREA RURAL','TAVARES','PB','58753-000');
INSERT INTO "Loan" VALUES (1,1,2,'01/01/2021','02/02/2021','20/01/2021');
INSERT INTO "Loan" VALUES (2,2,1,'02/03/2021','07/03/2021','05/03/2021');
COMMIT;
