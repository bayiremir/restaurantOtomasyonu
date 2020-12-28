--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6
-- Dumped by pg_dump version 12rc1

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
-- Name: RestaurantOtomasyon; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "RestaurantOtomasyon" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';


ALTER DATABASE "RestaurantOtomasyon" OWNER TO postgres;

\connect "RestaurantOtomasyon"

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
-- Name: bulacıkcıyeni(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."bulacıkcıyeni"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into bulasıkcı(ad,soyad)values(new.ad,new.soyad);
end;
$$;


ALTER FUNCTION public."bulacıkcıyeni"() OWNER TO postgres;

--
-- Name: fnckdvhesabi(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fnckdvhesabi(fiyat integer) RETURNS money
    LANGUAGE plpgsql
    AS $$
DECLARE
    kdv INTEGER;
BEGIN
       kdv =fiyat*0.18;
       
    RETURN kdv;
END;
$$;


ALTER FUNCTION public.fnckdvhesabi(fiyat integer) OWNER TO postgres;

--
-- Name: fnckdvhesabi(money); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fnckdvhesabi(fiyat money) RETURNS money
    LANGUAGE plpgsql
    AS $$
DECLARE
    kdv money;
BEGIN
       kdv =fiyat*0.18;
       

    RETURN kdv;
END;
$$;


ALTER FUNCTION public.fnckdvhesabi(fiyat money) OWNER TO postgres;

--
-- Name: int_to_text(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.int_to_text(integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
    SELECT textin(int4out($1));
$_$;


ALTER FUNCTION public.int_to_text(integer) OWNER TO postgres;

--
-- Name: isimgetir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isimgetir(prmt character varying) RETURNS TABLE(id integer, ad character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT
    ID,
    AD
FROM
    personeller
where 
    AD like prmt;
    END;
    $$;


ALTER FUNCTION public.isimgetir(prmt character varying) OWNER TO postgres;

--
-- Name: kdvlifiyat(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kdvlifiyat(fiyat double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
       FIYAT=FIYAT*0.18+FIYAT;
       
    RETURN FIYAT;
END;
$$;


ALTER FUNCTION public.kdvlifiyat(fiyat double precision) OWNER TO postgres;

--
-- Name: kdvlifiyat(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kdvlifiyat(fiyat integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
       FIYAT=FIYAT*0.18+FIYAT;
       
    RETURN FIYAT;
END;
$$;


ALTER FUNCTION public.kdvlifiyat(fiyat integer) OWNER TO postgres;

--
-- Name: test(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
update toplamurunsayisi set sayi=sayi+1; 
return new;
end;
$$;


ALTER FUNCTION public.test() OWNER TO postgres;

--
-- Name: test2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
adet integer;
BEGIN
adet=(SELECT length("URUNAD")from urunler order by "ID" DESC limit 1);
update toplamurunsayisi set uzunluk=uzunluk+adet;
return new;
end;
$$;


ALTER FUNCTION public.test2() OWNER TO postgres;

--
-- Name: test3(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test3() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
fiyatT integer;
BEGIN
fiyatT=(SELECT toplamfiyat from urunler order by "ID" DESC limit 1);
update toplamurunsayisi set toplamfiyat=toplamfiyat+fiyatT;
return new;
end;
$$;


ALTER FUNCTION public.test3() OWNER TO postgres;

--
-- Name: CAST (integer AS text); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (integer AS text) WITH FUNCTION public.int_to_text(integer) AS IMPLICIT;


SET default_tablespace = '';

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "personelNo" integer NOT NULL,
    adi character varying(40) NOT NULL,
    soyadi character varying(40) NOT NULL,
    "personelTipi" character(1) NOT NULL
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: Personel_personelNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Personel_personelNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Personel_personelNo_seq" OWNER TO postgres;

--
-- Name: Personel_personelNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Personel_personelNo_seq" OWNED BY public."Personel"."personelNo";


--
-- Name: adisyon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adisyon (
    "SERVISTURNO" integer,
    "PERSONELID" integer,
    "MASAID" integer,
    "ID" integer NOT NULL,
    "DURUM" integer
);


ALTER TABLE public.adisyon OWNER TO postgres;

--
-- Name: adisyon_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."adisyon_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."adisyon_ID_seq" OWNER TO postgres;

--
-- Name: adisyon_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."adisyon_ID_seq" OWNED BY public.adisyon."ID";


--
-- Name: bulasıkcı; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."bulasıkcı" (
    ad character varying(2044),
    soyad character varying(2044)
);


ALTER TABLE public."bulasıkcı" OWNER TO postgres;

--
-- Name: hesapOdemeleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."hesapOdemeleri" (
    "ADISYONID" integer,
    "ODEMETURID" integer,
    "ARATOPLAM" money,
    "KDVTUTARI" money,
    "INDIRIM" money,
    "TOPLAMTUTAR" money,
    "TARIH" date,
    "MUSTERIID" integer,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public."hesapOdemeleri" OWNER TO postgres;

--
-- Name: hesapOdemeleri_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."hesapOdemeleri_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."hesapOdemeleri_ID_seq" OWNER TO postgres;

--
-- Name: hesapOdemeleri_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."hesapOdemeleri_ID_seq" OWNED BY public."hesapOdemeleri"."ID";


--
-- Name: kategoriler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategoriler (
    "DURUM" boolean,
    "ID" integer NOT NULL,
    "FIYATLAR" integer,
    "KATEGORIADI" character varying(2044)
);


ALTER TABLE public.kategoriler OWNER TO postgres;

--
-- Name: kategoriler_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."kategoriler_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."kategoriler_ID_seq" OWNER TO postgres;

--
-- Name: kategoriler_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."kategoriler_ID_seq" OWNED BY public.kategoriler."ID";


--
-- Name: masalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masalar (
    "KAPASITE" integer,
    "SERVISTURU" integer,
    "DURUM" integer,
    "ID" integer NOT NULL,
    "ONAY" bit varying(2044) DEFAULT '0'::bit varying NOT NULL
);


ALTER TABLE public.masalar OWNER TO postgres;

--
-- Name: masalar_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."masalar_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."masalar_ID_seq" OWNER TO postgres;

--
-- Name: masalar_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."masalar_ID_seq" OWNED BY public.masalar."ID";


--
-- Name: musteriler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteriler (
    "AD" character varying(2044),
    "SOYAD" character varying(2044),
    "ADRES" text,
    "TELEFON" character varying(2044),
    "ILKSIPARIS" date,
    "EMAIL" character varying(2044),
    "SIPARISSAYISI" integer,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public.musteriler OWNER TO postgres;

--
-- Name: musteriler_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."musteriler_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."musteriler_ID_seq" OWNER TO postgres;

--
-- Name: musteriler_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."musteriler_ID_seq" OWNED BY public.musteriler."ID";


--
-- Name: odemeTurleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."odemeTurleri" (
    "ODEMETURU" character varying(2044),
    "ACIKLAMA" text,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public."odemeTurleri" OWNER TO postgres;

--
-- Name: odemeTurleri_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."odemeTurleri_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."odemeTurleri_ID_seq" OWNER TO postgres;

--
-- Name: odemeTurleri_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."odemeTurleri_ID_seq" OWNED BY public."odemeTurleri"."ID";


--
-- Name: paketSiparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."paketSiparis" (
    "MUSTERIID" integer,
    "ODEMEID" integer,
    "ODEMETURID" integer,
    "ACIKLAMA" integer,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public."paketSiparis" OWNER TO postgres;

--
-- Name: paketSiparis_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."paketSiparis_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."paketSiparis_ID_seq" OWNER TO postgres;

--
-- Name: paketSiparis_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."paketSiparis_ID_seq" OWNED BY public."paketSiparis"."ID";


--
-- Name: personelGorevleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."personelGorevleri" (
    "GOREV" character varying(2044),
    "ACIKLAMA" text,
    "DURUM" integer DEFAULT 0,
    "ID" integer NOT NULL
);


ALTER TABLE public."personelGorevleri" OWNER TO postgres;

--
-- Name: personelGorevleri_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."personelGorevleri_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."personelGorevleri_ID_seq" OWNER TO postgres;

--
-- Name: personelGorevleri_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."personelGorevleri_ID_seq" OWNED BY public."personelGorevleri"."ID";


--
-- Name: personelHareketleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."personelHareketleri" (
    "PERSONELID" integer,
    "ISLEM" character varying(2044),
    "TARIH" date,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public."personelHareketleri" OWNER TO postgres;

--
-- Name: personelHareketleri_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."personelHareketleri_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."personelHareketleri_ID_seq" OWNER TO postgres;

--
-- Name: personelHareketleri_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."personelHareketleri_ID_seq" OWNED BY public."personelHareketleri"."ID";


--
-- Name: personeller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personeller (
    "AD" character varying(2044),
    "SOYAD" character varying(2044),
    "GOREVID" integer,
    "KULLANICIADI" character varying(2044),
    "PAROLA" character varying(2044),
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public.personeller OWNER TO postgres;

--
-- Name: personeller_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."personeller_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."personeller_ID_seq" OWNER TO postgres;

--
-- Name: personeller_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."personeller_ID_seq" OWNED BY public.personeller."ID";


--
-- Name: rezervasyon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rezervasyon (
    "MUSTERIID" integer,
    "MASAID" integer,
    "TARIH" date,
    "KASISAYISI" integer,
    "DURUM" boolean,
    "ACIKLAMA" text,
    "ADISYONID" integer,
    "ID" integer NOT NULL
);


ALTER TABLE public.rezervasyon OWNER TO postgres;

--
-- Name: rezervasyon_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."rezervasyon_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."rezervasyon_ID_seq" OWNER TO postgres;

--
-- Name: rezervasyon_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."rezervasyon_ID_seq" OWNED BY public.rezervasyon."ID";


--
-- Name: satislar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satislar (
    "ADISYONID" integer,
    "URUNID" integer,
    "MASAID" integer,
    "ADET" integer,
    "DURUM" boolean,
    "ID" integer NOT NULL
);


ALTER TABLE public.satislar OWNER TO postgres;

--
-- Name: satislar_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."satislar_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."satislar_ID_seq" OWNER TO postgres;

--
-- Name: satislar_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."satislar_ID_seq" OWNED BY public.satislar."ID";


--
-- Name: servisturu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servisturu (
    "SERVISADI" character varying(2044),
    "ACIKLAMA" text,
    "ID" integer NOT NULL
);


ALTER TABLE public.servisturu OWNER TO postgres;

--
-- Name: servisturu_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."servisturu_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."servisturu_ID_seq" OWNER TO postgres;

--
-- Name: servisturu_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."servisturu_ID_seq" OWNED BY public.servisturu."ID";


--
-- Name: toplamurunsayisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamurunsayisi (
    sayi integer,
    uzunluk integer,
    toplamfiyat integer
);


ALTER TABLE public.toplamurunsayisi OWNER TO postgres;

--
-- Name: urunler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urunler (
    "URUNAD" character varying(2044),
    "DURUM" boolean,
    "KATEGORIID" integer,
    "ID" integer NOT NULL,
    "FIYAT" integer
);


ALTER TABLE public.urunler OWNER TO postgres;

--
-- Name: urunler_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."urunler_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."urunler_ID_seq" OWNER TO postgres;

--
-- Name: urunler_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."urunler_ID_seq" OWNED BY public.urunler."ID";


--
-- Name: Personel personelNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel" ALTER COLUMN "personelNo" SET DEFAULT nextval('public."Personel_personelNo_seq"'::regclass);


--
-- Name: adisyon ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon ALTER COLUMN "ID" SET DEFAULT nextval('public."adisyon_ID_seq"'::regclass);


--
-- Name: hesapOdemeleri ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapOdemeleri" ALTER COLUMN "ID" SET DEFAULT nextval('public."hesapOdemeleri_ID_seq"'::regclass);


--
-- Name: kategoriler ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoriler ALTER COLUMN "ID" SET DEFAULT nextval('public."kategoriler_ID_seq"'::regclass);


--
-- Name: masalar ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar ALTER COLUMN "ID" SET DEFAULT nextval('public."masalar_ID_seq"'::regclass);


--
-- Name: musteriler ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler ALTER COLUMN "ID" SET DEFAULT nextval('public."musteriler_ID_seq"'::regclass);


--
-- Name: odemeTurleri ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."odemeTurleri" ALTER COLUMN "ID" SET DEFAULT nextval('public."odemeTurleri_ID_seq"'::regclass);


--
-- Name: paketSiparis ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."paketSiparis" ALTER COLUMN "ID" SET DEFAULT nextval('public."paketSiparis_ID_seq"'::regclass);


--
-- Name: personelGorevleri ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelGorevleri" ALTER COLUMN "ID" SET DEFAULT nextval('public."personelGorevleri_ID_seq"'::regclass);


--
-- Name: personelHareketleri ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelHareketleri" ALTER COLUMN "ID" SET DEFAULT nextval('public."personelHareketleri_ID_seq"'::regclass);


--
-- Name: personeller ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personeller ALTER COLUMN "ID" SET DEFAULT nextval('public."personeller_ID_seq"'::regclass);


--
-- Name: rezervasyon ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon ALTER COLUMN "ID" SET DEFAULT nextval('public."rezervasyon_ID_seq"'::regclass);


--
-- Name: satislar ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satislar ALTER COLUMN "ID" SET DEFAULT nextval('public."satislar_ID_seq"'::regclass);


--
-- Name: servisturu ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servisturu ALTER COLUMN "ID" SET DEFAULT nextval('public."servisturu_ID_seq"'::regclass);


--
-- Name: urunler ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunler ALTER COLUMN "ID" SET DEFAULT nextval('public."urunler_ID_seq"'::regclass);


--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: adisyon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adisyon ("SERVISTURNO", "PERSONELID", "MASAID", "ID", "DURUM") VALUES (1, 1, 1, 1, NULL);
INSERT INTO public.adisyon ("SERVISTURNO", "PERSONELID", "MASAID", "ID", "DURUM") VALUES (1, 2, 2, 2, NULL);


--
-- Data for Name: bulasıkcı; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: hesapOdemeleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."hesapOdemeleri" ("ADISYONID", "ODEMETURID", "ARATOPLAM", "KDVTUTARI", "INDIRIM", "TOPLAMTUTAR", "TARIH", "MUSTERIID", "DURUM", "ID") VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public."hesapOdemeleri" ("ADISYONID", "ODEMETURID", "ARATOPLAM", "KDVTUTARI", "INDIRIM", "TOPLAMTUTAR", "TARIH", "MUSTERIID", "DURUM", "ID") VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);


--
-- Data for Name: kategoriler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategoriler ("DURUM", "ID", "FIYATLAR", "KATEGORIADI") VALUES (NULL, 1, 5, 'ANA YEMEK');
INSERT INTO public.kategoriler ("DURUM", "ID", "FIYATLAR", "KATEGORIADI") VALUES (NULL, 2, 5, 'Ana yemek');
INSERT INTO public.kategoriler ("DURUM", "ID", "FIYATLAR", "KATEGORIADI") VALUES (NULL, 3, 5, 'İçecekler');
INSERT INTO public.kategoriler ("DURUM", "ID", "FIYATLAR", "KATEGORIADI") VALUES (NULL, 4, 5, 'tatlılar');


--
-- Data for Name: masalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (5, 1, 1, 1, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (3, 1, 1, 3, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (7, 1, 1, 4, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (10, 1, 1, 5, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (5, 1, 1, 6, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (4, 1, 1, 7, B'0');
INSERT INTO public.masalar ("KAPASITE", "SERVISTURU", "DURUM", "ID", "ONAY") VALUES (6, 1, 2, 2, B'0');


--
-- Data for Name: musteriler; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: odemeTurleri; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: paketSiparis; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: personelGorevleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."personelGorevleri" ("GOREV", "ACIKLAMA", "DURUM", "ID") VALUES ('Komi', 'Komi', 0, 1);
INSERT INTO public."personelGorevleri" ("GOREV", "ACIKLAMA", "DURUM", "ID") VALUES ('Bulaşıkçı', 'Bulaşıkçı', 0, 2);
INSERT INTO public."personelGorevleri" ("GOREV", "ACIKLAMA", "DURUM", "ID") VALUES ('Şef', 'Şef', 0, 3);


--
-- Data for Name: personelHareketleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 7);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 8);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 9);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 10);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 11);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 12);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 13);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 14);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 15);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 16);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 17);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 18);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 19);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 20);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 21);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 22);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 23);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 24);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 25);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 26);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 27);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 28);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 29);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 30);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 31);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 32);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 33);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 34);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 35);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 36);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 37);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-26', NULL, 38);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 39);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 40);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 41);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 42);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 43);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 44);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 45);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 46);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 47);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 48);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 49);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 50);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 51);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 52);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 53);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 54);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 55);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 56);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 57);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 58);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 59);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 60);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 61);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 62);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 63);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 64);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 65);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 66);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 67);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 68);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 69);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 70);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 71);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 72);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 73);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 74);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 75);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 76);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 77);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 78);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 79);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 80);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 81);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 82);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-27', NULL, 83);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 84);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 85);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 86);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 87);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 88);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 89);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 90);
INSERT INTO public."personelHareketleri" ("PERSONELID", "ISLEM", "TARIH", "DURUM", "ID") VALUES (1, 'giriş yaptı', '2020-12-28', NULL, 91);


