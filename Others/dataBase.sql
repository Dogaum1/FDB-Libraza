BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "Company" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	"cnpj"	VARCHAR(255),
	PRIMARY KEY("id")
);

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

CREATE TABLE IF NOT EXISTS "Location" (
	"id"	INTEGER,
	"stand"	INTEGER,
	"shelf"	INTEGER,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "Author" (
	"id"	INTEGER,
	"name"	VARCHAR(255),
	PRIMARY KEY("id")
);
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

CREATE TABLE IF NOT EXISTS "Loan" (
	"id"	INTEGER,
	"user"	INTEGER,
	"book"	INTEGER,
	"start_date"	DATE,
	"return_period"	DATE,
	"return_date"	DATE,
	PRIMARY KEY("id"),
	FOREIGN KEY("user") REFERENCES "User"("id"),
	FOREIGN KEY("book") REFERENCES "Book"("id")
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
	PRIMARY KEY("id"),
	FOREIGN KEY("address") REFERENCES "Address"("id"),
	FOREIGN KEY("confiability") REFERENCES "Confiability"("id")
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
	"cover"	TEXT,
	"description"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("location") REFERENCES "Location"("id"),
	FOREIGN KEY("author") REFERENCES "Author"("id")
);

CREATE TABLE IF NOT EXISTS "Seal" (
	"Id"	INTEGER NOT NULL,
	"Label"	TEXT NOT NULL,
	PRIMARY KEY("Id")
);

CREATE TABLE IF NOT EXISTS "Confiability" (
	"id"	INTEGER,
	"label"	INTEGER,
	"amt_allowed_books"	INTEGER,
	"amt_borrowed_books"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("label") REFERENCES "Seal"("Id")
);
INSERT INTO "Company" ("id","name","cnpj") VALUES (1,'INSS','01'),
 (2,'BANCO DO BRASIL','02');
INSERT INTO "Employee" ("id","name","cpf","phone","email","birth_date","registration","password") VALUES (1,'Douglas','000.000.000-00','(83) 9 9999 9999','douglas@email.com','12/12/2000','1','123'),
 (2,'Gisele','111.111.111-11','(83) 9 8888 8888','gisele@email.com','11/11/2000','2','321');
INSERT INTO "Location" ("id","stand","shelf") VALUES (1,1,2),
 (2,3,4);
INSERT INTO "Author" ("id","name") VALUES (1,'Lima Barreto'),
 (2,'Mario de Andrade');
INSERT INTO "Address" ("id","type","logradouro","number","district","city","state","zip_code") VALUES (1,'RUA','FLORES',42,'CENTRO','PRINCESA ISABEL','PB','58755-000'),
 (2,'SITIO','MACACO',0,'AREA RURAL','TAVARES','PB','58753-000');
INSERT INTO "Loan" ("id","user","book","start_date","return_period","return_date") VALUES (1,1,2,'01/01/2021','02/02/2021','20/01/2021'),
 (2,2,1,'02/03/2021','07/03/2021','05/03/2021');
INSERT INTO "User" ("id","name","cpf","phone","address","email","birth_date","confiability") VALUES (1,'ASDAD','123132','6363463',1,'SFS@EMAIL.COM','12/12/2002',2),
 (2,'QQQQ','WWWW','99999',2,'WWWW@EMAIL.COM','01/01/2004',1);
INSERT INTO "Book" ("id","title","author","edition","publisher","year_publication","num_pages","barcode","genre","location","cover","description") VALUES (1,'Triste Fim De Policarpo Quaresma',1,1,'Lima Barreto',1945,100,'L001','Romance',1,'https://images-na.ssl-images-amazon.com/images/I/918ojG9v8oL.jpg','O Triste Fim de Policarpo Quaresma, de Lima Barreto, narra a trajetória de Policarpo Quaresma, um patriota ímpar, que causa estranheza nas pessoas pelos seus ideais e coragem. O livro é dividido em três partes. A primeira começa descrevendo a rotina do Major Policarpo Quaresma.'),
 (2,'Macunaima',2,1,'Mario de Andrade',1928,259,'L002','Romance, Ficção, Humor',2,'https://m.media-amazon.com/images/P/B01H6A95ZM.01._SCLZZZZZZZ_SX500_.jpg','Personagem principal do livro, é individualista, preguiçoso e faz o que deseja sem se preocupar com nada. Além disso, é vaidoso, mente com a maior facilidade e gosta, acima de tudo, de se entregar aos prazeres carnais. Maanape: irmão de Macunaíma. Tinha fama de feiticeiro e representa o povo negro.');
INSERT INTO "Seal" ("Id","Label") VALUES (1,'Bronze'),
 (2,'Prata'),
 (3,'Ouro');
INSERT INTO "Confiability" ("id","label","amt_allowed_books","amt_borrowed_books") VALUES (1,NULL,1,1),
 (2,NULL,2,2);
COMMIT;

drop view "Book_detail"

 CREATE VIEW "Book_detail" as SELECT 
 	"Book".id,
    "Book".title,
    "Author".name AS author,
	"Book".year_publication,
	"Book".genre,
    "Book".edition,
	"Book".cover,
	"Book".description,
    "Location".stand,
    "Location".shelf
   FROM "Book"
     LEFT JOIN "Author" ON "Book".author = "Author".id
     LEFT JOIN "Location" ON "Book".location = "Location".id;
	
	DROP VIEW "User_add"
	
	select * from "Address"
	
	CREATE VIEW "User_add" as 
	SELECT
	 "User".name, 
	 "User".cpf, 
	 "User".phone,
	 "User".email, 
	 "User".birth_date, 
	 "Seal".label as "confiability",
	 "Address".type,
	 "Address".logradouro,
	 "Address".number,
	 "Address".district,
	 "Address".city,
	 "Address".state,
	 "Address".zip_code
	 FROM "User"
	 	LEFT JOIN "Confiability" ON "User".confiability = "Confiability".label
		LEFT JOIN "Seal" ON "Confiability".id = "Seal".id
		LEFT JOIN "Address" ON "User".id = "Address".id
	
	CREATE VIEW "Book_edit" as 
	SELECT 
    "Book".title,
	"Author".name AS author,
    "Book".edition,
	"Book".publisher,
    "Book".year_publication,
    "Book".num_pages,
    "Book".barcode,
    "Book".genre,
	"Location".stand,
	"Location".shelf,
	"Book".cover,
	"Book".description
	FROM "Book"
     LEFT JOIN "Author" ON "Book".author = "Author".id
     LEFT JOIN "Location" ON "Book".location = "Location".id;
	
	DROP VIEW "User_search"
	
	CREATE VIEW "User_search" AS
	SELECT 
	"User".name,
    "User".cpf,
    "User".phone,
    "User".email,
    "User".birth_date
   	FROM "User"
   
   
    SELECT "Book".id,
    "Book".title,
    "Author".name AS author,
    "Book".edition,
    "Book".publisher,
    "Book".year_publication,
    "Book".num_pages,
    "Book".barcode,
    "Book".genre,
    "Location".stand,
    "Location".shelf,
    "Book".cover,
    "Book".description
   FROM "Book"
     LEFT JOIN "Author" ON "Book".author = "Author".id
     LEFT JOIN "Location" ON "Book".location = "Location".id;
   