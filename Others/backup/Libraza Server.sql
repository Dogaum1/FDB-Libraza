--
-- PostgreSQL database cluster dump
--

-- Started on 2022-04-28 14:44:59

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

-- Started on 2022-04-28 14:44:59

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

-- Completed on 2022-04-28 14:45:00

--
-- PostgreSQL database dump complete
--

--
-- Database "libraza_database" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-28 14:45:00

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
-- TOC entry 3491 (class 1262 OID 25618)
-- Name: libraza_database; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE libraza_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE libraza_database OWNER TO postgres;

\connect libraza_database

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
-- TOC entry 258 (class 1255 OID 26192)
-- Name: book_insert(character, character, integer, character, integer, integer, character, character, integer, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.book_insert(new_title character, new_author character, new_edition integer, new_publisher character, new_year_publication integer, new_num_pages integer, new_barcode character, new_genre character, new_amount integer, new_stand integer, new_shelf integer, new_cover character, new_description character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_author_id integer;
    new_location_id integer;
	new_book_id integer;
BEGIN

    INSERT INTO "Author" (name)
    VALUES (new_author) RETURNING id INTO new_author_id;
	
	INSERT INTO "Location" (stand, shelf)
    VALUES (new_stand, new_shelf) RETURNING id INTO new_location_id;
    
    INSERT INTO "Book" (title, author, edition, publisher, year_publication, num_pages, barcode, amount, available_amount, genre, location, cover, description)
    VALUES (new_title, new_author_id, new_edition, new_publisher, new_year_publication, new_num_pages, new_barcode, new_amount, (new_amount-1), new_genre, new_location_id, new_cover, new_description) RETURNING id INTO new_book_id;
	
	RETURN new_book_id;
	
END
$$;


ALTER FUNCTION public.book_insert(new_title character, new_author character, new_edition integer, new_publisher character, new_year_publication integer, new_num_pages integer, new_barcode character, new_genre character, new_amount integer, new_stand integer, new_shelf integer, new_cover character, new_description character) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 26153)
-- Name: book_remove(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.book_remove(delete_barcode character) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	remove_book_id integer;
	remove_author_id integer;
    remove_location_id integer;
BEGIN
	
	SELECT id, author, location FROM "Book" WHERE (barcode = delete_barcode) INTO remove_book_id, remove_author_id, remove_location_id;
	DELETE FROM "Book" WHERE id = remove_book_id;
	DELETE FROM "Author" WHERE id = remove_author_id;
	DELETE FROM "Location" WHERE id = remove_location_id;
	
END
$$;


ALTER FUNCTION public.book_remove(delete_barcode character) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 26130)
-- Name: book_update(integer, character, character, integer, character, integer, integer, character, character, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.book_update(book_id integer, new_title character, new_author character, new_edition integer, new_publisher character, new_year_publication integer, new_num_pages integer, new_barcode character, new_genre character, new_stand integer, new_shelf integer, new_cover character, new_description character) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    modify_author_id integer;
    modify_location_id integer;
BEGIN
	
	UPDATE "Book" SET title = new_title, edition = new_edition, publisher = new_publisher, year_publication = new_year_publication, num_pages = new_num_pages, barcode = new_barcode, genre = new_genre, cover = new_cover, description = new_description
  	WHERE (id = book_id) RETURNING "Book".author, "Book".location INTO modify_author_id, modify_location_id;
	
 	UPDATE "Author" SET name = new_author
    WHERE (id = modify_author_id);

    UPDATE "Location" SET stand = new_stand, shelf = new_shelf
    WHERE (id = modify_location_id);

END
$$;


ALTER FUNCTION public.book_update(book_id integer, new_title character, new_author character, new_edition integer, new_publisher character, new_year_publication integer, new_num_pages integer, new_barcode character, new_genre character, new_stand integer, new_shelf integer, new_cover character, new_description character) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 26276)
-- Name: loan_insert(character, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loan_insert(in_cpf character, in_user character, in_barcode character, in_book character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_user_id integer;
    new_book_id integer;
    new_confiability_id integer;
	new_confiability_label integer;
	new_loan_id integer;
	new_return_date date;
BEGIN
	SELECT "User".id, confiability, "Confiability".label FROM "User" 
    LEFT JOIN "Confiability" ON "User".confiability = "Confiability".id
    WHERE cpf = in_cpf INTO new_user_id, new_confiability_id, new_confiability_label;
	
    SELECT id FROM "Book" WHERE barcode = in_barcode INTO new_book_id;
	
	IF new_confiability_label = 1 THEN new_return_Date = CURRENT_DATE + 7; END IF;
	IF new_confiability_label = 2 THEN new_return_Date = CURRENT_DATE + 10; END IF;
	IF new_confiability_label = 3 THEN new_return_Date = CURRENT_DATE + 14; END IF;
	
	INSERT INTO "Loan" ("user", book, start_date, return_period)
    VALUES (new_user_id, new_book_id, CURRENT_DATE, new_return_Date)
	RETURNING "Loan".id into new_loan_id;
    
    UPDATE "Confiability" SET amt_borrowed_books = amt_borrowed_books + 1 WHERE id = new_confiability_id;
	UPDATE "Book" SET available_amount = available_amount - 1 WHERE id = new_book_id;
	
	RETURN new_loan_id;
   
END
$$;


ALTER FUNCTION public.loan_insert(in_cpf character, in_user character, in_barcode character, in_book character) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 26294)
-- Name: loan_renew_validate(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loan_renew_validate(in_loan_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
	loan_return_period date;
BEGIN
	SELECT return_period from "Loan" WHERE id = in_loan_id INTO loan_return_period;
	IF CURRENT_DATE < loan_return_period - 2 THEN RETURN FALSE; END IF;
	RETURN TRUE;
END
$$;


ALTER FUNCTION public.loan_renew_validate(in_loan_id integer) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 26255)
-- Name: loan_return(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loan_return(in_loan_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    confiability_id integer;
    book_id integer; 
	confiability_points integer;
	new_label integer;
	new_amt_allowed_books integer;
BEGIN
	UPDATE "Loan" SET return_date = CURRENT_DATE WHERE id = in_loan_id;
	
	SELECT "Confiability".id, "Loan".book from "Loan" 
	LEFT JOIN "User" ON "Loan".user = "User".id 
	LEFT JOIN "Confiability" ON "User".confiability = "Confiability".id
	WHERE "Loan".id = in_loan_id INTO confiability_id, book_id;
	
	UPDATE "Confiability" SET points = points + 5 WHERE id = confiability_id RETURNING points INTO confiability_points;
	
	IF confiability_points < 20 THEN new_label = 1; new_amt_allowed_books = 2; END IF;
	IF confiability_points >= 20 AND confiability_points < 50 THEN new_amt_allowed_books = 3; new_label = 2; END IF;
	IF confiability_points >= 50 THEN new_label = 3; new_amt_allowed_books = 5; END IF;
	
	UPDATE "Confiability" 
    SET label = new_label,
    amt_allowed_books = new_amt_allowed_books,
    amt_borrowed_books = amt_borrowed_books - 1
    WHERE "Confiability".id = confiability_id;
    
	UPDATE "Book" SET available_amount = available_amount + 1 WHERE id = book_id;
    
END
$$;


ALTER FUNCTION public.loan_return(in_loan_id integer) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 26218)
-- Name: loan_update(integer, character, character, date, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loan_update(loan_id integer, new_user character, new_book character, new_start_date date, new_return_period date, new_return_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN
	
	UPDATE "Loan" SET start_date = new_start_date, return_period = new_return_period, return_date = new_return_date WHERE id = loan_id;
	
END
$$;


ALTER FUNCTION public.loan_update(loan_id integer, new_user character, new_book character, new_start_date date, new_return_period date, new_return_date date) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 26277)
-- Name: loan_validate(character, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loan_validate(in_user_cpf character, in_user_name character, in_barcode character, in_book_name character) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
	result_array text[];
    user_id integer;
    book_id integer;
    loan_verify integer;
	user_amt_borrowed_books integer;
	user_amt_allowed_books integer;
	book_available_amount integer;
BEGIN

	SELECT "User".id, "Confiability".amt_borrowed_books, amt_allowed_books
	FROM "User"
	LEFT JOIN "Confiability" ON "User".confiability = "Confiability".id
	WHERE "User".cpf = in_user_cpf 
	INTO user_id, user_amt_borrowed_books, user_amt_allowed_books;
	
	SELECT "Book".id, available_amount FROM "Book" WHERE barcode = in_barcode INTO book_id, book_available_amount;
	SELECT "Loan".id FROM "Loan" WHERE "Loan".user = user_id AND "Loan".book = book_id AND "Loan".return_date IS NULL INTO loan_verify;
    
	IF user_amt_borrowed_books >= user_amt_allowed_books THEN result_array = array_append(result_array, 'borrow_limit'); END IF;
    IF book_available_amount <= 1 THEN result_array = array_append(result_array, 'available_limit'); END IF;
	IF loan_verify IS NOT NULL THEN result_array = array_append(result_array, 'already_borrowed'); END IF;
	RETURN result_array;
END
$$;


ALTER FUNCTION public.loan_validate(in_user_cpf character, in_user_name character, in_barcode character, in_book_name character) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 26193)
-- Name: user_insert(character, character, character, character, date, character, character, integer, character, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_insert(name character, cpf character, phone character, email character, birth_date date, type character, logradouro character, number integer, district character, city character, state character, zip_code character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_address_id integer;
    new_confiability_id integer;
	new_user_id integer;
BEGIN

    INSERT INTO "Address" (type, logradouro, number, district, city, state, zip_code)
    VALUES (type, logradouro, number, district, city, state, zip_code) RETURNING id INTO new_address_id;
    
    INSERT INTO "Confiability" DEFAULT VALUES RETURNING id into new_confiability_id;
    
    INSERT INTO "User" (name, cpf, phone, address, email, birth_date, confiability)
    VALUES (name, cpf, phone, new_address_id, email, birth_date, new_confiability_id) RETURNING id into new_user_id;
	
	RETURN new_user_id;
	
END
$$;


ALTER FUNCTION public.user_insert(name character, cpf character, phone character, email character, birth_date date, type character, logradouro character, number integer, district character, city character, state character, zip_code character) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 26145)
-- Name: user_remove(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_remove(delete_cpf character) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	remove_user_id integer;
    remove_address_id integer;
    remove_confiability_id integer;
BEGIN
	
	SELECT id, address, confiability FROM "User" WHERE (cpf = delete_cpf) INTO remove_user_id, remove_address_id, remove_confiability_id ;
	DELETE FROM "User" WHERE id = remove_user_id;
	DELETE FROM "Address" WHERE id = remove_address_id;
	DELETE FROM "Confiability" WHERE id = remove_confiability_id;
	
END
$$;


ALTER FUNCTION public.user_remove(delete_cpf character) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 26124)
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
-- TOC entry 228 (class 1259 OID 26091)
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
-- TOC entry 230 (class 1259 OID 26131)
-- Name: Author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Author" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Author_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
    description text,
    amount integer DEFAULT 1,
    available_amount integer DEFAULT 0
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
-- TOC entry 234 (class 1259 OID 26184)
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
    "Book".amount,
    "Location".stand,
    "Location".shelf,
    "Book".cover,
    "Book".description
   FROM ((public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
     LEFT JOIN public."Location" ON (("Book".location = "Location".id)));


ALTER TABLE public."Book_add" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 26068)
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
    "Location".shelf,
    "Book".available_amount
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
-- TOC entry 232 (class 1259 OID 26133)
-- Name: Book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Book" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Book_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 26035)
-- Name: Book_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Book_list" AS
 SELECT "Book".id,
    "Book".title,
    "Author".name AS author,
    "Book".year_publication,
    "Book".cover
   FROM (public."Book"
     LEFT JOIN public."Author" ON (("Book".author = "Author".id)))
  ORDER BY "Book".id;


ALTER TABLE public."Book_list" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 26063)
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
    label integer DEFAULT 1 NOT NULL,
    amt_allowed_books integer DEFAULT 2,
    amt_borrowed_books integer DEFAULT 0,
    points integer DEFAULT 0
);


ALTER TABLE public."Confiability" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 26101)
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
-- TOC entry 238 (class 1259 OID 26270)
-- Name: Loan_add; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_add" AS
 SELECT "Loan".id,
    "User".cpf,
    "User".name AS "user",
    "Book".barcode,
    "Book".title AS book
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_add" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 26025)
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
-- TOC entry 239 (class 1259 OID 26278)
-- Name: Loan_edit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_edit" AS
 SELECT "Loan".id,
    "User".name AS "user",
    "Book".title AS book,
    "Loan".start_date,
    "Loan".return_period
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)));