--
-- Data for Name: personeller; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personeller ("AD", "SOYAD", "GOREVID", "KULLANICIADI", "PAROLA", "DURUM", "ID") VALUES ('Emir', 'Bayir', 1, 'emirbayir', '123', NULL, 1);
INSERT INTO public.personeller ("AD", "SOYAD", "GOREVID", "KULLANICIADI", "PAROLA", "DURUM", "ID") VALUES ('ŞadiEvren', 'Şeker', 2, 'şadi', '123', NULL, 2);


--
-- Data for Name: rezervasyon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rezervasyon ("MUSTERIID", "MASAID", "TARIH", "KASISAYISI", "DURUM", "ACIKLAMA", "ADISYONID", "ID") VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.rezervasyon ("MUSTERIID", "MASAID", "TARIH", "KASISAYISI", "DURUM", "ACIKLAMA", "ADISYONID", "ID") VALUES (2, 1, '2020-01-10', NULL, NULL, NULL, NULL, 2);


--
-- Data for Name: satislar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.satislar ("ADISYONID", "URUNID", "MASAID", "ADET", "DURUM", "ID") VALUES (1, 1, 1, 1, NULL, 1);


--
-- Data for Name: servisturu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.servisturu ("SERVISADI", "ACIKLAMA", "ID") VALUES ('Komi', 'Komi', 1);
INSERT INTO public.servisturu ("SERVISADI", "ACIKLAMA", "ID") VALUES ('Garson', 'Garson', 2);
INSERT INTO public.servisturu ("SERVISADI", "ACIKLAMA", "ID") VALUES ('Aşçı', 'Aşçı', 3);


