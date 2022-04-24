--
-- PostgreSQL database cluster dump
--

-- Started on 2022-04-20 20:38:25

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:ZWn+97k6P6LPB6eJIQdg7Q==$6+ls1lgRn2cJv27CNOnumHOCLTOUX9kTlvUI1vxgils=:j1vIYOh9Zs/OunawY4ZhiSeQ7WAbnh+aG0qt1GjvNog=';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-20 20:38:25

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2022-04-20 20:38:26

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-20 20:38:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16394)
-- Name: Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Address" (
    id integer NOT NULL,
    type character varying(255),
    name character varying(255),
    number integer,
    district character varying(255),
    city character varying(255),
    state character varying(255),
    zip_code character varying(255)
);


ALTER TABLE public."Address" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16401)
-- Name: Book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book" (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    edition integer,
    publisher character varying(255),
    year_publication integer,
    num_pages integer,
    barcode character varying(255),
    genre character varying(255)
);


ALTER TABLE public."Book" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16408)
-- Name: BookAuthor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BookAuthor" (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public."BookAuthor" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16413)
-- Name: Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Company" (
    id integer NOT NULL,
    name character varying(255),
    cnpj character varying(255)
);


ALTER TABLE public."Company" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16420)
-- Name: Confiability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Confiability" (
    id integer NOT NULL,
    amt_allowed_books integer,
    amt_borrowed_books integer
);


ALTER TABLE public."Confiability" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16425)
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    id integer NOT NULL,
    name character varying(255),
    cpf character varying(255),
    phone character varying(255),
    email character varying(255),
    birth_date date,
    registration character varying(255),
    password character varying(255)
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16434)
-- Name: Loan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Loan" (
    id integer NOT NULL,
    start_date date,
    return_period date,
    return_date date
);


ALTER TABLE public."Loan" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16439)
-- Name: Location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    stand integer,
    shelf integer
);


ALTER TABLE public."Location" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16444)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name character varying(255),
    cpf character varying(255),
    phone character varying(255),
    email character varying(255),
    birth_date date
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 16394)
-- Dependencies: 210
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Address" (id, type, name, number, district, city, state, zip_code) FROM stdin;
1	RUA	FLORES	42	CENTRO	PRINCESA ISABEL	PB	58755-000
2	SITIO	MACACO	0	AREA RURAL	TAVARES	PB	58753-000
\.


--
-- TOC entry 3358 (class 0 OID 16401)
-- Dependencies: 211
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" (id, title, author, edition, publisher, year_publication, num_pages, barcode, genre) FROM stdin;
1	MANUAL DE SHAMPOO	ADOBE	1	PRINCESA LIVROS	2022	20	L001	MANUAL
2	TIRINGA CAÇADOR	LAMPIÃO	2	MANAIRA LIVROS	2021	300	L002	AÇÃO
\.


--
-- TOC entry 3359 (class 0 OID 16408)
-- Dependencies: 212
-- Data for Name: BookAuthor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."BookAuthor" (id, name) FROM stdin;
1	ADOBE
2	LAMPIAO
\.


--
-- TOC entry 3360 (class 0 OID 16413)
-- Dependencies: 213
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Company" (id, name, cnpj) FROM stdin;
1	INSS	01
2	BANCO DO BRASIL	02
\.


--
-- TOC entry 3361 (class 0 OID 16420)
-- Dependencies: 214
-- Data for Name: Confiability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Confiability" (id, amt_allowed_books, amt_borrowed_books) FROM stdin;
1	1	1
2	2	2
\.


--
-- TOC entry 3362 (class 0 OID 16425)
-- Dependencies: 215
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" (id, name, cpf, phone, email, birth_date, registration, password) FROM stdin;
1	DOUGLAS	000.000.000-00	(83) 9 9999 9999	douglas@email.com	2000-12-12	1	123
2	GISELE	111.111.111-11	(83) 9 8888 8888	gisele@email.com	2000-11-11	2	321
\.


