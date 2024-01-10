--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)

-- Started on 2024-01-10 22:23:40 +0330

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
-- TOC entry 6 (class 2615 OID 16881)
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO postgres;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16883)
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: postgres
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16882)
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: postgres
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drizzle.__drizzle_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 219
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: postgres
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- TOC entry 210 (class 1259 OID 16807)
-- Name: auth_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_key (
    id character varying(255) NOT NULL,
    user_id character varying(15) NOT NULL,
    primary_key boolean NOT NULL,
    hashed_password character varying(255),
    expires bigint
);


ALTER TABLE public.auth_key OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16814)
-- Name: auth_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_session (
    id character varying(128) NOT NULL,
    user_id character varying(15) NOT NULL,
    active_expires bigint NOT NULL,
    idle_expires bigint NOT NULL
);


ALTER TABLE public.auth_session OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16819)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id character varying(15) NOT NULL,
    email text,
    password text,
    type integer,
    display_name text
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16837)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    id integer NOT NULL,
    resource_id integer NOT NULL,
    project_id integer NOT NULL,
    price bigint
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16836)
-- Name: invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_id_seq OWNER TO postgres;

--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 213
-- Name: invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_id_seq OWNED BY public.invoice.id;


--
-- TOC entry 216 (class 1259 OID 16844)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    id integer NOT NULL,
    location text NOT NULL,
    service_types text[] NOT NULL,
    pilot_id character varying(15) NOT NULL,
    customer_id character varying(15) NOT NULL,
    confirmed boolean,
    "time" timestamp without time zone NOT NULL,
    status integer,
    target_users character varying[] NOT NULL,
    message character varying,
    "desc" character varying,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE public.project OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16843)
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_id_seq OWNER TO postgres;

--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 215
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_id_seq OWNED BY public.project.id;


--
-- TOC entry 218 (class 1259 OID 16853)
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource (
    id integer NOT NULL,
    name text NOT NULL,
    price bigint NOT NULL
);


ALTER TABLE public.resource OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16852)
-- Name: resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resource_id_seq OWNER TO postgres;

--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 217
-- Name: resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resource_id_seq OWNED BY public.resource.id;


--
-- TOC entry 3238 (class 2604 OID 16886)
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: postgres
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- TOC entry 3235 (class 2604 OID 16840)
-- Name: invoice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice ALTER COLUMN id SET DEFAULT nextval('public.invoice_id_seq'::regclass);


--
-- TOC entry 3236 (class 2604 OID 16847)
-- Name: project id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project ALTER COLUMN id SET DEFAULT nextval('public.project_id_seq'::regclass);


--
-- TOC entry 3237 (class 2604 OID 16856)
-- Name: resource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource ALTER COLUMN id SET DEFAULT nextval('public.resource_id_seq'::regclass);


--
-- TOC entry 3408 (class 0 OID 16883)
-- Dependencies: 220
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: postgres
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
\.


--
-- TOC entry 3398 (class 0 OID 16807)
-- Dependencies: 210
-- Data for Name: auth_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_key (id, user_id, primary_key, hashed_password, expires) FROM stdin;
email:mayor1@gmail.com	kLuIzSB6CnfYICe	t	s2:bKVF4iU81AzPzG8B:9707055ce5bd1d5125b229f402a1099f28894347dcb177f62736d16b9e351b39984d1da306e3dcf829c2c9d330e959dfa1bb46f67ada14e59d063e5d08333038	\N
email:customer2@gmail.com	sw1M81s19QGJwtR	t	s2:ZXaMRy4L1XdzV4OV:287d8b63af8f119ff96f349a65ffd86222b53151fd375260fc8afbc389b5dab0f48684d91290af55ca107ab0ae23b93c5f099fa6951d6909a7b659a82da36737	\N
email:meysam.areffar@gmail.com	hLjWb50ppADKEIp	t	s2:ZDRy5BA6fR3p1aIC:95ba8344ff40ae4d1b339f4e123490023a0ac7e3d58ba704a1451f3b05fddde52cf625439c3f0af687ff086c7d54798a65aa1a960fa005271c490237f742a28e	\N
email:pilot@gmail.com	hLjWb50ppaDKEIp	t	s2:bKVF4iU81AzPzG8B:9707055ce5bd1d5125b229f402a1099f28894347dcb177f62736d16b9e351b39984d1da306e3dcf829c2c9d330e959dfa1bb46f67ada14e59d063e5d08333038	\N
\.