ALTER TABLE public."Loan_edit" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 26134)
-- Name: Loan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Loan" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Loan_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 26220)
-- Name: Loan_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Loan_list" AS
 SELECT "Loan".id,
    "User".name AS "user",
    "Book".title AS book,
    "Loan".start_date,
    "Loan".return_period,
    "Loan".return_date,
        CASE
            WHEN ((CURRENT_DATE > "Loan".return_period) AND ("Loan".return_date IS NULL)) THEN 'Atrazado'::text
            WHEN ("Loan".return_date <= "Loan".return_period) THEN 'Devolvido'::text
            WHEN ("Loan".return_date > "Loan".return_period) THEN 'Devolvido (atrazo)'::text
            WHEN ("Loan".return_date IS NULL) THEN 'Em aberto'::text
            ELSE NULL::text
        END AS status
   FROM ((public."Loan"
     LEFT JOIN public."User" ON (("Loan"."user" = "User".id)))
     LEFT JOIN public."Book" ON (("Loan".book = "Book".id)))
  ORDER BY "Loan".id;


ALTER TABLE public."Loan_list" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 26014)
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
-- TOC entry 231 (class 1259 OID 26132)
-- Name: Location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Location" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Location_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 237 (class 1259 OID 26266)
-- Name: User_add; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_add" AS
 SELECT "User".id,
    "User".name,
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
-- TOC entry 236 (class 1259 OID 26256)
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
    "Confiability".points,
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
-- TOC entry 240 (class 1259 OID 26283)
-- Name: User_edit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_edit" AS
 SELECT "User".id,
    "User".name,
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
   FROM (((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".label)))
     LEFT JOIN public."Seal" ON (("Confiability".id = "Seal".id)))
     LEFT JOIN public."Address" ON (("User".address = "Address".id)));


ALTER TABLE public."User_edit" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 26089)
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
-- TOC entry 222 (class 1259 OID 26031)
-- Name: User_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."User_list" AS
 SELECT "User".id,
    "User".name,
    "User".cpf,
    "Seal".label AS confiability
   FROM ((public."User"
     LEFT JOIN public."Confiability" ON (("User".confiability = "Confiability".id)))
     LEFT JOIN public."Seal" ON (("Confiability".label = "Seal".id)))
  ORDER BY "User".id;