--
-- TOC entry 3363 (class 0 OID 16434)
-- Dependencies: 216
-- Data for Name: Loan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Loan" (id, start_date, return_period, return_date) FROM stdin;
1	2021-01-01	2021-02-02	2021-01-20
2	2021-03-02	2021-03-07	2021-03-05
\.


--
-- TOC entry 3364 (class 0 OID 16439)
-- Dependencies: 217
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, stand, shelf) FROM stdin;
1	1	2
2	3	4
\.


--
-- TOC entry 3365 (class 0 OID 16444)
-- Dependencies: 218
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, cpf, phone, email, birth_date) FROM stdin;
1	ASDAD	123132	6363463	SFS@EMAIL.COM	2002-12-12
2	QQQQ	WWWW	99999	WWWW@EMAIL.COM	2004-01-01
\.


--
-- TOC entry 3197 (class 2606 OID 16400)
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 16412)
-- Name: BookAuthor BookAuthor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BookAuthor"
    ADD CONSTRAINT "BookAuthor_pkey" PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 16407)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 16419)
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- TOC entry 3205 (class 2606 OID 16424)
-- Name: Confiability Confiability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Confiability"
    ADD CONSTRAINT "Confiability_pkey" PRIMARY KEY (id);


--
-- TOC entry 3207 (class 2606 OID 16433)
-- Name: Employee Employee_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3209 (class 2606 OID 16431)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id);


--
-- TOC entry 3211 (class 2606 OID 16438)
-- Name: Loan Loan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_pkey" PRIMARY KEY (id);


--
-- TOC entry 3213 (class 2606 OID 16443)
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- TOC entry 3215 (class 2606 OID 16452)
-- Name: User User_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3217 (class 2606 OID 16450)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


-- Completed on 2022-04-20 20:38:26

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres2" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-20 20:38:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3464 (class 1262 OID 25618)
-- Name: postgres2; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE postgres2 OWNER TO postgres;

\connect postgres2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 248 (class 1255 OID 26109)
-- Name: user_insert(character varying[], character varying, character varying, character varying, date, character varying, character varying, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_insert(name character varying[], cpf character varying, phone character varying, email character varying, birth_date date, type character varying, logradouro character varying, number integer, district character varying, city character varying, state character varying, zip_code character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE
    new_address_id integer;
    new_confiability_id integer;
BEGIN

    INSERT INTO "Address" (type, logradouro, number, district, city, state, zip_code)
    VALUES (type, logradouro, number, district, city, state, zip_code) RETURNING id INTO new_address_id;
    
    INSERT INTO "Confiability" (label, amt_allowed_book, amt_borrowed_book) VALUES (1, 2, 0) RETURNING id INTO new_confiability_id;
    
    INSERT INTO "User" (name, cpf, phone, address, email, birth_date, confiability)
    VALUES (name, cpf, phone, new_address_id, email, birth_date, new_confiability_id);
END$$;


ALTER FUNCTION public.user_insert(name character varying[], cpf character varying, phone character varying, email character varying, birth_date date, type character varying, logradouro character varying, number integer, district character varying, city character varying, state character varying, zip_code character varying) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 26110)
-- Name: user_insert(character, character, character, character, date, character, character, integer, character, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_insert(name character, cpf character, phone character, email character, birth_date date, type character, logradouro character, number integer, district character, city character, state character, zip_code character) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE
    new_address_id integer;
    new_confiability_id integer;
BEGIN

    INSERT INTO "Address" (type, logradouro, number, district, city, state, zip_code)
    VALUES (type, logradouro, number, district, city, state, zip_code) RETURNING id INTO new_address_id;
    
    INSERT INTO "Confiability" (label, amt_allowed_books, amt_borrowed_books) VALUES (1, 2, 0) RETURNING id into new_confiability_id;
    
    INSERT INTO "User" (name, cpf, phone, address, email, birth_date, confiability)
    VALUES (name, cpf, phone, new_address_id, email, birth_date, new_confiability_id);
END$$;


ALTER FUNCTION public.user_insert(name character, cpf character, phone character, email character, birth_date date, type character, logradouro character, number integer, district character, city character, state character, zip_code character) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 26124)
-- Name: user_update(integer, character, character, character, character, date, character, character, integer, character, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_update(user_id integer, new_name character, new_cpf character, new_phone character, new_email character, new_birth_date date, new_type character, new_logradouro character, new_number integer, new_district character, new_city character, new_state character, new_zip_code character) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    modify_address_id integer;
BEGIN
	
	UPDATE "User" SET name = new_name, cpf = new_cpf, phone = new_phone, email = new_email, birth_date = new_birth_date
  	WHERE (id = user_id) RETURNING "User".address INTO modify_address_id;
	
 	UPDATE "Address" SET type = type, logradouro = new_logradouro, number = new_number, district = new_district, city = new_city, state = new_state, zip_code = new_zip_code
  	WHERE ("Address".id = modify_address_id);

END
$$;


ALTER FUNCTION public.user_update(user_id integer, new_name character, new_cpf character, new_phone character, new_email character, new_birth_date date, new_type character, new_logradouro character, new_number integer, new_district character, new_city character, new_state character, new_zip_code character) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 25801)
-- Name: Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Address" (
    id integer NOT NULL,
    type character varying(255),
    logradouro character varying(255),
    number integer,
    district character varying(255),
    city character varying(255),
    state character varying(255),
    zip_code character varying(255)
);