--
-- TOC entry 3399 (class 0 OID 16814)
-- Dependencies: 211
-- Data for Name: auth_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_session (id, user_id, active_expires, idle_expires) FROM stdin;
npJI8N83eij5czE1btxOqEmW4ZGnl0AF0O5FDQxP	hLjWb50ppADKEIp	1703838891127	1705048491127
s47agqWU7t4gy4ZIOtjy6dWGaM48d7741vRzTZmP	hLjWb50ppADKEIp	1703928095249	1705137695249
YaGaxWd526cyi7tLvlWsuSmNo9tnXGQolIZK79Qk	hLjWb50ppADKEIp	1704037828446	1705247428446
hsMDr1XfWVIzYqwbBVq6z5WodECbKft7pjRIylQR	kLuIzSB6CnfYICe	1704124542311	1705334142311
7wf5N6F4Rrl1Z6kkmPYlOiiKDOkX9ZITG9GBVrO7	kLuIzSB6CnfYICe	1704124551731	1705334151731
S7VJcbmXoJjmyn03Uvld04FtAWoK9Bd7KSov2oIL	kLuIzSB6CnfYICe	1704124559133	1705334159133
bBKom55dEBavHHsy113v9HpHxu1TMQQgimj9eoBA	kLuIzSB6CnfYICe	1704124668288	1705334268288
Kf4qJ2YndKrB3P9VTw228VnzXxK0F1FtMO9O9mV3	kLuIzSB6CnfYICe	1704124890516	1705334490516
9qeoMCxMVuVPJIYz9h0x7DyrAbgOw7hYJKKd096G	kLuIzSB6CnfYICe	1704128303621	1705337903621
OyOmHodVDmNMGFIYroSlcC7bE5Y6UcYNoLDO9JOM	hLjWb50ppADKEIp	1704128314840	1705337914840
sQ1wDfFQHFSGYTMv4elsa5mqtPnklmJYOFqr8PA3	kLuIzSB6CnfYICe	1704128834307	1705338434307
qS1VpHVbVn2sHui20up2KxOaToGXhwXWN6Zj5BPG	hLjWb50ppADKEIp	1704130707263	1705340307263
o6vOGAzCt1ENWxOk8tysIQ0pgmR4YUbEuHb7I0sX	hLjWb50ppADKEIp	1704131384265	1705340984265
I8yXeCMjwJeUOkTZjhJ3wAFsHLZIXm6dCljW0UdY	hLjWb50ppADKEIp	1704131787410	1705341387410
s9Qq6AH1f4TOaE54rLvBtjyRtO6JN1tyIAFAPUle	kLuIzSB6CnfYICe	1704132396525	1705341996525
02p1trxIRUfKzaoJVJsXQxpX81fquLiWtpKqQ7NZ	hLjWb50ppADKEIp	1704132752249	1705342352249
ZrTJ30Kbsd0Tl1KWQSJAjAYSY3nbX448qMQdSsAZ	hLjWb50ppADKEIp	1704136180058	1705345780058
nPDoE0UcCCAex2gqkYNlRXcQK5eVlSHYyKJOLdSQ	kLuIzSB6CnfYICe	1704136472152	1705346072152
8HT7EfbIJRV9b7n92ufadp3In61qHaYsakSU5Azl	hLjWb50ppADKEIp	1704957775657	1706167375657
flJsG0Xg6ihKnIz46wnCgvtPH4Uq3T7jpIjxmPCW	sw1M81s19QGJwtR	1704971132431	1706180732431
mZEchb01H6mLQoka84GFTUPyVPong2UorhIcJTfy	hLjWb50ppADKEIp	1704976442948	1706186042948
DQUhuhiOxf5bAXj5fStiTKcszLB8UaM1YsKunUwE	sw1M81s19QGJwtR	1704981889539	1706191489539
mCWZpZ86oWsagGIlaLKSdKwS6guARqNz6oCSpYVt	kLuIzSB6CnfYICe	1704985538763	1706195138763
gdCp09aCwi5BOgDeXBLJzoQW9v6AuAZV7Gww3FUJ	sw1M81s19QGJwtR	1704986109391	1706195709391
OLWRpDijj1OsiPOJhsD8gcMPiDaRr9TPUqYoTgHD	kLuIzSB6CnfYICe	1704986250348	1706195850348
9tMXqoVGYXWtWNg8XL3jT0DCnrjFqWSn8ob5EId0	hLjWb50ppaDKEIp	1704986731825	1706196331825
Ftiamb9Vev4pdkvwGFm06cclPqtE9fzj6ccDdawk	kLuIzSB6CnfYICe	1704986975266	1706196575266
gJuTdeOh7zCDA17kACu01kVTR700LoATGUOLgl9u	hLjWb50ppaDKEIp	1704987006960	1706196606960
xA79gqRIehKAnJq7ZEG0KBZk6D2v2oztVPQynfDn	sw1M81s19QGJwtR	1704987082682	1706196682682
y5xAWS3rhuNJGwlQtje2GFnU1CAIEynowxCL7SBQ	sw1M81s19QGJwtR	1704989917939	1706199517939
iOH604ERQEXSKjKjPUlHPftYwDqcA3J5MvhB6BVe	kLuIzSB6CnfYICe	1704993887936	1706203487936
43LVhPSvTEomYshIV0uEDU0oEwTdYhajAtuF897R	hLjWb50ppaDKEIp	1704993972796	1706203572796
ttRZfb2WKnYxyqH1mSxylxNF9UKRVi1a79FI6cMF	kLuIzSB6CnfYICe	1704994019853	1706203619853
lYOtE3Ib2DlGv1tAjT3FnXHWAxykSGQv22GyZWvq	hLjWb50ppaDKEIp	1704994037616	1706203637616
b0EQnCfEEA2dGN187EFvFfbWN0UNAgpewdUqBHWJ	sw1M81s19QGJwtR	1704994074511	1706203674511
\.