--
-- Data for Name: toplamurunsayisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.toplamurunsayisi (sayi, uzunluk, toplamfiyat) VALUES (8, NULL, NULL);


--
-- Data for Name: urunler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('ekmek', NULL, 1, 1, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('pilav', NULL, 2, 2, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('kuru fasulye', NULL, 2, 3, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('çay', NULL, 3, 4, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('kahve', NULL, 3, 5, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('milkshake', NULL, 3, 6, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('süt', NULL, 3, 7, 5);
INSERT INTO public.urunler ("URUNAD", "DURUM", "KATEGORIID", "ID", "FIYAT") VALUES ('su', NULL, 3, 8, 5);


--
-- Name: Personel_personelNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Personel_personelNo_seq"', 1, false);


--
-- Name: adisyon_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."adisyon_ID_seq"', 10, true);


--
-- Name: hesapOdemeleri_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."hesapOdemeleri_ID_seq"', 2, true);


--
-- Name: kategoriler_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."kategoriler_ID_seq"', 1, false);


--
-- Name: masalar_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."masalar_ID_seq"', 7, true);


--
-- Name: musteriler_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."musteriler_ID_seq"', 1, false);


--
-- Name: odemeTurleri_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."odemeTurleri_ID_seq"', 1, false);


--
-- Name: paketSiparis_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."paketSiparis_ID_seq"', 1, false);


--
-- Name: personelGorevleri_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."personelGorevleri_ID_seq"', 5, true);


--
-- Name: personelHareketleri_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."personelHareketleri_ID_seq"', 91, true);


--
-- Name: personeller_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."personeller_ID_seq"', 2, true);


--
-- Name: rezervasyon_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."rezervasyon_ID_seq"', 2, true);


--
-- Name: satislar_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."satislar_ID_seq"', 1, false);


--
-- Name: servisturu_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."servisturu_ID_seq"', 5, true);


--
-- Name: urunler_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."urunler_ID_seq"', 1, true);


--
-- Name: adisyon adisyon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT adisyon_pkey PRIMARY KEY ("ID");


--
-- Name: hesapOdemeleri hesapOdemeleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapOdemeleri"
    ADD CONSTRAINT "hesapOdemeleri_pkey" PRIMARY KEY ("ID");


--
-- Name: kategoriler kategoriler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoriler
    ADD CONSTRAINT kategoriler_pkey PRIMARY KEY ("ID");


--
-- Name: masalar masalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masalar_pkey PRIMARY KEY ("ID");


--
-- Name: musteriler musteriler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler
    ADD CONSTRAINT musteriler_pkey PRIMARY KEY ("ID");


--
-- Name: odemeTurleri odemeTurleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."odemeTurleri"
    ADD CONSTRAINT "odemeTurleri_pkey" PRIMARY KEY ("ID");


--
-- Name: paketSiparis paketSiparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."paketSiparis"
    ADD CONSTRAINT "paketSiparis_pkey" PRIMARY KEY ("ID");


--
-- Name: personelGorevleri personelGorevleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelGorevleri"
    ADD CONSTRAINT "personelGorevleri_pkey" PRIMARY KEY ("ID");


--
-- Name: personelHareketleri personelHareketleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelHareketleri"
    ADD CONSTRAINT "personelHareketleri_pkey" PRIMARY KEY ("ID");


--
-- Name: Personel personelPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelPK" PRIMARY KEY ("personelNo");


--
-- Name: rezervasyon rezervasyon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT rezervasyon_pkey PRIMARY KEY ("ID");


--
-- Name: satislar satislar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satislar
    ADD CONSTRAINT satislar_pkey PRIMARY KEY ("ID");


--
-- Name: servisturu servisturu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servisturu
    ADD CONSTRAINT servisturu_pkey PRIMARY KEY ("ID");


--
-- Name: adisyon unique_adisyon_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "unique_adisyon_ID" UNIQUE ("ID");


--
-- Name: hesapOdemeleri unique_hesapOdemeleri_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapOdemeleri"
    ADD CONSTRAINT "unique_hesapOdemeleri_ID" UNIQUE ("ID");


--
-- Name: kategoriler unique_kategoriler_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoriler
    ADD CONSTRAINT "unique_kategoriler_ID" UNIQUE ("ID");


--
-- Name: masalar unique_masalar_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT "unique_masalar_ID" UNIQUE ("ID");


--
-- Name: musteriler unique_musteriler_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler
    ADD CONSTRAINT "unique_musteriler_ID" UNIQUE ("ID");


--
-- Name: odemeTurleri unique_odemeTurleri_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."odemeTurleri"
    ADD CONSTRAINT "unique_odemeTurleri_ID" UNIQUE ("ID");


--
-- Name: paketSiparis unique_paketSiparis_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."paketSiparis"
    ADD CONSTRAINT "unique_paketSiparis_ID" UNIQUE ("ID");


--
-- Name: personelGorevleri unique_personelGorevleri_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelGorevleri"
    ADD CONSTRAINT "unique_personelGorevleri_ID" UNIQUE ("ID");


--
-- Name: personelHareketleri unique_personelHareketleri_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."personelHareketleri"
    ADD CONSTRAINT "unique_personelHareketleri_ID" UNIQUE ("ID");


--
-- Name: personeller unique_personeller_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personeller
    ADD CONSTRAINT "unique_personeller_ID" UNIQUE ("ID");


--
-- Name: rezervasyon unique_rezervasyon_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT "unique_rezervasyon_ID" UNIQUE ("ID");


--
-- Name: satislar unique_satislar_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satislar
    ADD CONSTRAINT "unique_satislar_ID" UNIQUE ("ID");


--
-- Name: servisturu unique_servisturu_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servisturu
    ADD CONSTRAINT "unique_servisturu_ID" UNIQUE ("ID");


--
-- Name: urunler unique_urunler_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunler
    ADD CONSTRAINT "unique_urunler_ID" UNIQUE ("ID");


--
-- Name: urunler urunler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunler
    ADD CONSTRAINT urunler_pkey PRIMARY KEY ("ID");


--
-- Name: bulasıkcı bulastrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER bulastrigger AFTER INSERT ON public."bulasıkcı" FOR EACH ROW EXECUTE PROCEDURE public."bulacıkcıyeni"();


--
-- Name: urunler testtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrig AFTER INSERT ON public.urunler FOR EACH ROW EXECUTE PROCEDURE public.test();


--
-- Name: urunler testtrig2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrig2 AFTER INSERT ON public.urunler FOR EACH ROW EXECUTE PROCEDURE public.test2();


--
-- Name: urunler testtrig3; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrig3 AFTER INSERT ON public.urunler FOR EACH ROW EXECUTE PROCEDURE public.test3();


--
-- Name: adisyon SERVISTURUFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "SERVISTURUFK" FOREIGN KEY ("SERVISTURNO") REFERENCES public.servisturu("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adisyon adisyonFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "adisyonFK" FOREIGN KEY ("PERSONELID") REFERENCES public.personeller("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adisyon hesapOdemeleriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "hesapOdemeleriFK" FOREIGN KEY ("ID") REFERENCES public."hesapOdemeleri"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: urunler kategorilerFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunler
    ADD CONSTRAINT "kategorilerFK" FOREIGN KEY ("KATEGORIID") REFERENCES public.kategoriler("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adisyon masalarFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "masalarFK" FOREIGN KEY ("MASAID") REFERENCES public.masalar("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hesapOdemeleri musterilerFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapOdemeleri"
    ADD CONSTRAINT "musterilerFK" FOREIGN KEY ("MUSTERIID") REFERENCES public.musteriler("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hesapOdemeleri odemeTurleri2FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapOdemeleri"
    ADD CONSTRAINT "odemeTurleri2FK" FOREIGN KEY ("ODEMETURID") REFERENCES public."odemeTurleri"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paketSiparis odemeTurleriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."paketSiparis"
    ADD CONSTRAINT "odemeTurleriFK" FOREIGN KEY ("ODEMETURID") REFERENCES public."odemeTurleri"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: musteriler paketSiparisFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler
    ADD CONSTRAINT "paketSiparisFK" FOREIGN KEY ("ID") REFERENCES public."paketSiparis"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personeller personelGorevleri1FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personeller
    ADD CONSTRAINT "personelGorevleri1FK" FOREIGN KEY ("GOREVID") REFERENCES public."personelGorevleri"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personeller personelGorevleriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personeller
    ADD CONSTRAINT "personelGorevleriFK" FOREIGN KEY ("GOREVID") REFERENCES public."personelGorevleri"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adisyon rezervasyonFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adisyon
    ADD CONSTRAINT "rezervasyonFK" FOREIGN KEY ("ID") REFERENCES public.rezervasyon("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rezervasyon satislarFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT "satislarFK" FOREIGN KEY ("ADISYONID") REFERENCES public.satislar("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: satislar urunlerFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satislar
    ADD CONSTRAINT "urunlerFK" FOREIGN KEY ("URUNID") REFERENCES public.urunler("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