ALTER TABLE public."Address" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 26091)
-- Name: Address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Address" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Address_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- TOC entry 210 (class 1259 OID 25726)
-- Name: Author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Author" (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public."Author" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 25731)
-- Name: Book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book" (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author integer,
    edition integer,
    publisher character varying(255),
    year_publication integer,
    num_pages integer,
    barcode character varying(255),
    genre character varying(255),
    location integer,
    cover text,
    description text
);


ALTER TABLE public."Book" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25709)
-- Name: Location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    stand integer,
    shelf integer
);


ALTER TABLE public."Location" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25920)
-- Name: Book_add; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_add" AS
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
   FROM ((public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
     LEFT JOIN public."Location" ON (("Book".location = "Location".id)));


ALTER TABLE public."Book_add" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 26068)
-- Name: Book_detail; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_detail" AS
 SELECT "Book".id,
    "Book".title,
    "Author".name AS author,
    "Book".year_publication,
    "Book".genre,
    "Book".edition,
    "Book".cover,
    "Book".barcode,
    "Book".description,
    "Location".stand,
    "Location".shelf
   FROM ((public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
     LEFT JOIN public."Location" ON (("Book".location = "Location".id)));


ALTER TABLE public."Book_detail" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25915)
-- Name: Book_edit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_edit" AS
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
   FROM ((public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
     LEFT JOIN public."Location" ON (("Book".location = "Location".id)));


ALTER TABLE public."Book_edit" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 26035)
-- Name: Book_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_list" AS
 SELECT "Book".id,
    "Book".title,
    "Author".name AS author,
    "Book".year_publication,
    "Book".cover
   FROM (public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)));


ALTER TABLE public."Book_list" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 26063)
-- Name: Book_search; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_search" AS
 SELECT "Book".id,
    "Book".title,
    "Author".name AS author,
    "Book".edition,
    "Book".publisher,
    "Book".year_publication,
    "Book".barcode,
    "Book".cover,
    "Location".stand,
    "Location".shelf
   FROM ((public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
     LEFT JOIN public."Location" ON (("Book".location = "Location".id)));


ALTER TABLE public."Book_search" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25863)
-- Name: Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Company" (
    id integer NOT NULL,
    name character varying(255),
    cnpj character varying(255)
);