ALTER TABLE public."User_list" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 26055)
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
-- TOC entry 3472 (class 0 OID 25801)
-- Dependencies: 212
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Address" (id, type, logradouro, number, district, city, state, zip_code) FROM stdin;
35	Avenida	Transcontinental	261	Santiago	Ji-Paraná	RO	76901-201
36	Rua	José dos Santos Chaves	198	Brasilar	Teresina	PI	64035-445
37	Praça	Nilson Jaime	145	Vila Abajá	Goiânia	GO	74550-510
38	Quadra	SHIGS 712 Bloco H	737	Asa Sul	Brasília	DF	70361-758
39	Vila	Cosme de Farias	908	Cosme de Farias	Salvador	BA	40254-200
\.


--
-- TOC entry 3470 (class 0 OID 25726)
-- Dependencies: 210
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" (id, name) FROM stdin;
19	Sun Tzu
20	Inio Asano
21	 Tito Leite
\.


--
-- TOC entry 3471 (class 0 OID 25731)
-- Dependencies: 211
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" (id, title, author, edition, publisher, year_publication, num_pages, barcode, genre, location, cover, description, amount, available_amount) FROM stdin;
16	A Arte da Guerra	19	1	Jardim dos Livros	2017	128	8581303897	Ação	19	https://m.media-amazon.com/images/P/B00BBFSD3O.01._SCLZZZZZZZ_SX500_.jpg	O maior tratado de guerra de todos os tempos em sua versão completa em português. “A Arte da Guerra” é sem dúvida a Bíblia da estratégia, sendo hoje utilizada amplamente no mundo dos negócios, conquistando pessoas e mercados.	5	4
18	Dilúvio das almas	21	1	Todavia	2022	112	6556922552	 Ficção	21	https://m.media-amazon.com/images/P/B09S6X7CRZ.01._SCLZZZZZZZ_SX500_.jpg	Leonardo volta ao Nordeste, a Dilúvio das Almas, sua cidade natal, depois de muitos anos vivendo de todas as formas em São Paulo. Mas o retorno ao sertão semiárido está longe de ser idílico: a violência e a ignorância que o fizeram migrar continuam ali. Escrito num tom por vezes filosófico e desencantado, que contrasta com o extremo realismo das cenas e a secura dos diálogos, este é um romance potente sobre como pode ser difícil reinventar o próprio passado.	10	8
17	Boa Noite Punpun	20	1	Editora JBC	2022	432	8545709617	Infantil	20	https://m.media-amazon.com/images/P/B07VCMP6Y1.01._SCLZZZZZZZ_SX500_.jpg	Punpun Onodera é um garoto normal, que vive feliz com sua família. Um dia, Aiko Tanaka é transferida para a sua escola. Foi paixão à primeira vista!! Voltando juntos para casa, ela conta que no futuro, “a Terra vai se tornar um planeta inabitável”.	7	5
\.