--
-- TOC entry 3400 (class 0 OID 16819)
-- Dependencies: 212
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, email, password, type, display_name) FROM stdin;
hLjWb50ppaDKEIp	pilot@gmail.com	123456aZ$	1	میثم عارف فر
hLjWb50ppADKEIp	meysam.areffar@gmail.com	123456aZ$	0	Admin
hLjWb50ppaDKEI9	customer@gmail.com	123456aZ$	2	محمد جعفر زاده
hLjWa50ppaDKEI9	aydin@gmail.com	123456aZ$	2	علی عدل آوران
hLjWa50ppaDKEQ	moodi@gmail.com	123456aZ$	2	سیامک رضوی
hL=Wa50ppaDKEQ	sajied@gmail.com	123456aZ$	1	سید ساجد قادری
kLuIzSB6CnfYICe	mayor1@gmail.com	123	3	رامین شیری
sw1M81s19QGJwtR	customer2@gmail.com	123	2	کاربر تست
\.


--
-- TOC entry 3402 (class 0 OID 16837)
-- Dependencies: 214
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (id, resource_id, project_id, price) FROM stdin;
89	4	20	50000000
90	5	20	200000000
91	6	20	600000
92	7	20	6000
\.


--
-- TOC entry 3404 (class 0 OID 16844)
-- Dependencies: 216
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (id, location, service_types, pilot_id, customer_id, confirmed, "time", status, target_users, message, "desc", end_time) FROM stdin;
20	asdasdasd  sdf sdf sdf 	{}	hLjWb50ppaDKEIp	sw1M81s19QGJwtR	\N	2023-12-21 20:30:00	8	{@0}	\N	تستت22 یسسی	2024-01-19 20:30:00
\.


--
-- TOC entry 3406 (class 0 OID 16853)
-- Dependencies: 218
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource (id, name, price) FROM stdin;
4	دوربین	50000000
5	پهباد	200000000
6	ریسورس تست 1	600000
7	ریسورس تست 2	6000
\.


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 219
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: postgres
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 3, true);


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 213
-- Name: invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_id_seq', 92, true);


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 215
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_id_seq', 20, true);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 217
-- Name: resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resource_id_seq', 6, true);


--
-- TOC entry 3252 (class 2606 OID 16890)
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: postgres
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16813)
-- Name: auth_key auth_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_key
    ADD CONSTRAINT auth_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16818)
-- Name: auth_session auth_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_session
    ADD CONSTRAINT auth_session_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 16825)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16842)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 16851)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 16860)
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- TOC entry 3253 (class 2606 OID 16826)
-- Name: auth_key auth_key_user_id_auth_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_key
    ADD CONSTRAINT auth_key_user_id_auth_user_id_fk FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- TOC entry 3254 (class 2606 OID 16831)
-- Name: auth_session auth_session_user_id_auth_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_session
    ADD CONSTRAINT auth_session_user_id_auth_user_id_fk FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- TOC entry 3256 (class 2606 OID 16876)
-- Name: invoice invoice_project_id_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_project_id_project_id_fk FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3255 (class 2606 OID 16871)
-- Name: invoice invoice_resource_id_resource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_resource_id_resource_id_fk FOREIGN KEY (resource_id) REFERENCES public.resource(id);


--
-- TOC entry 3258 (class 2606 OID 16866)
-- Name: project project_customer_id_auth_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_customer_id_auth_user_id_fk FOREIGN KEY (customer_id) REFERENCES public.auth_user(id);


--
-- TOC entry 3257 (class 2606 OID 16861)
-- Name: project project_pilot_id_auth_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pilot_id_auth_user_id_fk FOREIGN KEY (pilot_id) REFERENCES public.auth_user(id);


-- Completed on 2024-01-10 22:23:40 +0330

--
-- PostgreSQL database dump complete
--