ALTER TABLE public."Company" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 25834)
-- Name: Confiability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Confiability" (
    id integer NOT NULL,
    label integer NOT NULL,
    amt_allowed_books integer,
    amt_borrowed_books integer
);


ALTER TABLE public."Confiability" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 26101)
-- Name: Confiability_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Confiability" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Confiability_id_seq"
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 25870)
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    id integer NOT NULL,
    name character varying(255),
    cpf character varying(255),
    phone character varying(255),
    email character varying(255),
    birth_date date,
    registration character varying(255),
    password character varying(255)
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25879)
-- Name: Loan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Loan" (
    id integer NOT NULL,
    "user" integer,
    book integer,
    start_date date,
    return_period date,
    return_date date
);


ALTER TABLE public."Loan" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25844)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name character varying(255),
    cpf character varying(255),
    phone character varying(255),
    address integer,
    email character varying(255),
    birth_date date,
    confiability integer
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 26025)
-- Name: Loan_detail; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_detail" AS
 SELECT "Loan".id,
    "User".id AS user_id,
    "Book".id AS book_id,
    "User".name AS "user",
    "Book".title AS book,
    "Book".cover,
    "Loan".start_date,
    "Loan".return_period,
    "Loan".return_date
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_detail" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25994)
-- Name: Loan_edit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_edit" AS
 SELECT "Loan".id,
    "User".name AS "user",
    "Book".title AS book,
    "Loan".start_date,
    "Loan".return_period,
    "Loan".return_date
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_edit" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25989)
-- Name: Loan_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_list" AS
 SELECT "Loan".id,
    "User".name AS "user",
    "Book".title AS book,
    "Loan".start_date,
    "Loan".return_period,
    "Loan".return_date
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_list" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 26014)
-- Name: Loan_search; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_search" AS
 SELECT "Loan".id,
    "User".name AS "user",
    "Book".title AS book,
    "Loan".start_date,
    "Loan".return_period,
    "Loan".return_date
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_search" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 25827)
-- Name: Seal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seal" (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public."Seal" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 26084)
-- Name: User_add; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_add" AS
 SELECT "User".name,
    "User".cpf,
    "User".phone,
    "User".email,
    "User".birth_date,
    "Address".type,
    "Address".logradouro,
    "Address".number,
    "Address".district,
    "Address".city,
    "Address".state,
    "Address".zip_code
   FROM (public."User"
     LEFT JOIN public."Address" ON (("User".address = "Address".id)));