--
-- TOC entry 3476 (class 0 OID 25863)
-- Dependencies: 216
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Company" (id, name, cnpj) FROM stdin;
\.


--
-- TOC entry 3474 (class 0 OID 25834)
-- Dependencies: 214
-- Data for Name: Confiability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Confiability" (id, label, amt_allowed_books, amt_borrowed_books, points) FROM stdin;
33	2	3	2	25
31	1	2	0	5
32	1	2	0	5
35	1	2	0	5
34	1	2	0	5
\.


--
-- TOC entry 3477 (class 0 OID 25870)
-- Dependencies: 217
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" (id, name, cpf, phone, email, birth_date, registration, password) FROM stdin;
1	Douglas	000.000.000-00	(83) 9 9999 9999	douglas@email.com	2000-12-12	EMP1	123
2	Gisele	111.111.111-11	(83) 9 8888 8888	gisele@email.com	2000-11-11	EMP2	321
3	Valdemir	222.222.222-22	(83) 9 7777-7777	valdemir@email.com	2000-10-10	EMP3	456
4	Heldon	333.333.333-33	(83) 9 6666-6666	heldon@email.com\n	2000-09-09	EMP4	654
\.


--
-- TOC entry 3478 (class 0 OID 25879)
-- Dependencies: 218
-- Data for Name: Loan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Loan" (id, "user", book, start_date, return_period, return_date) FROM stdin;
21	21	16	2022-04-27	2022-05-02	2022-04-27
26	23	16	2022-04-28	2022-05-05	2022-04-28
22	22	16	2022-04-27	2022-05-10	2022-04-28
23	23	17	2022-04-28	2022-05-05	2022-04-28
24	25	16	2022-04-28	2022-05-05	2022-04-28
25	24	16	2022-04-28	2022-05-05	2022-04-28
27	23	16	2022-04-28	2022-05-05	2022-04-28
28	23	17	2022-04-28	2022-05-05	2022-04-28
29	23	16	2022-04-28	2022-05-08	2022-04-28
30	23	18	2022-04-28	2022-04-30	\N
31	23	17	2022-04-28	2022-05-08	\N
\.