ALTER TABLE public."User_add" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 26114)
-- Name: User_detail; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_detail" AS
 SELECT "User".id,
    "User".name,
    "User".cpf,
    "User".phone,
    "User".email,
    "User".birth_date,
    "Seal".label AS confiability,
    "Address".type,
    "Address".logradouro,
    "Address".number,
    "Address".district,
    "Address".city,
    "Address".state,
    "Address".zip_code
   FROM (((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".id)))
     LEFT JOIN public."Seal" ON (("Confiability".label = "Seal".id)))
     LEFT JOIN public."Address" ON (("User".address = "Address".id)));


ALTER TABLE public."User_detail" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25975)
-- Name: User_edit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_edit" AS
 SELECT "User".id,
    "User".name,
    "User".cpf,
    "User".phone,
    "User".email,
    "User".birth_date,
    "Seal".label AS confiability,
    "Address".type,
    "Address".logradouro,
    "Address".number,
    "Address".district,
    "Address".city,
    "Address".state,
    "Address".zip_code
   FROM (((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".label)))
     LEFT JOIN public."Seal" ON (("Confiability".id = "Seal".id)))
     LEFT JOIN public."Address" ON (("User".address = "Address".id)));


ALTER TABLE public."User_edit" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 26089)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."User" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- TOC entry 226 (class 1259 OID 26031)
-- Name: User_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_list" AS
 SELECT "User".id,
    "User".name,
    "User".cpf,
    "Seal".label AS confiability
   FROM ((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".id)))
     LEFT JOIN public."Seal" ON (("Confiability".label = "Seal".id)));


ALTER TABLE public."User_list" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 26055)
-- Name: User_search; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_search" AS
 SELECT "User".id,
    "User".cpf,
    "User".name,
    "Seal".label AS confiability
   FROM ((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".id)))
     LEFT JOIN public."Seal" ON (("Confiability".label = "Seal".id)));


ALTER TABLE public."User_search" OWNER TO postgres;

--
-- TOC entry 3449 (class 0 OID 25801)
-- Dependencies: 212
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Address" (id, type, logradouro, number, district, city, state, zip_code) FROM stdin;
1	Sitio	Macapa	42	CAMPIM SANTO	Flores	PE	58753-000
2	RUA	MARCHAREL SILVA	43	CENTRO	TAVARES	PB	58753-000
7	Rua	Varzea	2	CENTRO	Princesa Isabel	PB	58755-000
\.


--
-- TOC entry 3447 (class 0 OID 25726)
-- Dependencies: 210
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" (id, name) FROM stdin;
1	Lima Barreto
2	Mario de Andrade
\.


--
-- TOC entry 3448 (class 0 OID 25731)
-- Dependencies: 211
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" (id, title, author, edition, publisher, year_publication, num_pages, barcode, genre, location, cover, description) FROM stdin;
1	Triste Fim De Policarpo Quaresma	1	1	Lima Barreto	1945	100	L001	Romance	1	https://images-na.ssl-images-amazon.com/images/I/918ojG9v8oL.jpg	O Triste Fim de Policarpo Quaresma, de Lima Barreto, narra a trajetória de Policarpo Quaresma, um patriota ímpar, que causa estranheza nas pessoas pelos seus ideais e coragem. O livro é dividido em três partes. A primeira começa descrevendo a rotina do Major Policarpo Quaresma.
2	Macunaima	2	1	Mario de Andrade	1928	259	L002	Humor	2	https://m.media-amazon.com/images/P/B01H6A95ZM.01._SCLZZZZZZZ_SX500_.jpg	Personagem principal do livro, é individualista, preguiçoso e faz o que deseja sem se preocupar com nada. Além disso, é vaidoso, mente com a maior facilidade e gosta, acima de tudo, de se entregar aos prazeres carnais. Maanape: irmão de Macunaíma. Tinha fama de feiticeiro e representa o povo negro.
\.


--
-- TOC entry 3453 (class 0 OID 25863)
-- Dependencies: 216
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Company" (id, name, cnpj) FROM stdin;
1	INSS	01
2	BANCO DO BRASIL	02
\.


--
-- TOC entry 3451 (class 0 OID 25834)
-- Dependencies: 214
-- Data for Name: Confiability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Confiability" (id, label, amt_allowed_books, amt_borrowed_books) FROM stdin;
2	2	1	1
1	3	5	1
6	1	2	0
3	1	2	0
\.


--
-- TOC entry 3454 (class 0 OID 25870)
-- Dependencies: 217
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" (id, name, cpf, phone, email, birth_date, registration, password) FROM stdin;
1	Douglas	000.000.000-00	(83) 9 9999 9999	douglas@email.com	2000-12-12	1	123
2	Gisele	111.111.111-11	(83) 9 8888 8888	gisele@email.com	2000-11-11	2	321
\.


--
-- TOC entry 3455 (class 0 OID 25879)
-- Dependencies: 218
-- Data for Name: Loan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Loan" (id, "user", book, start_date, return_period, return_date) FROM stdin;
1	1	2	2021-01-01	2021-02-02	2021-01-20
2	2	1	2021-03-02	2021-03-07	2021-03-05
\.


--
-- TOC entry 3446 (class 0 OID 25709)
-- Dependencies: 209
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, stand, shelf) FROM stdin;
1	5	3
2	3	4
\.


--
-- TOC entry 3450 (class 0 OID 25827)
-- Dependencies: 213
-- Data for Name: Seal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seal" (id, label) FROM stdin;
1	Bronze
2	Prata
3	Ouro
\.


--
-- TOC entry 3452 (class 0 OID 25844)
-- Dependencies: 215
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, cpf, phone, address, email, birth_date, confiability) FROM stdin;
1	Douglas Costa	444.444.444-44	(83) 9 9999-9999	1	douglasCosta@email.com	2002-12-12	2
2	Celio Vieira	111.111.111-11	(83) 9 8888-8888	2	celio@emaill.com	2004-01-01	1
3	Marcos Madeira Oliveira	555.555.555-55	(83) 9 0000-0000	7	marcos@email.com	2000-12-12	3
\.


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 233
-- Name: Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Address_id_seq"', 7, true);


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 234
-- Name: Confiability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Confiability_id_seq"', 3, true);


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 232
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 3, true);


--
-- TOC entry 3268 (class 2606 OID 25807)
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 25730)
-- Name: Author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 25737)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 25869)
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2606 OID 25838)
-- Name: Confiability Confiability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Confiability"
    ADD CONSTRAINT "Confiability_pkey" PRIMARY KEY (id);


--
-- TOC entry 3280 (class 2606 OID 25878)
-- Name: Employee Employee_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3282 (class 2606 OID 25876)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 25883)
-- Name: Loan Loan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_pkey" PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 25713)
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 25833)
-- Name: Seal Seal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seal"
    ADD CONSTRAINT "Seal_pkey" PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 25852)
-- Name: User User_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3276 (class 2606 OID 25850)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3443 (class 2618 OID 26080)
-- Name: Book_edit book_update; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE book_update AS
    ON UPDATE TO public."Book_edit" DO INSTEAD ( UPDATE public."Book" SET title = new.title, edition = new.edition, publisher = new.publisher, year_publication = new.year_publication, num_pages = new.num_pages, barcode = new.barcode, genre = new.genre, cover = new.cover, description = new.description
  WHERE ("Book".id = old.id);
 UPDATE public."Author" SET name = new.author
  WHERE ("Author".id = old.id);
 UPDATE public."Location" SET stand = new.stand, shelf = new.shelf
  WHERE ("Location".id = old.id);
);


--
-- TOC entry 3286 (class 2606 OID 25743)
-- Name: Book Book_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_author_fkey" FOREIGN KEY (author) REFERENCES public."Author"(id);


--
-- TOC entry 3285 (class 2606 OID 25738)
-- Name: Book Book_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_location_fkey" FOREIGN KEY (location) REFERENCES public."Location"(id);


--
-- TOC entry 3287 (class 2606 OID 25839)
-- Name: Confiability Confiability_label_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Confiability"
    ADD CONSTRAINT "Confiability_label_fkey" FOREIGN KEY (label) REFERENCES public."Seal"(id);


--
-- TOC entry 3291 (class 2606 OID 25889)
-- Name: Loan Loan_book_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_book_fkey" FOREIGN KEY (book) REFERENCES public."Book"(id);


--
-- TOC entry 3290 (class 2606 OID 25884)
-- Name: Loan Loan_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_user_fkey" FOREIGN KEY ("user") REFERENCES public."User"(id);


--
-- TOC entry 3288 (class 2606 OID 25853)
-- Name: User User_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_address_fkey" FOREIGN KEY (address) REFERENCES public."Address"(id);


--
-- TOC entry 3289 (class 2606 OID 25858)
-- Name: User User_confiability_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_confiability_fkey" FOREIGN KEY (confiability) REFERENCES public."Confiability"(id);


-- Completed on 2022-04-20 20:38:27

--
-- PostgreSQL database dump complete
--

-- Completed on 2022-04-20 20:38:27

--
-- PostgreSQL database cluster dump complete
--