--
-- TOC entry 3469 (class 0 OID 25709)
-- Dependencies: 209
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, stand, shelf) FROM stdin;
19	1	3
20	2	3
21	5	4
\.


--
-- TOC entry 3473 (class 0 OID 25827)
-- Dependencies: 213
-- Data for Name: Seal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seal" (id, label) FROM stdin;
1	Bronze
2	Prata
3	Ouro
\.


--
-- TOC entry 3475 (class 0 OID 25844)
-- Dependencies: 215
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, cpf, phone, address, email, birth_date, confiability) FROM stdin;
21	Joaquim Hugo Alves	374.233.706-81	(69) 9 9497-1862	35	joaquim_alves@renatoseguros.com	1963-03-16	31
22	Thiago José Nascimento	767.044.274-30	(86) 9 8507-2092	36	thiago.jose.nascimento@gruposimoes.com.br	1980-01-06	32
23	Carolina Flávia Melo	433.883.631-88	(62) 9 9739-0752	37	carolinaflaviamelo@artedaserra.com.br	1948-02-11	33
24	Sophia Lavínia Aragão	218.444.189-95	(61) 9 8831-7355	38	sophia-aragao99@diclace.com.br	2000-01-07	34
25	Rafael Kauê Danilo da Luz	151.349.558-59	(71) 9 8961-6815	39	rafael_daluz@bemdito.com.br	1999-01-11	35
\.


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 228
-- Name: Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Address_id_seq"', 39, true);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 230
-- Name: Author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Author_id_seq"', 21, true);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 232
-- Name: Book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Book_id_seq"', 18, true);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 229
-- Name: Confiability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Confiability_id_seq"', 35, true);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 233
-- Name: Loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Loan_id_seq"', 31, true);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 231
-- Name: Location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Location_id_seq"', 21, true);


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 227
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 25, true);


--
-- TOC entry 3290 (class 2606 OID 25807)
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 25730)
-- Name: Author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 25737)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 25869)
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- TOC entry 3294 (class 2606 OID 25838)
-- Name: Confiability Confiability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Confiability"
    ADD CONSTRAINT "Confiability_pkey" PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 25878)
-- Name: Employee Employee_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3304 (class 2606 OID 25876)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 25883)
-- Name: Loan Loan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_pkey" PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 25713)
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 25833)
-- Name: Seal Seal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seal"
    ADD CONSTRAINT "Seal_pkey" PRIMARY KEY (id);


--
-- TOC entry 3296 (class 2606 OID 25852)
-- Name: User User_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_cpf_key" UNIQUE (cpf);


--
-- TOC entry 3298 (class 2606 OID 25850)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3461 (class 2618 OID 26080)
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
-- TOC entry 3308 (class 2606 OID 25743)
-- Name: Book Book_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_author_fkey" FOREIGN KEY (author) REFERENCES public."Author"(id);


--
-- TOC entry 3307 (class 2606 OID 25738)
-- Name: Book Book_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_location_fkey" FOREIGN KEY (location) REFERENCES public."Location"(id);


--
-- TOC entry 3309 (class 2606 OID 25839)
-- Name: Confiability Confiability_label_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Confiability"
    ADD CONSTRAINT "Confiability_label_fkey" FOREIGN KEY (label) REFERENCES public."Seal"(id);


--
-- TOC entry 3313 (class 2606 OID 25889)
-- Name: Loan Loan_book_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_book_fkey" FOREIGN KEY (book) REFERENCES public."Book"(id);


--
-- TOC entry 3312 (class 2606 OID 25884)
-- Name: Loan Loan_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_user_fkey" FOREIGN KEY ("user") REFERENCES public."User"(id);


--
-- TOC entry 3310 (class 2606 OID 25853)
-- Name: User User_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_address_fkey" FOREIGN KEY (address) REFERENCES public."Address"(id);


--
-- TOC entry 3311 (class 2606 OID 25858)
-- Name: User User_confiability_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_confiability_fkey" FOREIGN KEY (confiability) REFERENCES public."Confiability"(id);


-- Completed on 2022-04-28 14:45:00

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

-- Started on 2022-04-28 14:45:00

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
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


-- Completed on 2022-04-28 14:45:00

--
-- PostgreSQL database dump complete
--

-- Completed on 2022-04-28 14:45:00

--
-- PostgreSQL database cluster dump complete
--

