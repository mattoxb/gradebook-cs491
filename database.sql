--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 15.7

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
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assignments; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.assignments (
    id integer NOT NULL,
    slug character varying NOT NULL,
    title character varying,
    category_id integer,
    "order" integer,
    max_points integer
);


ALTER TABLE public.assignments OWNER TO mattox;

--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assignments_id_seq OWNER TO mattox;

--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.assignments_id_seq OWNED BY public.assignments.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    slug character varying,
    title character varying
);


ALTER TABLE public.categories OWNER TO mattox;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO mattox;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: coursera_uids; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.coursera_uids (
    id integer NOT NULL,
    uid character varying,
    student_id integer,
    coursera_name character varying
);


ALTER TABLE public.coursera_uids OWNER TO mattox;

--
-- Name: coursera_uids_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.coursera_uids_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coursera_uids_id_seq OWNER TO mattox;

--
-- Name: coursera_uids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.coursera_uids_id_seq OWNED BY public.coursera_uids.id;


--
-- Name: curve; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.curve (
    id integer NOT NULL,
    score integer NOT NULL,
    grade character varying(7) NOT NULL
);


ALTER TABLE public.curve OWNER TO mattox;

--
-- Name: curve_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.curve_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curve_id_seq OWNER TO mattox;

--
-- Name: curve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.curve_id_seq OWNED BY public.curve.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_id integer,
    grade character varying,
    score double precision
);


ALTER TABLE public.grades OWNER TO mattox;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO mattox;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    student_id integer,
    topic character varying,
    proposed boolean,
    completed boolean,
    notes text
);


ALTER TABLE public.projects OWNER TO mattox;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO mattox;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    exam_id integer,
    assignment_id integer,
    zone_id integer,
    path character varying NOT NULL,
    max_points integer
);


ALTER TABLE public.questions OWNER TO mattox;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO mattox;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: scores; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.scores (
    id integer NOT NULL,
    student_id integer,
    assignment_id integer,
    status character varying(1),
    score double precision
);


ALTER TABLE public.scores OWNER TO mattox;

--
-- Name: scores_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scores_id_seq OWNER TO mattox;

--
-- Name: scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.scores_id_seq OWNED BY public.scores.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.students (
    id integer NOT NULL,
    netid character varying(9) NOT NULL,
    status character varying(1) NOT NULL,
    uin character varying(9),
    gender character varying(3),
    name character varying,
    credit integer,
    level character varying(2),
    year character varying,
    subject character varying,
    number character varying(4),
    section character varying(4),
    crn integer,
    degree character varying,
    major character varying,
    college character varying,
    program_code character varying,
    program_name character varying,
    ferpa character varying(1),
    comments integer,
    admit_term character varying,
    email character varying
);


ALTER TABLE public.students OWNER TO mattox;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO mattox;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: zones; Type: TABLE; Schema: public; Owner: mattox
--

CREATE TABLE public.zones (
    id integer NOT NULL,
    exam_id integer,
    assignment_id integer,
    slug character varying NOT NULL,
    title character varying,
    "order" integer,
    max_points integer
);


ALTER TABLE public.zones OWNER TO mattox;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: mattox
--

CREATE SEQUENCE public.zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zones_id_seq OWNER TO mattox;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mattox
--

ALTER SEQUENCE public.zones_id_seq OWNED BY public.zones.id;


--
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.assignments ALTER COLUMN id SET DEFAULT nextval('public.assignments_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: coursera_uids id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.coursera_uids ALTER COLUMN id SET DEFAULT nextval('public.coursera_uids_id_seq'::regclass);


--
-- Name: curve id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.curve ALTER COLUMN id SET DEFAULT nextval('public.curve_id_seq'::regclass);


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: scores id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.scores ALTER COLUMN id SET DEFAULT nextval('public.scores_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: zones id; Type: DEFAULT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.zones ALTER COLUMN id SET DEFAULT nextval('public.zones_id_seq'::regclass);


--
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.assignments (id, slug, title, category_id, "order", max_points) FROM stdin;
1	quiz-1	Quiz 1	1	1	1
2	quiz-2	Quiz 2	1	2	1
3	quiz-3	Quiz 3	1	3	1
4	quiz-4	Quiz 4	1	4	1
5	quiz-5	Quiz 5	1	5	1
6	quiz-6	Quiz 6	1	6	1
7	quiz-7	Quiz 7	1	7	1
8	quiz-8	Quiz 8	1	8	1
9	quiz-9	Quiz 9	1	9	1
10	quiz-10	Quiz 10	1	10	1
11	quiz-11	Quiz 11	1	11	1
12	quiz-12	Quiz 12	1	12	1
16	mp-4	MP 4	2	24	1
17	mp-5	MP 5	2	25	1
18	mp-6	MP 6	2	26	1
22	project	Project	4	41	100
23	exam-1-direct-recursion	Direct Recursion	15	1	10
24	exam-1-tail-recursion	Tail Recursion	15	2	10
25	exam-1-using-hofs	Using HOFs	15	3	10
26	exam-1-algebraic-data-types	Algebraic Data Types	15	4	10
27	exam-1-lambda-calculus-reductions	Lambda Calculus Reductions	15	5	10
28	exam-1-interpreters	Interpreters	15	6	10
29	exam-1-big-step-semantics	Big Step Semantics	15	7	10
30	exam-1-continuation-passing-style	Continuation Passing Style	15	8	10
31	exam-2-grammar-properties	Grammar Properties	15	1	10
32	exam-2-first-and-follow-sets	FIRST and FOLLOW Sets	15	2	10
33	exam-2-ll-conversion	LL Conversion	15	3	10
34	exam-2-lr-parsing	LR Parsing	15	4	10
35	exam-2-monotype-proof	Monotype Proof	15	5	10
36	exam-2-unification-step	Unification Step	15	6	10
37	final-direct-recursion	Direct Recursion	15	1	10
38	final-tail-recursion	Tail Recursion	15	2	10
39	final-using-hofs	Using HOFs	15	3	10
40	final-algebraic-data-types	Algebraic Data Types	15	4	10
41	final-lambda-calculus-reductions	Lambda Calculus Reductions	15	5	10
42	final-interpreters	Interpreters	15	6	10
43	final-big-step-semantics	Big Step Semantics	15	7	10
44	final-continuation-passing-style	Continuation Passing Style	15	8	20
45	final-grammar-properties	Grammar Properties	15	9	10
46	final-first-and-follow-sets	FIRST and FOLLOW Sets	15	10	5
47	final-ll-conversion	LL Conversion	15	11	10
48	final-lr-parsing	LR Parsing	15	12	10
49	final-monotype-proof	Monotype Proof	15	13	10
50	final-unification-step	Unification Step	15	14	10
13	mp-1	MP 1	2	21	27
19	exam-1	Midterm 1	3	31	1
20	exam-2	Midterm 2	3	32	1
21	final	Final	3	33	1
14	mp-2	MP 2	2	22	100
15	mp-3	MP 3	2	23	100
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.categories (id, slug, title) FROM stdin;
1	quizzes	Quizzes
2	mps	MPs
3	exams	Exams
4	project	Project
15	zones	Zones
\.


--
-- Data for Name: coursera_uids; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.coursera_uids (id, uid, student_id, coursera_name) FROM stdin;
1	0040ec119a0e7aa820b4de796ce5694e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	157	Ethan Mathew
2	009995e3dea17ea5ef1d656b79f75660@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	144	Agrim Kataria
4	0399bf0a2c62b3c49a31512444a65901@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	41	Gabriel Lee
5	0495693a8466130bb0ea4741df1681de@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	104	Xingyao Wang
6	0719f3990e689a31204062322ddd2750@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	61	Branden Nevius
7	0a108662abdcc69aefe016585e7496c4@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	167	Jongwon Park
8	0a382c8ebab8ff0a0373a2a072042d7f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	95	Marielle Derocher
10	0b55b9391ecee46a70199219d5f53b38@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	148	Jiwoo Lee
11	0c1975c3ca1fd88f8977eb5a8a1e56d6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	82	Nivaldo Tokuda
12	0d1b24c592de91a496a6ec8c17a7a5c0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	31	Lazar Ilic
13	11243d025a78ff758092602cde51b69c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	38	Abdul Latif
14	13cbc72d9b55920f51fb9e8920ca2862@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	91	Edward Zhu
15	13d9b036da61b5be2281e79bfb3a0994@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	46	Jacob Lizarraga
17	1583d30b9aaed0db331c7a9c6e793766@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	96	Arun Giridharan
18	1af24a3f8553190eb3e2877e8e41fd07@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	138	Labdhi Jain
19	1b1b6737d0aafbe89c421ff139780e85@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	124	Ananya Gahalaut
20	1b46eb23ffbda43b11b0f4c2294a18d6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	28	Ryley Higa
22	1c1945cfe86f5119aa9b64195fe63ac1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	59	Luke Milavec
24	1fb2d5c6bdf256dc970bc69a80d813f4@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	156	Sam Madhan
25	2092120005e870b6f8c2b8142c64df54@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	188	Youngbo Sohn
26	22aa71f113f803abc16c6a8d988fe8ce@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	26	Edmon Guan
28	2470ea6b5feb34c93a0055aa47295194@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	83	Vikram Vijayakumar
29	247d0b99b731419b1f1f2b6530c43622@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	7	Ryan Berry
30	24ab43862a81134221c62265f2acd43b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	79	Christian Tam
32	261ebe3ef8f805aecb16d25a5f37264f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	190	Adi Srinivasan
33	264f15b57a8960bcc2f9d6b9c632011b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	115	Kevin Chen
34	2abfa502176e2103d49e1ed6e7f1f34b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	2	Elias Amuneke
36	2c4642c207cccb6732a8ab9d6edcf458@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	13	Carlos Colmena
38	2edc3af010b97153be98fe81903b88bf@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	182	Yash Savalia
39	2fd19a3376b3a6204633c2201e545161@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	162	Sarn Mukhopadhyay
40	34586c89fbed0d2fbc3a462111a43ab7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	27	Jacob Hennig
41	3474c675c86940e15c65b58fce1fd4cc@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	145	Fiza Khwaja
42	34959327992b9da2187b7e78f4d9d7a5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	122	Akhil Gadde
44	3b90411da5312ad3897cd4311abe48f4@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	44	Wenching Li
45	3ca10db688c247f4fa00a780d34ffc17@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	196	Mohul Varma
46	3d61359afaf32b1a35272c30a056c0c6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	175	Shreya Pullabhotla
48	40dc3b85b540686da27272ff9481d6a1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	1	Ehit Agarwal
50	4a9143f109144550668b7de39131cf9e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	206	Andrew Yatzkan
51	4c0e141e889b8c7176253018d570294e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	199	Shane Wu
53	51a0feac87577a47fc4176ad3e94a5b3@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	143	Malcolm Kaplan
54	53de875d910dcc7cbe0b63ad1739ea3d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	141	Vaasudeva Kakuturu
55	54c4e341422bc1e8ab69af2d21c9118d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	14	Himangshu Das
56	55d2ccce309c2f386995af4bf3802c69@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	25	Layne Granados Mogollon
59	5b10add67fb43bb803eadd83fec5ed84@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	57	Justin Michal
60	5b7431d86ffcb561c720df9228109448@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	153	Fay Lin
61	6199e6d311e9a3bad01bc7ee912fbe3c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	81	Evan Timmerman
62	635e3561a07db06bd9ef6c6076e53398@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	29	Weng Shian Ho
63	6580abb9fe7b25a21d6d8c54f7e43e3f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	54	Meera Mehta
65	6c96739faf859da2e4a8a89dbe1da20e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	66	Anirudh Prasad
66	6de88f51f561ff112780dd4b4d831362@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	130	Rohan Gudipaty
67	6e495d3e7b9059782b98baf6224e71fc@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	109	Arnold Ancheril
68	6e4af39c853615db2e43b8a35ccd8186@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	33	Myles Iribarne
69	6f28acb5fc7048082b0c3757b21d4ad8@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	63	Christian Opperman
70	702d41bf2c10140384def8462f2ea6e2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	129	Zichen GU
47	4072fb0f812aa1829fab1b444b589852@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	98	Muhammad Saad Hussaini
49	45efabfa3b13e6817705f09f36642ffd@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	5	Sunki Baek
71	733e9303b314d303e0f0c12d79c9d912@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	179	Alexander Rowe
72	758e743710afb5c78a568d82e72d7369@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	180	Dhruv Saligram
73	75a10cbf1fce7ad35e9588af81e14026@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	194	Harshita Thota
74	76fef7cae366d0f73487ff58e06c5a3c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	9	Rohan Bindu
75	773aa8ad6c487cec9f0ba8197ab0ce0a@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	8	Sidd Bhattacharjee
76	77fa44da0a1e39c41879af751d1df4b1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	22	Alice Fu
77	7af913b2a634647e2a4cc2e142baa1e5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	165	Dan Nguyen
78	7b1a4313978eef95a58239f335745958@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	3	Spencer Arbour
79	7b87729bd8c3abce0e7dfe1bada99cd5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	136	Xiaoci Huang
80	7bc4bd9e045b862f521ab40975bd2dbc@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	117	Tyler Cushing
82	80a49e09b49aaefe1101c4b9f8942e0d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	65	Avi Patel
83	80fdeb8b882754b61cc222b281ef3f3b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	75	Caleb Skiles
84	824ab589b6899687ce8c3e7599e7d419@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	24	Anwesa Goswami
85	8277bcf034301220101a33e391daa146@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	173	Utkarsh Prasad
86	83c0bf93237659e859422bc2fbc13098@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	77	Sushant Sood
87	8950c26251107649199371847e737f94@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	154	Juntian Liu
89	8aadb656aa2c2b4d353a5e5aa1f4b50c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	120	Richard Fang
90	8b62b0c87ed556bf11423f7bc7f3c7e8@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	133	Emily Ho
91	8f12bb24f10648b13b35ce424b762956@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	53	Pankaj Harish Meghani
92	8fc475ac21754d1f56264dc3e0612a5d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	125	Anvita Ganugapati
94	93f553f3b8df1993aa513352ec877066@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	168	Supia Park
95	9462f88148dec40bbb7b87a6540266af@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	178	Ben Rosen
96	94fbb5d6d0621d5a20252b2230171f97@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	74	Ali Siddiqi
98	96597569628a847ce1cf9042fb172275@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	202	Sahan Yalavarthi
99	969426d74bed04e76fd32d7b11f4daec@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	35	Jason Jennings
100	96b2801a6bf26f2f30a35116da50eda7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	116	Simon Cooper
102	9a7d8c9ab514deb8be197fea21adea2d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	181	Soham Sarkar
103	9c75f22d87944b611d5ff29f588f9524@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	19	Ben Evanoff
104	9e2a0277ff3594205f6836c3a00cc514@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	191	Colsen Stiles
105	9e63978c918ca4277ed344e11f476580@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	71	Xijin Shan
106	9f1a65ea9addf8969d8b2e68429545b3@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	158	Jacob McGrath
109	a15f87be959c3faf5e46dd24c98d9bc8@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	174	Aditya Prerepa
110	a1adf206709e4aed10f6fdb211f74464@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	189	Joshua Spevak
111	a1bb3e08e9fd1fecb7df54392bb8b269@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	45	Yinchen Liu
112	a1e63d2a638877135de7340716f5f3a0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	30	Kenneth Hunter
113	a85c4d69a98aad2943d4af6e7b08df11@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	147	Neil Kozlowski
115	ab8f5053c1c76815adab5f9b4fb38079@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	163	Sean Nam
117	adf86516376e614aa214aaa8b525b807@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	17	Robert Ellwanger
118	b619ea741bb609c5b03747805dcbebf6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	192	Henry Tang
119	b9541cb93851d011392337c65522867d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	105	Peter Ze
122	bb2f497cf09699a06b9cf7ed507bd139@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	64	Neel Pai
124	c0aae272cbf5e4e1a1fa4847d6523ed1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	89	Bobby Zhang
125	c2029a74a7b9fa39ae7469bc3df555db@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	68	Jacques Samaha
126	c392ed4d3410fcc231f17fa0d6a55508@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	88	Zayn Yeo
128	c57d062f527dc352ee6c421909937834@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	128	Preeti Gomathinayagam
129	c8ddb910f694f4edd9411a5b0ebf30d8@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	56	Scott Metzger
131	cb6e12dfc9c97580bbc445ab81aa360a@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	42	Leo Lee
132	cd4a4c2f961813155f494b7ac23108c0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	185	Areet Sheth
133	cd783c0b0f6749b3533a74fb224b133c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	11	Matthew Carringer
134	ce2beb5b3e365595f0615c6244ca8355@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	48	Brian Maeng
135	d2eca0a4fbf4e6625aa0a71c61169178@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	210	Acelynn Zhang
136	d6aa11c8ca2c0a3915ad4d0e7c3a42cb@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	10	Dan Blustein
139	dcb07bc69f013721969ddecbef04d7e6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	16	Karan Desai
140	dec8e3fef7cd336ad3cc31fc03c9c8f2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	85	Jinfeng Wu
97	95d036f379331cd6343a66fcada8d4b5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	92	Yunwen Zhu
108	a1433a199b56a761e1bdb7aadff160ff@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	193	Clark Taylor
127	c4dff892cf4cdb3bf273d51d8d355244@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	106	Haoyu Zhou
3	01628579b4f6f68d9a941fd4ed2769e0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	123	Achintya Gahalaut
9	0aa8073a1a4277cf618f4d0ff7da3f99@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	60	Kevin Mooney
16	15376e30446e0ee799ce085f53429ada@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	111	Justin Bai
183	1989e7e1c9a77cbf0f0276a06404581a@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	107	JIZE ZOU
23	1e4609f427a2f0f0bd70ca8a0b02d2f2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	183	Adam Seskiewicz
27	23c8032bfd53a2dd8658a179b224df9c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	169	Armaan Patel
31	256bf6b7069d2ecf4d01da9719709f0d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	50	Kushaal Manchella
37	2c84a750971ba3fa31eb2d981a50e630@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	160	Hoyoung Min
166	3012882e0c71d85094884c581ca42bfb@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	184	Rahul Setlur
167	311694ef207da2c90606599344b75934@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	186	Melissa Shi
43	39effd0c8d9759abfa1b97fa378ed256@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	34	Luine Ito Madeira De Ley
168	3cd9b90ce5d9d181c0eb80023194de0b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	121	James Flaherty
52	4f6020bea28c81bb87a1d7c6b809fd44@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	78	Xiaoqian Su
169	5378078b76732e2d079dbf4a0b39cdb2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	201	Aryan Yadav
57	597b2dc4d2bcbd7b32a5995ba1cb5a91@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	142	Ahaan Kanaujia
170	696b3721bcb0432e476952dc84363436@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	146	Min Jae Kim
64	69fe3ab19159159a02301b291afba135@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	208	Xinming Zhai
171	78c4a44b36abb1241105cd04221ae744@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	164	Joshua Neela
172	7b4b3e6a3867896c68aa454ba6448793@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	132	Feisal Hassan
81	7ec80619bb5def65e411f06f7f86b85f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	139	Vidur Jain
88	8961cdef0cf3ef7181b6fb833c8ecfae@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	36	Matthew Kennedy
173	8b4d8d6438b7f43d9296e4c5db4c7bd2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	159	Kezzuo McSaint
174	8dcd06e566ca82e0bf587d05f996246b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	110	Drshika Asher
182	91a2b0ab70fbf0e54db2ab6965cbd0d0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	150	雷昊恩
93	929033a9cc4b4fe97034d44879216871@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	197	Bwohan Wang
175	963b1beefc32ffb7b15086d00603043a@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	204	Linda Yan
176	98fc8ae43de79a2e321e68cedf733ae8@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	84	Lufei Wang
101	99986b8c15e4c8542f4432f0f458543f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	47	Shang Lu
107	9fe80b4e2fa05903309af019739c076b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	99	Nikhil Kanamarla
185	a927df105fc44ff69c793d7959039c1e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	212	Jonathan Zhang
116	abdb040ac050e6290ed2eb753a51e00f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	6	Esteban Benitez
177	b188d7c65ce817acf7ed7cced529c5c7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	119	Sarah Dowden
178	b1bd54cff1b487b0191c27a6ebdb1f05@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	93	Haimo Bai
123	bd91b951da80e92f6d5a889354f5a916@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	131	Matthew Handzel
138	db7ee0fce881b54efd777535a310c20e@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	214	Andrew Zhao
180	dc72204ff99b25b39291cbbaefa8c0db@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	176	Rishabh Ranganathan
141	e0009d81369b0f54e14d3f4b855b80a0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	155	Jade Lundy
142	e1023d5d348c65c9c23070ae02048715@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	70	Devin Schmitz
144	e6d6bbd2ed57faaa7396712600fdd51c@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	15	Ayan Deka
145	e77914fdd106851d3b142c8cf68bbb1a@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	100	Yahav Mangel
146	e7b365225df13a5ce260fb4e18b817f1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	187	Anuj Singla
147	e85ab5aa640128ad19861d12c70c9b84@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	203	Jeffrey Yan
181	ea878cb2ee9e0ee0df5a4485254f20f2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	211	Hangao Zhang
149	ee53f9dc384e244b3f0b3ec49cb4ef18@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	149	Mike Lee
150	efc7f7170c9e744e42b1d6392948f133@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	52	Krista McDermott
151	f0e2130d895066a75f68b4ca176647a1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	172	Nishk Patel
152	f2d39ac3e3f86eb1ac55baf26957db29@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	114	Saketh Boyapally
153	f2e11c59878ab44a5a05771a52902edc@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	112	Suchit Bapatla
156	f3e8114185c5261821dd1f3320b8333f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	51	George McAskill
157	f813108e58a7592a47e2aafc531406e4@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	207	Yingjie Yu
184	f02b0388910bd63ab4b2a76594f7e0bf@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	102	Sergiu Pod
159	f88495f8dce6d75240141b5b1e4c0bac@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	4	Abraham Arellano Tavara
161	f962d8991b721d91ea7098f7f8642cc2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	90	Zhenyu Zhang
162	fa60bde8f89f219f6827034c8645b164@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	103	Laxmi Vijayan
163	fcf026273cebe42428abc4c8db3db6b5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	80	Karan Thapar
164	fec4ba53718228fba319fcc17feadc69@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	55	Haoming Meng
165	ffced793a714ea5cd780c0997c58f476@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	18	Nicolas Estrada
130	c8f00684b434f55701f287328d95cf92@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	198	Yijia Wang
179	d3395e4d16906813d464082830114f02@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	152	Victor Li
137	db13379ddabcf77f0bce2af22a17de5d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	213	Luke Zhang
143	e36a66c2586123624026ec95adcf16b6@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	101	Qizheng Mao
148	ed61291c80facba399022b7719f50b36@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	161	Eric Modesitt
154	f2e9accc51c0793a000b3b5ebbf4e551@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	21	Joshua Fischer
160	f935f9a8544309853d30b687e44c43f1@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	58	Daniel Mikhail
21	1bd4996290e6ef2bfd4bc58658c36b06@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	127	Samuel Gerstein
186	bac851246ac97b7993f7b6d24c5a7168@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	40	Chris Lee
206	b35f2baeb665a1cc296301946ebedfe2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	134	Jason Hu
187	f85e43b9c3239327d793cf110e92148d@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	171	Dimple Patel
188	f3b82fca2a809ebb16753bab8176d1e7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	87	Zhentao Xu
207	bb2cb802308f1dc94ecd10c09160b4e2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	67	Samantha Reizes
189	2b140d099dbe3a4f278d1d9f479b8aec@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	86	Daniel Xu
190	5a1c90f31e79d1958c1841bae1633cf9@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	170	Avi Patel
191	0c1e0de7fff1d65512c976ae34b3cec5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	37	Umer Khan
192	14dde9f8e6cf66932fe0725b4bd2d90f@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	12	Zan Wei Chong
193	1a5d43f0345ac5892e8fc5717ba136ae@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	69	Saju Sathyanathan
194	1a88f3572f0caf201aab61339f71ed46@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	39	Christopher Lawrence
195	26371859784d1874128ad6196c9100d0@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	209	Xianyang Zhan
196	306c73277d6c93cde4cd4440c8014f76@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	118	Jason Dhand
197	42e6ebca9fcb398bc2fa1cfd52a123fd@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	76	Mohan Somavarapu
198	534561a3706a48b625fd005f07497912@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	137	George Huebner
199	54061cbcc4307416105613a48bffc41b@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	20	Luis Fernandez De La Vara
200	64adb33bc39f884d29001a2c7f7c23ca@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	166	John Ni
201	6b415bca17105dde3c1a3fcc06574cb5@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	151	Simon Li
202	6e586c37a0b54ef682b135bdd864f210@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	97	Edward Guo
203	a17ad3099d219ecc4a13a8aadb9952b2@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	135	Zean Huang
204	aac5f311734d9c0811f2a0e3877495d7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	215	Sarah Zhao
205	b18b4a52851460b7b99023aa29f901eb@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	126	Karen Gao
208	beb655e6d7dff6d8ec696601851813f3@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	62	Derek Oda
209	bf1e02b57406d04476aca62df5f1fdec@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	72	Shaheen Sharifian
210	c204b77a2c6f7056ffa312a58187dad3@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	200	Siran Xianyu
211	ce4ccb693e1d03299eafbab2e64e3232@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	94	Ling Lee Chong
212	d13fc927281a9d9b6c337384060d2ba7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	49	Eric Magutu
213	d70e1709f4840168966d97c7c797fe30@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	113	Shohan Bhattacharya
214	f24e5ae305f748b30a9def40316048e7@ondemand~sEVQJ2QlEeiG_Q46AKImGg::ciid=154129	32	Axel Iota
\.


--
-- Data for Name: curve; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.curve (id, score, grade) FROM stdin;
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.grades (id, student_id, grade, score) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.projects (id, student_id, topic, proposed, completed, notes) FROM stdin;
1	1	\N	f	f	\N
2	2	\N	f	f	\N
3	3	\N	f	f	\N
4	4	\N	f	f	\N
5	5	\N	f	f	\N
7	7	\N	f	f	\N
8	8	\N	f	f	\N
9	9	\N	f	f	\N
10	10	\N	f	f	\N
11	11	\N	f	f	\N
12	12	\N	f	f	\N
13	13	\N	f	f	\N
14	14	\N	f	f	\N
15	15	\N	f	f	\N
16	16	\N	f	f	\N
17	17	\N	f	f	\N
18	18	\N	f	f	\N
19	19	\N	f	f	\N
20	20	\N	f	f	\N
21	21	\N	f	f	\N
22	22	\N	f	f	\N
23	23	\N	f	f	\N
24	24	\N	f	f	\N
25	25	\N	f	f	\N
26	26	\N	f	f	\N
27	27	\N	f	f	\N
28	28	\N	f	f	\N
29	29	\N	f	f	\N
31	31	\N	f	f	\N
32	32	\N	f	f	\N
33	33	\N	f	f	\N
34	34	\N	f	f	\N
36	36	\N	f	f	\N
37	37	\N	f	f	\N
38	38	\N	f	f	\N
39	39	\N	f	f	\N
41	41	\N	f	f	\N
42	42	\N	f	f	\N
43	43	\N	f	f	\N
44	44	\N	f	f	\N
45	45	\N	f	f	\N
46	46	\N	f	f	\N
47	47	\N	f	f	\N
48	48	\N	f	f	\N
49	49	\N	f	f	\N
50	50	\N	f	f	\N
51	51	\N	f	f	\N
52	52	\N	f	f	\N
53	53	\N	f	f	\N
54	54	\N	f	f	\N
55	55	\N	f	f	\N
56	56	\N	f	f	\N
57	57	\N	f	f	\N
58	58	\N	f	f	\N
59	59	\N	f	f	\N
60	60	\N	f	f	\N
61	61	\N	f	f	\N
62	62	\N	f	f	\N
63	63	\N	f	f	\N
64	64	\N	f	f	\N
65	65	\N	f	f	\N
66	66	\N	f	f	\N
67	67	\N	f	f	\N
68	68	\N	f	f	\N
69	69	\N	f	f	\N
70	70	\N	f	f	\N
71	71	\N	f	f	\N
72	72	\N	f	f	\N
73	73	\N	f	f	\N
74	74	\N	f	f	\N
75	75	\N	f	f	\N
76	76	\N	f	f	\N
77	77	\N	f	f	\N
78	78	\N	f	f	\N
79	79	\N	f	f	\N
80	80	\N	f	f	\N
81	81	\N	f	f	\N
82	82	\N	f	f	\N
83	83	\N	f	f	\N
84	84	\N	f	f	\N
85	85	\N	f	f	\N
86	86	\N	f	f	\N
87	87	\N	f	f	\N
88	88	\N	f	f	\N
89	89	\N	f	f	\N
90	90	\N	f	f	\N
91	91	\N	f	f	\N
92	92	\N	f	f	\N
93	93	\N	f	f	\N
94	94	\N	f	f	\N
95	95	\N	f	f	\N
96	96	\N	f	f	\N
97	97	\N	f	f	\N
98	98	\N	f	f	\N
99	99	\N	f	f	\N
100	100	\N	f	f	\N
101	101	\N	f	f	\N
102	102	\N	f	f	\N
103	103	\N	f	f	\N
104	104	\N	f	f	\N
105	105	\N	f	f	\N
106	106	\N	f	f	\N
107	107	\N	f	f	\N
40	40	Red Black Trees	t	f	I would like to implement Red and Black trees in Haskell (topic found here: https://wiki.haskell.org/Research_papers/Data_structures). \nPaper can be found here: https://ieeexplore.ieee.org/document/4567957\n\nI will be working alone on this project. I would like to implement the complete data structure in Haskell including the algorithms described in the paper. I will demonstrate the project by giving examples of the self balancing property as well as showing performance results.\n\nImplementation Schedule:\nJuly 12 - Finish implementing data structure\nJuly 19 - Create test cases demonstrating functionality\nJuly 26 - Finish write up\n\n
6	6	Probabalistic Programming	t	f	In pursuit of the four-credit hour criteria in CS 421: Programming Languages and Compilers, it is proposed to summarize and delve into the concept of Probabilistic Programming.  The basis of the core summary shall be based on Probabilistic Programming and Big Data | IEEE Conference Publication | IEEE Xplore.  As a current Data Engineer, and part of virtual team leading the application of generative ai capabilities in my current job, the proposed information deems to be a possible alternative to functional programming as the techniques and usage of Artificial Intelligence becomes more pervasive.  It is easily observable that programming paradigms have shifted from procedural to object oriented, or functional, and seem to trend into different areas as technology evolves, leading the way for probablistic programming, or perhaps in the future, items based on quantum technologies as well. \nThe proposed content aims to identify the state, and history of probabilistic programming, while identifying the challenges of incorporating into modern everyday usage.  We aim to answer the question of whether probabilistic programming agrees with the information retained in said article, and whether it is of value to continue research, and learnings into a paradigm that might have purpose in the near future.  This slight summary into Probabilistic technology will eliminate any coding implementations or attempt at proof of any mentioned theorems or hypothesis.  In conclusion this summary will provide education on what probabilistic programming is, and if it contains any value, of additional exploratory learnings.\n
30	30	Mandatory Access Control	t	f	      For CS421's final project, I would like to produce a paper based on the security reasons for using mandatory access control (MAC), and how Haskell can aid in its implementation. I would primarily be using https://www.usenix.org/system/files/atc22-curtsinger.pdf as the source of my information, with other supporting documents as needed. I have no doubt that I can describe both the need for MAC, and explain how the implementations within the paper are working. I believe there is more than enough information to not only show a gained understanding of MAC, but also to illustrate competency with Haskell from the many resources you have provided this semester. \n      If this proposal is acceptable, the resulting paper will meet the 2–4 page requirement. It shall be written as an IEEE research paper (unless otherwise requested), as that is where most of my writing experience is. I expect no issues providing a final document by July 27th and would also like to provide a rough draft for feedback. The rough draft would not only allow me to ensure I am meeting the expectations you have, but will also introduce a schedule so that I can stay on track. Ideally, this would be given on July 13th .  I believe this would give enough time for a cursory read by yourself, or course teaching assistants. I would also like to perform a brief presentation to cover what I have learned. I have scheduled time for this presentation on July 26th at 1:00 pm MST (2:00 pm CST) over Zoom.  I look forward to meeting with you and thank you for any preliminary feedback you can provide.\n
35	35	Phantom Types	t	f	For my CS421 project, I’m proposing to work alone and write a 2-4 page summary and prepare a presentation for the paper “Phantom Types and Subtyping” by Matthew Fluet and Riccardo Pucella.  This was submitted to the Journal of Functional Programming in 2006. \nIn this paper, Fluet and Pucella use Standard ML (SML) to demonstrate and explore the phantom-type technique that is used to break polymorphic types into subtype hierarchies.  I’m interested in learning more about how they unify polymorphic types into what I understand is basically a tree of subtypes.  All subtypes would fall under the same type class but may or may not share the same primitive operations.  The authors give an example of an algebraic data type atom, which can be either a bool or an int.  These hierarchies of subtypes can theoretically be any finite number of layers deep but appear to get messy quick.\nThe ultimate goal of the phantom-type technique is to be able to safely define polymorphic parameters so that they will error at compile time as opposed to giving us run-time errors.  The paper explores techniques to safely take such an approach. \nI believe this paper will help me better understand type classes, type constraints, and polymorphism.  It also displays a number of the topics that we covered in class: types, algebraic data types, Lambda (Damas-Milner) calculus, proofs/judgements.  It also gives me exposure to another functional programming language (SML).  These are all reasons why I am proposing to research “Phantom Types and Subtyping” for my final project.\n \nCitation:\nMatthew Fluet and Riccardo Pucella. 2006. Phantom types and subtyping. J. Funct. Program. 16, 6 (November 2006), 751–791. https://doi.org/10.1017/S0956796806006046\nDirect Link to PDF:\nhttps://www.cambridge.org/core/services/aop-cambridge-core/content/view/08E1C18BA8C61F0EDF70EFD4051604E5/S0956796806006046a.pdf/phantom-types-and-subtyping.pdf\n
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.questions (id, exam_id, assignment_id, zone_id, path, max_points) FROM stdin;
1	19	23	1	code-haskell/list-recursion/sumList	10
2	19	23	1	code-haskell/list-recursion/incList	10
3	19	24	2	code-haskell/tail-recursion/power	10
4	19	25	3	code-haskell/hof-using/takeEvens	10
5	19	25	3	code-haskell/hof-using/palindrome	10
6	19	26	4	code-haskell/adts/listifyTurtle_isBalanced	10
7	19	26	4	code-haskell/adts/tuple2pair_prodTuple	10
8	19	27	5	mc-lambda-reduction-02	5
9	19	27	5	mc-lambda-reduction-03	5
10	19	27	5	mc-lambda-reduction-04	5
11	19	27	5	mc-lambda-reduction-05	5
12	19	27	5	mc-lambda-reduction-06	5
13	19	28	6	code-haskell/interpreters/AppExp_manyArgs	10
14	19	28	6	code-haskell/interpreters/CStyleIfExpr	10
15	19	28	6	code-haskell/interpreters/WhereExp	10
16	19	29	7	big-step-semantics/proofs/ifplus1	10
17	19	30	8	continuations/mc/tail-recursion-similar-02	5
18	19	30	8	continuations/mc/tail-recursion-different-02	5
19	20	31	9	grammars/regular/rl-grammar-03	5
20	20	31	9	grammars/ambiguity/ambiguous-03	5
21	20	32	10	grammars/first-follow/select-02	5
22	20	32	10	grammars/first-follow/select-03	5
23	20	33	11	grammars/ll-grammars/ll-conversion-q3	5
24	20	33	11	grammars/ll-grammars/ll-to-haskell-q3	5
25	20	34	12	grammars/lr-grammars/lr-item-set-q3	7
26	20	34	12	grammars/lr-grammars/select-shift-reduce-q3	3
27	20	35	13	type-proofs/mono/xplusgy	10
28	20	36	14	unification-mc-04gk	5
29	20	36	14	unification-mc-05gk	5
30	21	37	15	code-haskell/list-recursion/flipzip	10
31	21	37	15	code-haskell/list-recursion/mulList	10
32	21	37	15	code-haskell/list-recursion/minlist	10
33	21	38	16	code-haskell/tail-recursion/fact	10
34	21	38	16	code-haskell/tail-recursion/minList	10
35	21	39	17	code-haskell/hof-using/allEven	10
36	21	39	17	code-haskell/hof-using/allOdd	10
37	21	39	17	code-haskell/hof-using/decList	10
38	21	40	18	code-haskell/adts/pair2tuple_sumTuple	10
39	21	40	18	code-haskell/adts/cons2list_sumCons	10
40	21	41	19	mc-lambda-reduction-08	5
41	21	41	19	mc-lambda-reduction-09	5
42	21	41	19	mc-lambda-reduction-10	5
43	21	41	19	mc-lambda-reduction-11	5
44	21	42	20	code-haskell/interpreters/MaxExp	10
45	21	43	21	big-step-semantics/proofs/seq1	10
46	21	44	22	continuations/mc/tail-recursion-similar-01	10
47	21	44	22	continuations/mc/tail-recursion-similar-02	10
48	21	44	22	continuations/mc/tail-recursion-similar-03	10
49	21	44	22	continuations/mc/tail-recursion-different-01	10
50	21	44	22	continuations/mc/tail-recursion-different-02	10
51	21	44	22	continuations/mc/tail-recursion-different-03	10
52	21	45	23	grammars/regular/rl-grammar-05	5
53	21	45	23	grammars/ambiguity/ambiguous-05	5
54	21	46	24	grammars/first-follow/select-05	5
55	21	47	25	grammars/ll-grammars/ll-conversion-q5	5
56	21	47	25	grammars/ll-grammars/ll-to-haskell-q5	5
57	21	48	26	grammars/lr-grammars/lr-item-set-q5	7
58	21	48	26	grammars/lr-grammars/select-shift-reduce-q3	3
59	21	49	27	type-proofs/mono/fxplusy	10
60	21	50	28	unification-mc-06gk	5
61	21	50	28	unification-mc-07gk	5
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.scores (id, student_id, assignment_id, status, score) FROM stdin;
9738	41	50	m	0
7164	41	37	m	0
7362	41	38	m	0
7560	41	39	m	0
7758	41	40	m	0
8154	41	42	m	0
8352	41	43	m	0
8748	41	45	m	0
9342	41	48	m	0
9540	41	49	m	0
7807	95	40	m	0
8005	95	41	m	0
8401	95	43	m	0
8599	95	44	m	0
8995	95	46	m	0
7262	148	37	m	0
7460	148	38	g	0
8450	148	43	m	0
9638	148	49	m	0
7355	31	38	m	0
8345	31	43	m	0
8034	127	41	m	0
9420	127	48	m	0
8461	160	43	g	0
8857	160	45	g	0
9253	160	47	g	0
9651	162	49	m	0
8143	27	42	g	0
9331	27	48	m	0
8447	145	43	m	0
8443	141	43	m	0
9064	170	46	m	0
9636	146	49	m	0
9404	109	48	m	0
8296	194	42	m	0
7673	164	39	m	0
8861	164	45	m	0
9257	164	47	m	0
7923	3	41	m	0
9526	24	49	m	0
7557	36	39	m	0
9523	19	49	m	0
9532	30	49	m	0
8449	147	43	m	0
7502	192	38	m	0
8294	192	42	m	0
7840	131	40	m	0
9204	106	47	m	0
9503	214	48	m	0
8332	16	43	m	0
9644	155	49	m	0
7602	87	39	m	0
8196	87	42	m	0
9582	87	49	m	0
7375	55	38	m	0
8959	55	46	m	0
9355	55	48	m	0
7956	41	41	g	10
9193	95	47	g	10
9836	148	50	g	5
8648	148	44	g	20
9044	148	46	g	1.25
9242	148	47	g	5
9440	148	48	g	10
9731	31	50	g	7
7553	31	39	g	10
7751	31	40	g	10
7949	31	41	g	10
8147	31	42	g	10
7638	127	39	g	10
7669	160	39	g	10
8659	160	44	g	20
8553	44	44	g	10
8924	14	46	g	2.5
7480	170	38	g	10
8140	24	42	g	2.5
9328	24	48	g	3
9018	120	46	g	5
7446	133	38	g	10
8183	74	42	g	10
9213	116	47	g	10
7499	189	38	g	10
8885	189	45	g	10
8202	93	42	g	10
9390	93	48	g	3
7772	56	40	g	10
9862	176	50	g	10
8464	163	43	m	0
5	5	1	g	100
4486	144	23	g	10
4684	144	24	g	0
4882	144	25	g	5.454545454545455
5080	144	26	g	10
5476	144	28	g	0
5544	215	28	g	0
4450	104	23	g	10
4864	124	25	g	10
4410	60	23	g	10
4528	188	23	g	10
4598	50	24	g	10
4918	182	25	g	10
5691	162	29	g	9.539473684210527
260	69	2	g	100
5655	123	29	g	10
4395	44	23	g	10
4623	78	24	g	10
5171	25	27	g	10
4484	142	23	g	10
4506	165	23	g	10
4359	3	23	g	10
4932	197	25	g	10
4508	168	23	g	10
203	5	2	g	100
5093	158	26	g	10
5039	99	26	g	10
5209	68	27	g	10
5720	192	29	g	10
4471	128	23	g	10
5422	85	28	g	10
4569	15	24	g	10
5238	100	27	g	10
221	25	2	g	100
8437	134	43	m	0
7351	27	38	g	10
7447	134	38	g	10
8607	103	44	g	20
220	24	2	g	100
5081	145	26	m	0
4970	21	26	m	0
241	48	2	g	100
179	196	1	g	100
159	175	1	g	100
198	215	1	g	100
193	210	1	g	100
5140	207	26	g	10
4606	58	24	g	10
5242	104	27	g	10
161	177	1	m	0
188	205	1	m	0
5719	191	29	g	10
265	76	2	g	100
4392	41	23	g	10
236	43	2	m	0
4427	80	23	g	10
4821	78	25	g	10
5391	51	28	g	10
5638	104	29	g	10
4903	167	25	g	10
222	26	2	g	100
5797	61	30	g	8
4640	96	24	g	10
5716	188	29	g	10
5432	96	28	g	0
5570	28	29	g	10
5201	59	27	g	10
4893	156	25	g	5.454545454545454
5091	156	26	g	0
5546	2	29	g	0
5314	182	27	g	5
4487	145	23	g	10
5613	78	29	g	10
5475	143	28	g	10
5275	141	27	g	5
5671	141	29	g	9.967105263157896
4964	14	26	g	10
4850	109	25	g	10
4584	33	24	g	10
5376	33	28	g	10
5660	129	29	g	10
5707	179	29	g	10
5157	9	27	g	10
5070	133	26	g	10
4930	194	25	g	10
5326	194	27	g	5
4774	24	25	g	10
4622	77	24	g	10
5414	77	28	g	10
5683	154	29	g	9.967105263157896
5268	133	27	g	10
4596	47	24	g	10
5664	133	29	g	9.835526315789474
4794	47	25	g	10
5388	47	28	g	10
5237	99	27	g	0
4529	189	23	g	10
5633	99	29	g	9.30921052631579
4649	105	24	g	10
5008	64	26	g	10
5624	89	29	g	9.93421052631579
4789	42	25	g	10
5185	42	27	g	10
4966	16	26	g	10
5383	42	28	g	10
4367	11	23	g	10
4762	10	25	g	10
4694	155	24	g	5.555555555555556
5740	213	29	g	9.967105263157894
5164	16	27	g	0
4772	21	25	g	10
5762	21	30	g	10
4830	87	25	g	10
5424	87	28	g	10
5622	87	29	g	10
5219	80	27	g	5
8601	97	44	p	0
8602	98	44	p	0
8603	99	44	p	0
8604	100	44	p	0
4590	41	24	g	10
8605	101	44	p	0
4788	41	25	g	10
4986	41	26	g	10
5184	41	27	g	5
5382	41	28	g	10
8608	104	44	p	0
8609	105	44	p	0
5945	5	31	p	0
7867	160	40	g	10
5952	12	31	p	0
7753	34	40	g	10
8979	78	46	g	5
458	69	3	g	100
8193	84	42	g	10
6042	113	31	g	10
434	43	3	m	0
5978	43	31	p	0
317	132	2	g	100
6045	116	31	g	10
401	5	3	g	100
6049	121	31	g	10
5996	62	31	p	0
5972	35	31	g	10
6002	69	31	p	0
6007	76	31	p	0
6023	92	31	p	0
6028	98	31	p	0
5966	28	31	g	10
6025	95	31	g	10
6062	135	31	p	0
6036	106	31	g	10
5995	61	31	g	5
6017	86	31	g	10
5994	60	31	g	10
6074	148	31	g	10
6013	82	31	g	10
6015	84	31	g	10
5974	38	31	g	10
6022	91	31	g	10
5981	46	31	g	10
6040	111	31	g	10
6026	96	31	g	10
6037	107	31	g	10
6052	124	31	g	10
5993	59	31	g	10
6081	156	31	g	10
5964	26	31	g	10
6014	83	31	g	10
5947	7	31	g	10
6008	77	31	g	10
6010	79	31	g	10
5984	50	31	g	10
6044	115	31	g	10
5942	2	31	g	5
6061	134	31	g	10
5953	13	31	g	10
6071	145	31	g	10
6050	122	31	g	10
5971	34	31	g	10
5979	44	31	g	5
6068	142	31	g	10
6054	127	31	g	10
5941	1	31	g	10
6069	143	31	g	10
6067	141	31	g	10
5954	14	31	g	5
6063	136	31	g	10
5991	57	31	g	10
6078	153	31	g	10
6012	81	31	g	10
5967	29	31	g	10
5988	54	31	g	10
6072	146	31	g	10
6000	66	31	g	10
6057	130	31	g	10
6038	109	31	g	10
5970	33	31	g	10
5997	63	31	g	10
5949	9	31	g	10
5948	8	31	g	10
5961	22	31	g	10
5943	3	31	g	10
6059	132	31	g	0
6046	117	31	g	10
5999	65	31	g	5
6066	139	31	g	5
6006	75	31	g	10
5968	30	31	g	10
6034	104	31	g	10
6079	154	31	g	10
6048	120	31	g	10
6060	133	31	g	10
6039	110	31	g	10
5987	53	31	g	10
6053	125	31	g	10
6076	150	31	g	10
6005	74	31	g	10
6032	102	31	g	10
5969	31	31	g	10
5959	19	31	g	10
6004	71	31	g	10
5980	45	31	g	5
5957	17	31	g	10
6073	147	31	g	10
5946	6	31	g	5
6055	128	31	g	10
6047	119	31	g	10
6024	93	31	g	10
6035	105	31	g	10
5975	40	31	g	10
5998	64	31	g	10
5983	48	31	g	10
6020	89	31	g	10
6019	88	31	g	5
5944	4	31	g	10
5990	56	31	g	10
5977	42	31	g	10
5951	11	31	g	10
6077	152	31	g	10
5950	10	31	g	10
5956	16	31	g	10
6016	85	31	g	10
6080	155	31	g	10
6003	70	31	g	10
6031	101	31	g	10
6030	100	31	g	10
6075	149	31	g	10
5986	52	31	g	10
6043	114	31	g	10
6041	112	31	g	10
5960	21	31	g	10
5985	51	31	g	5
5958	18	31	g	0
5992	58	31	g	10
6021	90	31	g	10
6033	103	31	g	10
6011	80	31	g	0
6064	137	31	g	10
6027	97	31	g	10
6051	123	31	g	10
5965	27	31	g	10
5962	24	31	g	10
6058	131	31	g	10
5982	47	31	g	10
6009	78	31	g	10
8879	183	45	m	0
6101	177	31	p	0
606	12	4	g	0
7694	186	39	g	0
6153	15	32	g	5
6117	193	31	p	0
6123	200	31	p	0
6128	205	31	p	0
9674	186	49	m	0
6143	5	32	p	0
6150	12	32	p	0
8375	65	43	m	0
6176	43	32	p	0
8771	65	45	g	10
8969	65	46	g	5
8658	159	44	g	18
9029	132	46	m	0
8261	158	42	m	0
6190	58	32	g	8
6194	62	32	p	0
6213	84	32	g	3
6200	69	32	p	0
602	8	4	g	100
6205	76	32	p	0
484	98	3	g	100
6149	11	32	g	8.5
6221	92	32	p	0
6192	60	32	g	6
6167	31	32	g	7.75
6172	38	32	g	7.75
6220	91	32	g	10
6164	28	32	g	9.25
6179	46	32	g	4.75
6191	59	32	g	4.75
6107	183	31	g	10
6093	169	31	g	10
6112	188	31	g	10
6162	26	32	g	3.5
6145	7	32	g	4.75
6212	83	32	g	3.5
6182	50	32	g	9.25
6114	190	31	g	10
6215	86	32	g	10
6140	2	32	g	8.5
6085	160	31	g	0
6151	13	32	g	6.25
6095	171	31	g	10
6087	162	31	g	10
6163	27	32	g	6
6108	184	31	g	0
6177	44	32	g	2.25
6169	34	32	g	8.75
6119	196	31	g	10
6122	199	31	g	10
6099	175	31	g	10
6139	1	32	g	10
6129	206	31	g	5
6124	201	31	g	0
6207	78	32	g	8.75
6152	14	32	g	1.25
6094	170	31	g	10
6161	25	32	g	6
6186	54	32	g	8.5
6210	81	32	g	10
6131	208	31	g	10
6168	33	32	g	10
6198	66	32	g	8.5
6103	179	31	g	10
6195	63	32	g	5.25
6147	9	32	g	6.75
6104	180	31	g	10
6118	194	31	g	5
6146	8	32	g	1.25
6089	164	31	g	10
6204	75	32	g	7.25
6090	165	31	g	10
6141	3	32	g	2.25
6160	24	32	g	3.5
6097	173	31	g	5
6206	77	32	g	5.5
6171	36	32	g	7.75
6084	159	31	g	5
6185	53	32	g	6.5
6120	197	31	g	10
6127	204	31	g	10
6092	168	31	g	10
6203	74	32	g	3.75
6091	167	31	g	10
6125	202	31	g	10
6170	35	32	g	6.75
6180	47	32	g	7.5
6105	181	31	g	10
6115	191	31	g	10
6157	19	32	g	6.25
6083	158	31	g	10
6202	71	32	g	9.25
6135	212	31	g	10
6098	174	31	g	10
6178	45	32	g	10
6166	30	32	g	5.5
6155	17	32	g	4
6088	163	31	g	10
6184	52	32	g	8
6222	93	32	g	5.75
6116	192	31	g	10
6196	64	32	g	9.25
6173	40	32	g	7.75
6218	89	32	g	2.25
6136	213	31	g	5
6188	56	32	g	6.5
6121	198	31	g	10
6109	185	31	g	10
6175	42	32	g	8
6181	48	32	g	10
617	25	4	g	100
6133	210	31	g	10
6148	10	32	g	6.75
6137	214	31	g	10
6214	85	32	g	8
6132	209	31	g	10
6138	215	31	g	10
6208	79	32	g	9.25
6111	187	31	g	10
6096	172	31	g	10
6126	203	31	g	10
6134	211	31	g	10
6086	161	31	g	10
6216	87	32	g	6.75
6158	21	32	g	9.25
6183	51	32	g	6.75
6130	207	31	g	10
6144	6	32	g	2.5
6142	4	32	g	4.75
6187	55	32	g	6.75
6156	18	32	g	2.5
9227	132	47	m	0
6174	41	32	g	5
6154	16	32	g	4.75
6219	90	32	g	6.75
6199	68	32	g	3
6165	29	32	g	5.25
6106	182	31	g	10
618	26	4	g	100
6211	82	32	g	6.75
6226	98	32	p	0
8657	158	44	m	0
8068	163	41	m	0
632	43	4	m	0
8860	163	45	m	0
6260	135	32	p	0
6229	101	32	g	9.25
6325	204	32	g	10
7829	119	40	m	0
6353	17	33	g	5
9745	48	50	g	7
7512	203	38	m	0
6299	177	32	p	0
9500	211	48	m	0
7570	52	39	g	10
6315	193	32	p	0
6330	209	32	g	6.75
6308	186	32	g	2.25
6321	200	32	p	0
9352	52	48	m	0
6326	205	32	p	0
6231	103	32	g	8.5
6298	176	32	g	6.75
8615	112	44	m	0
9201	103	47	m	0
6337	1	33	g	10
6341	5	33	p	0
6235	107	32	g	7.75
6348	12	33	p	0
6240	113	32	g	10
6243	116	32	g	7.5
6247	121	32	g	6
6238	111	32	g	7.75
6223	95	32	g	10
6272	148	32	g	4.25
6224	96	32	g	5.5
6338	2	33	g	5
6263	138	32	g	6
6250	124	32	g	8.75
6279	156	32	g	1.25
6310	188	32	g	10
6291	169	32	g	10
6360	26	33	g	5
6242	115	32	g	4.25
6312	190	32	g	9.25
6349	13	33	g	0
6283	160	32	g	3
6285	162	32	g	8
6304	182	32	g	9.25
6306	184	32	g	0
6259	134	32	g	5.25
6361	27	33	g	10
6269	145	32	g	10
6248	122	32	g	4.25
6297	175	32	g	5
6305	183	32	g	3.5
6327	206	32	g	7
6267	143	32	g	9.25
6322	201	32	g	1.25
6265	141	32	g	7.75
6350	14	33	g	0
6359	25	33	g	10
6266	142	32	g	6.25
6292	170	32	g	6.5
6276	153	32	g	3.5
6329	208	32	g	10
6255	130	32	g	5.25
6254	129	32	g	9.25
6301	179	32	g	8.5
6302	180	32	g	8.5
6316	194	32	g	7
6345	9	33	g	9.772727272727273
6344	8	33	g	0
6357	22	33	g	10
6287	164	32	g	4
6288	165	32	g	10
6261	136	32	g	3.5
6257	132	32	g	0
6264	139	32	g	2.5
6244	117	32	g	7.75
6358	24	33	g	10
6277	154	32	g	3.75
6295	173	32	g	6.25
6246	120	32	g	4.25
6282	159	32	g	0.5
6258	133	32	g	4
6237	110	32	g	8.75
6251	125	32	g	5
6274	150	32	g	10
6300	178	32	g	3
6290	168	32	g	3
6232	104	32	g	7.75
6323	202	32	g	10
6230	102	32	g	7.75
6313	191	32	g	7.5
6281	158	32	g	4.25
6227	99	32	g	10
6311	189	32	g	3
6296	174	32	g	6.75
6333	212	32	g	3.75
6286	163	32	g	4.75
6342	6	33	g	5
6239	112	32	g	0.5
6245	119	32	g	3.25
6314	192	32	g	5
6233	105	32	g	6.75
6268	144	32	g	3.5
6253	128	32	g	7.75
6319	198	32	g	9.25
6307	185	32	g	10
6346	10	33	g	10
6347	11	33	g	10
6275	152	32	g	8
6335	214	32	g	6.5
6334	213	32	g	1.25
6252	127	32	g	3.5
6352	16	33	g	10
6336	215	32	g	8.75
6236	109	32	g	9.25
6351	15	33	g	10
6309	187	32	g	10
6228	100	32	g	8
6284	161	32	g	6.75
6324	203	32	g	0
6294	172	32	g	10
6273	149	32	g	5.25
6241	114	32	g	5
6225	97	32	g	6.75
6328	207	32	g	10
6340	4	33	g	10
6293	171	32	g	2.25
6354	18	33	g	0
6278	155	32	g	3.75
6234	106	32	g	5.25
6262	137	32	g	9.25
6355	19	33	g	5
6356	21	33	g	9.772727272727273
6320	199	32	g	9.25
6256	131	32	g	8.5
6303	181	32	g	10
6289	167	32	g	10
6374	43	33	p	0
9047	152	46	m	0
6445	121	33	g	0
797	5	5	g	100
6368	35	33	g	10
6438	113	33	g	10
6392	62	33	p	0
6398	69	33	p	0
6496	176	33	g	10
6403	76	33	p	0
6441	116	33	g	10
6476	155	33	g	0
6419	92	33	p	0
6424	98	33	p	0
6487	167	33	g	10
6397	68	33	g	5
6466	144	33	g	0
6458	135	33	p	0
6457	134	33	g	5
6468	146	33	g	5
6428	102	33	g	5
6411	84	33	g	10
6497	177	33	p	0
6430	104	33	g	10
6390	60	33	g	5
6470	148	33	g	5
6409	82	33	g	10
6370	38	33	g	10
6448	124	33	g	10
6418	91	33	g	10
6437	112	33	g	10
6377	46	33	g	10
6389	59	33	g	5
6433	107	33	g	10
6461	138	33	g	5
6362	28	33	g	5
6489	169	33	g	10
6410	83	33	g	5
6406	79	33	g	10
6483	162	33	g	5
6380	50	33	g	10
6446	122	33	g	10
6396	66	33	g	10
6440	115	33	g	9.772727272727273
6495	175	33	g	9.772727272727273
6467	145	33	g	10
6405	78	33	g	10
6385	55	33	g	5
6367	34	33	g	10
6375	44	33	g	0
6474	153	33	g	5
6465	143	33	g	10
6463	141	33	g	10
6477	156	33	g	5
6464	142	33	g	10
6490	170	33	g	0
6408	81	33	g	10
6453	130	33	g	10
6363	29	33	g	10
6459	136	33	g	10
6402	75	33	g	10
6434	109	33	g	10
6366	33	33	g	10
6393	63	33	g	10
6452	129	33	g	10
6499	179	33	g	10
6485	164	33	g	10
6455	132	33	g	5
6442	117	33	g	10
6493	173	33	g	5
6462	139	33	g	0
6395	65	33	g	0
6404	77	33	g	5
6369	36	33	g	10
6475	154	33	g	10
6472	150	33	g	10
6444	120	33	g	10
6480	159	33	g	0
6456	133	33	g	10
6383	53	33	g	10
6488	168	33	g	5
6498	178	33	g	10
6484	163	33	g	0
6401	74	33	g	5
6384	54	33	g	5
6420	93	33	g	10
6372	41	33	g	5
6400	71	33	g	10
6422	96	33	g	10
6479	158	33	g	10
6425	99	33	g	10
6364	30	33	g	5
6469	147	33	g	10
6431	105	33	g	10
6443	119	33	g	5
6386	56	33	g	10
6371	40	33	g	10
6373	42	33	g	10
6421	95	33	g	5
6454	131	33	g	10
6416	89	33	g	10
6399	70	33	g	10
6451	128	33	g	5
6450	127	33	g	0
6412	85	33	g	5
6379	48	33	g	5
6473	152	33	g	5
6427	101	33	g	10
6391	61	33	g	5
6492	172	33	g	10
6413	86	33	g	10
6426	100	33	g	10
6439	114	33	g	10
6482	161	33	g	5
6388	58	33	g	5
6417	90	33	g	5
6414	87	33	g	10
6381	51	33	g	5
6423	97	33	g	5
6491	171	33	g	0
6429	103	33	g	10
6460	137	33	g	10
6376	45	33	g	10
6432	106	33	g	10
6407	80	33	g	0
6449	125	33	g	9.772727272727273
6471	149	33	g	5
6394	64	33	g	10
6378	47	33	g	10
6365	31	33	g	0
6513	193	33	p	0
1078	98	6	g	100
6519	200	33	p	0
1057	76	6	g	100
995	5	6	g	100
6524	205	33	p	0
6512	192	33	g	5
1012	24	6	g	25
6552	18	34	g	3
6100	176	31	g	10
6539	5	34	p	0
6546	12	34	p	0
6610	85	34	g	10
1002	12	6	m	0
6619	95	34	g	9.960893854748603
6572	43	34	p	0
1028	43	6	m	0
6590	62	34	p	0
1046	62	6	m	0
6596	69	34	p	0
6601	76	34	p	0
6617	92	34	p	0
6622	98	34	p	0
1052	69	6	m	0
6563	31	34	g	3
6607	82	34	g	9.960893854748603
6568	38	34	g	10
6503	183	33	g	5
6616	91	34	g	10
6575	46	34	g	10
6620	96	34	g	10
6631	107	34	g	10
6560	28	34	g	10
6508	188	33	g	10
6541	7	34	g	10
6608	83	34	g	9.745810055865922
6611	86	34	g	10
6527	208	33	g	10
6604	79	34	g	10
6578	50	34	g	10
6510	190	33	g	10
6536	2	34	g	3
6506	186	33	g	4.772727272727273
6547	13	34	g	10
6538	4	34	g	10
6504	184	33	g	0
6515	196	33	g	0
6565	34	34	g	10
6573	44	34	g	3
6535	1	34	g	10
6525	206	33	g	5
6518	199	33	g	10
6548	14	34	g	0
6603	78	34	g	10
6520	201	33	g	0
6585	57	34	g	6.960893854748603
6557	25	34	g	10
6606	81	34	g	8
6582	54	34	g	9
6567	36	34	g	6.745810055865922
6543	9	34	g	2
6594	66	34	g	10
6632	109	34	g	10
6564	33	34	g	10
6591	63	34	g	10
6500	180	33	g	10
6514	194	33	g	5
6542	8	34	g	2
6555	22	34	g	10
6602	77	34	g	9.980446927374302
6537	3	34	g	10
6600	75	34	g	10
6556	24	34	g	3
6633	110	34	g	9
6581	53	34	g	9.941340782122905
6516	197	33	g	10
6523	204	33	g	10
6599	74	34	g	3
6576	47	34	g	10
6521	202	33	g	10
6566	35	34	g	10
6609	84	34	g	9
6511	191	33	g	5
6553	19	34	g	3
6598	71	34	g	9.843575418994414
6623	99	34	g	9
6509	189	33	g	0
6574	45	34	g	9.921787709497206
6540	6	34	g	10
6562	30	34	g	10
6531	212	33	g	0
6551	17	34	g	10
6583	55	34	g	2
6618	93	34	g	8
6569	40	34	g	10
6614	89	34	g	10
6592	64	34	g	9.941340782122905
6545	11	34	g	9
6595	68	34	g	10
6613	88	34	g	9
6577	48	34	g	9.921787709497206
6517	198	33	g	10
6571	42	34	g	10
6505	185	33	g	10
6529	210	33	g	10
6533	214	33	g	10
6544	10	34	g	9.921787709497206
6624	100	34	g	10
6550	16	34	g	10
6534	215	33	g	10
6597	70	34	g	10
6625	101	34	g	10
6549	15	34	g	3
6530	211	33	g	10
6507	187	33	g	10
6522	203	33	g	0
6580	52	34	g	9
6554	21	34	g	3
6612	87	34	g	10
6579	51	34	g	10
6586	58	34	g	10
6615	90	34	g	10
6627	103	34	g	10
6605	80	34	g	1
6621	97	34	g	10
6630	106	34	g	10
6528	209	33	g	10
6587	59	34	g	3
6626	102	34	g	2
6628	104	34	g	10
6588	60	34	g	10
6502	182	33	g	10
947	171	5	g	100
1001	11	6	g	100
6584	56	34	g	10
1014	26	6	g	100
1060	79	6	g	100
6734	2	35	m	0
6636	113	34	g	10
9910	39	1	g	0
6681	162	34	g	10
9909	37	1	g	100
6694	176	34	g	10
6656	135	34	p	0
9911	118	1	g	100
6643	121	34	g	3
1200	12	7	m	0
9912	20	1	g	100
1226	43	7	m	0
9913	166	1	g	100
9914	151	1	g	100
6758	28	35	g	10
9915	126	1	g	100
9916	67	1	g	100
9917	72	1	g	100
9918	94	1	g	100
6695	177	34	p	0
9919	49	1	g	100
9920	32	1	g	100
1255	76	7	g	66.66666666666666
1193	5	7	g	0
6639	116	34	g	10
1244	62	7	m	0
6711	193	34	p	0
6719	202	34	g	10
1250	69	7	m	0
6717	200	34	p	0
6722	205	34	p	0
6737	5	35	p	0
6744	12	35	p	0
6675	156	34	g	1
6659	138	34	g	2
6646	124	34	g	10
6756	26	35	g	1.8918918918918914
6701	183	34	g	3
6706	188	34	g	10
6739	7	35	g	10
6687	169	34	g	10
6679	160	34	g	3
6638	115	34	g	9.921787709497206
6745	13	35	g	10
6704	186	34	g	9.960893854748603
6700	182	34	g	10
6761	31	35	g	10
6702	184	34	g	3
6757	27	35	g	10
6665	145	34	g	10
6693	175	34	g	9.921787709497206
6644	122	34	g	1
6763	34	35	g	10
6733	1	35	g	10
6685	167	34	g	9.921787709497206
6723	206	34	g	3
6663	143	34	g	10
6674	155	34	g	9.804469273743017
6666	146	34	g	10
6718	201	34	g	0
6661	141	34	g	10
6755	25	35	g	10
6662	142	34	g	10
6650	129	34	g	9.960893854748603
6688	170	34	g	3
6672	153	34	g	10
6698	180	34	g	10
6725	208	34	g	10
6651	130	34	g	3
6712	194	34	g	2
6697	179	34	g	9.921787709497206
6741	9	35	g	9.57957957957958
6753	22	35	g	10
6740	8	35	g	1.2312312312312312
6683	164	34	g	10
6657	136	34	g	3
6660	139	34	g	3
6735	3	35	g	10
6653	132	34	g	3
6640	117	34	g	10
6691	173	34	g	1
6642	120	34	g	10
6754	24	35	g	10
6678	159	34	g	3
6673	154	34	g	3
6654	133	34	g	9
6647	125	34	g	3
6670	150	34	g	9.941340782122905
6686	168	34	g	3
6696	178	34	g	10
6721	204	34	g	10
6692	174	34	g	3
6760	30	35	g	10
6726	209	34	g	10
6699	181	34	g	10
6709	191	34	g	3
6716	199	34	g	10
6729	212	34	g	3
6707	189	34	g	2
6682	163	34	g	3
6749	17	35	g	10
6738	6	35	g	10
6649	128	34	g	10
6730	213	34	g	2
6724	207	34	g	10
6710	192	34	g	3
6652	131	34	g	10
6648	127	34	g	10
6658	137	34	g	10
6703	185	34	g	10
6743	11	35	g	10
6727	210	34	g	8.88268156424581
6742	10	35	g	10
6705	187	34	g	10
6731	214	34	g	10
6728	211	34	g	10
6748	16	35	g	10
6747	15	35	g	10
6732	215	34	g	10
6677	158	34	g	10
6669	149	34	g	3
6680	161	34	g	9.921787709497206
6635	112	34	g	3
6690	172	34	g	9.960893854748603
6752	21	35	g	10
6762	33	35	g	10
6655	134	34	g	3
6736	4	35	g	10
6664	144	34	g	2
6751	19	35	g	10
6746	14	35	g	10
6641	119	34	g	10
1103	125	6	g	100
6668	148	34	g	3
1246	64	7	g	100
6720	203	34	g	3
6750	18	35	g	10
1239	57	7	g	100
6689	171	34	g	2
6715	198	34	g	10
6634	111	34	g	10
6770	43	35	p	0
1410	26	8	g	90.9090909090909
6788	62	35	p	0
6794	69	35	p	0
6862	144	35	m	0
6799	76	35	p	0
6858	139	35	m	0
9921	37	2	g	100
6815	92	35	p	0
6834	113	35	g	10
1391	5	8	m	0
6892	176	35	g	10
6820	98	35	p	0
9922	118	2	g	100
9923	20	2	g	100
1398	12	8	m	0
9924	166	2	g	100
6766	38	35	g	10
6826	104	35	g	10
9925	151	2	g	100
6854	135	35	p	0
9926	126	2	g	100
9927	67	2	g	100
9928	72	2	g	83.33333333333334
9929	94	2	g	100
9930	49	2	g	100
6808	85	35	g	10
6798	75	35	g	10
9931	32	2	g	0
6797	74	35	g	10
6872	155	35	g	10
6893	177	35	p	0
6807	84	35	g	9.51951951951952
6828	106	35	g	10
6787	61	35	g	10
6883	167	35	g	10
6817	95	35	g	10
6786	60	35	g	10
6866	148	35	g	10
6805	82	35	g	10
6813	90	35	g	10
6814	91	35	g	10
6773	46	35	g	10
6832	111	35	g	10
6829	107	35	g	10
6857	138	35	g	10
6785	59	35	g	10
6899	183	35	g	10
6873	156	35	g	10
6885	169	35	g	10
6806	83	35	g	10
6889	173	35	g	10
6776	50	35	g	10
6836	115	35	g	10
6809	86	35	g	10
6877	160	35	g	1.4714714714714716
6887	171	35	g	10
6900	184	35	g	0
6842	122	35	g	10
6801	78	35	g	10
6771	44	35	g	10
6853	134	35	g	10
1276	98	7	g	100
6841	121	35	g	10
6861	143	35	g	10
6859	141	35	g	10
6860	142	35	g	10
6886	170	35	g	10
6783	57	35	g	10
6780	54	35	g	7.297297297297297
6830	109	35	g	10
6792	66	35	g	10
6849	130	35	g	9.57957957957958
6791	65	35	g	10
6789	63	35	g	10
6848	129	35	g	10
6895	179	35	g	10
6896	180	35	g	10
6881	164	35	g	10
6882	165	35	g	10
6855	136	35	g	10
6838	117	35	g	10
6837	116	35	g	10
6852	133	35	g	10
6891	175	35	g	7.957957957957957
6800	77	35	g	10
6871	154	35	g	10
6765	36	35	g	10
6840	120	35	g	10
6876	159	35	g	5.075075075075075
6845	125	35	g	10
6831	110	35	g	8.85885885885886
6894	178	35	g	10
6868	150	35	g	10
6884	168	35	g	0
6768	41	35	g	10
6764	35	35	g	10
6824	102	35	g	10
6897	181	35	g	10
6796	71	35	g	10
6875	158	35	g	10
6821	99	35	g	10
6772	45	35	g	10
6865	147	35	g	10
6880	163	35	g	10
6839	119	35	g	10
6816	93	35	g	9.6996996996997
6867	149	35	g	9.57957957957958
6767	40	35	g	10
6790	64	35	g	10
6869	152	35	g	10
6812	89	35	g	10
6793	68	35	g	10
6811	88	35	g	10
6782	56	35	g	10
6769	42	35	g	10
6775	48	35	g	10
6846	127	35	g	10
6844	124	35	g	10
6795	70	35	g	10
6823	101	35	g	10
6822	100	35	g	10
6878	161	35	g	9.039039039039038
6778	52	35	g	10
6810	87	35	g	10
6835	114	35	g	10
6833	112	35	g	9.45945945945946
6781	55	35	g	9.51951951951952
6777	51	35	g	10
6784	58	35	g	10
6825	103	35	g	10
6803	80	35	g	0
6819	97	35	g	10
6856	137	35	g	10
6850	131	35	g	10
6804	81	35	g	10
6802	79	35	g	10
6863	145	35	g	10
6827	105	35	g	10
6774	47	35	g	10
6864	146	35	g	10
6879	162	35	g	10
6909	193	35	p	0
6915	200	35	p	0
6920	205	35	p	0
9932	37	3	g	100
9933	20	3	g	100
9934	166	3	g	100
9935	151	3	g	100
9936	126	3	g	66.66666666666666
9937	67	3	g	0
9938	72	3	g	0
6935	5	36	p	0
9939	94	3	g	0
6942	12	36	p	0
9940	49	3	g	100
9941	32	3	g	0
1424	43	8	m	0
6956	28	36	g	7
7032	113	36	g	10
6934	4	36	g	10
6968	43	36	p	0
6982	58	36	g	0
6957	29	36	g	2
6986	62	36	p	0
7023	103	36	g	2
6992	69	36	p	0
6980	56	36	g	0
6997	76	36	p	0
7013	92	36	p	0
7018	98	36	p	0
7003	82	36	g	5
6983	59	36	g	0
6904	188	35	g	10
7004	83	36	g	10
6921	206	35	g	9.3993993993994
6932	2	36	g	2
7007	86	36	g	10
6914	199	35	g	10
6978	54	36	g	0
6943	13	36	g	10
6902	186	35	g	10
6990	66	36	g	7
7028	109	36	g	5
6999	78	36	g	5
6938	8	36	g	5
6916	201	35	g	0.1501501501501501
6944	14	36	g	5
6951	22	36	g	2
6933	3	36	g	10
6953	25	36	g	5
6960	33	36	g	7
7022	102	36	g	5
6989	65	36	g	5
6996	75	36	g	7
6952	24	36	g	5
6977	53	36	g	5
6912	197	35	g	10
6995	74	36	g	2
6919	204	35	g	10
6917	202	35	g	10
6962	35	36	g	5
7005	84	36	g	5
6998	77	36	g	7
7029	110	36	g	4
6949	19	36	g	2
6907	191	35	g	10
6994	71	36	g	10
6905	189	35	g	10
6972	47	36	g	7
6970	45	36	g	7
6947	17	36	g	5
7014	93	36	g	5
6908	192	35	g	10
7025	105	36	g	7
6913	198	35	g	10
6958	30	36	g	0
6927	212	35	g	10
6955	27	36	g	5
6936	6	36	g	0
6967	42	36	g	2
6901	185	35	g	10
6941	11	36	g	5
6973	48	36	g	5
6965	40	36	g	10
6988	64	36	g	7
6925	210	35	g	10
7010	89	36	g	5
6928	213	35	g	10
6929	214	35	g	10
6940	10	36	g	5
6946	16	36	g	5
6918	203	35	g	0
6926	211	35	g	10
6976	52	36	g	5
7006	85	36	g	2
6924	209	35	g	10
7021	101	36	g	5
6945	15	36	g	5
7031	112	36	g	5
7020	100	36	g	4
6950	21	36	g	5
6903	187	35	g	10
7001	80	36	g	5
7008	87	36	g	5
6975	51	36	g	0
6979	55	36	g	2
6948	18	36	g	0
6961	34	36	g	2
7017	97	36	g	5
6922	207	35	g	10
7026	106	36	g	2
6930	215	35	g	10
7024	104	36	g	4
7015	95	36	g	7
6959	31	36	g	5
6964	38	36	g	5
7012	91	36	g	5
6971	46	36	g	5
6911	196	35	g	10
7030	111	36	g	7
7016	96	36	g	5
6984	60	36	g	5
6937	7	36	g	5
7000	79	36	g	5
6974	50	36	g	10
7027	107	36	g	10
6906	190	35	g	10
6987	63	36	g	5
6981	57	36	g	0
7009	88	36	g	5
6931	1	36	g	10
6910	194	35	g	10
7002	81	36	g	7
6939	9	36	g	10
9946	94	4	g	0
8632	131	44	m	0
8645	145	44	g	20
8625	123	44	g	20
8626	124	44	g	20
7052	135	36	p	0
8618	115	44	g	18
7055	138	36	g	7
7091	177	36	p	0
8631	130	44	g	20
8621	119	44	m	0
9947	49	4	g	33.33333333333333
9948	32	4	g	0
1589	5	9	m	0
1572	203	8	g	100
1596	12	9	m	0
7107	193	36	p	0
7113	200	36	p	0
7118	205	36	p	0
9942	37	4	g	97.58374519494782
599	5	4	g	99.56068094453597
9943	20	4	g	0
9944	166	4	g	98.79187259747391
9945	151	4	g	100
1608	26	9	g	99.56140350877193
616	24	4	g	50
7039	121	36	g	0
7090	176	36	g	2
7035	116	36	g	5
8633	132	44	m	0
7075	160	36	g	2
7096	182	36	g	5
7077	162	36	g	5
7061	145	36	g	10
7100	186	36	g	0
7040	122	36	g	2
7089	175	36	g	2
7119	206	36	g	5
7112	199	36	g	4
7114	201	36	g	0
7057	141	36	g	2
7058	142	36	g	10
7084	170	36	g	7
7062	146	36	g	7
7121	208	36	g	10
7093	179	36	g	7
7047	130	36	g	7
7094	180	36	g	5
7080	165	36	g	10
7108	194	36	g	0
7079	164	36	g	10
7049	132	36	g	0
7087	173	36	g	10
7069	154	36	g	5
7053	136	36	g	5
7038	120	36	g	2
7074	159	36	g	5
7082	168	36	g	2
7050	133	36	g	5
7043	125	36	g	7
7092	178	36	g	5
7066	150	36	g	10
7105	191	36	g	5
7073	158	36	g	0
7103	189	36	g	5
7117	204	36	g	5
7115	202	36	g	10
7063	147	36	g	5
7125	212	36	g	10
7078	163	36	g	5
7060	144	36	g	5
7037	119	36	g	7
7111	198	36	g	10
7123	210	36	g	7
7081	167	36	g	5
7067	152	36	g	10
7106	192	36	g	5
7048	131	36	g	7
7126	213	36	g	7
7127	214	36	g	5
7116	203	36	g	4
7070	155	36	g	4
7124	211	36	g	10
7086	172	36	g	10
7051	134	36	g	2
7128	215	36	g	5
7033	114	36	g	7
7122	209	36	g	5
7085	171	36	g	5
1622	43	9	m	0
7054	137	36	g	10
7064	148	36	g	2
1640	62	9	m	0
7088	174	36	g	5
7036	117	36	g	5
7046	129	36	g	7
7076	161	36	g	5
7045	128	36	g	5
7044	127	36	g	0
7102	188	36	g	10
7059	143	36	g	5
7042	124	36	g	7
7097	183	36	g	5
7065	149	36	g	10
7109	196	36	g	2
7110	197	36	g	10
7101	187	36	g	5
7071	156	36	g	5
7083	169	36	g	2
7104	190	36	g	10
7034	115	36	g	7
8617	114	44	p	0
8620	117	44	p	0
8624	122	44	p	0
8629	128	44	p	0
8630	129	44	p	0
8636	135	44	p	0
8637	136	44	p	0
8638	137	44	p	0
7151	25	37	m	0
7168	45	37	m	0
7143	15	37	m	0
9949	166	5	g	100
9950	151	5	g	100
9951	32	5	g	0
1728	159	9	g	0
1806	26	10	g	100
7130	2	37	g	10
7129	1	37	p	0
7133	5	37	p	0
7135	7	37	p	0
1787	5	10	m	0
1794	12	10	m	0
1804	24	10	m	0
7136	8	37	p	0
1820	43	10	m	0
7137	9	37	p	0
1802	21	10	g	100
1818	41	10	g	100
1783	1	10	g	100
1790	8	10	g	100
1825	48	10	g	100
1789	7	10	g	100
1805	25	10	g	100
7138	10	37	p	0
7139	11	37	p	0
7140	12	37	p	0
7141	13	37	p	0
7145	17	37	p	0
7152	26	37	p	0
7154	28	37	p	0
7155	29	37	p	0
7158	33	37	p	0
7162	38	37	p	0
7163	40	37	p	0
7166	43	37	p	0
7169	46	37	p	0
7247	132	37	g	10
7263	149	37	m	0
7265	152	37	m	0
9952	166	6	g	100
9953	151	6	g	100
9954	32	6	g	0
1887	116	10	g	100
2003	25	11	g	0
2023	48	11	g	100
7253	138	37	g	10
1985	5	11	m	0
1992	12	11	m	0
2002	24	11	m	0
2004	26	11	g	100
2018	43	11	m	0
2036	62	11	m	0
2000	21	11	g	100
2016	41	11	g	100
2031	57	11	g	100
1988	8	11	g	100
1987	7	11	g	100
2038	64	11	g	100
1981	1	11	m	0
7250	135	37	p	0
7251	136	37	p	0
7252	137	37	p	0
7254	139	37	p	0
7256	142	37	p	0
7257	143	37	p	0
7258	144	37	p	0
7264	150	37	p	0
7266	153	37	p	0
7267	154	37	p	0
7269	156	37	p	0
7270	157	37	p	0
7400	83	38	g	10
7366	45	38	m	0
7369	48	38	m	0
7372	52	38	m	0
7371	51	38	m	0
7397	80	38	m	0
9955	166	7	g	0
9956	32	7	g	0
2185	7	12	g	0
2191	13	12	g	20
2184	6	12	g	0
2193	15	12	g	46.666666666666664
2042	69	11	m	0
2179	1	12	m	0
2183	5	12	m	0
2188	10	12	m	0
2189	11	12	m	0
2190	12	12	m	0
7356	33	38	p	0
7360	38	38	p	0
7361	40	38	p	0
7364	43	38	p	0
7367	46	38	p	0
7368	47	38	p	0
2195	17	12	g	100
7370	50	38	p	0
2186	8	12	g	46.666666666666664
2196	18	12	g	91.11111111111111
2198	21	12	g	100
7373	53	38	p	0
7379	59	38	p	0
7380	60	38	p	0
7381	61	38	p	0
7382	62	38	p	0
7383	63	38	p	0
7384	64	38	p	0
7386	66	38	p	0
7387	68	38	p	0
7388	69	38	p	0
7389	70	38	p	0
7390	71	38	p	0
7392	75	38	p	0
7393	76	38	p	0
7394	77	38	p	0
7396	79	38	p	0
7399	82	38	p	0
7403	86	38	p	0
7493	183	38	m	0
7494	184	38	g	0
7496	186	38	g	0
7505	196	38	g	10
7470	159	38	m	0
7469	158	38	g	10
7484	174	38	g	10
7474	163	38	m	0
7461	149	38	m	0
7481	171	38	g	0
7463	152	38	m	0
9957	166	8	g	0
9958	32	8	g	0
7510	201	38	g	10
2199	22	12	g	20
7454	142	38	p	0
7455	143	38	p	0
7456	144	38	p	0
7462	150	38	p	0
7464	153	38	p	0
7465	154	38	p	0
7467	156	38	p	0
7468	157	38	p	0
7476	165	38	p	0
7477	167	38	p	0
7479	169	38	p	0
7482	172	38	p	0
7483	173	38	p	0
7485	175	38	p	0
7487	177	38	p	0
7488	178	38	p	0
7490	180	38	p	0
7491	181	38	p	0
7492	182	38	p	0
7495	185	38	p	0
7497	187	38	p	0
7498	188	38	p	0
7500	190	38	p	0
7501	191	38	p	0
7503	193	38	p	0
7506	197	38	p	0
7507	198	38	p	0
7508	199	38	p	0
7509	200	38	p	0
7515	206	38	g	10
7520	211	38	m	0
9959	32	9	g	0
2364	203	12	g	0
2381	5	13	m	0
2361	200	12	m	0
2366	205	12	m	0
2367	206	12	m	0
2369	208	12	m	0
2357	196	12	g	100
2359	198	12	g	8.888888888888888
2362	201	12	g	77.77777777777779
7514	205	38	p	0
7516	207	38	p	0
7517	208	38	p	0
7518	209	38	p	0
7519	210	38	p	0
7659	149	39	m	0
7661	152	39	m	0
9960	32	10	g	0
2598	26	14	g	45.95744680851064
2630	62	14	g	0
2520	159	13	g	0
7652	142	39	p	0
2579	5	14	m	0
2586	12	14	m	0
2612	43	14	m	0
2617	48	14	m	0
7653	143	39	p	0
7654	144	39	p	0
7660	150	39	p	0
7796	83	40	g	10
9961	32	11	g	0
2676	113	14	g	0
2777	5	15	m	0
2784	12	15	m	0
2810	43	15	m	0
7795	82	40	p	0
7799	86	40	p	0
7801	88	40	p	0
7802	89	40	p	0
7804	91	40	p	0
7805	92	40	p	0
7808	96	40	p	0
7809	97	40	p	0
7943	25	41	m	0
7960	45	41	m	0
7935	15	41	m	0
2206	30	12	g	26.666666666666668
2326	163	12	g	17.777777777777775
2315	152	12	g	86.66666666666666
2338	176	12	g	0
2349	187	12	g	0
2372	211	12	g	17.777777777777775
2324	161	12	g	0
9962	32	12	g	0
2279	112	12	g	20
2271	103	12	g	37.77777777777778
2221	48	12	g	64.44444444444444
2828	62	15	m	0
2975	5	16	m	0
2982	12	16	m	0
7937	17	41	p	0
7944	26	41	p	0
7946	28	41	p	0
7947	29	41	p	0
7950	33	41	p	0
7954	38	41	p	0
7955	40	41	p	0
7958	43	41	p	0
7961	46	41	p	0
8087	183	41	m	0
8088	184	41	g	5
8078	174	41	g	5
8075	171	41	g	5
2797	27	15	g	100
2910	153	15	g	55
2963	208	15	g	100
2802	33	15	g	100
2936	180	15	g	100
2781	9	15	g	100
2775	3	15	g	100
2898	139	15	g	35
2831	65	15	g	100
2838	75	15	g	100
2880	120	15	g	100
2819	53	15	g	100
2885	125	15	g	93.75
2908	150	15	g	100
2934	178	15	g	100
2847	84	15	g	100
2814	47	15	g	100
2937	181	15	g	100
2791	19	15	g	100
2947	191	15	g	100
2836	71	15	g	100
2915	158	15	g	80
2861	99	15	g	100
2949	193	15	g	100
2894	135	15	g	70
2945	189	15	g	100
2812	45	15	g	100
2800	30	15	g	100
2905	147	15	g	100
2967	212	15	g	35
2879	119	15	g	100
2856	93	15	g	100
2893	134	15	g	100
2948	192	15	g	100
2867	105	15	g	100
2807	40	15	g	100
2830	64	15	g	93.75
2890	131	15	g	100
2852	89	15	g	100
2851	88	15	g	100
2887	128	15	g	100
2822	56	15	g	100
2953	198	15	g	100
2809	42	15	g	100
2941	185	15	g	100
2783	11	15	g	100
2965	210	15	g	100
2909	152	15	g	100
2782	10	15	g	100
2968	213	15	g	100
2969	214	15	g	100
2932	176	15	g	100
2788	16	15	g	100
2835	70	15	g	100
2863	101	15	g	100
2787	15	15	g	100
2862	100	15	g	100
2943	187	15	g	100
2966	211	15	g	100
2918	161	15	g	100
2907	149	15	g	75
2818	52	15	g	100
2994	26	16	g	100
8076	172	41	p	0
8077	173	41	p	0
8079	175	41	p	0
8081	177	41	p	0
8082	178	41	p	0
8084	180	41	p	0
8085	181	41	p	0
8086	182	41	p	0
8229	123	42	m	0
8230	124	42	m	0
8222	115	42	g	10
8235	130	42	m	0
8225	119	42	g	10
8219	112	42	g	5
2864	102	15	g	87.5
2875	114	15	g	100
2873	112	15	g	100
2792	21	15	g	93.75
2850	87	15	g	100
2817	51	15	g	100
2962	207	15	g	100
2927	171	15	g	100
2776	4	15	g	93.75
2824	58	15	g	100
2853	90	15	g	100
2865	103	15	g	100
2843	80	15	g	75
2821	55	15	g	93.75
2790	18	15	g	100
8237	132	42	g	7.5
3173	5	17	m	0
3158	205	16	m	0
3168	215	16	m	0
8218	111	42	p	0
8220	113	42	p	0
8221	114	42	p	0
8224	117	42	p	0
8228	122	42	p	0
8233	128	42	p	0
8234	129	42	p	0
8240	135	42	p	0
8241	136	42	p	0
8242	137	42	p	0
8356	45	43	m	0
8359	48	43	m	0
8362	52	43	m	0
8361	51	43	m	0
3380	14	18	g	0
3369	3	18	g	0
3385	19	18	g	0
3381	15	18	g	0
7847	138	40	g	10
8837	138	45	g	10
7922	2	41	g	10
8297	196	42	m	0
9683	196	49	m	0
3298	144	17	m	0
3367	1	18	m	0
3371	5	18	m	0
3372	6	18	m	0
3376	10	18	m	0
3377	11	18	m	0
3378	12	18	m	0
3387	22	18	m	0
3388	24	18	m	0
3379	13	18	g	95.45454545454545
3383	17	18	g	98.86363636363636
3368	2	18	g	100
3384	18	18	g	95.45454545454545
3373	7	18	g	80.68181818181817
8342	28	43	p	0
8343	29	43	p	0
8346	33	43	p	0
8350	38	43	p	0
8351	40	43	p	0
8354	43	43	p	0
8357	46	43	p	0
8358	47	43	p	0
8360	50	43	p	0
8363	53	43	p	0
8369	59	43	p	0
8370	60	43	p	0
8371	61	43	p	0
8372	62	43	p	0
8424	120	43	m	0
8415	110	43	m	0
8412	106	43	m	0
8420	115	43	g	7.520215633423181
8423	119	43	m	0
8417	112	43	m	0
3455	99	18	g	96.5909090909091
3666	113	19	g	98.75
3565	1	19	m	0
3566	2	19	m	0
3567	3	19	m	0
3568	4	19	m	0
3569	5	19	m	0
3570	6	19	m	0
3571	7	19	m	0
3572	8	19	m	0
3573	9	19	m	0
3574	10	19	m	0
3575	11	19	m	0
3576	12	19	m	0
3577	13	19	m	0
3578	14	19	m	0
3579	15	19	m	0
3580	16	19	m	0
3581	17	19	m	0
3582	18	19	m	0
3583	19	19	m	0
3584	21	19	m	0
3585	22	19	m	0
3586	24	19	m	0
3587	25	19	m	0
3588	26	19	m	0
3589	27	19	m	0
3590	28	19	m	0
3591	29	19	m	0
3592	30	19	m	0
3593	31	19	m	0
3594	33	19	m	0
3595	34	19	m	0
3596	35	19	m	0
3597	36	19	m	0
3598	38	19	m	0
3599	40	19	m	0
3600	41	19	m	0
3601	42	19	m	0
3602	43	19	m	0
3603	44	19	m	0
3604	45	19	m	0
3605	46	19	m	0
3606	47	19	m	0
3607	48	19	m	0
3608	50	19	m	0
3609	51	19	m	0
3610	52	19	m	0
3611	53	19	m	0
8413	107	43	p	0
8416	111	43	p	0
8418	113	43	p	0
8419	114	43	p	0
8422	117	43	p	0
3763	1	20	m	0
3764	2	20	m	0
3765	3	20	m	0
3766	4	20	m	0
3767	5	20	m	0
3768	6	20	m	0
3961	1	21	p	0
3962	2	21	p	0
3963	3	21	p	0
3964	4	21	p	0
3965	5	21	p	0
3966	6	21	p	0
3967	7	21	p	0
3968	8	21	p	0
3969	9	21	p	0
3970	10	21	p	0
3971	11	21	p	0
3972	12	21	p	0
3973	13	21	p	0
3974	14	21	p	0
3975	15	21	p	0
3976	16	21	p	0
3977	17	21	p	0
3978	18	21	p	0
3979	19	21	p	0
3980	21	21	p	0
3981	22	21	p	0
3982	24	21	p	0
3983	25	21	p	0
3984	26	21	p	0
3985	27	21	p	0
3986	28	21	p	0
3987	29	21	p	0
3988	30	21	p	0
3989	31	21	p	0
3990	33	21	p	0
3991	34	21	p	0
3992	35	21	p	0
3993	36	21	p	0
3994	38	21	p	0
3995	40	21	p	0
3996	41	21	p	0
3997	42	21	p	0
3998	43	21	p	0
3999	44	21	p	0
4000	45	21	p	0
4001	46	21	p	0
4002	47	21	p	0
4003	48	21	p	0
4004	50	21	p	0
4005	51	21	p	0
4006	52	21	p	0
4007	53	21	p	0
4008	54	21	p	0
4009	55	21	p	0
4010	56	21	p	0
4011	57	21	p	0
4012	58	21	p	0
4013	59	21	p	0
4014	60	21	p	0
4015	61	21	p	0
4016	62	21	p	0
4017	63	21	p	0
4018	64	21	p	0
4019	65	21	p	0
4020	66	21	p	0
4021	68	21	p	0
4022	69	21	p	0
4023	70	21	p	0
4024	71	21	p	0
4025	74	21	p	0
4026	75	21	p	0
4027	76	21	p	0
4028	77	21	p	0
4029	78	21	p	0
4030	79	21	p	0
4031	80	21	p	0
4032	81	21	p	0
4033	82	21	p	0
4034	83	21	p	0
4035	84	21	p	0
4036	85	21	p	0
4037	86	21	p	0
4038	87	21	p	0
4039	88	21	p	0
4040	89	21	p	0
4041	90	21	p	0
4042	91	21	p	0
4043	92	21	p	0
4044	93	21	p	0
4045	95	21	p	0
4046	96	21	p	0
4047	97	21	p	0
4048	98	21	p	0
4049	99	21	p	0
4050	100	21	p	0
4051	101	21	p	0
4052	102	21	p	0
4053	103	21	p	0
4054	104	21	p	0
4055	105	21	p	0
4056	106	21	p	0
4057	107	21	p	0
4058	109	21	p	0
4059	110	21	p	0
4060	111	21	p	0
4061	112	21	p	0
4062	113	21	p	0
4063	114	21	p	0
4064	115	21	p	0
4065	116	21	p	0
4066	117	21	p	0
4067	119	21	p	0
4068	120	21	p	0
4069	121	21	p	0
4070	122	21	p	0
4071	123	21	p	0
4072	124	21	p	0
4073	125	21	p	0
4074	127	21	p	0
4075	128	21	p	0
4076	129	21	p	0
4077	130	21	p	0
4078	131	21	p	0
4079	132	21	p	0
4080	133	21	p	0
4081	134	21	p	0
4082	135	21	p	0
4083	136	21	p	0
4084	137	21	p	0
4085	138	21	p	0
4086	139	21	p	0
4087	141	21	p	0
4088	142	21	p	0
4089	143	21	p	0
4090	144	21	p	0
4091	145	21	p	0
4092	146	21	p	0
4093	147	21	p	0
4094	148	21	p	0
4095	149	21	p	0
4096	150	21	p	0
4097	152	21	p	0
4098	153	21	p	0
4099	154	21	p	0
4100	155	21	p	0
4101	156	21	p	0
4102	157	21	p	0
4103	158	21	p	0
4104	159	21	p	0
4105	160	21	p	0
4106	161	21	p	0
4107	162	21	p	0
4108	163	21	p	0
4109	164	21	p	0
4110	165	21	p	0
4111	167	21	p	0
4112	168	21	p	0
4113	169	21	p	0
4114	170	21	p	0
4115	171	21	p	0
4116	172	21	p	0
4117	173	21	p	0
4118	174	21	p	0
4119	175	21	p	0
4120	176	21	p	0
4121	177	21	p	0
4122	178	21	p	0
4123	179	21	p	0
4124	180	21	p	0
4125	181	21	p	0
4126	182	21	p	0
4127	183	21	p	0
4128	184	21	p	0
4129	185	21	p	0
4130	186	21	p	0
4131	187	21	p	0
4132	188	21	p	0
4133	189	21	p	0
4134	190	21	p	0
4135	191	21	p	0
4136	192	21	p	0
4137	193	21	p	0
4138	194	21	p	0
4139	196	21	p	0
4140	197	21	p	0
4141	198	21	p	0
4142	199	21	p	0
4143	200	21	p	0
4144	201	21	p	0
4145	202	21	p	0
4146	203	21	p	0
4147	204	21	p	0
4148	205	21	p	0
4149	206	21	p	0
4150	207	21	p	0
4151	208	21	p	0
4152	209	21	p	0
4153	210	21	p	0
4154	211	21	p	0
4155	212	21	p	0
4156	213	21	p	0
4157	214	21	p	0
4158	215	21	p	0
4183	27	22	g	100
4201	48	22	g	100
4227	78	22	g	100
4193	40	22	g	100
4224	75	22	g	100
4211	59	22	g	100
4159	1	22	g	100
4229	80	22	g	100
4190	35	22	g	100
4188	33	22	g	100
4186	30	22	g	100
4233	84	22	g	100
4209	57	22	g	100
4164	6	22	g	100
4232	83	22	g	100
4200	47	22	g	100
4231	82	22	g	100
4218	66	22	g	100
4202	50	22	g	100
4234	85	22	g	100
4236	87	22	g	100
4235	86	22	g	100
4168	10	22	g	100
4219	68	22	g	100
4228	79	22	g	100
4237	88	22	g	100
4181	25	22	g	100
4222	71	22	g	100
4206	54	22	g	100
4187	31	22	g	100
4171	13	22	g	100
4205	53	22	g	100
4167	9	22	g	100
4223	74	22	g	100
4210	58	22	g	100
4169	11	22	g	100
4199	46	22	g	100
4217	65	22	g	100
4172	14	22	g	100
4165	7	22	g	100
4203	51	22	g	100
4180	24	22	g	100
4213	61	22	g	100
4177	19	22	g	100
4208	56	22	g	100
4215	63	22	g	100
4230	81	22	g	100
4161	3	22	g	100
4173	15	22	g	100
4192	38	22	g	100
4216	64	22	g	100
4163	5	22	m	0
4170	12	22	m	0
4195	42	22	m	0
4196	43	22	m	0
4214	62	22	m	0
4220	69	22	m	0
4160	2	22	g	100
2650	85	14	g	80
2760	203	14	g	56.170212765957444
2868	106	15	g	100
2848	85	15	g	100
2958	203	15	g	80
186	203	1	g	100
3156	203	16	g	100
96	106	1	g	100
294	106	2	g	100
492	106	3	g	100
690	106	4	g	100
888	106	5	g	100
1086	106	6	g	100
1284	106	7	g	100
1482	106	8	g	100
1680	106	9	g	100
1878	106	10	g	100
2076	106	11	g	100
2274	106	12	g	100
2670	106	14	g	100
3066	106	16	g	100
3264	106	17	g	100
76	85	1	g	100
274	85	2	g	100
472	85	3	g	100
670	85	4	g	100
868	85	5	g	100
1066	85	6	g	100
1264	85	7	g	100
1462	85	8	g	100
1660	85	9	g	100
1858	85	10	g	100
2056	85	11	g	100
2254	85	12	g	91.11111111111111
3046	85	16	g	80
3244	85	17	g	100
136	150	1	g	100
334	150	2	g	100
4250	102	22	g	100
4254	106	22	g	100
4241	92	22	m	0
4253	105	22	g	100
4242	93	22	x	0
4243	95	22	x	0
4247	99	22	g	100
2472	106	13	g	100
2452	85	13	g	100
532	150	3	g	100
730	150	4	g	100
928	150	5	g	100
1126	150	6	g	100
1324	150	7	g	100
1522	150	8	g	95.45454545454545
1918	150	10	g	100
2116	150	11	g	100
2314	150	12	g	100
644	56	4	g	99.780340472268
2710	150	14	g	100
3304	150	17	g	11.11111111111111
3502	150	18	g	98.86363636363636
139	154	1	g	100
337	154	2	g	100
535	154	3	g	100
733	154	4	g	100
931	154	5	g	100
1129	154	6	g	100
1327	154	7	g	100
1921	154	10	g	100
2119	154	11	g	100
2713	154	14	g	100
3109	154	16	g	100
3307	154	17	g	100
122	135	1	g	100
320	135	2	g	100
518	135	3	g	100
716	135	4	g	66.66666666666666
1525	154	8	g	99.8952660242983
3092	135	16	g	60
19	19	1	g	100
217	19	2	g	100
415	19	3	g	100
613	19	4	g	100
811	19	5	g	100
1009	19	6	g	100
1207	19	7	g	100
1405	19	8	g	95.45454545454545
1603	19	9	g	100
1801	19	10	g	100
1999	19	11	g	100
2197	19	12	g	82.22222222222221
1639	61	9	g	98.1359649122807
2593	19	14	g	80
2989	19	16	g	100
3187	19	17	g	80
145	160	1	g	100
343	160	2	g	100
541	160	3	g	100
739	160	4	g	97.91323448654585
937	160	5	g	100
1135	160	6	g	100
1333	160	7	g	100
1531	160	8	g	95.45454545454545
1927	160	10	g	100
2125	160	11	g	100
2323	160	12	g	100
1729	160	9	g	99.3421052631579
2719	160	14	g	87.2340425531915
3115	160	16	g	100
55	61	1	g	100
253	61	2	g	100
451	61	3	g	100
649	61	4	g	88.68753432180121
847	61	5	g	100
1045	61	6	g	100
1243	61	7	g	66.66666666666666
1441	61	8	g	95.45454545454545
1837	61	10	g	100
2035	61	11	g	100
2233	61	12	g	77.77777777777779
2629	61	14	g	100
3025	61	16	g	60
3223	61	17	g	75.55555555555556
3421	61	18	g	95.45454545454545
114	127	1	g	100
312	127	2	g	100
510	127	3	g	100
708	127	4	g	100
906	127	5	g	100
1104	127	6	g	100
1302	127	7	g	100
1500	127	8	g	100
1698	127	9	g	100
1896	127	10	g	100
1723	154	9	g	99.89035087719299
3084	127	16	g	100
50	56	1	g	100
248	56	2	g	100
446	56	3	g	100
842	56	5	g	100
1040	56	6	g	100
1238	56	7	g	100
1436	56	8	g	100
1634	56	9	g	100
1832	56	10	g	100
2030	56	11	g	100
2228	56	12	g	95.55555555555554
2624	56	14	g	100
3020	56	16	g	100
3218	56	17	g	100
106	117	1	g	100
304	117	2	g	100
502	117	3	g	100
700	117	4	g	100
898	117	5	g	100
1096	117	6	g	100
1294	117	7	g	100
1492	117	8	g	100
1690	117	9	g	100
1888	117	10	g	100
2086	117	11	g	100
2284	117	12	g	100
2680	117	14	g	100
3076	117	16	g	100
46	52	1	g	100
244	52	2	g	100
442	52	3	g	100
640	52	4	g	100
838	52	5	g	100
1036	52	6	g	100
1234	52	7	g	100
1432	52	8	g	100
1630	52	9	g	100
1828	52	10	g	100
1720	150	9	g	99.3421052631579
2224	52	12	g	100
2422	52	13	g	100
2620	52	14	g	100
3016	52	16	g	100
3214	52	17	g	100
71	80	1	g	100
269	80	2	g	100
2482	117	13	g	100
2515	154	13	g	100
2426	56	13	g	100
2688	127	14	g	80
2431	61	13	g	80
2490	127	13	g	100
3106	150	16	g	90
2827	61	15	g	100
2886	127	15	g	100
2917	160	15	g	100
2878	117	15	g	100
2911	154	15	g	100
467	80	3	g	100
665	80	4	g	86.05161998901703
863	80	5	g	100
1061	80	6	g	100
1259	80	7	g	100
1457	80	8	g	50
1853	80	10	g	100
2051	80	11	g	100
2249	80	12	g	73.33333333333331
2447	80	13	g	100
2645	80	14	g	100
3041	80	16	g	60
3239	80	17	g	88.88888888888889
3437	80	18	g	98.86363636363636
377	196	2	g	100
575	196	3	g	100
1367	196	7	g	100
856	71	5	g	100
3149	196	16	g	40
147	162	1	g	100
345	162	2	g	100
543	162	3	g	100
741	162	4	g	100
939	162	5	g	100
1137	162	6	g	100
1335	162	7	g	100
1533	162	8	g	100
1731	162	9	g	100
1459	82	8	g	99.79053204859657
2721	162	14	g	100
3117	162	16	g	100
3315	162	17	g	38.88888888888889
13	13	1	g	100
211	13	2	g	100
409	13	3	g	100
607	13	4	g	100
805	13	5	g	100
1003	13	6	g	100
1201	13	7	g	100
1399	13	8	g	100
1597	13	9	g	100
1795	13	10	g	100
1993	13	11	g	100
1565	196	8	g	100
2587	13	14	g	100
2983	13	16	g	90
141	156	1	g	100
339	156	2	g	100
537	156	3	g	100
735	156	4	g	100
933	156	5	g	100
1131	156	6	g	100
1329	156	7	g	100
1527	156	8	g	95.45454545454545
1725	156	9	g	100
1923	156	10	g	100
2121	156	11	g	100
2319	156	12	g	100
2715	156	14	g	100
3111	156	16	g	100
3309	156	17	g	100
3507	156	18	g	95.45454545454545
73	82	1	g	100
271	82	2	g	100
469	82	3	g	100
667	82	4	g	100
865	82	5	g	100
1063	82	6	g	100
1261	82	7	g	100
1855	82	10	g	100
1657	82	9	g	99.89035087719299
2647	82	14	g	100
3043	82	16	g	80
3241	82	17	g	100
64	71	1	g	100
262	71	2	g	100
460	71	3	g	100
658	71	4	g	100
1054	71	6	g	100
1252	71	7	g	100
1846	71	10	g	100
2044	71	11	g	100
2638	71	14	g	100
3034	71	16	g	100
3232	71	17	g	63.1578947368421
174	190	1	g	100
372	190	2	g	100
570	190	3	g	100
768	190	4	g	100
966	190	5	g	100
1164	190	6	g	100
1362	190	7	g	100
1560	190	8	g	100
1758	190	9	g	100
1956	190	10	g	100
2154	190	11	g	100
1717	147	9	g	97.14912280701753
2748	190	14	g	100
3144	190	16	g	100
3342	190	17	g	100
108	120	1	g	100
306	120	2	g	100
504	120	3	g	100
702	120	4	g	100
900	120	5	g	100
1098	120	6	g	100
1296	120	7	g	100
1494	120	8	g	100
1692	120	9	g	100
1890	120	10	g	100
2088	120	11	g	100
2682	120	14	g	100
3078	120	16	g	100
3276	120	17	g	100
133	147	1	g	100
331	147	2	g	100
529	147	3	g	100
727	147	4	g	97.36408566721582
925	147	5	g	100
1123	147	6	g	100
1321	147	7	g	100
1655	80	9	g	97.80701754385966
1915	147	10	g	100
2113	147	11	g	100
2311	147	12	g	37.77777777777778
2707	147	14	g	100
3103	147	16	g	100
3301	147	17	g	100
27	29	1	g	100
225	29	2	g	100
423	29	3	g	100
621	29	4	g	100
819	29	5	g	100
1017	29	6	g	100
1215	29	7	g	100
1413	29	8	g	100
2440	71	13	g	100
2484	120	13	g	100
2053	82	11	g	0
2517	156	13	g	100
2509	147	13	g	95.86056644880175
3347	196	17	g	54.73684210526316
2845	82	15	g	100
2913	156	15	g	100
2946	190	15	g	100
2785	13	15	g	100
2919	162	15	g	100
1611	29	9	g	100
1809	29	10	g	100
2205	29	12	g	100
2601	29	14	g	100
2997	29	16	g	100
3195	29	17	g	100
137	152	1	g	100
1325	152	7	g	100
2711	152	14	g	100
3107	152	16	g	100
3305	152	17	g	61.111111111111114
1741	173	9	g	99.56140350877193
3138	184	16	g	100
185	202	1	g	100
383	202	2	g	100
581	202	3	g	100
779	202	4	g	100
977	202	5	g	100
1175	202	6	g	100
1373	202	7	g	100
1571	202	8	g	100
1769	202	9	g	100
1967	202	10	g	100
2165	202	11	g	100
2363	202	12	g	82.22222222222221
2007	29	11	g	0
2759	202	14	g	100
3155	202	16	g	100
3353	202	17	g	100
3551	202	18	g	98.86363636363636
78	87	1	g	100
276	87	2	g	100
474	87	3	g	100
672	87	4	g	100
2706	146	14	g	80
1068	87	6	g	100
1266	87	7	g	100
2606	35	14	g	87.2340425531915
1860	87	10	g	100
2454	87	13	g	100
2652	87	14	g	100
3048	87	16	g	100
3246	87	17	g	100
32	35	1	g	100
230	35	2	g	100
428	35	3	g	100
626	35	4	g	100
824	35	5	g	100
1022	35	6	g	100
1220	35	7	g	100
1418	35	8	g	100
1616	35	9	g	100
1814	35	10	g	100
2012	35	11	g	100
2210	35	12	g	100
3002	35	16	g	100
3200	35	17	g	33.33333333333333
132	146	1	g	100
330	146	2	g	100
528	146	3	g	100
726	146	4	g	100
924	146	5	g	100
1122	146	6	g	100
1320	146	7	g	100
1518	146	8	g	100
1716	146	9	g	100
2310	146	12	g	100
3498	146	18	g	100
17	17	1	g	100
215	17	2	g	100
413	17	3	g	100
611	17	4	g	100
809	17	5	g	100
1007	17	6	g	100
1205	17	7	g	100
1403	17	8	g	97.98182182473909
1601	17	9	g	99.78070175438596
1799	17	10	g	100
1997	17	11	g	100
2591	17	14	g	100
2987	17	16	g	100
3185	17	17	g	88.88888888888889
57	63	1	g	100
255	63	2	g	100
453	63	3	g	100
651	63	4	g	100
849	63	5	g	100
1047	63	6	g	100
1245	63	7	g	100
1443	63	8	g	100
1641	63	9	g	100
1839	63	10	g	100
2037	63	11	g	100
2235	63	12	g	100
2631	63	14	g	100
3027	63	16	g	100
3225	63	17	g	100
157	173	1	g	100
355	173	2	g	100
553	173	3	g	100
751	173	4	g	100
949	173	5	g	100
1147	173	6	g	100
1345	173	7	g	66.66666666666666
1543	173	8	g	95.45454545454545
1939	173	10	g	100
2137	173	11	g	100
2335	173	12	g	20
2731	173	14	g	100
3127	173	16	g	100
3325	173	17	g	55.55555555555556
3523	173	18	g	100
33	36	1	g	100
231	36	2	g	100
429	36	3	g	100
627	36	4	g	83.22350356946733
825	36	5	g	100
1023	36	6	g	100
1221	36	7	g	100
1419	36	8	g	95.45454545454545
1617	36	9	g	100
1815	36	10	g	100
2013	36	11	g	100
2211	36	12	g	100
2607	36	14	g	100
3003	36	16	g	100
3201	36	17	g	100
3	3	1	g	100
201	3	2	g	100
731	152	4	g	100
533	152	3	g	100
2403	29	13	g	100
2513	152	13	g	100
3102	146	16	g	48
2544	184	13	g	100
2508	146	13	g	100
2433	63	13	g	100
3336	184	17	g	48.88888888888889
2799	29	15	g	100
2904	146	15	g	100
2829	63	15	g	100
2929	173	15	g	93.75
2805	36	15	g	100
2957	202	15	g	93.75
2804	35	15	g	100
2789	17	15	g	93.75
399	3	3	g	100
597	3	4	g	100
795	3	5	g	100
993	3	6	g	100
1191	3	7	g	100
1389	3	8	g	100
1587	3	9	g	100
1785	3	10	g	100
1983	3	11	g	100
2181	3	12	g	100
2577	3	14	g	100
2973	3	16	g	100
3171	3	17	g	100
41	46	1	g	100
239	46	2	g	100
437	46	3	g	100
635	46	4	g	100
833	46	5	g	100
1031	46	6	g	100
1229	46	7	g	100
1427	46	8	g	100
1625	46	9	g	100
1823	46	10	g	100
2021	46	11	g	100
2219	46	12	g	100
608	14	4	g	99.780340472268
2615	46	14	g	100
3011	46	16	g	100
3209	46	17	g	100
126	139	1	g	100
155	171	1	g	100
1465	88	8	g	99.79053204859657
3125	171	16	g	100
194	211	1	g	100
392	211	2	g	100
590	211	3	g	100
788	211	4	g	100
986	211	5	g	100
1184	211	6	g	100
1382	211	7	g	100
1580	211	8	g	100
1976	211	10	g	100
2174	211	11	g	100
2768	211	14	g	100
3164	211	16	g	100
3362	211	17	g	100
44	50	1	g	100
242	50	2	g	100
440	50	3	g	100
638	50	4	g	100
836	50	5	g	100
1034	50	6	g	100
1232	50	7	g	100
1430	50	8	g	100
1628	50	9	g	100
1826	50	10	g	100
1598	14	9	g	99.12280701754386
2618	50	14	g	100
3014	50	16	g	100
3212	50	17	g	83.33333333333334
2	2	1	g	100
200	2	2	g	100
398	2	3	g	100
596	2	4	g	66.66666666666666
794	2	5	g	100
992	2	6	g	100
1190	2	7	g	66.66666666666666
1388	2	8	g	93.47826086956522
1586	2	9	g	100
1784	2	10	g	100
1982	2	11	g	100
2180	2	12	g	100
1778	211	9	g	99.89035087719299
2576	2	14	g	80
2972	2	16	g	60
3170	2	17	g	100
56	62	1	g	100
254	62	2	g	100
452	62	3	g	100
79	88	1	g	100
277	88	2	g	100
475	88	3	g	100
673	88	4	g	100
871	88	5	g	100
1069	88	6	g	100
1267	88	7	g	100
1663	88	9	g	100
1861	88	10	g	100
2059	88	11	g	100
2257	88	12	g	100
2653	88	14	g	100
3049	88	16	g	100
3247	88	17	g	100
20	21	1	g	100
218	21	2	g	100
416	21	3	g	100
614	21	4	g	100
812	21	5	g	100
1010	21	6	g	100
1208	21	7	g	100
1406	21	8	g	95.45454545454545
2396	21	13	g	100
2594	21	14	g	100
2990	21	16	g	80
3188	21	17	g	83.33333333333334
3386	21	18	g	98.86363636363636
14	14	1	g	100
212	14	2	g	100
410	14	3	g	100
806	14	5	g	100
1004	14	6	g	100
1202	14	7	g	100
1400	14	8	g	95.45454545454545
1796	14	10	g	100
1994	14	11	g	100
2192	14	12	g	86.66666666666666
2588	14	14	g	100
2984	14	16	g	100
3182	14	17	g	68.42105263157895
82	91	1	g	100
280	91	2	g	100
478	91	3	g	100
676	91	4	g	100
874	91	5	g	100
1072	91	6	g	100
1270	91	7	g	100
1468	91	8	g	100
1666	91	9	g	100
1864	91	10	g	100
2062	91	11	g	100
2260	91	12	g	100
1604	21	9	g	98.1359649122807
2024	50	11	m	0
2570	211	13	g	100
2531	171	13	g	80
2729	171	14	g	80
2390	14	13	g	100
2379	3	13	g	100
2432	62	13	g	100
2455	88	13	g	100
3294	139	17	g	44.44444444444444
3323	171	17	g	48.88888888888889
2813	46	15	g	100
2816	50	15	g	100
2774	2	15	g	75
2786	14	15	g	100
2656	91	14	g	100
3052	91	16	g	100
3250	91	17	g	100
86	96	1	g	100
284	96	2	g	100
482	96	3	g	100
680	96	4	g	82.45469522240528
878	96	5	g	100
1076	96	6	g	100
1274	96	7	g	100
1472	96	8	g	100
1670	96	9	g	100
1868	96	10	g	100
2066	96	11	g	100
2660	96	14	g	100
3056	96	16	g	48
3254	96	17	g	100
121	134	1	g	100
319	134	2	g	100
517	134	3	g	100
1111	134	6	g	100
1309	134	7	g	100
668	83	4	g	99.780340472268
778	201	4	g	98.13289401427787
3091	134	16	g	90
3289	134	17	g	88.88888888888889
74	83	1	g	100
272	83	2	g	100
470	83	3	g	100
866	83	5	g	100
1064	83	6	g	100
1262	83	7	g	100
1460	83	8	g	93.47826086956522
1856	83	10	g	100
2054	83	11	g	100
2252	83	12	g	20
2648	83	14	g	100
3044	83	16	g	100
3242	83	17	g	68.42105263157895
3440	83	18	g	72.72727272727273
104	115	1	g	100
302	115	2	g	100
500	115	3	g	100
698	115	4	g	100
896	115	5	g	100
1094	115	6	g	100
1292	115	7	g	100
1688	115	9	g	99.23245614035088
1886	115	10	g	100
2084	115	11	g	100
2678	115	14	g	80
3074	115	16	g	100
30	33	1	g	100
228	33	2	g	100
426	33	3	g	100
624	33	4	g	100
822	33	5	g	100
1020	33	6	g	100
1218	33	7	g	100
1416	33	8	g	100
1614	33	9	g	100
1812	33	10	g	100
2010	33	11	g	100
2208	33	12	g	100
2604	33	14	g	100
3000	33	16	g	100
3198	33	17	g	100
707	125	4	g	66.66666666666666
53	59	1	g	100
251	59	2	g	100
449	59	3	g	100
647	59	4	g	100
845	59	5	g	100
1043	59	6	g	100
1241	59	7	g	100
1439	59	8	g	95.45454545454545
1637	59	9	g	99.78070175438596
1835	59	10	g	100
2033	59	11	g	100
2231	59	12	g	100
2627	59	14	g	100
3023	59	16	g	100
3221	59	17	g	100
3419	59	18	g	100
25	27	1	g	100
223	27	2	g	100
421	27	3	g	100
619	27	4	g	100
817	27	5	g	100
1015	27	6	g	100
1213	27	7	g	100
1411	27	8	g	100
1609	27	9	g	100
1807	27	10	g	100
2005	27	11	g	100
2203	27	12	g	100
715	134	4	g	98.57221306974189
2599	27	14	g	100
2995	27	16	g	100
3193	27	17	g	100
66	75	1	g	100
264	75	2	g	100
462	75	3	g	100
660	75	4	g	100
858	75	5	g	100
1056	75	6	g	100
1254	75	7	g	100
1452	75	8	g	100
1650	75	9	g	100
1848	75	10	g	100
2046	75	11	g	100
2244	75	12	g	100
2640	75	14	g	100
3036	75	16	g	100
3234	75	17	g	100
184	201	1	g	100
382	201	2	g	100
580	201	3	g	100
976	201	5	g	100
113	125	1	g	100
1490	115	8	g	99.81147884373691
1658	83	9	g	98.90350877192982
2758	201	14	g	56.170212765957444
1895	125	10	g	100
2093	125	11	g	100
2687	125	14	g	80
197	214	1	g	100
395	214	2	g	100
2695	134	14	g	80.85106382978722
913	134	5	g	100
1507	134	8	g	100
2560	201	13	g	80
2406	33	13	g	100
2442	75	13	g	100
2489	125	13	g	100
2462	96	13	g	100
2429	59	13	g	80
2450	83	13	g	100
2480	115	13	g	100
3154	201	16	g	48
2854	91	15	g	100
2858	96	15	g	87.5
2825	59	15	g	87.5
2846	83	15	g	100
2876	115	15	g	100
593	214	3	g	100
791	214	4	g	100
989	214	5	g	100
1187	214	6	g	100
1385	214	7	g	100
1583	214	8	g	100
1781	214	9	g	100
1979	214	10	g	100
2177	214	11	g	100
2375	214	12	g	37.77777777777778
2771	214	14	g	100
3167	214	16	g	90
3365	214	17	g	94.44444444444444
160	176	1	g	100
358	176	2	g	100
556	176	3	g	100
754	176	4	g	100
952	176	5	g	100
1150	176	6	g	100
1348	176	7	g	100
1546	176	8	g	100
1744	176	9	g	66.66666666666666
1942	176	10	g	100
2140	176	11	g	100
2734	176	14	g	100
3130	176	16	g	80
192	209	1	g	100
390	209	2	g	100
588	209	3	g	100
786	209	4	g	100
984	209	5	g	100
1182	209	6	g	100
1380	209	7	g	100
1578	209	8	g	100
1776	209	9	g	100
1974	209	10	g	100
2172	209	11	g	100
2370	209	12	g	20
2766	209	14	g	100
3162	209	16	g	100
3360	209	17	g	100
63	70	1	g	100
261	70	2	g	100
459	70	3	g	100
657	70	4	g	100
855	70	5	g	100
1053	70	6	g	100
1251	70	7	g	100
1449	70	8	g	100
1647	70	9	g	100
1845	70	10	g	100
2043	70	11	g	100
2241	70	12	g	100
563	183	3	g	33.33333333333333
2637	70	14	g	80
3033	70	16	g	100
3231	70	17	g	100
3429	70	18	g	100
115	128	1	g	100
313	128	2	g	100
511	128	3	g	100
709	128	4	g	100
907	128	5	g	100
1105	128	6	g	100
1303	128	7	g	100
1501	128	8	g	100
1699	128	9	g	100
1897	128	10	g	100
2095	128	11	g	100
2689	128	14	g	100
3085	128	16	g	60
3283	128	17	g	83.33333333333334
149	164	1	g	100
347	164	2	g	100
545	164	3	g	100
941	164	5	g	100
1139	164	6	g	100
1337	164	7	g	100
1535	164	8	g	95.45454545454545
1733	164	9	g	100
761	183	4	g	99.56068094453597
2723	164	14	g	100
3317	164	17	g	100
357	175	2	g	100
753	175	4	g	99.45085118066996
951	175	5	g	100
1149	175	6	g	100
1347	175	7	g	100
1545	175	8	g	95.45454545454545
1743	175	9	g	99.78070175438596
1941	175	10	g	100
2139	175	11	g	100
2337	175	12	g	86.66666666666666
2733	175	14	g	100
3327	175	17	g	83.33333333333334
103	114	1	g	100
301	114	2	g	100
499	114	3	g	100
697	114	4	g	100
895	114	5	g	100
1093	114	6	g	100
1291	114	7	g	100
1489	114	8	g	100
1885	114	10	g	100
1687	114	9	g	99.89035087719299
2479	114	13	g	100
2677	114	14	g	100
3073	114	16	g	100
3271	114	17	g	100
119	132	1	g	100
515	132	3	g	100
2693	132	14	g	55.319148936170215
3287	132	17	g	50
190	207	1	g	100
388	207	2	g	100
586	207	3	g	100
784	207	4	g	100
982	207	5	g	100
1180	207	6	g	100
1378	207	7	g	100
1576	207	8	g	100
1774	207	9	g	100
1972	207	10	g	100
2170	207	11	g	100
2368	207	12	g	77.77777777777777
2566	207	13	g	100
2764	207	14	g	100
3160	207	16	g	100
3358	207	17	g	100
167	183	1	g	100
959	183	5	g	100
1157	183	6	g	100
1355	183	7	g	100
1553	183	8	g	95.45454545454545
1751	183	9	g	98.57456140350877
3328	176	17	g	94.73684210526315
2535	175	13	g	100
2491	128	13	g	100
2568	209	13	g	100
2573	214	13	g	100
2536	176	13	g	100
3129	175	16	g	60
2964	209	15	g	100
2931	175	15	g	100
2921	164	15	g	93.75
2891	132	15	g	87.5
1949	183	10	g	100
2147	183	11	g	100
2345	183	12	g	42.22222222222222
3137	183	16	g	60
3335	183	17	g	83.33333333333334
162	178	1	g	100
360	178	2	g	100
558	178	3	g	100
756	178	4	g	100
954	178	5	g	100
1152	178	6	g	100
1350	178	7	g	100
1548	178	8	g	100
1746	178	9	g	100
1944	178	10	g	100
349	167	2	g	66.66666666666666
547	167	3	g	100
2736	178	14	g	100
3132	178	16	g	100
3330	178	17	g	100
175	191	1	g	100
571	191	3	g	100
1363	191	7	g	100
1339	167	7	g	91.66666666666666
2749	191	14	g	100
3145	191	16	g	100
151	167	1	g	86.1111111111111
745	167	4	g	69.38495332235036
943	167	5	g	100
1141	167	6	g	100
1933	167	10	g	66.66666666666666
1537	167	8	g	90.9090909090909
2725	167	14	g	100
3121	167	16	g	48
29	31	1	g	100
227	31	2	g	100
425	31	3	g	100
623	31	4	g	99.45085118066996
821	31	5	g	100
1019	31	6	g	100
1217	31	7	g	100
1415	31	8	g	95.45454545454545
1613	31	9	g	100
1811	31	10	g	100
2009	31	11	g	100
2207	31	12	g	100
2603	31	14	g	80.85106382978722
2999	31	16	g	80
42	47	1	g	100
240	47	2	g	100
438	47	3	g	100
636	47	4	g	100
834	47	5	g	100
1032	47	6	g	100
1230	47	7	g	100
1428	47	8	g	100
1626	47	9	g	100
1824	47	10	g	100
1395	9	8	g	99.79053204859657
2741	183	14	g	64.68085106382978
2616	47	14	g	100
3012	47	16	g	100
3210	47	17	g	100
48	54	1	g	100
246	54	2	g	100
444	54	3	g	100
642	54	4	g	100
840	54	5	g	100
1038	54	6	g	100
1236	54	7	g	100
1434	54	8	g	100
1632	54	9	g	100
1830	54	10	g	100
2028	54	11	g	100
2622	54	14	g	80
3018	54	16	g	80
3216	54	17	g	100
9	9	1	g	100
207	9	2	g	100
405	9	3	g	100
603	9	4	g	100
801	9	5	g	100
999	9	6	g	100
1197	9	7	g	100
1593	9	9	g	100
1791	9	10	g	100
1989	9	11	g	100
2187	9	12	g	91.11111111111111
2583	9	14	g	100
2979	9	16	g	100
3177	9	17	g	77.77777777777779
3375	9	18	g	89.77272727272727
69	78	1	g	100
267	78	2	g	100
465	78	3	g	100
663	78	4	g	100
861	78	5	g	100
1059	78	6	g	100
1257	78	7	g	100
1455	78	8	g	100
1653	78	9	g	100
2643	78	14	g	100
3039	78	16	g	100
3237	78	17	g	100
36	41	1	g	100
234	41	2	g	100
432	41	3	g	100
630	41	4	g	100
828	41	5	g	100
1026	41	6	g	100
1224	41	7	g	100
1422	41	8	g	100
1620	41	9	g	100
2610	41	14	g	100
3006	41	16	g	100
3204	41	17	g	100
1	1	1	g	100
199	1	2	g	100
397	1	3	g	100
595	1	4	g	100
793	1	5	g	100
991	1	6	g	100
1189	1	7	g	100
1387	1	8	g	100
1585	1	9	g	100
2575	1	14	g	80
2971	1	16	g	100
3169	1	17	g	100
81	90	1	g	100
279	90	2	g	100
477	90	3	g	100
2377	1	13	g	100
2445	78	13	g	100
2412	41	13	g	100
2527	167	13	g	100
2405	31	13	g	100
2543	183	13	g	76.68845315904139
3319	167	17	g	58.94736842105263
2808	41	15	g	100
2923	167	15	g	81.25
2801	31	15	g	100
2939	183	15	g	80
2773	1	15	g	100
2841	78	15	g	100
2820	54	15	g	100
675	90	4	g	100
873	90	5	g	100
1071	90	6	g	100
1269	90	7	g	100
1467	90	8	g	100
1665	90	9	g	100
1863	90	10	g	100
2061	90	11	g	100
2457	90	13	g	100
2655	90	14	g	100
3051	90	16	g	100
3249	90	17	g	100
187	204	1	g	100
385	204	2	g	100
583	204	3	g	100
781	204	4	g	100
979	204	5	g	100
1177	204	6	g	100
1375	204	7	g	100
1573	204	8	g	100
1771	204	9	g	100
1969	204	10	g	100
2167	204	11	g	100
2365	204	12	g	100
1738	170	9	g	99.89035087719299
2761	204	14	g	100
3157	204	16	g	100
3355	204	17	g	100
67	76	1	g	100
463	76	3	g	100
120	133	1	g	100
318	133	2	g	100
516	133	3	g	100
714	133	4	g	100
912	133	5	g	100
1110	133	6	g	100
1308	133	7	g	100
1506	133	8	g	100
1704	133	9	g	100
1902	133	10	g	100
2100	133	11	g	100
2298	133	12	g	73.33333333333333
2694	133	14	g	100
3090	133	16	g	90
135	149	1	g	100
333	149	2	g	100
531	149	3	g	100
729	149	4	g	100
1125	149	6	g	100
1323	149	7	g	100
1521	149	8	g	50
117	130	1	g	100
315	130	2	g	100
513	130	3	g	100
2373	212	12	g	24.444444444444446
909	130	5	g	100
1107	130	6	g	100
1305	130	7	g	100
1503	130	8	g	95.45454545454545
2796	26	15	g	100
2691	130	14	g	80.85106382978722
3087	130	16	g	5
3285	130	17	g	77.77777777777779
110	122	1	g	100
308	122	2	g	100
506	122	3	g	100
902	122	5	g	100
1100	122	6	g	100
1298	122	7	g	100
1892	122	10	g	100
2090	122	11	g	100
2684	122	14	g	100
3080	122	16	g	60
396	215	2	g	100
594	215	3	g	100
792	215	4	g	36.710598572213065
2772	215	14	g	68.08510638297872
2718	159	14	g	100
3312	159	17	g	40
24	26	1	g	100
420	26	3	g	100
1212	26	7	g	100
95	105	1	g	100
293	105	2	g	100
491	105	3	g	100
689	105	4	g	100
887	105	5	g	100
1085	105	6	g	100
1283	105	7	g	100
1481	105	8	g	99.84289903644743
1679	105	9	g	100
1877	105	10	g	100
2075	105	11	g	100
2669	105	14	g	100
3065	105	16	g	100
3263	105	17	g	77.77777777777779
154	170	1	g	100
352	170	2	g	100
550	170	3	g	100
748	170	4	g	100
946	170	5	g	100
1144	170	6	g	100
1342	170	7	g	100
1540	170	8	g	99.78005865102638
1936	170	10	g	100
2134	170	11	g	100
2332	170	12	g	20
2728	170	14	g	100
3124	170	16	g	100
3322	170	17	g	88.88888888888889
3520	170	18	g	86.36363636363636
195	212	1	g	100
393	212	2	g	100
591	212	3	g	100
789	212	4	g	100
987	212	5	g	100
1185	212	6	g	100
1383	212	7	g	100
1779	212	9	g	100
1977	212	10	g	100
2175	212	11	g	100
2769	212	14	g	80
3165	212	16	g	80
3363	212	17	g	50
129	143	1	g	100
327	143	2	g	100
525	143	3	g	100
723	143	4	g	100
921	143	5	g	100
540	159	3	g	100
2530	170	13	g	100
2493	130	13	g	100
3114	159	16	g	8
3105	149	16	g	56
2400	26	13	g	80
2486	122	13	g	76.68845315904139
2496	133	13	g	100
3278	122	17	g	48.88888888888889
3303	149	17	g	57.77777777777778
2882	122	15	g	20
2926	170	15	g	100
2889	130	15	g	87.5
2916	159	15	g	80
2892	133	15	g	100
2959	204	15	g	100
1119	143	6	g	100
1317	143	7	g	100
1515	143	8	g	100
1713	143	9	g	100
1911	143	10	g	100
2109	143	11	g	100
2307	143	12	g	100
2703	143	14	g	100
3099	143	16	g	100
3495	143	18	g	100
152	168	1	g	100
350	168	2	g	100
548	168	3	g	100
944	168	5	g	100
1142	168	6	g	100
1340	168	7	g	100
1538	168	8	g	99.98952660242982
1934	168	10	g	100
2132	168	11	g	100
746	168	4	g	98.13289401427787
2726	168	14	g	100
3122	168	16	g	60
3320	168	17	g	72.22222222222221
150	165	1	g	100
348	165	2	g	100
546	165	3	g	100
744	165	4	g	100
942	165	5	g	100
1140	165	6	g	100
1338	165	7	g	100
1536	165	8	g	4.545454545454546
1734	165	9	g	99.78070175438596
1932	165	10	g	100
2130	165	11	g	100
2328	165	12	g	82.22222222222221
678	93	4	g	98.90170236133993
2724	165	14	g	100
3120	165	16	g	100
3318	165	17	g	100
180	197	1	g	100
378	197	2	g	100
576	197	3	g	100
774	197	4	g	100
972	197	5	g	100
1170	197	6	g	100
1368	197	7	g	100
1566	197	8	g	100
1764	197	9	g	100
1962	197	10	g	100
2160	197	11	g	100
2358	197	12	g	22.222222222222225
1454	77	8	g	99.80100544616674
2754	197	14	g	100
3150	197	16	g	100
3348	197	17	g	100
68	77	1	g	100
266	77	2	g	100
464	77	3	g	100
662	77	4	g	100
860	77	5	g	100
1058	77	6	g	100
1256	77	7	g	100
1652	77	9	g	100
1850	77	10	g	100
2048	77	11	g	100
2246	77	12	g	20
1736	168	9	g	98.02631578947367
2642	77	14	g	100
3038	77	16	g	100
3236	77	17	g	50
3434	77	18	g	100
84	93	1	g	100
282	93	2	g	100
480	93	3	g	100
876	93	5	g	100
1074	93	6	g	100
1272	93	7	g	100
1470	93	8	g	100
1668	93	9	g	98.57456140350877
2658	93	14	g	80
3054	93	16	g	100
3450	93	18	g	53.40909090909091
34	38	1	g	100
232	38	2	g	100
430	38	3	g	100
628	38	4	g	100
826	38	5	g	100
1024	38	6	g	100
1222	38	7	g	100
1420	38	8	g	100
1618	38	9	g	100
1816	38	10	g	100
2014	38	11	g	100
2608	38	14	g	100
3004	38	16	g	100
3202	38	17	g	100
176	192	1	g	100
374	192	2	g	100
572	192	3	g	100
770	192	4	g	100
968	192	5	g	100
1166	192	6	g	100
1364	192	7	g	100
1562	192	8	g	100
1760	192	9	g	100
1958	192	10	g	100
2156	192	11	g	100
2354	192	12	g	100
2750	192	14	g	100
3146	192	16	g	100
181	198	1	g	100
379	198	2	g	100
577	198	3	g	100
775	198	4	g	100
973	198	5	g	100
1171	198	6	g	100
1369	198	7	g	100
1567	198	8	g	100
1765	198	9	g	100
1963	198	10	g	100
2161	198	11	g	100
2755	198	14	g	100
3151	198	16	g	100
3349	198	17	g	100
134	148	1	g	100
332	148	2	g	100
530	148	3	g	100
728	148	4	g	100
1322	148	7	g	100
1718	148	9	g	100
2708	148	14	g	100
3302	148	17	g	75.55555555555556
163	179	1	g	100
1520	148	8	g	100
2505	143	13	g	100
2557	198	13	g	100
2510	148	13	g	100
2410	38	13	g	100
3344	192	17	g	94.44444444444444
2906	148	15	g	100
2806	38	15	g	100
2901	143	15	g	100
2922	165	15	g	100
2840	77	15	g	100
2952	197	15	g	100
2924	168	15	g	80
361	179	2	g	100
559	179	3	g	100
757	179	4	g	100
955	179	5	g	100
1153	179	6	g	100
1351	179	7	g	100
1549	179	8	g	95.45454545454545
1747	179	9	g	100
1945	179	10	g	100
2143	179	11	g	100
338	155	2	g	100
2737	179	14	g	100
3133	179	16	g	100
3331	179	17	g	100
148	163	1	g	100
346	163	2	g	100
544	163	3	g	100
940	163	5	g	100
1138	163	6	g	37.5
1336	163	7	g	100
1534	163	8	g	100
1930	163	10	g	100
2128	163	11	g	100
2722	163	14	g	100
3118	163	16	g	100
3316	163	17	g	100
97	107	1	g	100
295	107	2	g	100
493	107	3	g	100
691	107	4	g	100
889	107	5	g	100
1087	107	6	g	100
1285	107	7	g	100
1483	107	8	g	100
1681	107	9	g	100
1879	107	10	g	100
2077	107	11	g	100
2275	107	12	g	100
2671	107	14	g	100
3067	107	16	g	100
3265	107	17	g	100
3463	107	18	g	100
140	155	1	g	100
742	163	4	g	97.80340472267986
1510	137	8	g	99.91621281943863
932	155	5	g	100
1130	155	6	g	100
1328	155	7	g	100
1732	163	9	g	99.89035087719299
1724	155	9	g	99.23245614035088
1922	155	10	g	100
2120	155	11	g	100
2318	155	12	g	20
49	55	1	g	100
247	55	2	g	100
445	55	3	g	100
643	55	4	g	100
841	55	5	g	100
1039	55	6	g	100
1237	55	7	g	66.66666666666666
1435	55	8	g	95.45454545454545
1633	55	9	g	100
1831	55	10	g	100
2029	55	11	g	100
2227	55	12	g	100
2425	55	13	g	95.86056644880175
2623	55	14	g	100
3019	55	16	g	100
3217	55	17	g	100
90	100	1	g	100
288	100	2	g	100
486	100	3	g	100
684	100	4	g	100
882	100	5	g	100
1080	100	6	g	100
1278	100	7	g	100
1476	100	8	g	100
1674	100	9	g	100
1872	100	10	g	100
2070	100	11	g	100
2268	100	12	g	100
2664	100	14	g	100
3060	100	16	g	100
3456	100	18	g	98.86363636363636
35	40	1	g	100
233	40	2	g	100
431	40	3	g	100
629	40	4	g	100
827	40	5	g	100
1025	40	6	g	100
1223	40	7	g	100
1421	40	8	g	100
1619	40	9	g	100
1817	40	10	g	100
2015	40	11	g	100
2666	102	14	g	93.61702127659575
2609	40	14	g	100
3005	40	16	g	100
3203	40	17	g	100
92	102	1	g	100
290	102	2	g	100
488	102	3	g	100
686	102	4	g	100
884	102	5	g	100
1082	102	6	g	100
1280	102	7	g	100
1478	102	8	g	95.45454545454545
1676	102	9	g	98.57456140350877
1874	102	10	g	100
2072	102	11	g	100
2468	102	13	g	100
3062	102	16	g	80
3260	102	17	g	100
3458	102	18	g	78.4090909090909
124	137	1	g	100
322	137	2	g	100
520	137	3	g	100
718	137	4	g	100
916	137	5	g	100
1114	137	6	g	100
1312	137	7	g	100
1708	137	9	g	99.78070175438596
1906	137	10	g	100
2104	137	11	g	100
2302	137	12	g	100
2698	137	14	g	61.27659574468086
3094	137	16	g	100
127	141	1	g	100
325	141	2	g	100
523	141	3	g	100
721	141	4	g	100
919	141	5	g	100
1117	141	6	g	100
1315	141	7	g	100
1513	141	8	g	100
2500	137	13	g	100
2516	155	13	g	49.673202614379086
2466	100	13	g	100
2473	107	13	g	100
2539	179	13	g	100
2524	163	13	g	100
3110	155	16	g	32
3292	137	17	g	80
3308	155	17	g	31.11111111111111
2869	107	15	g	100
2896	137	15	g	100
2935	179	15	g	100
2920	163	15	g	100
1909	141	10	g	100
2107	141	11	g	100
2305	141	12	g	100
2701	141	14	g	100
3097	141	16	g	100
3295	141	17	g	100
3493	141	18	g	100
177	193	1	g	100
375	193	2	g	100
573	193	3	g	100
771	193	4	g	100
969	193	5	g	100
1711	141	9	g	99.89035087719299
2751	193	14	g	100
3147	193	16	g	100
3345	193	17	g	44.44444444444444
109	121	1	g	100
307	121	2	g	100
505	121	3	g	100
703	121	4	g	100
901	121	5	g	100
1099	121	6	g	100
1297	121	7	g	100
1495	121	8	g	100
1693	121	9	g	100
1891	121	10	g	100
2089	121	11	g	100
2287	121	12	g	100
2683	121	14	g	100
3079	121	16	g	100
89	99	1	g	100
287	99	2	g	100
485	99	3	g	100
683	99	4	g	100
881	99	5	g	100
1079	99	6	g	100
1277	99	7	g	100
1475	99	8	g	100
1673	99	9	g	100
1871	99	10	g	100
2069	99	11	g	100
2663	99	14	g	100
3059	99	16	g	100
118	131	1	g	100
316	131	2	g	100
514	131	3	g	100
712	131	4	g	100
910	131	5	g	100
1108	131	6	g	100
1306	131	7	g	100
1504	131	8	g	95.45454545454545
1702	131	9	g	100
1900	131	10	g	100
2098	131	11	g	100
2692	131	14	g	100
3088	131	16	g	100
3286	131	17	g	77.77777777777779
153	169	1	g	100
351	169	2	g	100
549	169	3	g	100
747	169	4	g	100
945	169	5	g	100
1143	169	6	g	100
1341	169	7	g	100
1539	169	8	g	100
1737	169	9	g	100
2727	169	14	g	100
3123	169	16	g	100
85	95	1	g	100
283	95	2	g	100
481	95	3	g	100
679	95	4	g	100
877	95	5	g	100
1075	95	6	g	100
1273	95	7	g	100
1471	95	8	g	100
1669	95	9	g	100
2659	95	14	g	80.85106382978722
3055	95	16	g	90
3253	95	17	g	100
143	158	1	g	100
341	158	2	g	100
539	158	3	g	100
737	158	4	g	100
935	158	5	g	100
1133	158	6	g	100
1331	158	7	g	100
2717	158	14	g	100
183	200	1	g	100
381	200	2	g	100
579	200	3	g	100
777	200	4	g	100
2559	200	13	g	100
2757	200	14	g	100
2955	200	15	g	100
3153	200	16	g	60
169	185	1	g	100
367	185	2	g	100
565	185	3	g	100
763	185	4	g	100
961	185	5	g	100
1159	185	6	g	100
1357	185	7	g	100
1555	185	8	g	100
1753	185	9	g	100
1951	185	10	g	100
2149	185	11	g	100
2743	185	14	g	100
3139	185	16	g	100
123	136	1	g	100
321	136	2	g	100
519	136	3	g	100
717	136	4	g	99.890170236134
915	136	5	g	100
1113	136	6	g	100
1311	136	7	g	100
1509	136	8	g	95.45454545454545
1707	136	9	g	100
1905	136	10	g	100
2103	136	11	g	100
2697	136	14	g	100
3093	136	16	g	100
3291	136	17	g	100
15	15	1	g	100
213	15	2	g	100
411	15	3	g	100
807	15	5	g	100
1005	15	6	g	100
1203	15	7	g	100
1401	15	8	g	99.97905320485965
2857	95	15	g	100
1167	193	6	g	100
1529	158	8	g	100
2503	141	13	g	100
2499	136	13	g	80
2519	158	13	g	100
2545	185	13	g	100
2925	169	15	g	80
2881	121	15	g	100
2899	141	15	g	80
2895	136	15	g	80
2461	95	13	g	100
2529	169	13	g	100
2485	121	13	g	100
2465	99	13	g	100
1797	15	10	g	100
1995	15	11	g	100
2589	15	14	g	76.59574468085107
2985	15	16	g	100
3183	15	17	g	83.33333333333334
164	180	1	g	100
362	180	2	g	100
560	180	3	g	100
758	180	4	g	100
956	180	5	g	100
1154	180	6	g	100
1352	180	7	g	100
1550	180	8	g	100
1748	180	9	g	100
1946	180	10	g	100
2144	180	11	g	100
2342	180	12	g	8.888888888888888
2738	180	14	g	100
3134	180	16	g	100
3332	180	17	g	100
116	129	1	g	100
314	129	2	g	100
512	129	3	g	100
710	129	4	g	100
908	129	5	g	100
1106	129	6	g	100
1304	129	7	g	100
1502	129	8	g	100
1700	129	9	g	100
1898	129	10	g	100
2096	129	11	g	100
2294	129	12	g	100
3086	129	16	g	100
3284	129	17	g	100
3482	129	18	g	100
172	188	1	g	100
370	188	2	g	100
568	188	3	g	100
766	188	4	g	100
964	188	5	g	100
1162	188	6	g	100
1360	188	7	g	100
1558	188	8	g	100
1756	188	9	g	100
1954	188	10	g	100
2152	188	11	g	100
2350	188	12	g	100
2746	188	14	g	100
3142	188	16	g	100
3340	188	17	g	100
142	157	1	g	100
340	157	2	g	100
538	157	3	g	100
736	157	4	g	100
934	157	5	g	100
1132	157	6	g	100
1330	157	7	g	100
1528	157	8	g	100
1924	157	10	g	100
2122	157	11	g	100
2716	157	14	g	100
3112	157	16	g	100
3310	157	17	g	94.44444444444444
105	116	1	g	100
303	116	2	g	100
501	116	3	g	100
699	116	4	g	100
897	116	5	g	100
1095	116	6	g	100
1293	116	7	g	100
1491	116	8	g	100
131	145	1	g	100
329	145	2	g	100
527	145	3	g	100
725	145	4	g	100
923	145	5	g	100
1726	157	9	g	98.90350877192982
2705	145	14	g	100
3101	145	16	g	100
3299	145	17	g	100
111	123	1	g	100
309	123	2	g	100
507	123	3	g	100
705	123	4	g	100
903	123	5	g	100
1101	123	6	g	100
1299	123	7	g	100
1497	123	8	g	100
1695	123	9	g	100
2685	123	14	g	100
3081	123	16	g	100
112	124	1	g	100
310	124	2	g	100
508	124	3	g	100
706	124	4	g	100
904	124	5	g	100
1102	124	6	g	100
1300	124	7	g	100
1498	124	8	g	100
2686	124	14	g	100
3082	124	16	g	100
3280	124	17	g	100
165	181	1	g	100
363	181	2	g	100
561	181	3	g	100
759	181	4	g	100
957	181	5	g	100
1155	181	6	g	100
1353	181	7	g	100
1551	181	8	g	50
1749	181	9	g	100
1947	181	10	g	100
2145	181	11	g	100
2690	129	14	g	100
2739	181	14	g	100
3135	181	16	g	90
3333	181	17	g	100
107	119	1	g	100
503	119	3	g	100
701	119	4	g	100
899	119	5	g	100
1097	119	6	g	37.5
1295	119	7	g	100
1889	119	10	g	100
2087	119	11	g	100
2681	119	14	g	100
3077	119	16	g	100
166	182	1	g	100
364	182	2	g	100
562	182	3	g	100
760	182	4	g	100
958	182	5	g	100
1156	182	6	g	100
2492	129	13	g	100
2540	180	13	g	100
2481	116	13	g	100
2391	15	13	g	95.86056644880175
3273	116	17	g	66.66666666666667
2914	157	15	g	100
2883	123	15	g	100
2518	157	13	g	100
2487	123	13	g	100
2488	124	13	g	100
2548	188	13	g	100
2884	124	15	g	100
2944	188	15	g	100
2888	129	15	g	100
1354	182	7	g	100
1552	182	8	g	100
1750	182	9	g	100
1948	182	10	g	100
2146	182	11	g	100
3136	182	16	g	100
178	194	1	g	100
376	194	2	g	100
574	194	3	g	100
772	194	4	g	66.66666666666666
970	194	5	g	100
1168	194	6	g	100
1366	194	7	g	100
1762	194	9	g	98.46491228070175
1960	194	10	g	100
2158	194	11	g	100
2752	194	14	g	100
3148	194	16	g	100
3346	194	17	g	50
158	174	1	g	100
356	174	2	g	100
554	174	3	g	100
752	174	4	g	82.78418451400329
950	174	5	g	100
1148	174	6	g	100
1346	174	7	g	100
1940	174	10	g	100
2138	174	11	g	100
1564	194	8	g	99.79053204859657
2732	174	14	g	100
3128	174	16	g	100
3326	174	17	g	100
173	189	1	g	100
371	189	2	g	100
569	189	3	g	100
1544	174	8	g	90.9090909090909
965	189	5	g	93.75
1163	189	6	g	100
1361	189	7	g	100
1559	189	8	g	93.47826086956522
1955	189	10	g	100
2153	189	11	g	100
1773	206	9	g	99.56140350877193
1742	174	9	g	99.12280701754386
2747	189	14	g	100
3143	189	16	g	100
3341	189	17	g	100
196	213	1	g	100
394	213	2	g	100
592	213	3	g	100
790	213	4	g	100
988	213	5	g	100
1186	213	6	g	100
1384	213	7	g	100
1582	213	8	g	100
1780	213	9	g	100
1978	213	10	g	100
2176	213	11	g	100
2374	213	12	g	100
2770	213	14	g	100
3166	213	16	g	100
3364	213	17	g	88.88888888888889
98	109	1	g	100
296	109	2	g	100
494	109	3	g	100
692	109	4	g	100
890	109	5	g	100
1088	109	6	g	100
1286	109	7	g	100
1484	109	8	g	100
1682	109	9	g	99.78070175438596
1880	109	10	g	100
2078	109	11	g	100
2276	109	12	g	77.77777777777779
2672	109	14	g	80
3266	109	17	g	83.33333333333334
39	44	1	g	100
237	44	2	g	100
435	44	3	g	100
633	44	4	g	100
831	44	5	g	100
1029	44	6	g	100
1227	44	7	g	100
1425	44	8	g	100
1623	44	9	g	100
1821	44	10	g	100
2019	44	11	g	100
2217	44	12	g	100
1757	189	9	g	98.68421052631578
2613	44	14	g	100
3009	44	16	g	100
3207	44	17	g	100
3405	44	18	g	95.45454545454545
787	210	4	g	100
1183	210	6	g	100
1381	210	7	g	100
1579	210	8	g	100
1777	210	9	g	100
2767	210	14	g	80
3163	210	16	g	100
189	206	1	g	100
3159	206	16	g	48
93	103	1	g	100
291	103	2	g	100
489	103	3	g	100
687	103	4	g	100
885	103	5	g	100
1083	103	6	g	100
1281	103	7	g	100
1479	103	8	g	100
1677	103	9	g	100
1875	103	10	g	100
2073	103	11	g	100
2469	103	13	g	100
2667	103	14	g	80
3063	103	16	g	100
3261	103	17	g	100
58	64	1	g	100
256	64	2	g	100
454	64	3	g	100
652	64	4	g	100
1048	64	6	g	100
2356	194	12	g	24.444444444444446
2632	64	14	g	100
3028	64	16	g	90
3226	64	17	g	88.88888888888889
60	66	1	g	100
258	66	2	g	100
456	66	3	g	100
654	66	4	g	100
852	66	5	g	100
1050	66	6	g	100
1248	66	7	g	100
1446	66	8	g	100
2554	194	13	g	100
2569	210	13	g	76.68845315904139
2740	182	14	g	80
2474	109	13	g	100
2542	182	13	g	80
2572	213	13	g	100
3068	109	16	g	56
2938	182	15	g	80
2811	44	15	g	100
2870	109	15	g	70
2950	194	15	g	100
2930	174	15	g	100
1644	66	9	g	100
1842	66	10	g	100
2040	66	11	g	100
245	53	2	g	100
2634	66	14	g	100
3030	66	16	g	100
3228	66	17	g	66.66666666666666
59	65	1	g	100
257	65	2	g	100
455	65	3	g	100
851	65	5	g	100
1049	65	6	g	100
1247	65	7	g	100
1445	65	8	g	95.45454545454545
1841	65	10	g	100
2039	65	11	g	100
2237	65	12	g	86.66666666666666
443	53	3	g	66.66666666666666
2633	65	14	g	100
3029	65	16	g	80
3227	65	17	g	77.77777777777779
23	25	1	g	100
419	25	3	g	100
815	25	5	g	100
1013	25	6	g	100
1211	25	7	g	100
1409	25	8	g	100
1607	25	9	g	100
2597	25	14	g	100
2993	25	16	g	70
3191	25	17	g	83.33333333333334
47	53	1	g	88.8888888888889
641	53	4	g	95.6068094453597
839	53	5	g	100
1037	53	6	g	87.5
1235	53	7	g	100
1631	53	9	g	100
1829	53	10	g	100
653	65	4	g	99.780340472268
3017	53	16	g	100
3215	53	17	g	100
40	45	1	g	100
238	45	2	g	100
436	45	3	g	100
634	45	4	g	100
832	45	5	g	100
1030	45	6	g	100
1228	45	7	g	100
1426	45	8	g	100
1624	45	9	g	100
1822	45	10	g	100
2020	45	11	g	100
622	30	4	g	99.780340472268
2614	45	14	g	100
3010	45	16	g	100
3208	45	17	g	100
51	57	1	g	100
249	57	2	g	100
447	57	3	g	100
645	57	4	g	100
1041	57	6	g	100
1437	57	8	g	100
1433	53	8	g	90.9090909090909
2625	57	14	g	100
3021	57	16	g	100
3219	57	17	g	100
26	28	1	g	100
224	28	2	g	100
422	28	3	g	100
620	28	4	g	100
818	28	5	g	100
1016	28	6	g	100
1214	28	7	g	100
1412	28	8	g	100
1610	28	9	g	100
1808	28	10	g	100
1654	79	9	g	99.12280701754386
2600	28	14	g	100
2996	28	16	g	100
3194	28	17	g	100
94	104	1	g	100
292	104	2	g	100
490	104	3	g	100
688	104	4	g	100
886	104	5	g	100
1084	104	6	g	100
1282	104	7	g	100
1480	104	8	g	100
1678	104	9	g	100
1876	104	10	g	100
2074	104	11	g	100
2668	104	14	g	100
3064	104	16	g	90
3262	104	17	g	100
70	79	1	g	100
268	79	2	g	100
466	79	3	g	100
664	79	4	g	100
862	79	5	g	100
1258	79	7	g	100
1456	79	8	g	99.95810640971932
2644	79	14	g	100
3040	79	16	g	100
11	11	1	g	100
209	11	2	g	100
407	11	3	g	100
605	11	4	g	100
803	11	5	g	100
1199	11	7	g	100
1397	11	8	g	100
1595	11	9	g	100
1793	11	10	g	100
1991	11	11	g	100
2981	11	16	g	100
3179	11	17	g	77.77777777777779
28	30	1	g	100
226	30	2	g	100
424	30	3	g	100
820	30	5	g	100
1018	30	6	g	100
1216	30	7	g	100
1643	65	9	g	98.68421052631578
1612	30	9	g	100
1810	30	10	g	100
2008	30	11	g	100
2621	53	14	g	93.61702127659575
2602	30	14	g	100
2998	30	16	g	100
3196	30	17	g	100
2027	53	11	m	0
2399	25	13	g	76.68845315904139
2427	57	13	g	100
2387	11	13	g	100
2585	11	14	g	80
2470	104	13	g	100
2402	28	13	g	100
2446	79	13	g	100
3425	65	18	g	90.9090909090909
2866	104	15	g	100
2798	28	15	g	100
2842	79	15	g	100
2795	25	15	g	80
2823	57	15	g	75
2832	66	15	g	100
8	8	1	g	100
598	4	4	g	99.34102141680395
404	8	3	g	100
998	8	6	g	100
1196	8	7	g	100
1740	172	9	g	99.01315789473685
1592	8	9	g	100
2582	8	14	g	100
2978	8	16	g	100
3374	8	18	g	100
4	4	1	g	100
202	4	2	g	100
400	4	3	g	100
796	4	5	g	100
994	4	6	g	100
1192	4	7	g	100
1390	4	8	g	100
1786	4	10	g	100
1984	4	11	g	100
2182	4	12	g	100
2380	4	13	g	100
2578	4	14	g	100
2974	4	16	g	100
3172	4	17	g	100
3370	4	18	g	100
61	68	1	g	100
259	68	2	g	100
457	68	3	g	100
655	68	4	g	100
853	68	5	g	100
1051	68	6	g	100
1249	68	7	g	100
1447	68	8	g	100
1645	68	9	g	100
1843	68	10	g	100
2041	68	11	g	100
2635	68	14	g	100
3031	68	16	g	100
3229	68	17	g	100
43	48	1	g	100
1629	51	9	g	98.24561403508771
637	48	4	g	100
1588	4	9	g	99.3421052631579
1033	48	6	g	37.5
1231	48	7	g	100
1429	48	8	g	100
1627	48	9	g	100
3013	48	16	g	48
18	18	1	g	100
216	18	2	g	100
414	18	3	g	100
612	18	4	g	100
810	18	5	g	100
1008	18	6	g	100
1206	18	7	g	100
1404	18	8	g	99.97905320485965
1800	18	10	g	100
1998	18	11	g	100
2394	18	13	g	95.86056644880175
2592	18	14	g	87.2340425531915
2988	18	16	g	90
3186	18	17	g	100
7	7	1	g	100
205	7	2	g	100
403	7	3	g	100
1602	18	9	g	99.89035087719299
799	7	5	g	100
997	7	6	g	100
1195	7	7	g	100
1393	7	8	g	54.54545454545454
2674	111	14	g	87.2340425531915
2581	7	14	g	80
2977	7	16	g	100
45	51	1	g	100
243	51	2	g	100
441	51	3	g	100
639	51	4	g	100
837	51	5	g	100
1035	51	6	g	100
1233	51	7	g	100
1431	51	8	g	100
1827	51	10	g	100
2025	51	11	g	100
2223	51	12	g	95.55555555555554
2421	51	13	g	80
2619	51	14	g	100
3015	51	16	g	100
3213	51	17	g	61.111111111111114
100	111	1	g	100
298	111	2	g	100
496	111	3	g	100
694	111	4	g	100
892	111	5	g	100
1090	111	6	g	100
1288	111	7	g	100
1486	111	8	g	100
1684	111	9	g	100
1882	111	10	g	100
2080	111	11	g	100
2278	111	12	g	20
3070	111	16	g	100
3268	111	17	g	33.33333333333333
156	172	1	g	100
354	172	2	g	100
552	172	3	g	100
750	172	4	g	100
948	172	5	g	100
1146	172	6	g	100
1344	172	7	g	100
1542	172	8	g	4.545454545454546
1938	172	10	g	100
2136	172	11	g	100
2532	172	13	g	100
2730	172	14	g	100
3126	172	16	g	100
3324	172	17	g	66.66666666666666
31	34	1	g	100
229	34	2	g	100
427	34	3	g	100
823	34	5	g	100
1021	34	6	g	100
1219	34	7	g	100
1417	34	8	g	100
1813	34	10	g	100
2011	34	11	g	100
2209	34	12	g	100
2605	34	14	g	100
3001	34	16	g	100
3199	34	17	g	100
3397	34	18	g	10.227272727272728
75	84	1	g	100
273	84	2	g	100
1615	34	9	g	100
2384	8	13	g	100
2437	68	13	g	100
2419	48	13	g	39.73856209150327
2476	111	13	g	95.86056644880175
2383	7	13	g	80
2407	34	13	g	100
2872	111	15	g	80
2779	7	15	g	100
2803	34	15	g	100
2780	8	15	g	100
2833	68	15	g	100
2815	48	15	g	80
2928	172	15	g	100
471	84	3	g	100
693	110	4	g	98.57221306974189
867	84	5	g	93.75
1065	84	6	g	100
1263	84	7	g	100
695	112	4	g	99.780340472268
2649	84	14	g	100
3045	84	16	g	60
3243	84	17	g	72.22222222222221
125	138	1	g	100
323	138	2	g	100
521	138	3	g	100
719	138	4	g	100
917	138	5	g	100
1115	138	6	g	100
1313	138	7	g	100
1511	138	8	g	95.45454545454545
1709	138	9	g	100
1907	138	10	g	100
2105	138	11	g	100
3095	138	16	g	100
3293	138	17	g	50
99	110	1	g	100
297	110	2	g	100
495	110	3	g	100
891	110	5	g	100
1089	110	6	g	100
1287	110	7	g	100
1485	110	8	g	95.45454545454545
1881	110	10	g	100
2079	110	11	g	100
1466	89	8	g	99.79053204859657
2673	110	14	g	100
3069	110	16	g	100
3267	110	17	g	100
80	89	1	g	100
278	89	2	g	100
476	89	3	g	100
674	89	4	g	99.890170236134
872	89	5	g	100
1070	89	6	g	100
1268	89	7	g	100
1664	89	9	g	99.78070175438596
1862	89	10	g	100
2060	89	11	g	100
2258	89	12	g	100
1487	112	8	g	100
2654	89	14	g	100
3050	89	16	g	100
3248	89	17	g	77.77777777777779
3446	89	18	g	100
101	112	1	g	100
299	112	2	g	100
497	112	3	g	100
893	112	5	g	100
1091	112	6	g	100
1289	112	7	g	100
1685	112	9	g	99.23245614035088
2477	112	13	g	100
2675	112	14	g	80
3071	112	16	g	80
3269	112	17	g	83.33333333333334
128	142	1	g	100
326	142	2	g	100
524	142	3	g	100
722	142	4	g	100
920	142	5	g	100
1118	142	6	g	100
1316	142	7	g	100
1514	142	8	g	100
1712	142	9	g	100
1910	142	10	g	100
2108	142	11	g	100
2702	142	14	g	100
3098	142	16	g	100
3296	142	17	g	100
21	22	1	g	100
219	22	2	g	100
417	22	3	g	100
615	22	4	g	100
813	22	5	g	100
1011	22	6	g	100
1209	22	7	g	100
1407	22	8	g	100
1605	22	9	g	100
1659	84	9	g	99.67105263157895
2595	22	14	g	100
2991	22	16	g	90
3189	22	17	g	100
65	74	1	g	100
263	74	2	g	100
461	74	3	g	100
659	74	4	g	100
857	74	5	g	100
1055	74	6	g	100
1253	74	7	g	100
2639	74	14	g	100
3035	74	16	g	100
130	144	1	g	100
328	144	2	g	100
526	144	3	g	100
724	144	4	g	86.93025809994509
922	144	5	g	100
1120	144	6	g	100
1318	144	7	g	100
1516	144	8	g	95.45454545454545
1714	144	9	g	66.66666666666666
2704	144	14	g	87.2340425531915
3100	144	16	g	100
171	187	1	g	100
369	187	2	g	100
567	187	3	g	100
765	187	4	g	100
963	187	5	g	100
1161	187	6	g	100
1359	187	7	g	100
1557	187	8	g	100
1755	187	9	g	100
1953	187	10	g	100
2151	187	11	g	100
2745	187	14	g	100
3141	187	16	g	100
3339	187	17	g	100
182	199	1	g	100
380	199	2	g	100
578	199	3	g	100
776	199	4	g	100
974	199	5	g	100
1172	199	6	g	100
1370	199	7	g	100
1568	199	8	g	100
1766	199	9	g	100
1964	199	10	g	100
2162	199	11	g	100
1803	22	10	g	100
2504	142	13	g	100
2547	187	13	g	100
2506	144	13	g	100
2501	138	13	g	100
3233	74	17	g	62.22222222222222
2902	144	15	g	87.5
2897	138	15	g	100
2900	142	15	g	100
2793	22	15	g	100
2871	110	15	g	100
2837	74	15	g	100
2360	199	12	g	100
2756	199	14	g	100
3152	199	16	g	100
83	92	1	g	100
281	92	2	g	100
479	92	3	g	100
677	92	4	g	100
875	92	5	g	100
1073	92	6	g	100
1271	92	7	g	100
1469	92	8	g	95.45454545454545
1667	92	9	g	100
1865	92	10	g	100
2063	92	11	g	100
2459	92	13	g	100
2657	92	14	g	10.212765957446807
2855	92	15	g	93.75
3053	92	16	g	80
3251	92	17	g	77.77777777777779
12	12	1	g	100
210	12	2	g	100
408	12	3	g	100
146	161	1	g	100
344	161	2	g	100
542	161	3	g	100
740	161	4	g	100
938	161	5	g	100
1136	161	6	g	100
1334	161	7	g	100
1532	161	8	g	95.45454545454545
1730	161	9	g	100
1928	161	10	g	100
2126	161	11	g	100
2720	161	14	g	100
3116	161	16	g	100
3314	161	17	g	100
16	16	1	g	100
214	16	2	g	100
412	16	3	g	100
610	16	4	g	100
808	16	5	g	100
1006	16	6	g	100
1204	16	7	g	100
1402	16	8	g	100
1600	16	9	g	100
1798	16	10	g	100
1996	16	11	g	100
2194	16	12	g	100
2590	16	14	g	100
2986	16	16	g	100
3184	16	17	g	100
3382	16	18	g	39.77272727272727
22	24	1	g	100
1210	24	7	g	100
1408	24	8	g	4.545454545454546
1606	24	9	g	66.66666666666666
418	24	3	g	66.66666666666666
2596	24	14	g	100
2992	24	16	g	100
3190	24	17	g	100
87	97	1	g	100
285	97	2	g	100
483	97	3	g	100
681	97	4	g	100
879	97	5	g	100
1077	97	6	g	100
1275	97	7	g	100
1473	97	8	g	100
1671	97	9	g	100
1869	97	10	g	100
2067	97	11	g	100
2265	97	12	g	100
604	10	4	g	98.90170236133993
2661	97	14	g	100
3057	97	16	g	100
3255	97	17	g	100
52	58	1	g	100
250	58	2	g	100
448	58	3	g	100
646	58	4	g	100
844	58	5	g	100
1042	58	6	g	100
1240	58	7	g	100
1438	58	8	g	100
1636	58	9	g	100
1834	58	10	g	100
2032	58	11	g	100
2428	58	13	g	100
2626	58	14	g	100
3022	58	16	g	100
3220	58	17	g	66.66666666666666
3418	58	18	g	100
6	6	1	g	100
204	6	2	g	100
402	6	3	g	100
600	6	4	g	100
798	6	5	g	100
996	6	6	g	100
1194	6	7	g	100
1392	6	8	g	100
1590	6	9	g	100
1788	6	10	g	100
1396	10	8	g	99.79053204859657
2580	6	14	g	87.2340425531915
2976	6	16	g	100
3174	6	17	g	83.33333333333334
10	10	1	g	100
208	10	2	g	100
406	10	3	g	100
802	10	5	g	100
1000	10	6	g	100
1198	10	7	g	100
1792	10	10	g	100
1594	10	9	g	96.60087719298247
2584	10	14	g	100
2980	10	16	g	100
3178	10	17	g	100
72	81	1	g	100
270	81	2	g	100
468	81	3	g	100
666	81	4	g	100
864	81	5	g	100
1062	81	6	g	100
1260	81	7	g	100
1458	81	8	g	100
1656	81	9	g	100
1854	81	10	g	100
2052	81	11	g	100
2646	81	14	g	100
3042	81	16	g	100
1986	6	11	g	0
191	208	1	g	100
389	208	2	g	100
587	208	3	g	100
785	208	4	g	100
1379	208	7	g	100
2558	199	13	g	100
2386	10	13	g	100
2392	16	13	g	100
2388	12	13	g	100
2448	81	13	g	100
2522	161	13	g	100
2954	199	15	g	100
2844	81	15	g	100
2859	97	15	g	100
2794	24	15	g	100
2778	6	15	g	68.75
1577	208	8	g	100
2765	208	14	g	100
3161	208	16	g	100
3359	208	17	g	55.55555555555556
138	153	1	g	100
336	153	2	g	100
534	153	3	g	100
732	153	4	g	100
930	153	5	g	100
1128	153	6	g	100
1326	153	7	g	100
1524	153	8	g	100
1722	153	9	g	100
1920	153	10	g	100
2118	153	11	g	100
3108	153	16	g	90
3306	153	17	g	72.22222222222221
54	60	1	g	100
252	60	2	g	100
450	60	3	g	100
648	60	4	g	100
846	60	5	g	100
1044	60	6	g	100
1242	60	7	g	100
1440	60	8	g	100
1638	60	9	g	100
1836	60	10	g	100
2034	60	11	g	100
2628	60	14	g	100
3024	60	16	g	100
3222	60	17	g	100
37	42	1	g	100
235	42	2	g	100
433	42	3	g	100
631	42	4	g	100
829	42	5	g	100
1027	42	6	g	100
1225	42	7	g	100
1423	42	8	g	100
1621	42	9	g	100
1819	42	10	g	100
2017	42	11	g	100
1754	186	9	g	99.89035087719299
2611	42	14	g	100
3007	42	16	g	100
3205	42	17	g	100
91	101	1	g	100
289	101	2	g	100
487	101	3	g	100
685	101	4	g	100
883	101	5	g	100
1081	101	6	g	100
1279	101	7	g	100
1477	101	8	g	100
1675	101	9	g	100
1873	101	10	g	100
2071	101	11	g	100
2269	101	12	g	100
2712	153	14	g	61.27659574468086
2665	101	14	g	100
3061	101	16	g	100
3259	101	17	g	100
77	86	1	g	100
275	86	2	g	100
473	86	3	g	100
671	86	4	g	100
869	86	5	g	100
1067	86	6	g	100
1265	86	7	g	100
1463	86	8	g	100
1661	86	9	g	100
1859	86	10	g	100
2057	86	11	g	100
2255	86	12	g	100
2651	86	14	g	100
3047	86	16	g	100
3245	86	17	g	100
170	186	1	g	100
368	186	2	g	100
566	186	3	g	100
764	186	4	g	100
962	186	5	g	100
1160	186	6	g	100
1358	186	7	g	100
1556	186	8	g	100
3140	186	16	g	100
1775	208	9	g	100
4393	42	23	g	10
4368	12	23	p	0
4385	31	23	g	10
4394	43	23	p	0
4390	38	23	g	10
4397	46	23	g	10
4412	62	23	p	0
4382	28	23	g	10
4409	59	23	g	10
4380	26	23	g	10
4363	7	23	g	10
4400	50	23	g	10
4358	2	23	g	10
4369	13	23	g	10
4381	27	23	g	10
4387	34	23	g	10
4357	1	23	g	10
4361	5	23	g	10
4370	14	23	g	10
4379	25	23	g	10
4407	57	23	g	10
4383	29	23	g	10
4404	54	23	g	10
4386	33	23	g	10
4413	63	23	g	10
4365	9	23	g	10
4364	8	23	g	10
4377	22	23	g	10
4378	24	23	g	10
4389	36	23	g	10
4403	53	23	g	10
4388	35	23	g	10
4398	47	23	g	10
4375	19	23	g	10
4396	45	23	g	10
4384	30	23	g	10
4362	6	23	g	10
4373	17	23	g	10
4391	40	23	g	10
4406	56	23	g	10
4399	48	23	g	10
4366	10	23	g	10
4372	16	23	g	10
4371	15	23	g	10
4402	52	23	g	10
4376	21	23	g	10
4401	51	23	g	10
4360	4	23	g	10
4408	58	23	g	10
4405	55	23	g	10
4374	18	23	g	10
2514	153	13	g	80
4411	61	23	g	10
2567	208	13	g	100
2413	42	13	g	100
2430	60	13	g	100
2453	86	13	g	100
2826	60	15	g	100
2849	86	15	g	100
4418	69	23	p	0
4423	76	23	p	0
4431	84	23	p	0
4518	178	23	g	10
4458	113	23	p	0
4511	171	23	g	10
4478	135	23	p	0
4558	4	24	g	10
4438	91	23	g	10
4443	97	23	g	10
4561	7	24	g	10
4480	137	23	g	10
4517	177	23	p	0
4524	184	23	p	0
4550	211	23	g	10
4465	121	23	g	10
4544	205	23	p	0
4546	207	23	g	10
4566	12	24	p	0
4453	107	23	g	10
4441	95	23	g	10
4490	148	23	g	10
4429	82	23	g	10
4543	204	23	g	10
4456	111	23	g	10
4442	96	23	g	10
4481	138	23	g	10
4468	124	23	g	10
4470	127	23	g	10
4523	183	23	g	10
4497	156	23	g	10
4509	169	23	g	10
4430	83	23	g	10
4424	77	23	g	10
4426	79	23	g	10
4488	146	23	g	10
4460	115	23	g	10
4556	2	24	g	10
4433	86	23	g	10
4567	13	24	g	10
4498	157	23	g	10
4522	182	23	g	10
4503	162	23	g	10
4466	122	23	g	10
4535	196	23	g	10
4515	175	23	g	10
4444	98	23	g	10
4548	209	23	g	10
4559	5	24	g	10
4545	206	23	g	10
4538	199	23	g	10
4425	78	23	g	10
4485	143	23	g	10
4483	141	23	g	10
4568	14	24	g	10
4510	170	23	g	10
4494	153	23	g	10
4416	66	23	g	10
4473	130	23	g	10
4505	164	23	g	10
4454	109	23	g	10
4472	129	23	g	10
4519	179	23	g	10
4520	180	23	g	10
4534	194	23	g	10
4563	9	24	g	10
4562	8	24	g	10
4557	3	24	g	10
4479	136	23	g	10
4462	117	23	g	10
4482	139	23	g	0
4422	75	23	g	10
4449	103	23	g	10
4530	190	23	g	10
4495	154	23	g	10
4464	120	23	g	10
4476	133	23	g	10
4469	125	23	g	10
4492	150	23	g	10
4536	197	23	g	10
4421	74	23	g	10
4439	92	23	g	10
4541	202	23	g	10
4461	116	23	g	10
4521	181	23	g	10
4531	191	23	g	10
4420	71	23	g	10
4499	158	23	g	10
4445	99	23	g	10
4533	193	23	g	10
4514	174	23	g	10
4489	147	23	g	10
4551	212	23	g	10
4504	163	23	g	10
4477	134	23	g	10
4532	192	23	g	10
4451	105	23	g	10
4414	64	23	g	10
4474	131	23	g	10
4436	89	23	g	10
4417	68	23	g	10
4435	88	23	g	10
4452	106	23	g	10
4537	198	23	g	10
4525	185	23	g	10
4565	11	24	g	10
4549	210	23	g	10
4564	10	24	g	10
4552	213	23	g	10
4553	214	23	g	10
4570	16	24	g	10
4554	215	23	g	10
4496	155	23	g	10
4419	70	23	g	10
4447	101	23	g	10
4446	100	23	g	10
4527	187	23	g	10
4542	203	23	g	10
4502	161	23	g	10
4491	149	23	g	10
4512	172	23	g	10
4459	114	23	g	10
4457	112	23	g	10
4434	87	23	g	10
4555	1	24	g	10
4500	159	23	g	0
4540	201	23	g	10
4455	110	23	g	10
4507	167	23	g	10
4513	173	23	g	10
4526	186	23	g	10
4475	132	23	g	10
4516	176	23	g	10
4463	119	23	g	10
4448	102	23	g	10
4539	200	23	g	10
4493	152	23	g	10
4432	85	23	g	10
4415	65	23	g	10
4560	6	24	g	10
4437	90	23	g	10
4428	81	23	g	10
4501	160	23	g	10
4440	93	23	g	10
4467	123	23	g	10
4668	127	24	m	0
4721	183	24	g	10
4592	43	24	p	0
4619	74	24	g	10
4576	24	24	g	10
4720	182	24	g	10
4610	62	24	p	0
4616	69	24	p	0
4621	76	24	p	0
4696	157	24	g	10
4665	123	24	g	10
4629	84	24	p	0
4678	137	24	g	10
4663	121	24	g	10
4656	113	24	p	0
4676	135	24	p	0
4675	134	24	g	0
4703	164	24	g	10
4715	177	24	p	0
4722	184	24	p	0
4698	159	24	g	0
4705	167	24	g	10
4639	95	24	g	10
4608	60	24	g	10
4688	148	24	g	5.555555555555555
4607	59	24	g	10
4588	38	24	g	10
4686	146	24	g	10
4636	91	24	g	10
4595	46	24	g	10
4654	111	24	g	10
4679	138	24	g	10
4666	124	24	g	10
4580	28	24	g	10
4624	79	24	g	10
4695	156	24	g	10
4626	81	24	g	10
4726	188	24	g	10
4578	26	24	g	10
4707	169	24	g	10
4628	83	24	g	5.555555555555555
4711	173	24	g	10
4664	122	24	g	10
4631	86	24	g	10
4699	160	24	g	10
4709	171	24	g	0
4701	162	24	g	10
4579	27	24	g	5.555555555555555
4713	175	24	g	10
4585	34	24	g	10
4605	57	24	g	10
4593	44	24	g	0
4642	98	24	g	10
4719	181	24	g	10
4627	82	24	g	10
4681	141	24	g	10
4577	25	24	g	10
4682	142	24	g	10
4708	170	24	g	0
4692	153	24	g	10
4601	53	24	g	10
4581	29	24	g	10
4602	54	24	g	10
4614	66	24	g	10
4671	130	24	g	10
4652	109	24	g	10
4611	63	24	g	10
4670	129	24	g	10
4717	179	24	g	10
4718	180	24	g	10
4575	22	24	g	10
4704	165	24	g	10
4677	136	24	g	10
4660	117	24	g	10
4680	139	24	g	0
4620	75	24	g	10
4653	110	24	g	4.444444444444445
4658	115	24	g	10
4693	154	24	g	10
4587	36	24	g	10
4662	120	24	g	10
4674	133	24	g	0
4667	125	24	g	10
4690	150	24	g	10
4716	178	24	g	10
4618	71	24	g	10
4637	92	24	g	10
4586	35	24	g	10
4659	116	24	g	0
4573	19	24	g	0
4643	99	24	g	10
4697	158	24	g	5.555555555555555
4712	174	24	g	10
4635	90	24	g	10
4727	189	24	g	10
4644	100	24	g	10
4594	45	24	g	10
4582	30	24	g	10
4687	147	24	g	10
4702	163	24	g	10
4571	17	24	g	10
4589	40	24	g	10
4612	64	24	g	10
4597	48	24	g	10
4634	89	24	g	10
4615	68	24	g	10
4633	88	24	g	10
4650	106	24	g	10
4669	128	24	g	10
4604	56	24	g	10
4591	42	24	g	10
4723	185	24	g	10
4630	85	24	g	10
4617	70	24	g	10
4645	101	24	g	10
4724	186	24	g	0
4725	187	24	g	10
4700	161	24	g	10
4689	149	24	g	10
4600	52	24	g	10
4710	172	24	g	10
4657	114	24	g	10
4714	176	24	g	10
4574	21	24	g	10
4632	87	24	g	10
4599	51	24	g	10
4647	103	24	g	10
4625	80	24	g	10
4603	55	24	g	10
4572	18	24	g	0
4651	107	24	g	10
4648	104	24	g	10
4641	97	24	g	10
4609	61	24	g	10
4661	119	24	g	10
4673	132	24	g	10
4646	102	24	g	10
4691	152	24	g	10
4685	145	24	g	10
4672	131	24	g	10
4613	65	24	g	10
4655	112	24	g	10
4683	143	24	g	10
4583	31	24	g	10
4638	93	24	g	10
4742	205	24	p	0
4760	8	25	m	0
4812	66	25	g	10
4764	12	25	p	0
4755	3	25	g	10
4836	93	25	g	10
4869	130	25	g	10
4820	77	25	g	10
4790	43	25	p	0
4839	97	25	g	10
4808	62	25	p	0
4814	69	25	p	0
4819	76	25	p	0
4828	85	25	g	10
4827	84	25	p	0
4849	107	25	g	10
4748	211	24	g	10
4854	113	25	p	0
4861	121	25	g	10
4874	135	25	p	0
4871	132	25	g	10
4786	38	25	g	10
4837	95	25	g	10
4806	60	25	g	10
4825	82	25	g	10
4781	31	25	g	10
4883	145	25	g	10
4834	91	25	g	10
4793	46	25	g	10
4852	111	25	g	10
4838	96	25	g	10
4877	138	25	g	10
4778	28	25	g	10
4866	127	25	g	0
4776	26	25	g	10
4826	83	25	g	10
4791	44	25	g	0
4759	7	25	g	10
4779	29	25	g	10
4822	79	25	g	10
4796	50	25	g	10
4728	190	24	g	10
4856	115	25	g	10
4754	2	25	g	10
4829	86	25	g	10
4765	13	25	g	10
4862	122	25	g	10
4783	34	25	g	0
4733	196	24	g	10
4840	98	25	g	10
4753	1	25	g	10
4880	142	25	g	10
4773	22	25	g	10
4757	5	25	g	10
4743	206	24	g	10
4736	199	24	g	10
4881	143	25	g	10
4879	141	25	g	10
4766	14	25	g	10
4775	25	25	g	0
4803	57	25	g	10
4824	81	25	g	10
4841	99	25	g	10
4741	204	24	g	10
4800	54	25	g	10
4745	208	24	g	10
4756	4	25	g	10
4884	146	25	g	10
4782	33	25	g	10
4809	63	25	g	10
4868	129	25	g	10
4732	194	24	g	10
4761	9	25	g	10
4855	114	25	g	10
4875	136	25	g	10
4859	119	25	g	10
4858	117	25	g	10
4878	139	25	g	10
4811	65	25	g	10
4818	75	25	g	10
4785	36	25	g	10
4860	120	25	g	10
4872	133	25	g	10
4799	53	25	g	10
4865	125	25	g	10
4734	197	24	g	10
4817	74	25	g	10
4835	92	25	g	10
4739	202	24	g	10
4784	35	25	g	10
4857	116	25	g	10
4771	19	25	g	10
4729	191	24	g	10
4816	71	25	g	10
4749	212	24	g	10
4731	193	24	g	10
4792	45	25	g	10
4780	30	25	g	10
4744	207	24	g	10
4758	6	25	g	10
4873	134	25	g	5.454545454545455
4730	192	24	g	10
4847	105	25	g	10
4787	40	25	g	10
4810	64	25	g	10
4832	89	25	g	10
4813	68	25	g	10
4831	88	25	g	10
4848	106	25	g	10
4867	128	25	g	10
4802	56	25	g	10
4735	198	24	g	10
4763	11	25	g	10
4795	48	25	g	10
4747	210	24	g	10
4750	213	24	g	10
4751	214	24	g	10
4768	16	25	g	10
4752	215	24	g	10
4815	70	25	g	10
4843	101	25	g	10
4767	15	25	g	10
4842	100	25	g	10
4740	203	24	g	10
4798	52	25	g	0
4853	112	25	g	10
4738	201	24	g	0
4797	51	25	g	0
4863	123	25	g	10
4833	90	25	g	10
4844	102	25	g	10
4737	200	24	g	10
4845	103	25	g	10
4823	80	25	g	10
4801	55	25	g	10
4770	18	25	g	0
4876	137	25	g	10
4807	61	25	g	10
4851	110	25	g	0
4805	59	25	g	10
4846	104	25	g	10
4769	17	25	g	10
4870	131	25	g	10
4777	27	25	g	0
4804	58	25	g	10
4902	165	25	g	10
5011	68	26	g	10
4913	177	25	p	0
4914	178	25	g	10
4920	184	25	p	0
4951	1	26	g	10
4980	33	26	g	10
4940	205	25	p	0
4958	8	26	m	0
4962	12	26	p	0
4901	164	25	g	10
4971	22	26	g	10
4922	186	25	g	5.454545454545455
4939	204	25	g	10
4988	43	26	p	0
5006	62	26	p	0
4892	155	25	g	10
5012	69	26	p	0
5017	76	26	p	0
5025	84	26	p	0
4956	6	26	g	5
5004	60	26	g	10
4896	159	25	g	0
4905	169	25	g	10
4984	38	26	g	10
4957	7	26	g	10
5032	91	26	g	10
4991	46	26	g	10
5036	96	26	g	10
4976	28	26	g	10
5003	59	26	g	10
4919	183	25	g	10
4924	188	25	g	10
4974	26	26	g	5
5024	83	26	g	5
5022	81	26	g	10
5034	93	26	g	10
4994	50	26	g	10
4981	34	26	g	0
4926	190	25	g	10
4952	2	26	g	0
4963	13	26	g	10
4907	171	25	g	0.9090909090909092
4989	44	26	g	0
4899	162	25	g	10
4975	27	26	g	0
4911	175	25	g	10
4931	196	25	g	10
5038	98	26	g	10
4906	170	25	g	0
5001	57	26	g	10
4944	209	25	g	10
4955	5	26	g	10
4941	206	25	g	10
4934	199	25	g	10
5019	78	26	g	10
4973	25	26	g	0
4890	153	25	g	10
4912	176	25	g	10
4969	19	26	g	10
4977	29	26	g	10
4998	54	26	g	10
4943	208	25	g	10
4894	157	25	g	10
4935	200	25	g	10
5007	63	26	g	10
4915	179	25	g	10
4916	180	25	g	10
4959	9	26	g	10
5009	65	26	g	0
4953	3	26	g	5
4972	24	26	g	10
5016	75	26	g	10
4909	173	25	g	10
5020	79	26	g	10
5018	77	26	g	10
4891	154	25	g	10
4983	36	26	g	10
4997	53	26	g	10
4888	150	25	g	10
4904	168	25	g	10
4990	45	26	g	10
5033	92	26	g	10
4937	202	25	g	10
4982	35	26	g	10
4992	47	26	g	10
4917	181	25	g	10
4900	163	25	g	10
4927	191	25	g	10
5014	71	26	g	10
4895	158	25	g	10
4929	193	25	g	10
4910	174	25	g	10
4925	189	25	g	0
4978	30	26	g	10
4889	152	25	g	10
4885	147	25	g	10
4947	212	25	g	0.9090909090909092
4967	17	26	g	10
4945	210	25	g	10
4928	192	25	g	10
4985	40	26	g	10
4908	172	25	g	10
5030	89	26	g	10
4961	11	26	g	10
5029	88	26	g	10
5000	56	26	g	10
4933	198	25	g	10
4987	42	26	g	10
4921	185	25	g	10
4993	48	26	g	0
4960	10	26	g	10
4954	4	26	g	10
4948	213	25	g	10
4949	214	25	g	10
5026	85	26	g	10
4950	215	25	g	10
5013	70	26	g	10
5041	101	26	g	10
4965	15	26	g	10
5040	100	26	g	10
4923	187	25	g	10
4938	203	25	g	10
4898	161	25	g	10
4887	149	25	g	10
4996	52	26	g	0
5028	87	26	g	10
5027	86	26	g	10
4968	18	26	g	0
4936	201	25	g	0
5031	90	26	g	10
5021	80	26	g	10
4999	55	26	g	10
5023	82	26	g	10
4946	211	25	g	0
5035	95	26	g	10
5037	97	26	g	10
4886	148	25	g	0.9090909090909092
5002	58	26	g	10
4995	51	26	g	10
4897	160	25	g	10
5010	66	26	g	10
4979	31	26	g	10
5015	74	26	g	10
5005	61	26	g	10
5052	113	26	p	0
5069	132	26	m	0
5072	135	26	p	0
5134	201	26	g	0
5169	22	27	g	5
5102	168	26	g	5
5048	109	26	g	10
5111	177	26	p	0
5118	184	26	p	0
5105	171	26	m	0
5138	205	26	p	0
5074	137	26	g	10
5153	5	27	g	5
5160	12	27	p	0
5059	121	26	g	10
5071	134	26	g	0
5163	15	27	g	10
5099	164	26	g	10
5186	43	27	p	0
5101	167	26	g	0
5182	38	27	g	10
5137	204	26	g	10
5103	169	26	g	10
5189	46	27	g	10
5050	111	26	g	10
5075	138	26	g	10
5062	124	26	g	10
5174	28	27	g	10
5064	127	26	g	10
5117	183	26	g	10
5122	188	26	g	10
5172	26	27	g	10
5095	160	26	g	10
5155	7	27	g	10
5124	190	26	g	10
5054	115	26	g	10
5150	2	27	g	5
5173	27	27	g	10
5060	122	26	g	10
5116	182	26	g	10
5097	162	26	g	5
5109	175	26	g	10
5187	44	27	g	10
5179	34	27	g	10
5129	196	26	g	0
5141	208	26	g	10
5149	1	27	g	10
5139	206	26	g	10
5088	153	26	g	10
5132	199	26	g	10
5104	170	26	g	0
5079	143	26	g	10
5077	141	26	g	10
5162	14	27	g	10
5078	142	26	g	10
5175	29	27	g	10
5113	179	26	g	10
5196	54	27	g	10
5043	103	26	m	0
5092	157	26	g	10
5082	146	26	g	10
5178	33	27	g	10
5066	129	26	g	10
5100	165	26	g	10
5114	180	26	g	10
5128	194	26	g	10
5156	8	27	g	0
5170	24	27	g	10
5151	3	27	g	10
5076	139	26	g	0
5073	136	26	g	10
5056	117	26	g	10
5058	120	26	g	10
5107	173	26	g	10
5086	150	26	g	10
5089	154	26	g	10
5181	36	27	g	0
5195	53	27	g	10
5112	178	26	g	10
5063	125	26	g	0
5130	197	26	g	10
5190	47	27	g	10
5180	35	27	g	10
5115	181	26	g	10
5055	116	26	g	5
5083	147	26	g	10
5145	212	26	g	10
5167	19	27	g	10
5125	191	26	g	10
5127	193	26	g	10
5108	174	26	g	10
5123	189	26	g	10
5188	45	27	g	10
5176	30	27	g	0
5154	6	27	g	5
5165	17	27	g	5
5098	163	26	g	0
5046	106	26	g	10
5131	198	26	g	10
5119	185	26	g	10
5045	105	26	g	10
5183	40	27	g	10
5068	131	26	g	10
5065	128	26	g	10
5198	56	27	g	5
5106	172	26	g	10
5146	213	26	g	10
5159	11	27	g	10
5191	48	27	g	10
5143	210	26	g	10
5158	10	27	g	10
5152	4	27	g	5
5147	214	26	g	10
5090	155	26	g	10
5148	215	26	g	10
5121	187	26	g	10
5136	203	26	g	10
5096	161	26	g	10
5085	149	26	g	10
5194	52	27	g	5
5193	51	27	g	5
5053	114	26	g	10
5094	159	26	g	0
5168	21	27	g	5
5120	186	26	g	0
5166	18	27	g	0
5110	176	26	g	10
5144	211	26	g	0
5044	104	26	g	10
5049	110	26	g	0
5177	31	27	g	10
5057	119	26	g	10
5142	209	26	g	10
5042	102	26	g	10
5087	152	26	g	0
5192	50	27	g	10
5126	192	26	g	10
5067	130	26	g	10
5197	55	27	g	5
5047	107	26	g	10
5051	112	26	g	10
5135	202	26	g	10
5084	148	26	g	0
5161	13	27	g	10
5061	123	26	g	10
5204	62	27	p	0
5300	168	27	g	10
5210	69	27	p	0
5215	76	27	p	0
5351	5	28	g	10
5223	84	27	p	0
5203	61	27	g	5
5265	130	27	g	10
5235	97	27	g	5
5250	113	27	p	0
5286	153	27	g	5
5270	135	27	p	0
5208	66	27	g	10
5280	146	27	g	10
5309	177	27	p	0
5342	211	27	g	10
5316	184	27	p	0
5257	121	27	g	10
5336	205	27	p	0
8414	109	43	g	9.703504043126687
5202	60	27	g	10
5221	82	27	g	10
5282	148	27	g	5
5335	204	27	g	10
5234	96	27	g	10
5248	111	27	g	5
5273	138	27	g	10
5225	86	27	g	10
5260	124	27	g	10
5305	173	27	g	10
5262	127	27	g	10
5315	183	27	g	10
5289	156	27	g	10
5320	188	27	g	10
5301	169	27	g	10
5222	83	27	g	10
5216	77	27	g	10
5218	79	27	g	10
5327	196	27	g	10
5252	115	27	g	10
5348	2	28	g	0
5293	160	27	g	10
5200	58	27	g	10
5258	122	27	g	5
5279	145	27	g	10
5307	175	27	g	10
5347	1	28	g	10
5220	81	27	g	10
5236	98	27	g	0
5340	209	27	g	10
5217	78	27	g	10
5337	206	27	g	10
5330	199	27	g	10
5339	208	27	g	10
5277	143	27	g	10
5276	142	27	g	10
5302	170	27	g	10
5199	57	27	g	10
5205	63	27	g	10
5290	157	27	g	10
5264	129	27	g	10
5245	107	27	g	10
5246	109	27	g	5
5312	180	27	g	10
5355	9	28	g	10
5311	179	27	g	5
5254	117	27	g	10
5298	165	27	g	10
5297	164	27	g	10
5349	3	28	g	10
5271	136	27	g	0
5207	65	27	g	10
5274	139	27	g	0
5214	75	27	g	10
5328	197	27	g	10
5284	150	27	g	5
5322	190	27	g	10
5287	154	27	g	10
5256	120	27	g	10
5261	125	27	g	10
5253	116	27	g	10
5333	202	27	g	10
5310	178	27	g	10
5285	152	27	g	10
5231	92	27	g	5
5325	193	27	g	10
5313	181	27	g	10
5306	174	27	g	10
5323	191	27	g	10
5212	71	27	g	10
5291	158	27	g	5
5281	147	27	g	10
5321	189	27	g	5
5343	212	27	g	10
5324	192	27	g	10
5296	163	27	g	10
5206	64	27	g	10
5269	134	27	g	10
5243	105	27	g	10
5244	106	27	g	10
5263	128	27	g	10
5266	131	27	g	10
5228	89	27	g	10
5227	88	27	g	5
5283	149	27	g	5
5329	198	27	g	10
5341	210	27	g	10
5317	185	27	g	10
5211	70	27	g	10
5344	213	27	g	10
5345	214	27	g	10
5224	85	27	g	10
5346	215	27	g	10
5350	4	28	g	10
5239	101	27	g	10
5319	187	27	g	10
5334	203	27	g	10
5294	161	27	g	5
5304	172	27	g	10
5352	6	28	g	0
5251	114	27	g	10
5241	103	27	g	10
5226	87	27	g	10
5303	171	27	g	0
5292	159	27	g	5
5229	90	27	g	10
5332	201	27	g	0
5272	137	27	g	10
5299	167	27	g	0
5233	95	27	g	10
5318	186	27	g	10
5308	176	27	g	10
5255	119	27	g	10
5240	102	27	g	10
5331	200	27	g	10
5288	155	27	g	10
5247	110	27	g	5
5267	132	27	g	0
5353	7	28	g	10
5249	112	27	g	10
5295	162	27	g	10
5230	91	27	g	10
5213	74	27	g	10
5259	123	27	g	5
5232	93	27	g	10
5358	12	28	p	0
5485	154	28	g	10
5360	14	28	m	0
5434	98	28	g	10
5384	43	28	p	0
5397	57	28	g	10
5405	65	28	m	0
5402	62	28	p	0
5408	69	28	p	0
5413	76	28	p	0
5427	90	28	g	0
5421	84	28	p	0
5362	16	28	g	10
5508	178	28	g	10
5491	160	28	g	10
5448	113	28	p	0
5468	135	28	p	0
5488	157	28	g	10
5457	123	28	g	10
5465	132	28	m	0
5507	177	28	p	0
5400	60	28	g	10
5497	167	28	g	5
5419	82	28	g	10
5480	148	28	g	0
5506	176	28	g	0
5375	31	28	g	0
5428	91	28	g	0
5387	46	28	g	10
5446	111	28	g	10
5399	59	28	g	10
5471	138	28	g	10
5372	28	28	g	10
5458	124	28	g	10
5499	169	28	g	10
5460	127	28	g	0
5487	156	28	g	10
5370	26	28	g	0
5420	83	28	g	0
5416	79	28	g	10
5373	29	28	g	10
5368	24	28	m	0
5443	107	28	g	10
5450	115	28	g	10
5423	86	28	g	10
5359	13	28	g	10
5512	182	28	g	10
5493	162	28	g	10
5377	34	28	m	0
5456	122	28	g	10
5505	175	28	g	10
5385	44	28	g	0
5455	121	28	g	10
5500	170	28	m	0
5464	131	28	g	10
5473	141	28	g	10
5369	25	28	m	0
5474	142	28	g	10
5418	81	28	g	10
5490	159	28	g	0
5495	164	28	g	0
5411	74	28	g	0
5394	54	28	g	10
5444	109	28	g	10
5406	66	28	g	10
5463	130	28	g	10
5469	136	28	g	10
5403	63	28	g	10
5462	129	28	g	10
5509	179	28	g	10
5510	180	28	g	10
5367	22	28	g	10
5496	165	28	g	10
5412	75	28	g	10
5452	117	28	g	10
5472	139	28	g	0
5503	173	28	g	10
5454	120	28	g	10
5477	145	28	g	0
5379	36	28	g	0
5393	53	28	g	0
5466	133	28	g	0
5498	168	28	g	10
5459	125	28	g	0
5504	174	28	g	10
5482	150	28	g	10
5429	92	28	g	10
5371	27	28	m	0
5378	35	28	g	10
5451	116	28	g	10
5435	99	28	g	0
5511	181	28	g	10
5365	19	28	g	10
5410	71	28	g	10
5489	158	28	g	10
5494	163	28	g	0
5386	45	28	g	10
5479	147	28	g	0
5374	30	28	g	10
5363	17	28	g	0
5381	40	28	g	10
5478	146	28	g	10
5441	105	28	g	10
5356	10	28	g	10
5404	64	28	g	10
5426	89	28	g	10
5407	68	28	g	10
5425	88	28	g	10
5442	106	28	g	10
5461	128	28	g	10
5396	56	28	g	10
5357	11	28	g	10
5501	171	28	m	0
5409	70	28	g	10
5486	155	28	g	0
5437	101	28	g	10
5481	149	28	g	10
5361	15	28	g	10
5392	52	28	g	0
5436	100	28	g	10
5492	161	28	g	5
5502	172	28	g	10
5449	114	28	g	10
5366	21	28	g	0
5467	134	28	m	0
5395	55	28	g	10
5439	103	28	g	0
5453	119	28	g	0
5398	58	28	g	10
5417	80	28	g	10
5364	18	28	g	0
5445	110	28	g	0
5430	93	28	g	10
5470	137	28	g	10
5440	104	28	g	10
5433	97	28	g	10
5401	61	28	g	10
5438	102	28	g	0
5389	48	28	m	0
5390	50	28	g	10
5484	153	28	g	0
5447	112	28	g	0
5415	78	28	g	10
5380	38	28	g	10
5431	95	28	g	10
5514	184	28	p	0
5534	205	28	p	0
5663	132	29	m	0
5598	60	29	g	10
5518	188	28	g	10
5556	12	29	p	0
5566	24	29	g	0
5582	43	29	p	0
5600	62	29	p	0
5606	69	29	p	0
5611	76	29	p	0
5583	44	29	g	7.203947368421053
5619	84	29	p	0
5525	196	28	g	10
5642	109	29	g	4.309210526315789
5523	193	28	g	10
5658	127	29	m	0
5646	113	29	p	0
5555	11	29	g	10
5593	55	29	g	9.93421052631579
5641	107	29	g	10
5666	135	29	p	0
5631	97	29	g	10
5617	82	29	g	10
5626	91	29	g	10
5573	31	29	g	5.592105263157895
5669	138	29	g	10
5585	46	29	g	10
5656	124	29	g	10
5644	111	29	g	10
5630	96	29	g	9.93421052631579
5597	59	29	g	9.769736842105262
5569	27	29	m	0
5662	131	29	g	10
5513	183	28	g	0
5568	26	29	g	9.671052631578947
5618	83	29	g	9.901315789473685
5588	50	29	g	10
5551	7	29	g	10
5571	29	29	g	10
5592	54	29	g	10
5621	86	29	g	10
5520	190	28	g	10
5648	115	29	g	9.93421052631579
5557	13	29	g	10
5567	25	29	m	0
5668	137	29	g	10
5625	90	29	g	10
5575	34	29	g	9.868421052631579
5540	211	28	g	10
5545	1	29	g	10
5632	98	29	g	9.342105263157896
5535	206	28	g	0
5549	5	29	g	0
5558	14	29	g	9.736842105263161
5528	199	28	g	10
5521	191	28	m	0
5595	57	29	g	9.967105263157896
5616	81	29	g	10
5653	121	29	g	9.967105263157896
5652	120	29	g	10
5577	36	29	g	0
5607	70	29	g	10
5604	66	29	g	10
5661	130	29	g	9.868421052631579
5565	22	29	g	10
5574	33	29	g	10
5601	63	29	g	10
5524	194	28	g	10
5547	3	29	g	10
5553	9	29	g	10
5552	8	29	g	0
5610	75	29	g	10
5667	136	29	g	10
5650	117	29	g	10
5636	102	29	g	10
5603	65	29	g	9.901315789473685
5612	77	29	g	9.342105263157894
5614	79	29	g	9.967105263157894
5591	53	29	g	8.75
5657	125	29	g	9.901315789473685
5526	197	28	g	10
5627	92	29	g	10
5609	74	29	g	9.671052631578947
5586	47	29	g	10
5531	202	28	g	10
5576	35	29	g	10
5628	93	29	m	0
5649	116	29	g	9.901315789473685
5536	207	28	g	10
5608	71	29	g	10
5584	45	29	g	10
5533	204	28	g	10
5572	30	29	g	10
5519	189	28	g	0
5550	6	29	g	9.605263157894738
5541	212	28	g	0
5522	192	28	g	10
5579	40	29	g	10
5516	186	28	g	10
5639	105	29	g	9.93421052631579
5623	88	29	g	10
5602	64	29	g	10
5640	106	29	g	10
5587	48	29	g	10
5605	68	29	g	9.967105263157894
5515	185	28	g	10
5659	128	29	g	10
5651	119	29	g	9.901315789473683
5594	56	29	g	10
5527	198	28	g	10
5581	42	29	g	9.736842105263158
5554	10	29	g	9.638157894736842
5620	85	29	g	9.967105263157894
5539	210	28	g	0
5543	214	28	g	0
5542	213	28	g	0
5560	16	29	g	10
5635	101	29	g	10
5634	100	29	g	10
5559	15	29	g	0
5590	52	29	g	9.901315789473685
5517	187	28	g	10
5532	203	28	g	0
5647	114	29	g	10
5564	21	29	g	9.901315789473685
5645	112	29	g	9.506578947368423
5589	51	29	g	9.835526315789473
5599	61	29	m	0
5596	58	29	g	10
5580	41	29	g	9.901315789473685
5538	209	28	g	10
5637	103	29	g	10
5530	201	28	g	0
5615	80	29	g	4.177631578947368
5562	18	29	g	9.605263157894736
5529	200	28	g	0
5578	38	29	g	10
5665	134	29	g	9.835526315789473
5561	17	29	g	10
5643	110	29	m	0
5654	122	29	m	0
5629	95	29	g	10
5563	19	29	g	9.605263157894736
5548	4	29	g	6.842105263157896
5696	168	29	g	9.407894736842106
5814	81	30	g	10
5733	206	29	g	10
5751	9	30	g	10
5705	177	29	p	0
5822	89	30	g	5
5712	184	29	p	0
5731	204	29	g	10
5693	164	29	g	10
5805	70	30	g	10
5732	205	29	p	0
5688	159	29	m	0
5807	74	30	g	9
5754	12	30	p	0
5780	43	30	p	0
5704	176	29	g	9.934210526315791
5798	62	30	p	0
5804	69	30	p	0
5809	76	30	p	0
5817	84	30	p	0
5776	38	30	g	9
5824	91	30	g	9
5815	82	30	g	10
5714	186	29	g	9.835526315789473
5766	26	30	g	10
5783	46	30	g	9
5768	28	30	g	10
5711	183	29	g	5.032894736842104
5795	59	30	g	5
5685	156	29	g	10
5749	7	30	g	10
5697	169	29	g	10
5812	79	30	g	10
5816	83	30	g	5
5810	77	30	g	10
5786	50	30	g	9
5767	27	30	g	5
5710	182	29	g	10
5744	2	30	g	10
5819	86	30	g	10
5755	13	30	g	10
5746	4	30	g	10
5675	145	29	g	9.93421052631579
5773	34	30	g	10
5781	44	30	g	9
5723	196	29	g	7.269736842105264
5747	5	30	g	8
5703	175	29	g	9.835526315789473
5743	1	30	g	5
5736	209	29	g	10
5673	143	29	g	10
5726	199	29	g	10
5811	78	30	g	5
5756	14	30	g	4
5765	25	30	g	8
5698	170	29	g	8.519736842105264
5672	142	29	g	10
5793	57	30	g	4
5682	153	29	g	9.375
5772	33	30	g	10
5769	29	30	g	10
5750	8	30	g	8
5790	54	30	g	10
5735	208	29	g	10
5686	157	29	g	9.967105263157896
5727	200	29	g	10
5799	63	30	g	10
5708	180	29	g	10
5722	194	29	g	9.539473684210527
5763	22	30	g	10
5801	65	30	g	5
5745	3	30	g	9
5694	165	29	g	9.901315789473683
5670	139	29	g	0
5808	75	30	g	9
5764	24	30	g	5
5826	93	30	g	9
5789	53	30	g	9
5775	36	30	g	0
5680	150	29	g	9.967105263157896
5724	197	29	g	10
5825	92	30	g	10
5706	178	29	g	10
5759	17	30	g	10
5784	47	30	g	9
5709	181	29	g	10
5729	202	29	g	10
5774	35	30	g	0
5806	71	30	g	10
5761	19	30	g	9
5702	174	29	g	9.736842105263158
5721	193	29	g	9.802631578947366
5687	158	29	g	7.763157894736842
5717	189	29	g	3.68421052631579
5782	45	30	g	4
5770	30	30	g	9
5677	147	29	g	9.243421052631579
5739	212	29	g	10
5748	6	30	g	9
5692	163	29	g	9.967105263157894
5681	152	29	g	10
5800	64	30	g	10
5777	40	30	g	9
5821	88	30	g	10
5803	68	30	g	10
5752	10	30	g	9
5725	198	29	g	10
5792	56	30	g	5
5785	48	30	g	5
5713	185	29	g	10
5779	42	30	g	9
5737	210	29	g	7.0394736842105265
5753	11	30	g	10
5741	214	29	g	10
5818	85	30	g	10
5742	215	29	g	10
5758	16	30	g	5
5684	155	29	g	9.769736842105264
5715	187	29	g	10
5757	15	30	g	5
5690	161	29	g	10
5730	203	29	g	0
5700	172	29	g	9.901315789473685
5679	149	29	g	10
5788	52	30	g	5
5787	51	30	g	5
5820	87	30	g	9
5738	211	29	g	9.901315789473685
5823	90	30	g	9
5718	190	29	g	10
5794	58	30	g	10
5791	55	30	g	4
5760	18	30	g	4
5728	201	29	g	0
5802	66	30	g	5
5676	146	29	g	10
5796	60	30	g	10
5678	148	29	g	10
5813	80	30	g	9
5699	171	29	g	0
5689	160	29	g	9.868421052631579
5778	41	30	g	5
5771	31	30	g	9
5701	173	29	g	9.868421052631579
5695	167	29	g	9.901315789473685
5844	113	30	p	0
5864	135	30	p	0
5903	177	30	p	0
5910	184	30	p	0
5930	205	30	p	0
5876	148	30	g	4
5836	104	30	g	10
5866	137	30	g	10
5842	111	30	g	9
5828	96	30	g	9
5905	179	30	g	10
5854	124	30	g	9
5856	127	30	g	5
5855	125	30	g	4
5862	133	30	g	8
5878	150	30	g	9
5904	178	30	g	10
5907	181	30	g	9
5831	99	30	g	9
5887	160	30	g	8
5889	162	30	g	5
5873	145	30	g	5
5852	122	30	g	10
5837	105	30	g	5
5921	196	30	g	4
5857	128	30	g	5
5935	210	30	g	10
5882	155	30	g	5
5869	141	30	g	5
5871	143	30	g	9
5870	142	30	g	9
5938	213	30	g	10
5939	214	30	g	0
5880	153	30	g	9
5848	117	30	g	9
5906	180	30	g	10
5920	194	30	g	10
5892	165	30	g	10
5865	136	30	g	9
5868	139	30	g	9
5899	173	30	g	9
5881	154	30	g	5
5850	120	30	g	10
5922	197	30	g	10
5847	116	30	g	0
5885	158	30	g	10
5917	191	30	g	5
5919	193	30	g	8
5933	208	30	g	5
5900	174	30	g	10
5875	147	30	g	9
5915	189	30	g	9
5937	212	30	g	10
5918	192	30	g	9
5890	163	30	g	0
5929	204	30	g	4
5838	106	30	g	5
5923	198	30	g	10
5911	185	30	g	5
5888	161	30	g	4
5913	187	30	g	10
5877	149	30	g	10
5898	172	30	g	10
5940	215	30	g	0
5835	103	30	g	9
5926	201	30	g	4
5843	112	30	g	9
5829	97	30	g	8
5853	123	30	g	5
5893	167	30	g	10
5827	95	30	g	9
5886	159	30	g	8
5909	183	30	g	9
5883	156	30	g	4
5914	188	30	g	9
5895	169	30	g	9
5916	190	30	g	9
5846	115	30	g	10
5901	175	30	g	9
5830	98	30	g	10
5924	199	30	g	10
5896	170	30	g	10
5832	100	30	g	10
5928	203	30	g	5
5897	171	30	g	8
5845	114	30	g	10
5908	182	30	g	9
5894	168	30	g	8
5858	129	30	g	10
5840	109	30	g	9
5863	134	30	g	5
5936	211	30	g	9
5839	107	30	g	10
5891	164	30	g	5
5927	202	30	g	10
5874	146	30	g	5
5912	186	30	g	9
5902	176	30	g	4
5849	119	30	g	9
5834	102	30	g	5
5925	200	30	g	5
5879	152	30	g	9
5833	101	30	g	10
5841	110	30	g	4
5860	131	30	g	9
5931	206	30	g	9
5867	138	30	g	5
5861	132	30	g	10
8426	122	43	p	0
5872	144	30	g	10
5884	157	30	g	10
5859	130	30	g	5
8651	152	44	m	0
8809	107	45	p	0
8812	111	45	p	0
8965	61	46	p	0
9123	15	47	m	0
9279	187	47	p	0
9436	144	48	p	0
9593	99	49	p	0
6082	157	31	g	10
9755	59	50	p	0
9756	60	50	p	0
9757	61	50	p	0
9758	62	50	p	0
9759	63	50	p	0
9760	64	50	p	0
3279	123	17	g	100
8137	19	42	m	0
7459	147	38	m	0
8066	161	41	m	0
8421	116	43	g	8.355795148247978
8960	56	46	g	5
3197	31	17	g	0
3192	26	17	g	44.44444444444444
3181	13	17	g	0
3176	8	17	g	0
3281	125	17	g	0
3252	93	17	g	0
3258	100	17	g	0
6070	144	31	g	5
6249	123	32	g	9.25
3175	7	17	m	0
3180	12	17	m	0
3206	43	17	m	0
3211	48	17	m	0
3224	62	17	m	0
3230	69	17	m	0
3235	76	17	m	0
3238	79	17	m	0
3240	81	17	m	0
3256	98	17	m	0
3257	99	17	m	0
3270	113	17	m	0
3272	115	17	m	0
3274	117	17	m	0
3275	119	17	m	0
3277	121	17	m	0
3282	127	17	m	0
3288	133	17	m	0
3290	135	17	m	0
6888	172	35	g	10
6435	110	33	g	0
6779	53	35	g	10
5976	41	31	g	10
6193	61	32	g	3.75
6570	41	34	g	9.921787709497206
6966	41	36	g	10
6589	61	34	g	2
6985	61	36	g	7
6436	111	33	g	10
6818	96	35	g	10
6065	138	31	g	10
6343	7	33	g	10
6898	182	35	g	10
6110	186	31	g	5
6558	26	34	g	10
6954	26	36	g	5
6708	190	34	g	10
6481	160	33	g	0
6559	27	34	g	10
7098	184	36	g	5
6969	44	36	g	0
6317	196	32	g	7.25
6713	196	34	g	2
5963	25	31	g	10
6189	57	32	g	5
6870	153	35	g	10
7068	153	36	g	2
6387	57	33	g	5
6561	29	34	g	10
6923	208	35	g	10
6759	29	35	g	10
6486	165	33	g	10
6270	146	32	g	7.5
6056	129	31	g	10
6197	65	32	g	2.25
6159	22	32	g	7.75
6684	165	34	g	10
5973	36	31	g	10
6339	3	33	g	10
6851	132	35	g	10
7056	139	36	g	0
6593	65	34	g	0
6318	197	32	g	10
6494	174	33	g	10
6714	197	34	g	10
6102	178	31	g	10
6501	181	33	g	10
7095	181	36	g	10
6029	99	31	g	10
7019	99	36	g	4
6890	174	35	g	10
6629	105	34	g	8
6113	189	31	g	10
6271	147	32	g	3.5
6667	147	34	g	3
6001	68	31	g	10
6217	88	32	g	3
6847	128	35	g	10
6415	88	33	g	0
7099	185	36	g	10
6671	152	34	g	10
6331	210	32	g	4.75
6532	213	33	g	5
6201	70	32	g	8.75
6993	70	36	g	7
5955	15	31	g	10
7011	90	36	g	5
6209	80	32	g	6
6332	211	32	g	10
6382	52	33	g	10
6637	114	34	g	10
6018	87	31	g	10
6526	207	33	g	10
5989	55	31	g	10
6447	123	33	g	10
6645	123	34	g	10
6843	123	35	g	10
6963	36	36	g	2
6991	68	36	g	5
7120	207	36	g	5
7041	123	36	g	10
3297	143	17	m	0
3300	146	17	m	0
3311	158	17	m	0
3321	169	17	m	0
3329	177	17	m	0
3334	182	17	m	0
3350	199	17	m	0
3351	200	17	m	0
3352	201	17	m	0
3356	205	17	m	0
3357	206	17	m	0
3361	210	17	m	0
3366	215	17	m	0
2414	43	13	m	0
2438	69	13	m	0
2464	98	13	m	0
2502	139	13	m	0
2537	177	13	m	0
2564	205	13	m	0
2636	69	14	m	0
2662	98	14	m	0
2641	76	14	g	0
2700	139	14	m	0
2709	149	14	m	0
2714	155	14	m	0
2735	177	14	m	0
2753	196	14	m	0
2762	205	14	m	0
2763	206	14	m	0
2834	69	15	m	0
2860	98	15	m	0
2874	113	15	m	0
2903	145	15	m	0
2933	177	15	m	0
2940	184	15	m	0
2956	201	15	m	0
2960	205	15	m	0
2970	215	15	m	0
3008	43	16	m	0
3026	62	16	m	0
3032	69	16	m	0
3037	76	16	m	0
3058	98	16	m	0
3072	113	16	m	0
2679	116	14	g	100
3096	139	16	m	0
3104	148	16	m	0
3113	158	16	m	0
3119	164	16	m	0
3131	177	16	m	0
3389	25	18	m	0
3391	27	18	m	0
3392	28	18	m	0
3393	29	18	m	0
3394	30	18	m	0
3398	35	18	m	0
3399	36	18	m	0
3400	38	18	m	0
3401	40	18	m	0
3402	41	18	m	0
3403	42	18	m	0
3404	43	18	m	0
3407	46	18	m	0
3408	47	18	m	0
3409	48	18	m	0
3410	50	18	m	0
2696	135	14	g	0
3412	52	18	m	0
3413	53	18	m	0
3414	54	18	m	0
3415	55	18	m	0
3416	56	18	m	0
3420	60	18	m	0
3422	62	18	m	0
3423	63	18	m	0
3424	64	18	m	0
3427	68	18	m	0
3428	69	18	m	0
3343	191	17	g	100
3432	75	18	m	0
2839	76	15	g	0
3439	82	18	m	0
3443	86	18	m	0
3444	87	18	m	0
3445	88	18	m	0
3449	92	18	m	0
3451	95	18	m	0
3453	97	18	m	0
3454	98	18	m	0
2511	149	13	g	0
2742	184	14	g	0
3462	106	18	m	0
2912	155	15	g	0
3465	110	18	m	0
3075	116	16	g	80
3468	113	18	m	0
3469	114	18	m	0
3313	160	17	g	0
3337	185	17	g	0
3354	203	17	g	35.55555555555556
3395	31	18	g	0
3448	91	18	g	0
3477	123	18	m	0
3478	124	18	m	0
3435	78	18	g	0
3426	66	18	g	0
3485	132	18	g	80
3471	116	18	g	0
3441	84	18	g	0
3430	71	18	g	0
3488	135	18	m	0
3406	45	18	g	0
3461	105	18	g	0
3481	128	18	g	98.86363636363636
2942	186	15	g	100
2951	196	15	g	55
3338	186	17	g	100
3442	85	18	g	0
2443	76	13	g	0
3447	90	18	g	0
3089	132	16	g	60
2961	206	15	g	80
2478	113	13	g	0
2744	186	14	g	100
2877	116	15	g	93.75
2565	206	13	g	0
2562	203	13	g	0
3390	26	18	g	100
2546	186	13	g	100
3492	139	18	m	0
3494	142	18	m	0
589	210	3	g	100
656	69	4	g	0
3499	147	18	m	0
773	196	4	g	92.09225700164745
682	98	4	g	99.45085118066996
3504	153	18	m	0
3505	154	18	m	0
738	159	4	g	0
3508	157	18	m	0
3509	158	18	m	0
3510	159	18	m	0
62	69	1	g	100
3512	161	18	m	0
88	98	1	g	100
3514	163	18	m	0
365	183	2	g	100
3516	165	18	m	0
286	98	2	g	100
387	206	2	g	66.66666666666666
324	139	2	g	66.66666666666666
373	191	2	g	100
3522	172	18	m	0
391	210	2	g	100
3527	177	18	m	0
3528	178	18	m	0
3529	179	18	m	0
335	152	2	g	100
555	175	3	g	100
3533	183	18	m	0
522	139	3	g	0
650	62	4	g	0
3536	186	18	m	0
3537	187	18	m	0
3538	188	18	m	0
3540	190	18	m	0
3541	191	18	m	0
971	196	5	g	100
3546	197	18	m	0
880	98	5	g	100
3549	200	18	m	0
911	132	5	g	100
3552	203	18	m	0
3553	204	18	m	0
3554	205	18	m	0
3555	206	18	m	0
3556	207	18	m	0
814	24	5	g	68.75
936	159	5	g	0
3562	213	18	m	0
3563	214	18	m	0
3564	215	18	m	0
38	43	1	m	0
914	135	5	g	0
359	177	2	m	0
386	205	2	m	0
557	177	3	m	0
975	200	5	g	68.75
584	205	3	m	0
985	210	5	g	100
1121	145	6	g	37.5
1169	196	6	g	100
720	139	4	m	0
1109	132	6	g	100
755	177	4	m	0
1116	139	6	g	0
769	191	4	m	0
782	205	4	m	0
783	206	4	m	0
1134	159	6	g	0
804	12	5	m	0
830	43	5	m	0
1112	135	6	g	0
848	62	5	m	0
854	69	5	m	0
918	139	5	m	0
927	149	5	m	0
953	177	5	m	0
1173	200	6	g	0
967	191	5	m	0
980	205	5	m	0
981	206	5	m	0
990	215	5	m	0
1092	113	6	g	0
1151	177	6	m	0
1165	191	6	m	0
1178	205	6	m	0
1179	206	6	m	0
1176	203	6	g	100
929	152	5	g	100
1127	152	6	g	100
144	159	1	g	100
342	159	2	g	100
366	184	2	g	100
1158	184	6	g	100
305	119	2	g	100
3558	209	18	g	0
3525	175	18	g	0
3530	180	18	g	0
661	76	4	g	66.66666666666666
816	26	5	g	100
850	64	5	g	100
3544	194	18	g	0
978	203	5	g	100
3547	198	18	g	0
1174	201	6	g	100
859	76	5	g	100
102	113	1	g	100
300	113	2	g	100
498	113	3	g	100
894	113	5	g	100
3524	174	18	g	0
3539	189	18	g	0
3561	212	18	g	0
3542	192	18	g	0
3560	211	18	g	0
713	132	4	g	66.66666666666666
384	203	2	g	100
582	203	3	g	100
780	203	4	g	100
1188	215	6	m	0
1319	145	7	g	100
1307	132	7	g	0
1349	177	7	m	0
1376	205	7	m	0
1377	206	7	m	0
1386	215	7	m	0
1442	62	8	m	0
1448	69	8	m	0
1314	139	7	g	66.66666666666666
1453	76	8	m	0
1332	159	7	g	0
1310	135	7	g	0
1371	200	7	g	0
1290	113	7	g	66.66666666666666
1547	177	8	m	0
1574	205	8	m	0
1575	206	8	m	0
1584	215	8	m	0
1646	69	9	m	0
1374	203	7	g	33.33333333333333
1649	74	9	m	0
1651	76	9	m	0
1517	145	8	g	100
1474	98	8	g	99.79053204859657
1719	149	9	m	0
1745	177	9	m	0
1767	200	9	m	0
1772	205	9	m	0
1782	215	9	m	0
1505	132	8	g	45.45454545454545
1838	62	10	m	0
1844	69	10	m	0
1849	76	10	m	0
1512	139	8	g	0
1530	159	8	g	0
1451	74	8	g	0
1870	98	10	m	0
1561	191	8	g	45.45454545454545
1908	139	10	m	0
1508	135	8	g	0
1581	212	8	g	0
1444	64	8	g	99.80100544616674
1569	200	8	g	0
1943	177	10	m	0
1523	152	8	g	100
1965	200	10	m	0
1970	205	10	m	0
1971	206	10	m	0
1980	215	10	m	0
2047	76	11	m	0
1735	167	9	g	0
1696	124	9	g	100
1763	196	9	g	66.66666666666666
2068	98	11	m	0
1672	98	9	g	99.12280701754386
2102	135	11	m	0
2106	139	11	m	0
1768	201	9	g	0
2115	149	11	m	0
1710	139	9	g	66.66666666666666
1683	110	9	g	0
2141	177	11	m	0
1689	116	9	g	100
1563	193	8	g	4.545454545454546
1761	193	9	g	100
1959	193	10	g	100
2157	193	11	g	100
1356	184	7	g	100
1554	184	8	g	95.45454545454545
1752	184	9	g	66.66666666666666
1931	164	10	g	100
2129	164	11	g	100
1925	158	10	g	100
2123	158	11	g	100
1903	134	10	g	100
2101	134	11	g	100
1759	191	9	g	33.33333333333333
1866	93	10	g	100
2064	93	11	g	100
1916	148	10	g	100
2114	148	11	g	100
1706	135	9	g	0
1642	64	9	g	100
1840	64	10	g	100
1852	79	10	g	100
2050	79	11	g	100
2159	196	11	g	100
2112	146	11	g	100
1372	201	7	g	100
1721	152	9	g	99.56140350877193
1966	201	10	g	100
1770	203	9	g	100
1894	124	10	g	100
1686	113	9	g	100
1884	113	10	g	100
2082	113	11	g	100
2081	112	11	g	100
1952	186	10	g	100
2150	186	11	g	100
1913	145	10	g	100
1961	196	10	g	100
1914	146	10	g	100
1899	130	10	g	100
1901	132	10	g	100
1926	159	10	g	0
1847	74	10	g	100
1957	191	10	g	0
1904	135	10	g	0
1975	210	10	g	100
1919	152	10	g	100
1917	149	10	g	33.33333333333333
1883	112	10	g	100
2092	124	11	g	100
2111	145	11	g	100
2097	130	11	g	100
2099	132	11	g	100
2124	159	11	g	0
2045	74	11	g	100
2085	116	11	g	100
2155	191	11	g	0
2117	152	11	g	100
1570	201	8	g	49.79053204859657
1488	113	8	g	99.98952660242982
1703	132	9	g	66.66666666666666
1968	203	10	g	100
2163	200	11	m	0
2168	205	11	m	0
2169	206	11	m	0
2173	210	11	g	0
2178	215	11	m	0
2200	24	12	m	0
2201	25	12	m	0
2212	38	12	m	0
2312	148	12	g	37.77777777777778
2216	43	12	m	0
2220	47	12	m	0
2222	50	12	m	0
2225	53	12	m	0
2290	124	12	g	0
2204	28	12	g	0
2234	62	12	m	0
2238	66	12	m	0
2331	169	12	g	0
2240	69	12	m	0
2248	79	12	g	0
2245	76	12	m	0
2352	190	12	g	0
2282	115	12	g	100
2251	82	12	m	0
2256	87	12	m	0
2325	162	12	g	0
2261	92	12	m	0
2263	95	12	m	0
2348	186	12	g	0
2266	98	12	m	0
2309	145	12	g	0
2306	142	12	g	0
2273	105	12	m	0
2281	114	12	m	0
2229	57	12	g	20
2226	54	12	g	0
2295	130	12	g	0
2292	127	12	m	0
2300	135	12	m	0
2327	164	12	g	0
2304	139	12	m	0
2297	132	12	g	86.66666666666666
2313	149	12	m	0
2301	136	12	g	100
2317	154	12	g	26.666666666666668
2277	110	12	g	0
2291	125	12	g	20
2340	178	12	g	0
2243	74	12	g	100
2283	116	12	g	100
2339	177	12	m	0
2353	191	12	g	0
2267	99	12	g	100
2218	45	12	g	0
2371	210	12	m	0
2376	215	12	m	0
3612	54	19	m	0
3613	55	19	m	0
3614	56	19	m	0
3615	57	19	m	0
3616	58	19	m	0
3617	59	19	m	0
3618	60	19	m	0
3619	61	19	m	0
3620	62	19	m	0
3621	63	19	m	0
3622	64	19	m	0
3623	65	19	m	0
3624	66	19	m	0
3625	68	19	m	0
3626	69	19	m	0
3627	70	19	m	0
3628	71	19	m	0
3629	74	19	m	0
3630	75	19	m	0
3631	76	19	m	0
3632	77	19	m	0
3633	78	19	m	0
3634	79	19	m	0
3635	80	19	m	0
3636	81	19	m	0
3637	82	19	m	0
3638	83	19	m	0
3639	84	19	m	0
3640	85	19	m	0
3641	86	19	m	0
3642	87	19	m	0
3643	88	19	m	0
3644	89	19	m	0
3645	90	19	m	0
3646	91	19	m	0
3647	92	19	m	0
3648	93	19	m	0
3649	95	19	m	0
3650	96	19	m	0
3651	97	19	m	0
3652	98	19	m	0
3653	99	19	m	0
3654	100	19	m	0
3655	101	19	m	0
3656	102	19	m	0
3657	103	19	m	0
3658	104	19	m	0
3659	105	19	m	0
3660	106	19	m	0
3661	107	19	m	0
2322	159	12	g	13.333333333333334
2355	193	12	g	86.66666666666666
2320	157	12	g	28.888888888888886
2346	184	12	g	100
2299	134	12	g	20
2293	128	12	g	100
2202	26	12	g	100
2262	93	12	g	100
2236	64	12	g	100
2166	203	11	g	100
2253	84	12	g	100
2164	201	11	g	100
2280	113	12	g	100
3662	109	19	m	0
3663	110	19	m	0
3664	111	19	m	0
3665	112	19	m	0
3667	114	19	m	0
3668	115	19	m	0
3669	116	19	m	0
3670	117	19	m	0
3671	119	19	m	0
3672	120	19	m	0
3673	121	19	m	0
3674	122	19	m	0
3675	123	19	m	0
3676	124	19	m	0
3677	125	19	m	0
3678	127	19	m	0
3679	128	19	m	0
3680	129	19	m	0
3681	130	19	m	0
3682	131	19	m	0
3683	132	19	m	0
3684	133	19	m	0
3685	134	19	m	0
3686	135	19	m	0
3687	136	19	m	0
3688	137	19	m	0
3689	138	19	m	0
3690	139	19	m	0
3691	141	19	m	0
3692	142	19	m	0
3693	143	19	m	0
3694	144	19	m	0
3695	145	19	m	0
3696	146	19	m	0
3697	147	19	m	0
3698	148	19	m	0
3699	149	19	m	0
3700	150	19	m	0
3701	152	19	m	0
3702	153	19	m	0
3703	154	19	m	0
3704	155	19	m	0
3705	156	19	m	0
3706	157	19	m	0
3707	158	19	m	0
3708	159	19	m	0
3709	160	19	m	0
3710	161	19	m	0
3711	162	19	m	0
3712	163	19	m	0
3713	164	19	m	0
3714	165	19	m	0
3715	167	19	m	0
3716	168	19	m	0
3717	169	19	m	0
3718	170	19	m	0
3719	171	19	m	0
3720	172	19	m	0
3721	173	19	m	0
3722	174	19	m	0
3723	175	19	m	0
3724	176	19	m	0
3725	177	19	m	0
3726	178	19	m	0
3727	179	19	m	0
3728	180	19	m	0
3729	181	19	m	0
3730	182	19	m	0
3731	183	19	m	0
3732	184	19	m	0
3733	185	19	m	0
3734	186	19	m	0
3735	187	19	m	0
3736	188	19	m	0
3737	189	19	m	0
3738	190	19	m	0
3739	191	19	m	0
3740	192	19	m	0
3741	193	19	m	0
3742	194	19	m	0
3743	196	19	m	0
3744	197	19	m	0
3745	198	19	m	0
3746	199	19	m	0
3747	200	19	m	0
3748	201	19	m	0
3749	202	19	m	0
3750	203	19	m	0
3751	204	19	m	0
3752	205	19	m	0
3753	206	19	m	0
3754	207	19	m	0
3755	208	19	m	0
3756	209	19	m	0
3757	210	19	m	0
3758	211	19	m	0
3759	212	19	m	0
3760	213	19	m	0
3761	214	19	m	0
3762	215	19	m	0
3769	7	20	m	0
3770	8	20	m	0
3771	9	20	m	0
3772	10	20	m	0
3773	11	20	m	0
3774	12	20	m	0
3775	13	20	m	0
3776	14	20	m	0
3777	15	20	m	0
3778	16	20	m	0
3779	17	20	m	0
3780	18	20	m	0
3781	19	20	m	0
3782	21	20	m	0
3783	22	20	m	0
3784	24	20	m	0
3785	25	20	m	0
3786	26	20	m	0
3787	27	20	m	0
3788	28	20	m	0
3789	29	20	m	0
3790	30	20	m	0
3791	31	20	m	0
3792	33	20	m	0
3793	34	20	m	0
3794	35	20	m	0
3795	36	20	m	0
3796	38	20	m	0
3797	40	20	m	0
3798	41	20	m	0
3799	42	20	m	0
3800	43	20	m	0
3801	44	20	m	0
3802	45	20	m	0
3803	46	20	m	0
3804	47	20	m	0
3805	48	20	m	0
3806	50	20	m	0
3807	51	20	m	0
3808	52	20	m	0
3809	53	20	m	0
3810	54	20	m	0
3811	55	20	m	0
3812	56	20	m	0
3813	57	20	m	0
3814	58	20	m	0
3815	59	20	m	0
3816	60	20	m	0
3817	61	20	m	0
3818	62	20	m	0
3819	63	20	m	0
3820	64	20	m	0
3821	65	20	m	0
3822	66	20	m	0
3823	68	20	m	0
3824	69	20	m	0
3825	70	20	m	0
3826	71	20	m	0
3827	74	20	m	0
3828	75	20	m	0
3829	76	20	m	0
3830	77	20	m	0
3831	78	20	m	0
3832	79	20	m	0
3833	80	20	m	0
3834	81	20	m	0
3835	82	20	m	0
3836	83	20	m	0
3837	84	20	m	0
3838	85	20	m	0
3839	86	20	m	0
3840	87	20	m	0
3841	88	20	m	0
3842	89	20	m	0
3843	90	20	m	0
3844	91	20	m	0
3845	92	20	m	0
3846	93	20	m	0
3847	95	20	m	0
3848	96	20	m	0
3849	97	20	m	0
3850	98	20	m	0
3851	99	20	m	0
3852	100	20	m	0
3853	101	20	m	0
3854	102	20	m	0
3855	103	20	m	0
3856	104	20	m	0
3857	105	20	m	0
3858	106	20	m	0
3859	107	20	m	0
3860	109	20	m	0
3861	110	20	m	0
3862	111	20	m	0
3863	112	20	m	0
3864	113	20	m	0
3865	114	20	m	0
3866	115	20	m	0
3867	116	20	m	0
3868	117	20	m	0
3869	119	20	m	0
3870	120	20	m	0
3871	121	20	m	0
3872	122	20	m	0
3873	123	20	m	0
3874	124	20	m	0
3875	125	20	m	0
3876	127	20	m	0
3877	128	20	m	0
3878	129	20	m	0
3879	130	20	m	0
3880	131	20	m	0
3881	132	20	m	0
3882	133	20	m	0
3883	134	20	m	0
3884	135	20	m	0
3885	136	20	m	0
3886	137	20	m	0
3887	138	20	m	0
3888	139	20	m	0
3889	141	20	m	0
3890	142	20	m	0
3891	143	20	m	0
3892	144	20	m	0
3893	145	20	m	0
3894	146	20	m	0
3895	147	20	m	0
3896	148	20	m	0
3897	149	20	m	0
3898	150	20	m	0
3899	152	20	m	0
3900	153	20	m	0
3901	154	20	m	0
3902	155	20	m	0
3903	156	20	m	0
3904	157	20	m	0
3905	158	20	m	0
3906	159	20	m	0
3907	160	20	m	0
3908	161	20	m	0
3909	162	20	m	0
3910	163	20	m	0
3911	164	20	m	0
3912	165	20	m	0
3913	167	20	m	0
3914	168	20	m	0
3915	169	20	m	0
3916	170	20	m	0
3917	171	20	m	0
3918	172	20	m	0
3919	173	20	m	0
3920	174	20	m	0
3921	175	20	m	0
3922	176	20	m	0
3923	177	20	m	0
3924	178	20	m	0
3925	179	20	m	0
3926	180	20	m	0
3927	181	20	m	0
3928	182	20	m	0
3929	183	20	m	0
3930	184	20	m	0
3931	185	20	m	0
3932	186	20	m	0
3933	187	20	m	0
3934	188	20	m	0
3935	189	20	m	0
3936	190	20	m	0
3937	191	20	m	0
3938	192	20	m	0
3940	194	20	m	0
3941	196	20	m	0
3942	197	20	m	0
3943	198	20	m	0
3944	199	20	m	0
3945	200	20	m	0
3946	201	20	m	0
3947	202	20	m	0
3948	203	20	m	0
3949	204	20	m	0
3950	205	20	m	0
3951	206	20	m	0
3952	207	20	m	0
3953	208	20	m	0
3954	209	20	m	0
3955	210	20	m	0
3956	211	20	m	0
3957	212	20	m	0
3958	213	20	m	0
3959	214	20	m	0
3960	215	20	m	0
3939	193	20	x	0
4162	4	22	g	100
4240	91	22	g	100
4226	77	22	g	100
4182	26	22	g	100
4248	100	22	g	100
4191	36	22	g	100
4252	104	22	g	100
4212	60	22	g	100
4189	34	22	g	100
4174	16	22	g	100
4207	55	22	g	100
4238	89	22	g	100
4184	28	22	g	100
4225	76	22	g	100
5133	200	26	g	0
5483	152	28	g	0
4746	209	24	g	10
5851	121	30	g	10
3511	160	18	g	89.77272727272727
3480	127	18	g	98.86363636363636
3472	117	18	g	100
1929	162	10	g	100
1450	71	8	g	100
1648	71	9	g	100
2242	71	12	g	13.333333333333334
2286	120	12	g	100
3474	120	18	g	98.86363636363636
1519	147	8	g	99.94763301214914
3503	152	18	g	98.86363636363636
168	184	1	g	100
536	155	3	g	66.66666666666666
960	184	5	g	100
1950	184	10	g	100
2148	184	11	g	100
3534	184	18	g	82.95454545454545
870	87	5	g	100
749	171	4	g	99.780340472268
1662	87	9	g	100
353	171	2	g	100
551	171	3	g	100
1145	171	6	g	100
1343	171	7	g	100
1541	171	8	g	99.97905320485965
1937	171	10	g	100
2135	171	11	g	100
2333	171	12	g	77.77777777777779
3521	171	18	g	68.18181818181817
2264	96	12	g	100
3452	96	18	g	76.36363636363637
3487	134	18	g	95.45454545454545
3470	115	18	g	100
3396	33	18	g	76.13636363636364
3550	201	18	g	89.77272727272727
311	125	2	g	100
509	125	3	g	100
905	125	5	g	100
1301	125	7	g	100
3083	125	16	g	80
1394	8	8	g	99.79053204859657
3526	176	18	g	95.45454545454545
3515	164	18	g	95.45454545454545
2329	167	12	g	77.77777777777779
3517	167	18	g	92.04545454545455
1851	78	10	g	100
2049	78	11	g	100
2247	78	12	g	37.77777777777778
2214	41	12	g	22.222222222222225
2259	90	12	g	100
3433	76	18	g	100
3486	133	18	g	68.18181818181817
3501	149	18	g	84.0909090909091
711	130	4	g	100
1701	130	9	g	100
3483	130	18	g	95.45454545454545
704	122	4	g	16.666666666666664
1496	122	8	g	95.45454545454545
1694	122	9	g	100
2288	122	12	g	33.33333333333333
3476	122	18	g	88.63636363636364
2330	168	12	g	68.88888888888889
3518	168	18	g	86.36363636363636
926	148	5	g	100
1124	148	6	g	100
3500	148	18	g	40
2341	179	12	g	100
734	155	4	g	99.890170236134
1526	155	8	g	95.45454545454545
3506	155	18	g	18.181818181818183
2213	40	12	g	100
2270	102	12	g	95.55555555555554
3490	137	18	g	100
3543	193	18	g	95.45454545454545
3475	121	18	g	88.63636363636364
2296	131	12	g	100
3484	131	18	g	86.36363636363636
1935	169	10	g	100
2133	169	11	g	100
3519	169	18	g	100
1867	95	10	g	100
2321	158	12	g	13.333333333333334
2347	185	12	g	55.55555555555556
3535	185	18	g	100
3489	136	18	g	100
1715	145	9	g	100
1893	123	10	g	100
2091	123	11	g	100
2289	123	12	g	20
2343	181	12	g	20
3531	181	18	g	7.272727272727273
1493	119	8	g	100
1691	119	9	g	100
2285	119	12	g	100
3473	119	18	g	100
696	113	4	g	100
2344	182	12	g	100
3532	182	18	g	100
2336	174	12	g	95.55555555555554
767	189	4	g	96.81493684788578
2351	189	12	g	100
3464	109	18	g	2.272727272727273
3559	210	18	g	98.86363636363636
585	206	3	g	66.66666666666666
3459	103	18	g	100
843	57	5	g	100
1635	57	9	g	99.78070175438596
1833	57	10	g	100
3417	57	18	g	98.86363636363636
2272	104	12	g	100
3460	104	18	g	79.54545454545455
206	8	2	g	100
800	8	5	g	100
2239	68	12	g	68.88888888888889
1499	125	8	g	93.47826086956522
1461	84	8	g	98.02371541501978
601	7	4	g	100
1591	7	9	g	100
3411	51	18	g	95.45454545454545
3466	111	18	g	88.63636363636364
2334	172	12	g	100
625	34	4	g	100
669	84	4	g	100
1857	84	10	g	100
2055	84	11	g	100
2303	138	12	g	100
2699	138	14	g	100
3491	138	18	g	56.81818181818182
3467	112	18	g	76.13636363636364
3431	74	18	g	100
1912	144	10	g	100
2110	144	11	g	100
3496	144	18	g	86.36363636363636
3548	199	18	g	98.86363636363636
2230	58	12	g	26.666666666666668
2250	81	12	g	20
3438	81	18	g	95.45454545454545
983	208	5	g	100
1181	208	6	g	100
1973	208	10	g	100
762	184	4	g	83.33333333333334
2308	144	12	g	91.11111111111111
3436	79	18	g	96.5909090909091
2171	208	11	m	0
1414	30	8	g	99.79053204859657
1697	125	9	g	98.1359649122807
1739	171	9	g	99.67105263157895
2065	95	11	g	0
2127	162	11	g	0
3513	162	18	g	90.9090909090909
3497	145	18	g	96.5909090909091
3545	196	18	g	97.72727272727273
3557	208	18	g	95.45454545454545
2316	153	12	g	20
2232	60	12	g	100
2215	42	12	g	100
9618	127	49	m	0
9535	34	49	m	0
4249	101	22	x	0
4251	103	22	x	0
1464	87	8	g	99.79053204859657
4256	109	22	x	0
4257	110	22	x	0
4258	111	22	x	0
4259	112	22	x	0
4260	113	22	x	0
4261	114	22	x	0
4262	115	22	x	0
4263	116	22	x	0
4264	117	22	x	0
4265	119	22	x	0
4266	120	22	x	0
4267	121	22	x	0
4268	122	22	x	0
4269	123	22	x	0
4270	124	22	x	0
4271	125	22	x	0
4272	127	22	x	0
4273	128	22	x	0
4246	98	22	x	0
4274	129	22	x	0
4275	130	22	x	0
4276	131	22	x	0
4277	132	22	x	0
4278	133	22	x	0
4279	134	22	x	0
4280	135	22	x	0
4281	136	22	x	0
4282	137	22	x	0
4283	138	22	x	0
4284	139	22	x	0
4285	141	22	x	0
4286	142	22	x	0
4287	143	22	x	0
4288	144	22	x	0
4289	145	22	x	0
4290	146	22	x	0
4291	147	22	x	0
1365	193	7	g	100
4292	148	22	x	0
4293	149	22	x	0
4294	150	22	x	0
4295	152	22	x	0
4296	153	22	x	0
4297	154	22	x	0
4298	155	22	x	0
4299	156	22	x	0
4300	157	22	x	0
4301	158	22	x	0
4302	159	22	x	0
4303	160	22	x	0
4304	161	22	x	0
4305	162	22	x	0
4306	163	22	x	0
4307	164	22	x	0
4308	165	22	x	0
4309	167	22	x	0
4310	168	22	x	0
4311	169	22	x	0
4312	170	22	x	0
4313	171	22	x	0
4314	172	22	x	0
4315	173	22	x	0
4316	174	22	x	0
4317	175	22	x	0
4318	176	22	x	0
4319	177	22	x	0
4320	178	22	x	0
4321	179	22	x	0
4322	180	22	x	0
4323	181	22	x	0
4324	182	22	x	0
4325	183	22	x	0
4326	184	22	x	0
4327	185	22	x	0
4328	186	22	x	0
4329	187	22	x	0
4330	188	22	x	0
4331	189	22	x	0
4332	190	22	x	0
4333	191	22	x	0
4334	192	22	x	0
4335	193	22	x	0
4336	194	22	x	0
4337	196	22	x	0
4338	197	22	x	0
4339	198	22	x	0
4340	199	22	x	0
4342	201	22	x	0
4343	202	22	x	0
4344	203	22	x	0
4345	204	22	x	0
4346	205	22	x	0
4347	206	22	x	0
4348	207	22	x	0
4349	208	22	x	0
4350	209	22	x	0
4351	210	22	x	0
4352	211	22	x	0
4353	212	22	x	0
4354	213	22	x	0
4355	214	22	x	0
4356	215	22	x	0
4341	200	22	x	0
4244	96	22	g	100
4197	44	22	g	100
4239	90	22	g	100
4194	41	22	g	100
4179	22	22	g	100
4204	52	22	g	100
4185	29	22	g	100
4255	107	22	g	100
4178	21	22	g	100
4166	8	22	g	100
4175	17	22	g	100
4198	45	22	g	100
1599	15	9	g	99.89035087719299
4706	168	24	g	10
4942	207	25	g	10
5338	207	27	g	10
3457	101	18	g	96.5909090909091
4221	70	22	g	100
4176	18	22	g	100
9901	94	22	x	\N
9902	108	22	x	\N
9903	118	22	x	\N
9904	126	22	x	\N
9905	140	22	x	\N
9906	151	22	x	\N
9907	166	22	x	\N
9908	195	22	x	\N
4245	97	22	x	0
564	184	3	g	100
1727	158	9	g	100
609	15	4	g	100
5934	209	30	g	10
5674	144	29	m	0
5354	8	28	m	0
8826	127	45	m	0
9529	27	49	m	0
8187	78	42	m	0
8781	78	45	m	0
9177	78	47	m	0
9375	78	48	m	0
9573	78	49	m	0
9856	170	50	m	0
8733	22	45	m	0
743	164	4	g	100
835	48	5	g	100
2001	22	11	g	100
2058	87	11	m	0
2083	114	11	m	0
2131	167	11	g	80
2006	28	11	g	80
1990	10	11	m	0
2436	66	13	g	100
2463	97	13	g	100
2385	9	13	g	100
2397	22	13	g	100
2525	164	13	g	100
2526	165	13	g	100
2495	132	13	g	100
2435	65	13	g	100
2398	24	13	g	95.06172839506173
2533	173	13	g	100
2444	77	13	g	100
2409	36	13	g	100
2475	110	13	g	100
2423	53	13	g	95.86056644880175
2512	150	13	g	80
6280	157	32	g	10
6478	157	33	g	10
6676	157	34	g	10
6874	157	35	g	10
7072	157	36	g	5
2556	197	13	g	100
439	48	3	g	0
2528	168	13	g	100
2538	178	13	g	100
5278	144	27	g	10
1705	134	9	g	99.4517543859649
2449	82	13	g	100
2458	91	13	g	100
2417	46	13	g	100
2420	50	13	g	100
2550	190	13	g	100
2378	2	13	g	100
2389	13	13	g	100
2521	160	13	g	100
2523	162	13	g	100
2401	27	13	g	100
2507	145	13	g	100
2415	44	13	g	100
2555	196	13	g	56.2962962962963
2424	54	13	g	100
2441	74	13	g	100
2563	204	13	g	100
2561	202	13	g	95.86056644880175
2408	35	13	g	100
2451	84	13	g	100
2418	47	13	g	100
2541	181	13	g	100
2395	19	13	g	90.92229484386348
2551	191	13	g	100
2553	193	13	g	100
2534	174	13	g	95.86056644880175
2498	135	13	g	100
2549	189	13	g	100
2416	45	13	g	100
2404	30	13	g	100
2571	212	13	g	76.68845315904139
2574	215	13	g	100
2382	6	13	g	84.29920116194626
2393	17	13	g	100
2483	119	13	g	100
2460	93	13	g	80
2497	134	13	g	100
2552	192	13	g	100
2471	105	13	g	100
2411	40	13	g	100
2434	64	13	g	100
2494	131	13	g	100
2456	89	13	g	100
2439	70	13	g	100
2467	101	13	g	100
8543	31	44	g	20
8939	31	46	g	3.75
9137	31	47	g	5
9335	31	48	g	3
9533	31	49	g	10
9156	54	47	g	10
9019	121	46	g	5
2094	127	11	g	0
2142	178	11	g	0
2022	47	11	g	0
2026	52	11	g	0
3479	125	18	g	32.72727272727273
4547	208	23	g	10
5537	208	28	g	0
5734	207	29	g	10
5932	207	30	g	10
8537	25	44	m	0
8463	162	43	m	0
8474	174	43	g	9.838274932614556
8545	34	44	m	0
8554	45	44	g	20
8557	48	44	g	20
8470	170	43	m	0
8529	15	44	g	20
8479	179	43	m	0
8465	164	43	m	0
8517	3	44	m	0
8468	168	43	m	0
8579	74	44	m	0
8502	203	43	g	5.067385444743935
8533	19	44	m	0
8489	189	43	g	0
8542	30	44	m	0
8520	6	44	m	0
8510	211	43	m	0
8492	192	43	m	0
8560	52	44	g	20
8559	51	44	g	18
8513	214	43	m	0
8476	176	43	m	0
8563	55	44	m	0
8471	171	43	g	2.533692722371967
8550	41	44	g	18
8539	27	44	g	8
8583	78	44	g	20
8528	14	44	g	20
8565	57	44	g	20
8546	35	44	g	20
8598	93	44	g	20
8564	56	44	g	8
8551	42	44	g	20
8532	18	44	g	20
8483	183	43	g	8.436657681940702
8588	83	44	g	18
8466	165	43	p	0
8467	167	43	p	0
8469	169	43	p	0
8472	172	43	p	0
8473	173	43	p	0
8475	175	43	p	0
8477	177	43	p	0
8478	178	43	p	0
8480	180	43	p	0
8481	181	43	p	0
8482	182	43	p	0
8485	185	43	p	0
8487	187	43	p	0
8488	188	43	p	0
8490	190	43	p	0
8491	191	43	p	0
8493	193	43	p	0
8496	197	43	p	0
8497	198	43	p	0
8498	199	43	p	0
8499	200	43	p	0
8501	202	43	p	0
8503	204	43	p	0
8504	205	43	p	0
8506	207	43	p	0
8507	208	43	p	0
8508	209	43	p	0
8509	210	43	p	0
8511	212	43	p	0
8512	213	43	p	0
8514	215	43	p	0
8515	1	44	p	0
8519	5	44	p	0
8521	7	44	p	0
8522	8	44	p	0
8523	9	44	p	0
8524	10	44	p	0
8525	11	44	p	0
8526	12	44	p	0
8527	13	44	p	0
8531	17	44	p	0
8538	26	44	p	0
8540	28	44	p	0
8541	29	44	p	0
8544	33	44	p	0
8548	38	44	p	0
8549	40	44	p	0
8552	43	44	p	0
8555	46	44	p	0
8556	47	44	p	0
8558	50	44	p	0
8561	53	44	p	0
8567	59	44	p	0
8568	60	44	p	0
8569	61	44	p	0
8570	62	44	p	0
8571	63	44	p	0
8572	64	44	p	0
8574	66	44	p	0
8575	68	44	p	0
8576	69	44	p	0
8577	70	44	p	0
8578	71	44	p	0
8580	75	44	p	0
8581	76	44	p	0
8582	77	44	p	0
8584	79	44	p	0
8587	82	44	p	0
8591	86	44	p	0
8593	88	44	p	0
8594	89	44	p	0
8596	91	44	p	0
8597	92	44	p	0
8600	96	44	p	0
8484	184	43	g	0
8486	186	43	m	0
8505	206	43	g	8.032345013477089
8585	80	44	m	0
8516	2	44	g	20
8495	196	43	m	0
8500	201	43	m	0
8611	107	44	p	0
8614	111	44	p	0
8616	113	44	p	0
8640	139	44	p	0
8642	142	44	p	0
8643	143	44	p	0
8644	144	44	p	0
8650	150	44	p	0
7170	47	37	p	0
7172	50	37	p	0
7175	53	37	p	0
7181	59	37	p	0
7182	60	37	p	0
7183	61	37	p	0
7184	62	37	p	0
7185	63	37	p	0
7186	64	37	p	0
7188	66	37	p	0
7189	68	37	p	0
7190	69	37	p	0
7191	70	37	p	0
7192	71	37	p	0
7194	75	37	p	0
7195	76	37	p	0
7196	77	37	p	0
7198	79	37	p	0
7201	82	37	p	0
7205	86	37	p	0
7207	88	37	p	0
7208	89	37	p	0
7210	91	37	p	0
7211	92	37	p	0
7214	96	37	p	0
7215	97	37	p	0
7216	98	37	p	0
7217	99	37	p	0
7218	100	37	p	0
7219	101	37	p	0
7222	104	37	p	0
7223	105	37	p	0
7225	107	37	p	0
7228	111	37	p	0
7230	113	37	p	0
7231	114	37	p	0
7234	117	37	p	0
7238	122	37	p	0
7243	128	37	p	0
7244	129	37	p	0
7278	165	37	p	0
7279	167	37	p	0
7281	169	37	p	0
7284	172	37	p	0
7285	173	37	p	0
7287	175	37	p	0
7289	177	37	p	0
7213	95	37	m	0
8628	127	44	g	20
7242	127	37	m	0
8341	27	43	g	7.601078167115904
7167	44	37	g	10
7159	34	37	m	0
9771	78	50	g	10
8641	141	44	g	20
7197	78	37	m	0
7593	78	39	m	0
8646	146	44	g	18
7453	141	38	m	0
8536	24	44	g	8
7142	14	37	m	0
7179	57	37	m	0
7200	81	37	m	0
8586	81	44	m	0
7176	54	37	m	0
8562	54	44	m	0
8547	36	44	g	20
7226	109	37	m	0
8494	194	43	m	0
7149	22	37	m	0
8535	22	44	m	0
7131	3	37	m	0
7150	24	37	m	0
7227	110	37	g	10
7161	36	37	m	0
7233	116	37	g	10
7236	120	37	m	0
8622	120	44	m	0
8634	133	44	m	0
8619	116	44	g	18
7241	125	37	m	0
8627	125	44	m	0
7193	74	37	m	0
7160	35	37	m	0
7203	84	37	g	10
8589	84	44	g	20
7212	93	37	g	10
8610	106	44	g	20
7147	19	37	m	0
7156	30	37	m	0
8647	147	44	m	0
7134	6	37	m	0
7178	56	37	g	10
7246	131	37	m	0
7224	106	37	m	0
8530	16	44	g	18
8606	102	44	g	18
7165	42	37	m	0
7144	16	37	m	0
8635	134	44	g	20
7204	85	37	m	0
8590	85	44	m	0
7220	102	37	m	0
7239	123	37	m	0
7148	21	37	m	0
8534	21	44	m	0
7206	87	37	m	0
8592	87	44	m	0
7132	4	37	m	0
8518	4	44	m	0
7180	58	37	m	0
8566	58	44	m	0
7209	90	37	m	0
8595	90	44	m	0
7177	55	37	m	0
7146	18	37	m	0
7237	121	37	m	0
8623	121	44	m	0
7240	124	37	m	0
7157	31	37	g	10
7202	83	37	m	0
7232	115	37	g	10
7245	130	37	m	0
7187	65	37	m	0
8573	65	44	g	20
7272	159	37	g	0
7271	158	37	m	0
7286	174	37	g	10
7276	163	37	m	0
7235	119	37	m	0
7171	48	37	m	0
8649	149	44	m	0
7174	52	37	m	0
7229	112	37	m	0
7173	51	37	m	0
7283	171	37	m	0
7221	103	37	m	0
7199	80	37	m	0
8639	138	44	g	20
7290	178	37	p	0
7292	180	37	p	0
7293	181	37	p	0
7294	182	37	p	0
7297	185	37	p	0
7299	187	37	p	0
7300	188	37	p	0
7302	190	37	p	0
7303	191	37	p	0
7305	193	37	p	0
7308	197	37	p	0
7309	198	37	p	0
7310	199	37	p	0
7311	200	37	p	0
7313	202	37	p	0
7315	204	37	p	0
7316	205	37	p	0
7318	207	37	p	0
7319	208	37	p	0
7320	209	37	p	0
7321	210	37	p	0
7323	212	37	p	0
7324	213	37	p	0
7326	215	37	p	0
7327	1	38	p	0
7331	5	38	p	0
7333	7	38	p	0
7334	8	38	p	0
7335	9	38	p	0
7336	10	38	p	0
7337	11	38	p	0
7338	12	38	p	0
7339	13	38	p	0
7343	17	38	p	0
7350	26	38	p	0
7352	28	38	p	0
7353	29	38	p	0
7405	88	38	p	0
7406	89	38	p	0
7408	91	38	p	0
7409	92	38	p	0
7412	96	38	p	0
7413	97	38	p	0
7414	98	38	p	0
7415	99	38	p	0
7416	100	38	p	0
7417	101	38	p	0
7420	104	38	p	0
7421	105	38	p	0
7423	107	38	p	0
7426	111	38	p	0
7428	113	38	p	0
7429	114	38	p	0
7432	117	38	p	0
7436	122	38	p	0
7441	128	38	p	0
7442	129	38	p	0
7448	135	38	p	0
7449	136	38	p	0
7450	137	38	p	0
7452	139	38	p	0
7511	202	38	p	0
7513	204	38	p	0
7411	95	38	m	0
7273	160	37	g	10
7365	44	38	g	10
7425	110	38	g	10
7275	162	37	m	0
7473	162	38	m	0
7259	145	37	m	0
7457	145	38	m	0
7357	34	38	m	0
7431	116	38	g	10
7395	78	38	m	0
7255	141	37	m	0
7340	14	38	m	0
7282	170	37	m	0
7377	57	38	m	0
7398	81	38	m	0
7374	54	38	m	0
7260	146	37	m	0
7458	146	38	m	0
7424	109	38	m	0
7306	194	37	m	0
7504	194	38	m	0
7347	22	38	m	0
7277	164	37	m	0
7475	164	38	m	0
7329	3	38	m	0
7348	24	38	m	0
7359	36	38	m	0
7434	120	38	m	0
7248	133	37	m	0
7401	84	38	g	10
7439	125	38	m	0
7280	168	37	m	0
7478	168	38	m	0
7391	74	38	m	0
7358	35	38	m	0
7301	189	37	g	10
7410	93	38	g	10
7345	19	38	g	0
7376	56	38	g	10
7354	30	38	m	0
7261	147	37	m	0
7332	6	38	m	0
7344	18	38	g	1
7304	192	37	m	0
7444	131	38	m	0
7422	106	38	m	0
7437	123	38	m	0
7363	42	38	m	0
7325	214	37	m	0
7288	176	37	m	0
7342	16	38	m	0
7402	85	38	m	0
7268	155	37	m	0
7274	161	37	m	0
7418	102	38	m	0
7346	21	38	m	0
7404	87	38	m	0
7330	4	38	m	0
7378	58	38	m	0
7407	90	38	m	0
7438	124	38	m	0
7435	121	38	m	0
7249	134	37	m	0
7440	127	38	g	10
7471	160	38	g	10
7295	183	37	m	0
7430	115	38	g	10
7296	184	37	g	0
7298	186	37	m	0
7307	196	37	g	10
7317	206	37	g	10
7349	25	38	m	0
7443	130	38	m	0
7445	132	38	g	10
7385	65	38	m	0
7433	119	38	m	0
7341	15	38	m	0
7314	203	37	m	0
7322	211	37	m	0
7427	112	38	m	0
7419	103	38	m	0
7451	138	38	g	10
7328	2	38	g	10
7312	201	37	g	10
7521	212	38	p	0
7522	213	38	p	0
7524	215	38	p	0
7525	1	39	p	0
7529	5	39	p	0
7531	7	39	p	0
7532	8	39	p	0
7533	9	39	p	0
7534	10	39	p	0
7535	11	39	p	0
7536	12	39	p	0
7537	13	39	p	0
7541	17	39	p	0
7548	26	39	p	0
7550	28	39	p	0
7551	29	39	p	0
7554	33	39	p	0
7558	38	39	p	0
7559	40	39	p	0
7562	43	39	p	0
7565	46	39	p	0
7566	47	39	p	0
7568	50	39	p	0
7571	53	39	p	0
7577	59	39	p	0
7578	60	39	p	0
7579	61	39	p	0
7580	62	39	p	0
7581	63	39	p	0
7582	64	39	p	0
7584	66	39	p	0
7585	68	39	p	0
7586	69	39	p	0
7587	70	39	p	0
7588	71	39	p	0
7590	75	39	p	0
7591	76	39	p	0
7592	77	39	p	0
7594	79	39	p	0
7597	82	39	p	0
7601	86	39	p	0
7603	88	39	p	0
7604	89	39	p	0
7606	91	39	p	0
7607	92	39	p	0
7610	96	39	p	0
7611	97	39	p	0
7612	98	39	p	0
7613	99	39	p	0
7614	100	39	p	0
7615	101	39	p	0
7618	104	39	p	0
7619	105	39	p	0
7621	107	39	p	0
7624	111	39	p	0
7626	113	39	p	0
7627	114	39	p	0
7630	117	39	p	0
7634	122	39	p	0
7639	128	39	p	0
7640	129	39	p	0
7646	135	39	p	0
7647	136	39	p	0
7648	137	39	p	0
7650	139	39	p	0
7662	153	39	p	0
7663	154	39	p	0
7665	156	39	p	0
7666	157	39	p	0
7674	165	39	p	0
7675	167	39	p	0
7677	169	39	p	0
7680	172	39	p	0
7681	173	39	p	0
7683	175	39	p	0
7685	177	39	p	0
7686	178	39	p	0
7688	180	39	p	0
7689	181	39	p	0
7690	182	39	p	0
7693	185	39	p	0
7695	187	39	p	0
7609	95	39	m	0
7555	34	39	g	10
7623	110	39	g	10
7563	44	39	g	0
7651	141	39	m	0
7538	14	39	m	0
7575	57	39	m	0
7596	81	39	m	0
7572	54	39	m	0
7622	109	39	m	0
7545	22	39	m	0
7527	3	39	m	0
7546	24	39	m	0
7632	120	39	m	0
7644	133	39	m	0
7629	116	39	g	10
7637	125	39	m	0
7589	74	39	m	0
7556	35	39	m	0
7599	84	39	g	10
7608	93	39	g	10
7543	19	39	m	0
7552	30	39	m	0
7530	6	39	m	0
7574	56	39	g	10
7642	131	39	m	0
7620	106	39	m	0
7466	155	38	g	10
7561	42	39	m	0
7523	214	38	m	0
7486	176	38	m	0
7540	16	39	m	0
7600	85	39	m	0
7645	134	39	g	10
7472	161	38	m	0
7616	102	39	m	0
7544	21	39	m	0
7528	4	39	m	0
7605	90	39	m	0
7573	55	39	m	0
7542	18	39	g	0
7633	121	39	m	0
7635	123	39	m	0
7549	27	39	g	1
7636	124	39	m	0
7691	183	39	m	0
7598	83	39	m	0
7628	115	39	g	10
7692	184	39	g	10
7547	25	39	g	10
7641	130	39	m	0
7643	132	39	g	10
7583	65	39	m	0
7668	159	39	m	0
7667	158	39	m	0
7682	174	39	g	10
7564	45	39	m	0
7672	163	39	m	0
7631	119	39	m	0
7567	48	39	m	0
7539	15	39	m	0
7625	112	39	m	0
7569	51	39	g	10
7679	171	39	g	0
7617	103	39	m	0
7595	80	39	m	0
7649	138	39	g	10
7526	2	39	g	10
7696	188	39	p	0
7698	190	39	p	0
7699	191	39	p	0
7701	193	39	p	0
7704	197	39	p	0
7705	198	39	p	0
7706	199	39	p	0
7707	200	39	p	0
7709	202	39	p	0
7711	204	39	p	0
7712	205	39	p	0
7714	207	39	p	0
7715	208	39	p	0
7716	209	39	p	0
7717	210	39	p	0
7719	212	39	p	0
7720	213	39	p	0
7722	215	39	p	0
7723	1	40	p	0
7727	5	40	p	0
7729	7	40	p	0
7730	8	40	p	0
7731	9	40	p	0
7732	10	40	p	0
7733	11	40	p	0
7734	12	40	p	0
7735	13	40	p	0
7739	17	40	p	0
7746	26	40	p	0
7748	28	40	p	0
7749	29	40	p	0
7752	33	40	p	0
7756	38	40	p	0
7757	40	40	p	0
7760	43	40	p	0
7763	46	40	p	0
7764	47	40	p	0
7766	50	40	p	0
7769	53	40	p	0
7775	59	40	p	0
7776	60	40	p	0
7777	61	40	p	0
7778	62	40	p	0
7779	63	40	p	0
7780	64	40	p	0
7782	66	40	p	0
7783	68	40	p	0
7784	69	40	p	0
7785	70	40	p	0
7786	71	40	p	0
7788	75	40	p	0
7789	76	40	p	0
7790	77	40	p	0
7792	79	40	p	0
7810	98	40	p	0
7811	99	40	p	0
7812	100	40	p	0
7813	101	40	p	0
7816	104	40	p	0
7817	105	40	p	0
7819	107	40	p	0
7822	111	40	p	0
7824	113	40	p	0
7825	114	40	p	0
7828	117	40	p	0
7832	122	40	p	0
7837	128	40	p	0
7838	129	40	p	0
7844	135	40	p	0
7845	136	40	p	0
7846	137	40	p	0
7848	139	40	p	0
7850	142	40	p	0
7851	143	40	p	0
7852	144	40	p	0
7858	150	40	p	0
7860	153	40	p	0
7861	154	40	p	0
7863	156	40	p	0
7864	157	40	p	0
7872	165	40	p	0
7873	167	40	p	0
7875	169	40	p	0
7878	172	40	p	0
7879	173	40	p	0
7881	175	40	p	0
7883	177	40	p	0
7658	148	39	g	0
7671	162	39	m	0
7761	44	40	g	10
7655	145	39	m	0
7678	170	39	g	10
7697	189	39	g	10
7736	14	40	m	0
7728	6	40	g	10
7770	54	40	m	0
7656	146	39	m	0
7687	179	39	m	0
7702	194	39	m	0
7743	22	40	m	0
7725	3	40	m	0
7744	24	40	m	0
7755	36	40	m	0
7676	168	39	m	0
7787	74	40	m	0
7754	35	40	m	0
7741	19	40	m	0
7742	21	40	g	10
7750	30	40	m	0
7657	147	39	m	0
7833	123	40	m	0
7700	192	39	m	0
7759	42	40	m	0
7721	214	39	m	0
7684	176	39	m	0
7738	16	40	m	0
7664	155	39	m	0
7670	161	39	m	0
7834	124	40	m	0
7726	4	40	m	0
7774	58	40	m	0
7771	55	40	m	0
7740	18	40	m	0
7747	27	40	g	10
7826	115	40	g	10
7703	196	39	m	0
7713	206	39	g	10
7745	25	40	g	10
7839	130	40	m	0
7841	132	40	g	10
7781	65	40	g	10
7866	159	40	m	0
7865	158	40	m	0
7880	174	40	g	10
7762	45	40	m	0
7870	163	40	g	10
7765	48	40	g	10
7737	15	40	m	0
7710	203	39	m	0
7718	211	39	g	10
7857	149	40	m	0
7768	52	40	g	10
7823	112	40	m	0
7767	51	40	m	0
7877	171	40	g	0
7815	103	40	g	10
7793	80	40	m	0
7859	152	40	g	10
7724	2	40	g	10
7708	201	39	g	10
7884	178	40	p	0
7886	180	40	p	0
7887	181	40	p	0
7888	182	40	p	0
7891	185	40	p	0
7893	187	40	p	0
7894	188	40	p	0
7896	190	40	p	0
7897	191	40	p	0
7899	193	40	p	0
7902	197	40	p	0
7903	198	40	p	0
7904	199	40	p	0
7905	200	40	p	0
7907	202	40	p	0
7909	204	40	p	0
7910	205	40	p	0
7912	207	40	p	0
7913	208	40	p	0
7914	209	40	p	0
7915	210	40	p	0
7917	212	40	p	0
7918	213	40	p	0
7920	215	40	p	0
7921	1	41	p	0
7925	5	41	p	0
7927	7	41	p	0
7928	8	41	p	0
7929	9	41	p	0
7930	10	41	p	0
7931	11	41	p	0
7932	12	41	p	0
7933	13	41	p	0
7962	47	41	p	0
7964	50	41	p	0
7967	53	41	p	0
7973	59	41	p	0
7974	60	41	p	0
7975	61	41	p	0
7976	62	41	p	0
7977	63	41	p	0
7978	64	41	p	0
7980	66	41	p	0
7981	68	41	p	0
7982	69	41	p	0
7983	70	41	p	0
7984	71	41	p	0
7986	75	41	p	0
7987	76	41	p	0
7988	77	41	p	0
7990	79	41	p	0
7993	82	41	p	0
7997	86	41	p	0
7999	88	41	p	0
8000	89	41	p	0
8002	91	41	p	0
8003	92	41	p	0
8006	96	41	p	0
8007	97	41	p	0
8008	98	41	p	0
8009	99	41	p	0
8010	100	41	p	0
8011	101	41	p	0
8014	104	41	p	0
8015	105	41	p	0
8017	107	41	p	0
8020	111	41	p	0
8022	113	41	p	0
8023	114	41	p	0
8026	117	41	p	0
8030	122	41	p	0
8035	128	41	p	0
8036	129	41	p	0
8042	135	41	p	0
8043	136	41	p	0
8044	137	41	p	0
8046	139	41	p	0
8048	142	41	p	0
8049	143	41	p	0
8050	144	41	p	0
8056	150	41	p	0
8058	153	41	p	0
8059	154	41	p	0
8061	156	41	p	0
8062	157	41	p	0
8070	165	41	p	0
8071	167	41	p	0
8073	169	41	p	0
7856	148	40	g	0
7836	127	40	m	0
7869	162	40	g	10
7853	145	40	g	10
7876	170	40	g	10
7934	14	41	m	0
7821	110	40	g	10
7794	81	40	m	0
7968	54	41	m	0
7854	146	40	m	0
7820	109	40	m	0
7900	194	40	m	0
7871	164	40	m	0
7830	120	40	m	0
7842	133	40	m	0
7835	125	40	g	10
7874	168	40	g	10
7827	116	40	g	10
7797	84	40	g	10
7895	189	40	g	10
7926	6	41	g	10
7855	147	40	m	0
7806	93	40	g	10
7924	4	41	g	5
7898	192	40	m	0
7818	106	40	m	0
7919	214	40	m	0
7882	176	40	m	0
7798	85	40	m	0
7862	155	40	m	0
7868	161	40	m	0
7814	102	40	m	0
7800	87	40	m	0
7843	134	40	g	10
7803	90	40	m	0
7831	121	40	m	0
8031	123	41	g	10
8032	124	41	m	0
7889	183	40	m	0
7994	83	41	m	0
8024	115	41	g	5
7890	184	40	m	0
7892	186	40	g	10
7901	196	40	m	0
7911	206	40	g	10
8037	130	41	m	0
8039	132	41	g	10
8064	159	41	g	5
8063	158	41	g	10
8027	119	41	m	0
7963	48	41	m	0
7908	203	40	m	0
7916	211	40	g	10
8055	149	41	m	0
7966	52	41	g	0
8021	112	41	m	0
7965	51	41	g	10
8013	103	41	m	0
7991	80	41	g	0
8057	152	41	m	0
8045	138	41	g	10
7906	201	40	g	10
8089	185	41	p	0
8091	187	41	p	0
8092	188	41	p	0
8094	190	41	p	0
8095	191	41	p	0
8097	193	41	p	0
8100	197	41	p	0
8101	198	41	p	0
8102	199	41	p	0
8103	200	41	p	0
8105	202	41	p	0
8107	204	41	p	0
8108	205	41	p	0
8110	207	41	p	0
8111	208	41	p	0
8112	209	41	p	0
8113	210	41	p	0
8115	212	41	p	0
8116	213	41	p	0
8118	215	41	p	0
8119	1	42	p	0
8123	5	42	p	0
8125	7	42	p	0
8126	8	42	p	0
8127	9	42	p	0
8128	10	42	p	0
8129	11	42	p	0
8130	12	42	p	0
8131	13	42	p	0
8135	17	42	p	0
8142	26	42	p	0
8144	28	42	p	0
8145	29	42	p	0
8148	33	42	p	0
8152	38	42	p	0
8153	40	42	p	0
8156	43	42	p	0
8159	46	42	p	0
8160	47	42	p	0
8162	50	42	p	0
8165	53	42	p	0
8171	59	42	p	0
8172	60	42	p	0
8173	61	42	p	0
8174	62	42	p	0
8175	63	42	p	0
8176	64	42	p	0
8178	66	42	p	0
8179	68	42	p	0
8180	69	42	p	0
8181	70	42	p	0
8182	71	42	p	0
8184	75	42	p	0
8185	76	42	p	0
8186	77	42	p	0
8188	79	42	p	0
8191	82	42	p	0
8195	86	42	p	0
8197	88	42	p	0
8198	89	42	p	0
8200	91	42	p	0
8201	92	42	p	0
8204	96	42	p	0
8205	97	42	p	0
8206	98	42	p	0
8207	99	42	p	0
8208	100	42	p	0
8209	101	42	p	0
8212	104	42	p	0
8213	105	42	p	0
8215	107	42	p	0
8065	160	41	g	10
8018	109	41	g	10
8067	162	41	m	0
7945	27	41	m	0
8051	145	41	m	0
7951	34	41	m	0
8149	34	42	g	0
7959	44	41	g	0
8157	44	42	g	0
8047	141	41	m	0
8074	170	41	m	0
7971	57	41	m	0
8169	57	42	m	0
7992	81	41	m	0
8166	54	42	m	0
8052	146	41	m	0
8083	179	41	g	10
7941	22	41	g	10
7953	36	41	g	5
8069	164	41	m	0
8121	3	42	m	0
7942	24	41	m	0
8019	110	41	g	5
8028	120	41	m	0
8040	133	41	m	0
8025	116	41	g	5
8033	125	41	m	0
8072	168	41	m	0
7985	74	41	m	0
7952	35	41	m	0
8150	35	42	m	0
7995	84	41	g	10
7948	30	41	g	5
8124	6	42	g	10
7939	19	41	m	0
8093	189	41	g	0
8004	93	41	g	10
8053	147	41	m	0
7970	56	41	g	10
8168	56	42	g	10
8038	131	41	m	0
8016	106	41	m	0
7936	16	41	g	10
7940	21	41	g	10
7957	42	41	m	0
8155	42	42	m	0
8117	214	41	m	0
8080	176	41	m	0
7938	18	41	g	5
7996	85	41	m	0
8060	155	41	m	0
8012	102	41	m	0
8192	83	42	g	10
7998	87	41	m	0
7972	58	41	m	0
8001	90	41	m	0
7969	55	41	m	0
8167	55	42	m	0
8090	186	41	m	0
8136	18	42	m	0
8029	121	41	m	0
8041	134	41	m	0
8054	148	41	g	10
8099	196	41	g	10
8109	206	41	g	10
8141	25	42	g	10
7979	65	41	m	0
8158	45	42	m	0
8161	48	42	m	0
8133	15	42	m	0
8106	203	41	m	0
8114	211	41	m	0
8164	52	42	g	0
8163	51	42	m	0
8211	103	42	g	0
8189	80	42	m	0
8120	2	42	g	10
8104	201	41	g	5
8244	139	42	p	0
8246	142	42	p	0
8247	143	42	p	0
8248	144	42	p	0
8254	150	42	p	0
8256	153	42	p	0
8257	154	42	p	0
8259	156	42	p	0
8260	157	42	p	0
8268	165	42	p	0
8269	167	42	p	0
8271	169	42	p	0
8274	172	42	p	0
8275	173	42	p	0
8277	175	42	p	0
8279	177	42	p	0
8280	178	42	p	0
8282	180	42	p	0
8283	181	42	p	0
8284	182	42	p	0
8287	185	42	p	0
8289	187	42	p	0
8290	188	42	p	0
8292	190	42	p	0
8293	191	42	p	0
8295	193	42	p	0
8298	197	42	p	0
8299	198	42	p	0
8300	199	42	p	0
8301	200	42	p	0
8303	202	42	p	0
8305	204	42	p	0
8306	205	42	p	0
8308	207	42	p	0
8309	208	42	p	0
8310	209	42	p	0
8311	210	42	p	0
8313	212	42	p	0
8314	213	42	p	0
8316	215	42	p	0
8317	1	43	p	0
8321	5	43	p	0
8323	7	43	p	0
8324	8	43	p	0
8325	9	43	p	0
8326	10	43	p	0
8327	11	43	p	0
8328	12	43	p	0
8329	13	43	p	0
8333	17	43	p	0
8340	26	43	p	0
8373	63	43	p	0
8374	64	43	p	0
8376	66	43	p	0
8377	68	43	p	0
8378	69	43	p	0
8379	70	43	p	0
8380	71	43	p	0
8382	75	43	p	0
8383	76	43	p	0
8384	77	43	p	0
8386	79	43	p	0
8389	82	43	p	0
8393	86	43	p	0
8395	88	43	p	0
8396	89	43	p	0
8398	91	43	p	0
8399	92	43	p	0
8402	96	43	p	0
8403	97	43	p	0
8404	98	43	p	0
8405	99	43	p	0
8406	100	43	p	0
8407	101	43	p	0
8410	104	43	p	0
8411	105	43	p	0
8203	95	42	m	0
8252	148	42	g	0
8355	44	43	g	6.603773584905661
8263	160	42	g	0
8265	162	42	m	0
8249	145	42	m	0
8347	34	43	m	0
8338	24	43	g	7.520215633423181
8245	141	42	m	0
8132	14	42	m	0
8330	14	43	m	0
8272	170	42	g	0
8190	81	42	m	0
8250	146	42	m	0
8281	179	42	m	0
8098	194	41	g	0
8139	22	42	m	0
8337	22	43	m	0
8267	164	42	m	0
8319	3	43	m	0
8151	36	42	g	10
8238	133	42	g	10
8226	120	42	m	0
8231	125	42	g	2.5
8217	110	42	m	0
8223	116	42	g	7.5
8270	168	42	m	0
8315	214	42	g	10
8335	19	43	m	0
8291	189	42	m	0
8146	30	42	m	0
8251	147	42	m	0
8322	6	43	m	0
8096	192	41	m	0
8236	131	42	m	0
8214	106	42	m	0
8320	4	43	g	10
8278	176	42	g	0
8134	16	42	m	0
8194	85	42	m	0
8258	155	42	m	0
8264	161	42	m	0
8210	102	42	g	0
8138	21	42	m	0
8336	21	43	m	0
8122	4	42	m	0
8199	90	42	g	10
8170	58	42	m	0
8285	183	42	g	0
8334	18	43	m	0
8227	121	42	m	0
8239	134	42	g	0
8232	127	42	g	10
8390	83	43	m	0
8286	184	42	m	0
8288	186	42	m	0
8302	201	42	g	5
8307	206	42	g	10
8339	25	43	g	7.520215633423181
8177	65	42	m	0
8262	159	42	m	0
8276	174	42	g	10
8266	163	42	g	0
8331	15	43	g	7.331536388140162
8304	203	42	g	0
8312	211	42	m	0
8253	149	42	m	0
8273	171	42	g	0
8409	103	43	m	0
8387	80	43	m	0
8255	152	42	g	0
8243	138	42	g	10
8318	2	43	g	10
8431	128	43	p	0
8432	129	43	p	0
8438	135	43	p	0
8439	136	43	p	0
8440	137	43	p	0
8442	139	43	p	0
8444	142	43	p	0
8445	143	43	p	0
8446	144	43	p	0
8452	150	43	p	0
8454	153	43	p	0
8455	154	43	p	0
8457	156	43	p	0
8458	157	43	p	0
8652	153	44	p	0
8653	154	44	p	0
8655	156	44	p	0
8656	157	44	p	0
8664	165	44	p	0
8665	167	44	p	0
8667	169	44	p	0
8670	172	44	p	0
8671	173	44	p	0
8673	175	44	p	0
8675	177	44	p	0
8676	178	44	p	0
8678	180	44	p	0
8679	181	44	p	0
8680	182	44	p	0
8683	185	44	p	0
8685	187	44	p	0
8686	188	44	p	0
8688	190	44	p	0
8689	191	44	p	0
8691	193	44	p	0
8694	197	44	p	0
8695	198	44	p	0
8696	199	44	p	0
8697	200	44	p	0
8699	202	44	p	0
8701	204	44	p	0
8702	205	44	p	0
8704	207	44	p	0
8705	208	44	p	0
8706	209	44	p	0
8707	210	44	p	0
8709	212	44	p	0
8710	213	44	p	0
8712	215	44	p	0
8713	1	45	p	0
8717	5	45	p	0
8719	7	45	p	0
8720	8	45	p	0
8721	9	45	p	0
8722	10	45	p	0
8723	11	45	p	0
8724	12	45	p	0
8725	13	45	p	0
8729	17	45	p	0
8736	26	45	p	0
8738	28	45	p	0
8739	29	45	p	0
8742	33	45	p	0
8746	38	45	p	0
8747	40	45	p	0
8750	43	45	p	0
8753	46	45	p	0
8754	47	45	p	0
8756	50	45	p	0
8759	53	45	p	0
8765	59	45	p	0
8766	60	45	p	0
8767	61	45	p	0
8768	62	45	p	0
8769	63	45	p	0
8770	64	45	p	0
8772	66	45	p	0
8773	68	45	p	0
8774	69	45	p	0
8775	70	45	p	0
8776	71	45	p	0
8778	75	45	p	0
8779	76	45	p	0
8780	77	45	p	0
8782	79	45	p	0
8785	82	45	p	0
8789	86	45	p	0
8791	88	45	p	0
8792	89	45	p	0
8794	91	45	p	0
8795	92	45	p	0
8798	96	45	p	0
8799	97	45	p	0
8800	98	45	p	0
8801	99	45	p	0
8802	100	45	p	0
8803	101	45	p	0
8391	84	43	g	7.169811320754716
8385	78	43	m	0
8367	57	43	m	0
8388	81	43	m	0
8364	54	43	m	0
8448	146	43	m	0
8349	36	43	m	0
8436	133	43	m	0
8429	125	43	m	0
8381	74	43	m	0
8348	35	43	m	0
8400	93	43	g	4.905660377358491
8344	30	43	m	0
8366	56	43	g	7.520215633423181
8434	131	43	m	0
8353	42	43	g	1.0242587601078168
8427	123	43	m	0
8392	85	43	m	0
8456	155	43	m	0
8408	102	43	m	0
8394	87	43	m	0
8368	58	43	m	0
8397	90	43	m	0
8365	55	43	m	0
8425	121	43	m	0
8430	127	43	g	7.520215633423181
8428	124	43	m	0
8681	183	44	m	0
8786	83	45	m	0
8682	184	44	g	18
8684	186	44	m	0
8703	206	44	g	10
8735	25	45	m	0
8433	130	43	m	0
8693	196	44	m	0
8460	159	43	m	0
8459	158	43	g	10
8672	174	44	g	20
8752	45	45	g	10
8662	163	44	g	18
8755	48	45	m	0
8727	15	45	m	0
8700	203	44	g	10
8708	211	44	m	0
8451	149	43	m	0
8758	52	45	m	0
8757	51	45	m	0
8669	171	44	g	10
8783	80	45	g	5
8453	152	43	m	0
8441	138	43	g	7.358490566037737
8714	2	45	g	5
8698	201	44	g	20
8435	132	43	m	0
8806	104	45	p	0
8807	105	45	p	0
8814	113	45	p	0
8815	114	45	p	0
8818	117	45	p	0
8822	122	45	p	0
8827	128	45	p	0
8828	129	45	p	0
8834	135	45	p	0
8835	136	45	p	0
8836	137	45	p	0
8838	139	45	p	0
8840	142	45	p	0
8841	143	45	p	0
8842	144	45	p	0
8848	150	45	p	0
8850	153	45	p	0
8851	154	45	p	0
8853	156	45	p	0
8854	157	45	p	0
8862	165	45	p	0
8863	167	45	p	0
8865	169	45	p	0
8868	172	45	p	0
8869	173	45	p	0
8871	175	45	p	0
8873	177	45	p	0
8874	178	45	p	0
8876	180	45	p	0
8877	181	45	p	0
8878	182	45	p	0
8881	185	45	p	0
8883	187	45	p	0
8884	188	45	p	0
8886	190	45	p	0
8887	191	45	p	0
8889	193	45	p	0
8892	197	45	p	0
8893	198	45	p	0
8894	199	45	p	0
8895	200	45	p	0
8897	202	45	p	0
8899	204	45	p	0
8900	205	45	p	0
8902	207	45	p	0
8903	208	45	p	0
8904	209	45	p	0
8905	210	45	p	0
8907	212	45	p	0
8908	213	45	p	0
8910	215	45	p	0
8911	1	46	p	0
8915	5	46	p	0
8917	7	46	p	0
8918	8	46	p	0
8919	9	46	p	0
8920	10	46	p	0
8921	11	46	p	0
8922	12	46	p	0
8923	13	46	p	0
8927	17	46	p	0
8934	26	46	p	0
8936	28	46	p	0
8937	29	46	p	0
8940	33	46	p	0
8944	38	46	p	0
8945	40	46	p	0
8948	43	46	p	0
8951	46	46	p	0
8952	47	46	p	0
8954	50	46	p	0
8957	53	46	p	0
8963	59	46	p	0
8964	60	46	p	0
8797	95	45	m	0
8751	44	45	g	10
8737	27	45	m	0
8743	34	45	m	0
8913	3	46	g	3.75
8726	14	45	m	0
8668	170	44	m	0
8763	57	45	m	0
8784	81	45	m	0
8760	54	45	m	0
8810	109	45	m	0
8677	179	44	m	0
8692	194	44	m	0
8663	164	44	m	0
8715	3	45	m	0
8666	168	44	g	20
8734	24	45	m	0
8745	36	45	m	0
8942	35	46	g	5
8777	74	45	m	0
8744	35	45	m	0
8687	189	44	g	18
8787	84	45	m	0
8731	19	45	m	0
8938	30	46	g	3.75
8740	30	45	m	0
8796	93	45	g	10
8845	147	45	m	0
8718	6	45	m	0
8762	56	45	g	10
8690	192	44	m	0
8830	131	45	m	0
8674	176	44	g	20
8749	42	45	m	0
8654	155	44	g	20
8728	16	45	m	0
8788	85	45	m	0
8730	18	45	g	10
8660	161	44	m	0
8804	102	45	m	0
8732	21	45	m	0
8790	87	45	m	0
8716	4	45	m	0
8764	58	45	m	0
8793	90	45	m	0
8761	55	45	m	0
8823	123	45	m	0
8661	162	44	g	20
8824	124	45	m	0
8816	115	45	g	10
8880	184	45	g	5
8882	186	45	g	10
8891	196	45	g	10
8901	206	45	g	10
8933	25	46	m	0
8829	130	45	m	0
8896	201	45	m	0
8856	159	45	g	5
8855	158	45	m	0
8870	174	45	g	10
8950	45	46	m	0
8819	119	45	m	0
8953	48	46	m	0
8925	15	46	g	5
8898	203	45	m	0
8906	211	45	m	0
8847	149	45	m	0
8956	52	46	g	5
8813	112	45	m	0
8955	51	46	g	5
8867	171	45	m	0
8805	103	45	m	0
8849	152	45	m	0
8912	2	46	g	2.5
8831	132	45	m	0
8966	62	46	p	0
8967	63	46	p	0
8968	64	46	p	0
8970	66	46	p	0
8971	68	46	p	0
8972	69	46	p	0
8973	70	46	p	0
8974	71	46	p	0
8976	75	46	p	0
8977	76	46	p	0
8978	77	46	p	0
8980	79	46	p	0
8983	82	46	p	0
8987	86	46	p	0
8989	88	46	p	0
8990	89	46	p	0
8992	91	46	p	0
8993	92	46	p	0
8996	96	46	p	0
8997	97	46	p	0
8998	98	46	p	0
8999	99	46	p	0
9000	100	46	p	0
9001	101	46	p	0
9004	104	46	p	0
9005	105	46	p	0
9007	107	46	p	0
9010	111	46	p	0
9012	113	46	p	0
9013	114	46	p	0
9016	117	46	p	0
9020	122	46	p	0
9025	128	46	p	0
9026	129	46	p	0
9032	135	46	p	0
9033	136	46	p	0
9034	137	46	p	0
9036	139	46	p	0
9038	142	46	p	0
9039	143	46	p	0
9040	144	46	p	0
9046	150	46	p	0
9048	153	46	p	0
9049	154	46	p	0
9051	156	46	p	0
9052	157	46	p	0
9060	165	46	p	0
9061	167	46	p	0
9063	169	46	p	0
9066	172	46	p	0
9067	173	46	p	0
9069	175	46	p	0
9071	177	46	p	0
9072	178	46	p	0
9074	180	46	p	0
9075	181	46	p	0
9076	182	46	p	0
9079	185	46	p	0
9081	187	46	p	0
9082	188	46	p	0
9084	190	46	p	0
9085	191	46	p	0
9087	193	46	p	0
9090	197	46	p	0
9091	198	46	p	0
9092	199	46	p	0
9093	200	46	p	0
9095	202	46	p	0
9097	204	46	p	0
9098	205	46	p	0
9100	207	46	p	0
9101	208	46	p	0
9102	209	46	p	0
9103	210	46	p	0
9105	212	46	p	0
9106	213	46	p	0
9108	215	46	p	0
9109	1	47	p	0
9113	5	47	p	0
9115	7	47	p	0
9116	8	47	p	0
9117	9	47	p	0
9118	10	47	p	0
9119	11	47	p	0
9120	12	47	p	0
9121	13	47	p	0
8846	148	45	m	0
8859	162	45	m	0
8941	34	46	g	5
8843	145	45	m	0
8949	44	46	g	2.5
8961	57	46	g	5
8866	170	45	m	0
8931	22	46	g	5
8958	54	46	m	0
8844	146	45	m	0
8875	179	45	m	0
8890	194	45	m	0
8932	24	46	g	2.5
9111	3	47	m	0
8975	74	46	g	5
8943	36	46	m	0
8820	120	45	m	0
8832	133	45	m	0
8811	110	45	m	0
8825	125	45	m	0
8864	168	45	m	0
8817	116	45	g	10
9043	147	46	g	5
8929	19	46	g	0
8916	6	46	g	2.5
8947	42	46	g	5
8888	192	45	m	0
8808	106	45	m	0
8926	16	46	g	3.75
8909	214	45	m	0
8872	176	45	m	0
8962	58	46	g	5
8852	155	45	m	0
8858	161	45	m	0
8930	21	46	m	0
8914	4	46	m	0
9021	123	46	g	5
8821	121	45	m	0
8833	134	45	m	0
8935	27	46	g	5
9022	124	46	g	5
9077	183	46	g	2.5
8984	83	46	g	0
9014	115	46	g	2.5
9078	184	46	g	3.75
9089	196	46	g	3.75
9099	206	46	g	5
9027	130	46	g	5
9054	159	46	g	2.5
9053	158	46	g	3.75
9068	174	46	g	2.5
9058	163	46	g	5
9017	119	46	g	2.5
9096	203	46	g	3.75
9104	211	46	m	0
9045	149	46	g	3.75
9011	112	46	g	5
9065	171	46	g	1.25
9003	103	46	g	5
8981	80	46	g	5
9035	138	46	g	3.75
9110	2	47	g	10
9094	201	46	m	0
9080	186	46	g	3.75
9125	17	47	p	0
9132	26	47	p	0
9134	28	47	p	0
9135	29	47	p	0
9138	33	47	p	0
9142	38	47	p	0
9143	40	47	p	0
9146	43	47	p	0
9149	46	47	p	0
9150	47	47	p	0
9152	50	47	p	0
9155	53	47	p	0
9161	59	47	p	0
9162	60	47	p	0
9163	61	47	p	0
9164	62	47	p	0
9165	63	47	p	0
9166	64	47	p	0
9168	66	47	p	0
9169	68	47	p	0
9170	69	47	p	0
9171	70	47	p	0
9172	71	47	p	0
9174	75	47	p	0
9175	76	47	p	0
9176	77	47	p	0
9178	79	47	p	0
9181	82	47	p	0
9185	86	47	p	0
9187	88	47	p	0
9188	89	47	p	0
9190	91	47	p	0
9191	92	47	p	0
9194	96	47	p	0
9195	97	47	p	0
9196	98	47	p	0
9197	99	47	p	0
9198	100	47	p	0
9199	101	47	p	0
9202	104	47	p	0
9203	105	47	p	0
9205	107	47	p	0
9208	111	47	p	0
9210	113	47	p	0
9211	114	47	p	0
9214	117	47	p	0
9218	122	47	p	0
9223	128	47	p	0
9224	129	47	p	0
9230	135	47	p	0
9231	136	47	p	0
9232	137	47	p	0
9234	139	47	p	0
9236	142	47	p	0
9237	143	47	p	0
9238	144	47	p	0
9244	150	47	p	0
9246	153	47	p	0
9247	154	47	p	0
9249	156	47	p	0
9250	157	47	p	0
9258	165	47	p	0
9259	167	47	p	0
9261	169	47	p	0
9264	172	47	p	0
9265	173	47	p	0
9267	175	47	p	0
9269	177	47	p	0
9270	178	47	p	0
9272	180	47	p	0
9273	181	47	p	0
9274	182	47	p	0
9277	185	47	p	0
9055	160	46	g	5
9147	44	47	g	10
9057	162	46	m	0
9041	145	46	m	0
9139	34	47	m	0
9122	14	47	g	5
9037	141	46	m	0
9042	146	46	g	5
8982	81	46	m	0
9180	81	47	m	0
9073	179	46	g	5
9088	194	46	g	2.5
9271	179	47	m	0
9059	164	46	g	5
9129	22	47	m	0
9030	133	46	g	5
9130	24	47	m	0
9062	168	46	g	5
9228	133	47	m	0
9009	110	46	m	0
9207	110	47	m	0
9023	125	46	m	0
9221	125	47	m	0
9015	116	46	g	5
9173	74	47	m	0
9140	35	47	m	0
8985	84	46	g	5
9136	30	47	g	10
9183	84	47	m	0
9083	189	46	g	0
8994	93	46	g	3.75
9241	147	47	m	0
9086	192	46	g	5
9006	106	46	g	5
9028	131	46	m	0
9226	131	47	m	0
8986	85	46	g	5
9145	42	47	m	0
9107	214	46	m	0
9070	176	46	m	0
9124	16	47	m	0
9050	155	46	g	5
9056	161	46	g	5
8988	87	46	g	5
9002	102	46	m	0
9128	21	47	m	0
9160	58	47	g	10
9112	4	47	m	0
9217	121	47	g	10
8991	90	46	m	0
9031	134	46	g	5
9219	123	47	m	0
9024	127	46	g	5
9220	124	47	m	0
9275	183	47	m	0
9182	83	47	g	9.772727272727273
9212	115	47	g	10
9276	184	47	g	10
9278	186	47	g	10
9131	25	47	m	0
9225	130	47	m	0
9252	159	47	m	0
9251	158	47	m	0
9266	174	47	g	10
9148	45	47	m	0
9256	163	47	g	10
9215	119	47	g	10
9151	48	47	g	10
9243	149	47	g	10
9154	52	47	m	0
9209	112	47	m	0
9153	51	47	g	4.772727272727273
9263	171	47	g	0
9179	80	47	g	5
9245	152	47	m	0
9233	138	47	g	5
9280	188	47	p	0
9282	190	47	p	0
9283	191	47	p	0
9285	193	47	p	0
9288	197	47	p	0
9289	198	47	p	0
9290	199	47	p	0
9291	200	47	p	0
9293	202	47	p	0
9295	204	47	p	0
9296	205	47	p	0
9298	207	47	p	0
9299	208	47	p	0
9300	209	47	p	0
9301	210	47	p	0
9303	212	47	p	0
9304	213	47	p	0
9306	215	47	p	0
9307	1	48	p	0
9311	5	48	p	0
9313	7	48	p	0
9314	8	48	p	0
9315	9	48	p	0
9316	10	48	p	0
9317	11	48	p	0
9318	12	48	p	0
9319	13	48	p	0
9323	17	48	p	0
9330	26	48	p	0
9332	28	48	p	0
9333	29	48	p	0
9336	33	48	p	0
9340	38	48	p	0
9341	40	48	p	0
9344	43	48	p	0
9347	46	48	p	0
9348	47	48	p	0
9350	50	48	p	0
9353	53	48	p	0
9359	59	48	p	0
9360	60	48	p	0
9361	61	48	p	0
9362	62	48	p	0
9363	63	48	p	0
9364	64	48	p	0
9366	66	48	p	0
9367	68	48	p	0
9368	69	48	p	0
9369	70	48	p	0
9370	71	48	p	0
9372	75	48	p	0
9373	76	48	p	0
9374	77	48	p	0
9376	79	48	p	0
9379	82	48	p	0
9383	86	48	p	0
9385	88	48	p	0
9386	89	48	p	0
9388	91	48	p	0
9389	92	48	p	0
9392	96	48	p	0
9393	97	48	p	0
9394	98	48	p	0
9395	99	48	p	0
9396	100	48	p	0
9397	101	48	p	0
9400	104	48	p	0
9401	105	48	p	0
9403	107	48	p	0
9406	111	48	p	0
9408	113	48	p	0
9409	114	48	p	0
9412	117	48	p	0
9416	122	48	p	0
9421	128	48	p	0
9422	129	48	p	0
9428	135	48	p	0
9429	136	48	p	0
9430	137	48	p	0
9432	139	48	p	0
9434	142	48	p	0
9435	143	48	p	0
9255	162	47	g	10
9345	44	48	g	9.86
9133	27	47	m	0
9239	145	47	m	0
9337	34	48	m	0
9262	170	47	g	10
9235	141	47	m	0
9433	141	48	m	0
9378	81	48	g	10
9159	57	47	m	0
9357	57	48	m	0
9240	146	47	g	10
9419	125	48	g	10
9206	109	47	m	0
9327	22	48	m	0
9141	36	47	m	0
9339	36	48	m	0
9216	120	47	m	0
9426	133	48	m	0
9405	110	48	m	0
9260	168	47	g	5
9411	116	48	g	10
9371	74	48	m	0
9338	35	48	m	0
9192	93	47	g	10
9381	84	48	m	0
9127	19	47	m	0
9281	189	47	g	0
9312	6	48	m	0
9284	192	47	g	10
9184	85	47	g	10
9424	131	48	m	0
9343	42	48	m	0
9268	176	47	m	0
9322	16	48	m	0
9248	155	47	g	10
9200	102	47	g	10
9254	161	47	m	0
9415	121	48	g	3
9186	87	47	m	0
9310	4	48	m	0
9157	55	47	m	0
9126	18	47	m	0
9229	134	47	g	10
9417	123	48	m	0
9222	127	47	g	5
9418	124	48	m	0
9380	83	48	m	0
9410	115	48	g	10
9297	206	47	g	5
9329	25	48	m	0
9423	130	48	g	10
9287	196	47	m	0
9167	65	47	g	10
9346	45	48	m	0
9413	119	48	m	0
9349	48	48	m	0
9321	15	48	m	0
9294	203	47	g	5
9302	211	47	m	0
9407	112	48	g	10
9351	51	48	m	0
9399	103	48	m	0
9377	80	48	g	3
9431	138	48	g	3
9308	2	48	g	3
9292	201	47	m	0
9425	132	48	m	0
9442	150	48	p	0
9444	153	48	p	0
9445	154	48	p	0
9447	156	48	p	0
9448	157	48	p	0
9456	165	48	p	0
9457	167	48	p	0
9459	169	48	p	0
9462	172	48	p	0
9463	173	48	p	0
9465	175	48	p	0
9467	177	48	p	0
9468	178	48	p	0
9470	180	48	p	0
9471	181	48	p	0
9472	182	48	p	0
9475	185	48	p	0
9477	187	48	p	0
9478	188	48	p	0
9480	190	48	p	0
9481	191	48	p	0
9483	193	48	p	0
9486	197	48	p	0
9487	198	48	p	0
9488	199	48	p	0
9489	200	48	p	0
9491	202	48	p	0
9493	204	48	p	0
9494	205	48	p	0
9496	207	48	p	0
9497	208	48	p	0
9498	209	48	p	0
9499	210	48	p	0
9501	212	48	p	0
9502	213	48	p	0
9504	215	48	p	0
9505	1	49	p	0
9509	5	49	p	0
9511	7	49	p	0
9512	8	49	p	0
9513	9	49	p	0
9514	10	49	p	0
9515	11	49	p	0
9516	12	49	p	0
9517	13	49	p	0
9521	17	49	p	0
9528	26	49	p	0
9530	28	49	p	0
9531	29	49	p	0
9534	33	49	p	0
9538	38	49	p	0
9539	40	49	p	0
9542	43	49	p	0
9545	46	49	p	0
9546	47	49	p	0
9548	50	49	p	0
9551	53	49	p	0
9557	59	49	p	0
9558	60	49	p	0
9559	61	49	p	0
9560	62	49	p	0
9561	63	49	p	0
9562	64	49	p	0
9564	66	49	p	0
9565	68	49	p	0
9566	69	49	p	0
9567	70	49	p	0
9568	71	49	p	0
9570	75	49	p	0
9571	76	49	p	0
9572	77	49	p	0
9574	79	49	p	0
9577	82	49	p	0
9581	86	49	p	0
9583	88	49	p	0
9584	89	49	p	0
9586	91	49	p	0
9587	92	49	p	0
9590	96	49	p	0
9591	97	49	p	0
9592	98	49	p	0
9391	95	48	m	0
9320	14	48	g	3
9453	162	48	m	0
9437	145	48	m	0
9460	170	48	g	10
9286	194	47	g	10
9576	81	49	m	0
9354	54	48	m	0
9469	179	48	m	0
9458	168	48	g	9.92
9525	22	49	m	0
9455	164	48	m	0
9507	3	49	m	0
9414	120	48	m	0
9479	189	48	g	3
9569	74	49	m	0
9536	35	49	m	0
9579	84	49	m	0
9325	19	48	m	0
9439	147	48	g	9.92
9334	30	48	m	0
9588	93	49	g	10
9510	6	49	m	0
9482	192	48	g	10
9554	56	49	g	10
9402	106	48	m	0
9541	42	49	g	10
9398	102	48	g	10
9305	214	47	m	0
9466	176	48	m	0
9382	85	48	m	0
9580	85	49	m	0
9452	161	48	m	0
9427	134	48	g	9.92
9326	21	48	m	0
9524	21	49	m	0
9384	87	48	m	0
9508	4	49	m	0
9358	58	48	m	0
9556	58	49	m	0
9387	90	48	m	0
9585	90	49	m	0
9553	55	49	m	0
9522	18	49	m	0
9473	183	48	m	0
9451	160	48	g	3
9578	83	49	m	0
9474	184	48	g	9.84
9476	186	48	m	0
9485	196	48	g	10
9495	206	48	g	3
9527	25	49	m	0
9365	65	48	g	3
9450	159	48	g	3
9449	158	48	m	0
9464	174	48	g	3
9544	45	49	m	0
9454	163	48	m	0
9547	48	49	m	0
9519	15	49	m	0
9492	203	48	g	3
9441	149	48	g	10
9550	52	49	m	0
9549	51	49	m	0
9461	171	48	m	0
9575	80	49	g	9.87987987987988
9443	152	48	m	0
9506	2	49	g	10
9490	201	48	m	0
9594	100	49	p	0
9595	101	49	p	0
9598	104	49	p	0
9599	105	49	p	0
9601	107	49	p	0
9604	111	49	p	0
9606	113	49	p	0
9607	114	49	p	0
9610	117	49	p	0
9614	122	49	p	0
9619	128	49	p	0
9620	129	49	p	0
9626	135	49	p	0
9627	136	49	p	0
9628	137	49	p	0
9630	139	49	p	0
9632	142	49	p	0
9633	143	49	p	0
9634	144	49	p	0
9640	150	49	p	0
9642	153	49	p	0
9643	154	49	p	0
9645	156	49	p	0
9646	157	49	p	0
9654	165	49	p	0
9655	167	49	p	0
9657	169	49	p	0
9660	172	49	p	0
9661	173	49	p	0
9663	175	49	p	0
9665	177	49	p	0
9666	178	49	p	0
9668	180	49	p	0
9669	181	49	p	0
9670	182	49	p	0
9673	185	49	p	0
9675	187	49	p	0
9676	188	49	p	0
9678	190	49	p	0
9679	191	49	p	0
9681	193	49	p	0
9684	197	49	p	0
9685	198	49	p	0
9686	199	49	p	0
9687	200	49	p	0
9689	202	49	p	0
9691	204	49	p	0
9692	205	49	p	0
9694	207	49	p	0
9695	208	49	p	0
9696	209	49	p	0
9697	210	49	p	0
9699	212	49	p	0
9700	213	49	p	0
9702	215	49	p	0
9703	1	50	p	0
9707	5	50	p	0
9709	7	50	p	0
9710	8	50	p	0
9711	9	50	p	0
9712	10	50	p	0
9713	11	50	p	0
9714	12	50	p	0
9715	13	50	p	0
9719	17	50	p	0
9726	26	50	p	0
9728	28	50	p	0
9729	29	50	p	0
9732	33	50	p	0
9736	38	50	p	0
9737	40	50	p	0
9740	43	50	p	0
9743	46	50	p	0
9744	47	50	p	0
9746	50	50	p	0
9749	53	50	p	0
9589	95	49	m	0
9733	34	50	g	5
9635	145	49	m	0
9741	44	50	g	5
9552	54	49	g	10
9518	14	49	m	0
9658	170	49	m	0
9555	57	49	m	0
9484	194	48	g	3
9438	146	48	m	0
9602	109	49	m	0
9723	22	50	g	10
9682	194	49	m	0
9724	24	50	g	10
9653	164	49	m	0
9705	3	50	m	0
9735	36	50	g	10
9656	168	49	g	10
9537	36	49	m	0
9612	120	49	m	0
9603	110	49	m	0
9617	125	49	m	0
9734	35	50	g	10
9609	116	49	g	10
9721	19	50	g	5
9677	189	49	g	9.81981981981982
9730	30	50	g	10
9708	6	50	g	10
9637	147	49	m	0
9739	42	50	g	7
9680	192	49	m	0
9622	131	49	m	0
9600	106	49	m	0
9722	21	50	g	10
9701	214	49	m	0
9664	176	49	m	0
9520	16	49	m	0
9446	155	48	m	0
9650	161	49	m	0
9596	102	49	m	0
9720	18	50	g	5
9615	123	49	m	0
9613	121	49	m	0
9625	134	49	m	0
9727	27	50	g	10
9616	124	49	m	0
9671	183	49	m	0
9608	115	49	g	10
9672	184	49	g	1.9519519519519524
9693	206	49	g	9.57957957957958
9725	25	50	m	0
9621	130	49	g	9.75975975975976
9688	201	49	m	0
9563	65	49	m	0
9648	159	49	g	1.0510510510510507
9647	158	49	m	0
9662	174	49	g	9.75975975975976
9742	45	50	m	0
9652	163	49	m	0
9611	119	49	m	0
9717	15	50	g	5
9690	203	49	g	9.81981981981982
9698	211	49	m	0
9639	149	49	m	0
9748	52	50	g	10
9605	112	49	m	0
9747	51	50	g	5
9659	171	49	m	0
9597	103	49	m	0
9641	152	49	m	0
9629	138	49	g	10
9704	2	50	g	7
9623	132	49	m	0
9762	66	50	p	0
9763	68	50	p	0
9764	69	50	p	0
9765	70	50	p	0
9766	71	50	p	0
9768	75	50	p	0
9769	76	50	p	0
9770	77	50	p	0
9772	79	50	p	0
9775	82	50	p	0
9779	86	50	p	0
9781	88	50	p	0
9782	89	50	p	0
9784	91	50	p	0
9785	92	50	p	0
9788	96	50	p	0
9789	97	50	p	0
9790	98	50	p	0
9791	99	50	p	0
9792	100	50	p	0
9793	101	50	p	0
9796	104	50	p	0
9797	105	50	p	0
9799	107	50	p	0
9802	111	50	p	0
9804	113	50	p	0
9805	114	50	p	0
9808	117	50	p	0
9812	122	50	p	0
9817	128	50	p	0
9818	129	50	p	0
9824	135	50	p	0
9825	136	50	p	0
9826	137	50	p	0
9828	139	50	p	0
9830	142	50	p	0
9831	143	50	p	0
9832	144	50	p	0
9838	150	50	p	0
9840	153	50	p	0
9841	154	50	p	0
9843	156	50	p	0
9844	157	50	p	0
9852	165	50	p	0
9853	167	50	p	0
9855	169	50	p	0
9858	172	50	p	0
9859	173	50	p	0
9861	175	50	p	0
9863	177	50	p	0
9864	178	50	p	0
9866	180	50	p	0
9867	181	50	p	0
9868	182	50	p	0
9871	185	50	p	0
9873	187	50	p	0
9874	188	50	p	0
9876	190	50	p	0
9877	191	50	p	0
9879	193	50	p	0
9882	197	50	p	0
9883	198	50	p	0
9884	199	50	p	0
9885	200	50	p	0
9887	202	50	p	0
9889	204	50	p	0
9890	205	50	p	0
9892	207	50	p	0
9893	208	50	p	0
9894	209	50	p	0
9895	210	50	p	0
9897	212	50	p	0
9898	213	50	p	0
9900	215	50	p	0
9816	127	50	g	10
8741	31	45	m	0
9847	160	50	g	5
9849	162	50	g	10
9829	141	50	g	10
9753	57	50	g	10
7153	27	37	m	0
9833	145	50	m	0
7791	78	40	m	0
7989	78	41	m	0
9774	81	50	g	10
7849	141	40	m	0
9750	54	50	g	10
9800	109	50	g	10
9865	179	50	g	10
9834	146	50	m	0
9880	194	50	g	10
9810	120	50	g	10
9667	179	49	m	0
9822	133	50	g	10
9851	164	50	m	0
9854	168	50	g	5
9807	116	50	g	10
9624	133	49	m	0
9801	110	50	m	0
9815	125	50	m	0
9878	192	50	g	10
9767	74	50	m	0
9820	131	50	g	10
9875	189	50	g	0
9835	147	50	m	0
9786	93	50	g	0
9798	106	50	g	10
9752	56	50	g	7
9718	16	50	g	10
9778	85	50	g	10
9899	214	50	m	0
9842	155	50	g	10
9794	102	50	g	5
9780	87	50	g	10
9848	161	50	m	0
9783	90	50	g	20
9751	55	50	g	10
9811	121	50	g	10
9823	134	50	g	10
9813	123	50	m	0
9814	124	50	g	10
9787	95	50	g	10
9649	160	49	g	7.957957957957957
9869	183	50	g	7
9776	83	50	m	0
9806	115	50	g	10
9870	184	50	m	0
9872	186	50	g	10
9881	196	50	g	10
9891	206	50	g	4
9819	130	50	m	0
9821	132	50	g	2
9761	65	50	g	10
9846	159	50	g	5
9845	158	50	g	10
9860	174	50	g	10
9850	163	50	g	7
9809	119	50	g	10
9888	203	50	g	10
9896	211	50	m	0
9837	149	50	m	0
9803	112	50	g	7
9857	171	50	m	0
9795	103	50	g	7
9773	80	50	g	5
9839	152	50	m	0
9827	138	50	g	10
9886	201	50	m	0
9144	41	47	m	0
8839	141	45	m	0
9631	141	49	m	0
7773	57	40	m	0
8216	109	42	m	0
8612	109	44	m	0
9008	109	46	m	0
7291	179	37	m	0
7489	179	38	m	0
7885	179	40	m	0
9309	3	48	m	0
9114	6	47	m	0
8462	161	43	m	0
9706	4	50	m	0
7576	58	39	m	0
9324	18	48	m	0
8946	41	46	g	5
9543	44	49	g	4.2342342342342345
9716	14	50	g	5
8613	110	44	g	10
9777	84	50	g	10
9158	56	47	g	10
9356	56	48	g	10
8711	214	44	g	20
9754	58	50	g	10
9189	90	47	g	10
8928	18	46	g	5
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.students (id, netid, status, uin, gender, name, credit, level, year, subject, number, section, crn, degree, major, college, program_code, program_name, ferpa, comments, admit_term, email) FROM stdin;
20	luisef2	d	676996641	M	Fernandez De La Vara, Luis Ernesto	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2022	luisef2@illinois.edu
23	ngaye2	d	650985973	M	Gayeta, Neil Richard	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	ngaye2@illinois.edu
32	aiota2	d	656211075	F	Iota, Axel	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	aiota2@illinois.edu
37	umerk2	d	656192729	M	Khan, Umer	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	umerk2@illinois.edu
39	cl110	d	656523078	M	Lawrence, Christopher	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2021	cl110@illinois.edu
49	emagutu2	d	652209340	M	Magutu, Eric	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	emagutu2@illinois.edu
80	kthapar2	r	679417899	M	Thapar, Karan	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	kthapar2@illinois.edu
67	sreizes2	d	664946628	F	Reizes, Samantha Arielle	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	sreizes2@illinois.edu
72	ssharif2	d	665535413	M	Sharifian, Shaheen Loong	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	ssharif2@illinois.edu
73	shipway2	d	661964723	M	Shipway, Aaron L.	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2021	shipway2@illinois.edu
94	llchong2	d	670932832	F	Chong, Ling Lee	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	10KS0112MCS	MCS:Computer Science -UIUC	N	\N	Fall 2018	llchong2@illinois.edu
108	aa69	d	661044086	M	Anandaram, Asuthosh	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	aa69@illinois.edu
118	jodhand2	d	651658603	M	Dhand, Jason Om	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	jodhand2@illinois.edu
126	karenyg2	d	650791931	F	Gao, Karen Yuqian	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	karenyg2@illinois.edu
1	ehitda2	r	654247422	M	Agarwal, Ehit Dinesh	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	ehitda2@illinois.edu
2	eliasia2	r	656476426	M	Amuneke, Elias Ikechukwu	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	eliasia2@illinois.edu
3	sarbour2	r	664249672	M	Arbour, Spencer Madhav	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	sarbour2@illinois.edu
4	aa107	r	660879281	M	Arellano Tavara, Abraham	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	aa107@illinois.edu
6	benitez5	r	661286762	M	Benitez, Esteban	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	benitez5@illinois.edu
7	rpberry2	r	652083421	M	Berry, Ryan Patrick	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2021	rpberry2@illinois.edu
8	sb52	r	674949091	M	Bhattacharjee, Sidd	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	sb52@illinois.edu
9	bindu2	r	663757658	M	Bindu, Rohan	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	bindu2@illinois.edu
10	dansb2	r	673797247	M	Blustein, Dan Sakai	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	dansb2@illinois.edu
11	mc148	r	668098769	M	Carringer, Matthew	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	mc148@illinois.edu
12	zwchong2	r	650722637	M	Chong, Zan Wei	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	zwchong2@illinois.edu
13	colmena3	r	658919849	M	Colmena, Carlos	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	colmena3@illinois.edu
14	hdas4	r	653612908	M	Das, Himangshu	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	hdas4@illinois.edu
15	ayand2	r	662032485	M	Deka, Ayan Jeet	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	ayand2@illinois.edu
140	zehaoji2	d	672551352	M	Ji, Zehao	3	1U	Junior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	zehaoji2@illinois.edu
151	jinheng2	d	663198789	M	Li, Simon	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	jinheng2@illinois.edu
166	johnni2	d	679833132	M	Ni, John	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	johnni2@illinois.edu
195	ruruma2	d	664837992	M	Uruma, Rohit	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	ruruma2@illinois.edu
16	karansd2	r	668907941	M	Desai, Karan Sanjay	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	karansd2@illinois.edu
17	roberte3	r	664241196	M	Ellwanger, Robert Parker	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	roberte3@illinois.edu
18	ne13	r	661303726	M	Estrada, Nicolas	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	ne13@illinois.edu
19	evanoff3	r	663858875	M	Evanoff, Ben	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	evanoff3@illinois.edu
21	joshuaf4	r	665577296	M	Fischer, Joshua	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	joshuaf4@illinois.edu
22	alicejf2	r	662018782	F	Fu, Alice Jingwen	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	alicejf2@illinois.edu
24	anwesag2	r	665058626	F	Goswami, Anwesa	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	10KS0112MCSX	MCS: Computer Sci OFF - UIUC	N	\N	Spring 2024	anwesag2@illinois.edu
25	layneog2	r	655735286	F	Granados Mogollon, Layne Otilia	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	layneog2@illinois.edu
26	edmong2	r	659307302	M	Guan, Edmon	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	edmong2@illinois.edu
27	jhennig3	r	671961715	M	Hennig, Jacob Kyran Meng Chung	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	jhennig3@illinois.edu
28	higa2	r	651432077	M	Higa, Ryley K	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	higa2@illinois.edu
29	wsho3	r	664261251	M	Ho, Weng Shian	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2022	wsho3@illinois.edu
30	khunter5	r	656106679	M	Hunter, Kenneth Duncan	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	khunter5@illinois.edu
31	lazari2	r	667832232	M	Ilic, Lazar	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	lazari2@illinois.edu
33	mylesai2	r	658657877	M	Iribarne, Myles Alejandro	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	mylesai2@illinois.edu
34	luinei2	r	655903374	M	Ito Madeira De Ley, Luine	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	luinei2@illinois.edu
35	jason18	r	673288906	M	Jennings, Jason	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	jason18@illinois.edu
36	mk65	r	660959461	M	Kennedy, Matthew	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	mk65@illinois.edu
38	alatif5	r	671505090	M	Latif, Abdul	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	alatif5@illinois.edu
40	cgl2	r	661125091	M	Lee, Chris Gunwoo	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	cgl2@illinois.edu
41	gjlee4	r	663805738	M	Lee, Gabriel J	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	gjlee4@illinois.edu
42	ll37	r	667830109	M	Lee, Leo	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	ll37@illinois.edu
44	wl33	r	653726783	F	Li, Wenching	4	1G	Graduate	CS	421	DSO	37194	NDEG	Computer Science	Grainger Engineering	1SKS0112NDEU	NDEG:Computer Science Onl-UIUC	N	\N	Summer 2024	wl33@illinois.edu
45	yinchen3	r	650848283	M	Liu, Yinchen	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	yinchen3@illinois.edu
46	jdl8	r	654482714	M	Lizarraga, Jacob Daniel	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	jdl8@illinois.edu
47	lu94	r	667708971	M	Lu, Shang	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	lu94@illinois.edu
48	jooyolm2	r	662431141	M	Maeng, Brian	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2019	jooyolm2@illinois.edu
50	kushaal2	r	659436732	M	Manchella, Kushaal Bharadwaj	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	kushaal2@illinois.edu
51	georgem6	r	658432784	M	McAskill, George	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	georgem6@illinois.edu
52	krista2	r	659273393	F	McDermott, Krista Eileen Kuzara	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2022	krista2@illinois.edu
53	meghani3	r	675591329	M	Meghani, Pankaj Harish	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	meghani3@illinois.edu
5	sunkib2	d	677992646	M	Baek, Sunki	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	sunkib2@illinois.edu
54	arielm4	r	665746540	F	Mehta, Meera	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	arielm4@illinois.edu
55	hm14	r	650978431	M	Meng, Haoming	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	hm14@illinois.edu
56	sam19	r	652217036	M	Metzger, Scott Allen	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2022	sam19@illinois.edu
57	jmichal3	r	655464281	M	Michal, Justin	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2022	jmichal3@illinois.edu
58	dmikha2	r	671239705	M	Mikhail, Daniel Nabil	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	dmikha2@illinois.edu
59	milavec2	r	652412696	M	Milavec, Luke	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	milavec2@illinois.edu
60	kmoone3	r	670369657	M	Mooney, Kevin Christopher	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	kmoone3@illinois.edu
61	bnevius2	r	672241625	M	Nevius, Branden	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2022	bnevius2@illinois.edu
62	dereklo2	r	671121982	M	Oda, Derek Lowell	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	dereklo2@illinois.edu
63	cjo6	r	671675257	M	Opperman, Christian	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	cjo6@illinois.edu
64	ipai3	r	654365181	M	Pai, Neel	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	ipai3@illinois.edu
65	agpatel2	r	675569095	M	Patel, Avi	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	agpatel2@illinois.edu
66	ap73	r	653393776	M	Prasad, Anirudh	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	ap73@illinois.edu
68	jsamaha2	r	675219304	M	Samaha, Jacques	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	jsamaha2@illinois.edu
70	devinms3	r	654760885	M	Schmitz, Devin Michael	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	devinms3@illinois.edu
71	xijins2	r	670950796	M	Shan, Xijin	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2021	xijins2@illinois.edu
74	aliis2	r	675971298	M	Siddiqi, Ali I	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	aliis2@illinois.edu
75	calebes2	r	672202193	M	Skiles, Caleb Eugene	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	calebes2@illinois.edu
76	mohanks2	r	656302159	M	Somavarapu, Mohan	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2019	mohanks2@illinois.edu
77	sood8	r	670297498	M	Sood, Sushant	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	sood8@illinois.edu
78	xsu11	r	669514111	F	Su, Xiaoqian	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	xsu11@illinois.edu
79	cmtam2	r	667144449	M	Tam, Christian Michael	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	cmtam2@illinois.edu
81	evanmt2	r	668394091	M	Timmerman, Evan Matthew	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	evanmt2@illinois.edu
82	ntokuda2	r	675831751	M	Tokuda, Nivaldo Humberto Oliveira	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	ntokuda2@illinois.edu
83	vikramv4	r	672187035	M	Vijayakumar, Vikram	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	vikramv4@illinois.edu
84	lufeiw2	r	674751039	M	Wang, Lufei	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	lufeiw2@illinois.edu
85	jinfeng4	r	650075269	M	Wu, Jinfeng	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	jinfeng4@illinois.edu
86	dhxu2	r	673052260	M	Xu, Daniel Haozhe	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2022	dhxu2@illinois.edu
87	zx46	r	668136311	M	Xu, Zhentao	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	zx46@illinois.edu
88	shyeo2	r	653117200	M	Yeo, Zayn	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	shyeo2@illinois.edu
105	tze2	r	675225866	M	Ze, Peter	4	1G	Graduate	CS	421	DSO	30794	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	tze2@illinois.edu
89	yuchen58	r	671115970	M	Zhang, Bobby	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2023	yuchen58@illinois.edu
90	zhenyuz3	r	663274937	M	Zhang, Zhenyu	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Spring 2024	zhenyuz3@illinois.edu
43	mandyl2	d	652394562	 	Lee, Mandy	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Fall 2023	mandyl2@illinois.edu
91	ez7	r	655241681	M	Zhu, Edward	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	ez7@illinois.edu
93	haimob2	r	672667121	M	Bai, Haimo	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	haimob2@illinois.edu
95	md68	r	656119669	F	Derocher, Marielle Claire	3	1G	Graduate	CS	421	PG	30794	CERT	Computing Fundamentals	Grainger Engineering	10KS6079CERU	CERT:ComputingFundam ONL- UIUC	N	\N	Fall 2023	md68@illinois.edu
96	arunhg2	r	651024910	M	Giridharan, Arun Hari	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	arunhg2@illinois.edu
97	eguo4	r	675273665	M	Guo, Edward	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	10KS0112MCS	MCS:Computer Science -UIUC	N	\N	Fall 2023	eguo4@illinois.edu
99	nvk4	r	667423540	M	Kanamarla, Nikhil Venkata	4	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	10KS0112MCS	MCS:Computer Science -UIUC	N	\N	Fall 2023	nvk4@illinois.edu
100	ymangel2	r	656676318	M	Mangel, Yahav Shmuel	4	1U	Senior	CS	421	PG	30794	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	ymangel2@illinois.edu
101	qmao3	r	664821221	F	Mao, Qizheng	3	1G	Graduate	CS	421	PG	30794	CERT	Computing Fundamentals	Grainger Engineering	10KS6079CERU	CERT:ComputingFundam ONL- UIUC	N	\N	Fall 2023	qmao3@illinois.edu
102	spod2	r	668022142	M	Pod, Sergiu C	4	1G	Graduate	CS	421	PG	30794	CERT	Computing Fundamentals	Grainger Engineering	10KS6079CERT	CERT:ComputingFundam - UIUC	N	\N	Fall 2023	spod2@illinois.edu
103	laxmiv2	r	659959507	F	Vijayan, Lux	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	10KS0112MCS	MCS:Computer Science -UIUC	N	\N	Fall 2022	laxmiv2@illinois.edu
104	xingyao6	r	665862740	M	Wang, Xingyao	4	1G	Graduate	CS	421	PG	30794	PHD	Computer Science	Grainger Engineering	10KS0112PHD	PHD:Computer Science -UIUC	N	\N	Fall 2022	xingyao6@illinois.edu
106	haoyu9	r	656859498	M	Zhou, Kevin	4	1G	Graduate	CS	421	PG	30794	PHD	Electrical & Computer Engr	Grainger Engineering	10KS1200PHD	PHD:Electr & Computer Eng-UIUC	N	\N	Fall 2023	haoyu9@illinois.edu
107	jizezou2	r	663866915	M	Zou, Jeff	3	1U	Senior	CS	421	PG	30794	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	jizezou2@illinois.edu
109	arnolda2	r	676620086	M	Ancheril, Arnold Robert	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2020	arnolda2@illinois.edu
110	drshika2	r	677256768	F	Asher, Drshika	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	drshika2@illinois.edu
111	justinb8	r	664061157	M	Bai, Justin	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV8037BSLA	BSLAS:LAS Multiple Majors-UIUC	N	\N	Fall 2021	justinb8@illinois.edu
112	suchit2	r	652562704	M	Bapatla, Suchit	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	suchit2@illinois.edu
113	shohanb2	r	658770215	M	Bhattacharya, Shohan	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2017	shohanb2@illinois.edu
114	sakethb2	r	665733847	M	Boyapally, Saketh	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2021	sakethb2@illinois.edu
115	kevinlc3	r	677777944	M	Chen, Kevin	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Chemistry	Liberal Arts & Sciences	10KV5350BSLA	BSLAS: Comp Sci & Chem-UIUC	N	\N	Fall 2021	kevinlc3@illinois.edu
116	simonac2	r	672755529	M	Cooper, Simon	3	1U	Senior	CS	421	PU	30792	BS	Computer Science and Music	Fine & Applied Arts	10KR5639BS	BS:Computer Sci & Music - UIUC	N	\N	Fall 2020	simonac2@illinois.edu
117	tylerjc5	r	659604378	M	Cushing, Tyler	3	1U	Junior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	tylerjc5@illinois.edu
119	sdowden2	r	677362702	F	Dowden, Sarah Hope	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	sdowden2@illinois.edu
120	rrfang2	r	657948098	M	Fang, Richard Ricky	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2023	rrfang2@illinois.edu
121	jamespf3	r	659210799	M	Flaherty, Jimmy	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	jamespf3@illinois.edu
122	agadd6	r	667372734	M	Gadde, Akhil	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Economics	Liberal Arts & Sciences	10KV5667BSLA	BSLAS: Comp Sci & Econ - UIUC	N	\N	Fall 2021	agadd6@illinois.edu
123	ag72	r	653379025	M	Gahalaut, Achintya	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	ag72@illinois.edu
124	ananyag8	r	653621365	M	Gahalaut, Ananya	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	ananyag8@illinois.edu
125	anvitag2	r	679011745	F	Ganugapati, Anvita Srikari	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Linguistics	Liberal Arts & Sciences	10KV5351BSLA	BSLAS: Comp Sci & Ling-UIUC	N	\N	Fall 2021	anvitag2@illinois.edu
127	samuel37	r	653681187	M	Gerstein, Samuel	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	samuel37@illinois.edu
128	preetig3	r	656910979	F	Gomathinayagam, Preeti	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	preetig3@illinois.edu
69	sajus2	d	669970098	M	Sathyanathan, Saju	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2023	sajus2@illinois.edu
92	yunwenz2	d	651127626	F	Zhu, Yunwen	4	1G	Graduate	CS	421	DSO	37194	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	yunwenz2@illinois.edu
98	msh17	d	676163412	M	Hussaini, Muhammad Saad	3	1G	Graduate	CS	421	PG	30794	MCS	Computer Science	Grainger Engineering	1SKS0112MCSU	MCS:Computer Sci Online -UIUC	N	\N	Summer 2024	msh17@illinois.edu
129	zichen6	r	659342170	M	GU, Zichen	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2022	zichen6@illinois.edu
130	rohanvg3	r	669735417	M	Gudipaty, Rohan Venkat	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	rohanvg3@illinois.edu
131	handzel4	r	660333043	M	Handzel, Matt	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2023	handzel4@illinois.edu
132	feisalh2	r	659851695	M	Hassan, Feisal	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	feisalh2@illinois.edu
133	eeho2	r	663921510	F	Ho, Emily	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Geog & GIS	Liberal Arts & Sciences	10KV5676BSLA	BSLAS:Comp Sci & Geog&GIS-UIUC	N	\N	Fall 2021	eeho2@illinois.edu
134	jasonzh2	r	658873858	M	Hu, Jason Z	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	jasonzh2@illinois.edu
135	zeanh2	r	668320044	M	Huang, Wyatt	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	zeanh2@illinois.edu
136	xiaocih2	r	654676468	M	Huang, Xiaoci	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Economics	Liberal Arts & Sciences	10KV5667BSLA	BSLAS: Comp Sci & Econ - UIUC	N	\N	Fall 2020	xiaocih2@illinois.edu
137	georgeh3	r	677000975	M	Huebner, George	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	georgeh3@illinois.edu
138	ljain2	r	675368349	F	Jain, Labdhi	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP5458BS	BS:BS/MCS Computer Sci -UIUC	N	\N	Fall 2021	ljain2@illinois.edu
139	vidurj2	r	663577254	M	Jain, Vidur	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	vidurj2@illinois.edu
141	vk29	r	663033867	M	Kakuturu, Vaasu	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	vk29@illinois.edu
142	ahaank2	r	674083504	M	Kanaujia, Ahaan	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV8037BSLA	BSLAS:LAS Multiple Majors-UIUC	N	\N	Fall 2021	ahaank2@illinois.edu
143	mkaplan6	r	651794267	M	Kaplan, Malcolm	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Anthropology	Liberal Arts & Sciences	10KV5348BSLA	BSLAS: Comp Sci & Anth-UIUC	N	\N	Fall 2021	mkaplan6@illinois.edu
144	agrimk2	r	679387572	M	Kataria, Agrim	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	agrimk2@illinois.edu
145	fkhwa2	r	665383585	F	Khwaja, Fiza Nuwera	3	1U	Junior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	fkhwa2@illinois.edu
146	minjaek3	r	660870418	M	Kim, Min Jae	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2019	minjaek3@illinois.edu
147	nkozlo3	r	679134441	M	Kozlowski, Neil Nikolajs	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2020	nkozlo3@illinois.edu
148	jiwool4	r	673451721	F	Lee, JiWoo	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	jiwool4@illinois.edu
149	dcl3	r	654621023	M	Lee, Mike	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2019	dcl3@illinois.edu
150	haoenl2	r	658954139	M	Lei, Haoen	3	1U	Senior	CS	421	PU	30792	BSLAS	Mathematics	Liberal Arts & Sciences	10KV8037BSLA	BSLAS:LAS Multiple Majors-UIUC	N	\N	Fall 2021	haoenl2@illinois.edu
152	wentaol4	r	657535327	M	Li, Victor	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Philosophy	Liberal Arts & Sciences	10KV5679BSLA	BSLAS: Comp Sci & Phil - UIUC	N	\N	Fall 2021	wentaol4@illinois.edu
153	flin24	r	667054950	F	Lin, Fay	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Chemistry	Liberal Arts & Sciences	10KV5350BSLA	BSLAS: Comp Sci & Chem-UIUC	N	\N	Fall 2021	flin24@illinois.edu
154	jl203	r	678643284	M	Liu, Juntian	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Summer 2022	jl203@illinois.edu
155	jrlundy2	r	659335143	F	Lundy, Jade	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Anthropology	Liberal Arts & Sciences	10KV5348BSLA	BSLAS: Comp Sci & Anth-UIUC	N	\N	Fall 2019	jrlundy2@illinois.edu
156	smadhan2	r	679331315	F	Madhan, Sam	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Economics	Liberal Arts & Sciences	10KV5667BSLA	BSLAS: Comp Sci & Econ - UIUC	N	\N	Fall 2021	smadhan2@illinois.edu
157	ethantm2	r	667270505	M	Mathew, Ethan Thomas	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	ethantm2@illinois.edu
158	jmcgr7	r	677792228	M	McGrath, Jacob	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Philosophy	Liberal Arts & Sciences	10KV5679BSLA	BSLAS: Comp Sci & Phil - UIUC	N	\N	Fall 2022	jmcgr7@illinois.edu
159	mcsaint2	r	669769102	M	McSaint, Kezzuo Lie	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	mcsaint2@illinois.edu
160	hoyoung4	r	679879286	M	Min, Max	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2019	hoyoung4@illinois.edu
161	ericjm4	r	678621981	M	Modesitt, Eric	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	ericjm4@illinois.edu
162	smukh4	r	651728669	M	Mukhopadhyay, Sarn	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV8037BSLA	BSLAS:LAS Multiple Majors-UIUC	N	\N	Fall 2021	smukh4@illinois.edu
163	shihyun2	r	679895419	M	Nam, Sean	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2020	shihyun2@illinois.edu
164	jneel5	r	672964350	M	Neela, Joshua Ratnam	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	jneel5@illinois.edu
165	danhn3	r	679411664	M	Nguyen, Dan Hien	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	danhn3@illinois.edu
167	jwp6	r	661056821	M	Park, Jongwon	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	jwp6@illinois.edu
168	spark336	r	667626430	F	Park, Supia	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	spark336@illinois.edu
169	apate563	r	663285778	M	Patel, Armaan Chetan	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	apate563@illinois.edu
170	anp6	r	670100733	M	Patel, Avi	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	anp6@illinois.edu
171	dimple2	r	667641824	F	Patel, Dimple Tusharkumar	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	dimple2@illinois.edu
172	nishkdp2	r	655207533	M	Patel, Nishk	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	nishkdp2@illinois.edu
173	uprasad3	r	651558364	M	Prasad, Utkarsh	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Astronomy	Liberal Arts & Sciences	10KV5349BSLA	BSLAS: Comp Sci & Astr-UIUC	N	\N	Fall 2021	uprasad3@illinois.edu
174	prerepa2	r	669979304	M	Prerepa, Aditya S	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Philosophy	Liberal Arts & Sciences	10KV5679BSLA	BSLAS: Comp Sci & Phil - UIUC	N	\N	Fall 2022	prerepa2@illinois.edu
175	spulla4	r	668971494	F	Pullabhotla, Shreya	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	spulla4@illinois.edu
176	rranga8	r	669852932	M	Ranganathan, Rishabh	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	rranga8@illinois.edu
177	aravan4	r	664658317	M	Ravanh, Anthany	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Summer 2022	aravan4@illinois.edu
178	rosen14	r	659994123	M	Rosen, Ben	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2020	rosen14@illinois.edu
179	alexr6	r	669466352	M	Rowe, Alex	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2023	alexr6@illinois.edu
180	dhruvks2	r	670046940	M	Saligram, Dhruv	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	dhruvks2@illinois.edu
181	soham4	r	669343082	M	Sarkar, Soham	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2022	soham4@illinois.edu
182	savalia2	r	667045744	M	Savalia, Yash Shailesh	3	1U	Senior	CS	421	PU	30792	BS	Engineering Physics	Grainger Engineering	10KP0121BS	BS:Engineering Physics -UIUC	N	\N	Fall 2021	savalia2@illinois.edu
183	adam11	r	655251697	M	Seskiewicz, Adam	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2020	adam11@illinois.edu
184	rsetlur2	r	656983110	M	Setlur, Rahul Srihari	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Linguistics	Liberal Arts & Sciences	10KV5351BSLA	BSLAS: Comp Sci & Ling-UIUC	N	\N	Fall 2020	rsetlur2@illinois.edu
185	assheth2	r	677516857	M	Sheth, Areet	3	1U	Senior	CS	421	PU	30792	BS	Mechanical Engineering	Grainger Engineering	10KP0133BS	BS:Mechanical Engineerng -UIUC	N	\N	Fall 2021	assheth2@illinois.edu
186	mshi24	r	658523554	F	Shi, Melissa	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2023	mshi24@illinois.edu
187	anujs3	r	650169128	M	Singla, Anuj	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	anujs3@illinois.edu
188	yssohn2	r	651733172	M	Sohn, Youngbo Suh	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	yssohn2@illinois.edu
189	jspevak2	r	664048087	M	Spevak, Joshua	3	1U	Freshman	CS	421	PU	30792	NDEG	Engineering	Grainger Engineering	10KP1211NDEU	NDEG:Engineering UG ONL - UIUC	N	\N		jspevak2@illinois.edu
190	ans15	r	674593523	M	Srinivasan, Adi	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	ans15@illinois.edu
191	cstile2	r	660999682	M	Stiles, Colsen	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2022	cstile2@illinois.edu
192	heweit2	r	675652871	M	Tang, Henry	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	heweit2@illinois.edu
193	clarkmt2	r	669616540	M	Taylor, Clark M	3	1U	Senior	CS	421	PU	30792	BS	Computer Engineering	Grainger Engineering	10KP0109BS	BS:Computer Engineering -UIUC	N	\N	Fall 2021	clarkmt2@illinois.edu
194	hthota3	r	660078990	F	Thota, Harshita	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Summer 2023	hthota3@illinois.edu
196	mohulv2	r	668999673	M	Varma, Mohul	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Anthropology	Liberal Arts & Sciences	10KV5348BSLA	BSLAS: Comp Sci & Anth-UIUC	N	\N	Fall 2018	mohulv2@illinois.edu
197	bwohanw2	r	674100968	M	Wang, Bwohan	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	bwohanw2@illinois.edu
198	yijia6	r	663174245	M	Wang, Yijia	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2022	yijia6@illinois.edu
199	rw17	r	676462950	M	Wu, Shane	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Linguistics	Liberal Arts & Sciences	10KV5351BSLA	BSLAS: Comp Sci & Ling-UIUC	N	\N	Spring 2021	rw17@illinois.edu
201	aryany2	r	651400843	M	Yadav, Aryan Kumar	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Astronomy	Liberal Arts & Sciences	10KV5349BSLA	BSLAS: Comp Sci & Astr-UIUC	N	\N	Fall 2018	aryany2@illinois.edu
202	sahansy2	r	654396857	M	Yalavarthi, Sahan Sai	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2022	sahansy2@illinois.edu
203	joyan2	r	675099333	M	Yan, Jeffrey	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Linguistics	Liberal Arts & Sciences	10KV5351BSLA	BSLAS: Comp Sci & Ling-UIUC	N	\N	Fall 2020	joyan2@illinois.edu
204	linday2	r	676884011	F	Yan, linda	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2023	linday2@illinois.edu
205	davidy4	r	671441315	M	Yang, David	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Linguistics	Liberal Arts & Sciences	10KV5351BSLA	BSLAS: Comp Sci & Ling-UIUC	N	\N	Fall 2020	davidy4@illinois.edu
206	yatzkan3	r	670390032	M	Yatzkan, Andrew	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	yatzkan3@illinois.edu
207	yyu69	r	652621341	M	Yu, Yingjie	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	yyu69@illinois.edu
208	xinming7	r	679542637	M	Zhai, Xinming	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	xinming7@illinois.edu
209	zhan39	r	665612177	M	Zhan, Xianyang	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2023	zhan39@illinois.edu
210	carolz3	r	674590986	F	Zhang, Acelynn	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	carolz3@illinois.edu
211	hangaoz2	r	661977579	M	Zhang, Hangao	3	1U	Senior	CS	421	PU	30792	BS	Computer Science&Crop Sciences	Agr, Consumer, & Env Sciences	10KL5623BS	BS: Comp Sci & Crop Sci - UIUC	N	\N	Spring 2023	hangaoz2@illinois.edu
212	jszhang4	r	663994259	M	Zhang, Jonathan Scott	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Sci & Anthropology	Liberal Arts & Sciences	10KV5348BSLA	BSLAS: Comp Sci & Anth-UIUC	N	\N	Fall 2021	jszhang4@illinois.edu
213	lukez4	r	678406936	M	Zhang, Luke	3	1U	Senior	CS	421	PU	30792	BSLAS	Statistics & Computer Science	Liberal Arts & Sciences	10KV0464BSLA	BSLAS:Stats & Comp Sci -UIUC	N	\N	Fall 2021	lukez4@illinois.edu
214	aazhao2	r	663699291	M	Zhao, Andrew Anduo	3	1U	Senior	CS	421	PU	30792	BS	Computer Science	Grainger Engineering	10KP0112BS	BS:Computer Science -UIUC	N	\N	Fall 2021	aazhao2@illinois.edu
215	szhao66	r	672253962	F	Zhao, Sarah	3	1U	Senior	CS	421	PU	30792	BSLAS	Computer Science & Economics	Liberal Arts & Sciences	10KV8037BSLA	BSLAS:LAS Multiple Majors-UIUC	N	\N	Fall 2021	szhao66@illinois.edu
200	sxianyu2	d	661045105	M	Xianyu, Siran	3	1U	Senior	CS	421	PU	30792	BSLAS	Math & Computer Science	Liberal Arts & Sciences	10KV1438BSLA	BSLAS:Math&Computer Sci -UIUC	N	\N	Fall 2021	sxianyu2@illinois.edu
\.


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: mattox
--

COPY public.zones (id, exam_id, assignment_id, slug, title, "order", max_points) FROM stdin;
28	21	50	final-unification-step	Unification Step	14	10
1	19	23	exam-1-direct-recursion	Direct Recursion	1	10
2	19	24	exam-1-tail-recursion	Tail Recursion	2	10
3	19	25	exam-1-using-hofs	Using HOFs	3	10
4	19	26	exam-1-algebraic-data-types	Algebraic Data Types	4	10
5	19	27	exam-1-lambda-calculus-reductions	Lambda Calculus Reductions	5	10
6	19	28	exam-1-interpreters	Interpreters	6	10
7	19	29	exam-1-big-step-semantics	Big Step Semantics	7	10
8	19	30	exam-1-continuation-passing-style	Continuation Passing Style	8	10
9	20	31	exam-2-grammar-properties	Grammar Properties	1	10
10	20	32	exam-2-first-and-follow-sets	FIRST and FOLLOW Sets	2	10
11	20	33	exam-2-ll-conversion	LL Conversion	3	10
12	20	34	exam-2-lr-parsing	LR Parsing	4	10
13	20	35	exam-2-monotype-proof	Monotype Proof	5	10
14	20	36	exam-2-unification-step	Unification Step	6	10
15	21	37	final-direct-recursion	Direct Recursion	1	10
16	21	38	final-tail-recursion	Tail Recursion	2	10
17	21	39	final-using-hofs	Using HOFs	3	10
18	21	40	final-algebraic-data-types	Algebraic Data Types	4	10
19	21	41	final-lambda-calculus-reductions	Lambda Calculus Reductions	5	10
20	21	42	final-interpreters	Interpreters	6	10
21	21	43	final-big-step-semantics	Big Step Semantics	7	10
22	21	44	final-continuation-passing-style	Continuation Passing Style	8	20
23	21	45	final-grammar-properties	Grammar Properties	9	10
24	21	46	final-first-and-follow-sets	FIRST and FOLLOW Sets	10	5
25	21	47	final-ll-conversion	LL Conversion	11	10
26	21	48	final-lr-parsing	LR Parsing	12	10
27	21	49	final-monotype-proof	Monotype Proof	13	10
\.


--
-- Name: assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.assignments_id_seq', 50, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.categories_id_seq', 15, true);


--
-- Name: coursera_uids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.coursera_uids_id_seq', 214, true);


--
-- Name: curve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.curve_id_seq', 1, false);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.grades_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.projects_id_seq', 107, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.questions_id_seq', 61, true);


--
-- Name: scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.scores_id_seq', 9962, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.students_id_seq', 215, true);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattox
--

SELECT pg_catalog.setval('public.zones_id_seq', 28, true);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: assignments assignments_slug_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_slug_key UNIQUE (slug);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: coursera_uids coursera_uids_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.coursera_uids
    ADD CONSTRAINT coursera_uids_pkey PRIMARY KEY (id);


--
-- Name: coursera_uids coursera_uids_uid_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.coursera_uids
    ADD CONSTRAINT coursera_uids_uid_key UNIQUE (uid);


--
-- Name: curve curve_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.curve
    ADD CONSTRAINT curve_pkey PRIMARY KEY (id);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: grades grades_student_id_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_id_key UNIQUE (student_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects projects_student_id_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_student_id_key UNIQUE (student_id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (id);


--
-- Name: scores scores_student_id_assignment_id_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_student_id_assignment_id_key UNIQUE (student_id, assignment_id);


--
-- Name: students students_netid_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_netid_key UNIQUE (netid);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students students_uin_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_uin_key UNIQUE (uin);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: zones zones_slug_key; Type: CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_slug_key UNIQUE (slug);


--
-- Name: assignments assignments_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: coursera_uids coursera_uids_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.coursera_uids
    ADD CONSTRAINT coursera_uids_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: grades grades_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: projects projects_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: questions questions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- Name: questions questions_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.assignments(id);


--
-- Name: questions questions_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.zones(id);


--
-- Name: scores scores_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- Name: scores scores_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: zones zones_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- Name: zones zones_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattox
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.assignments(id);


--
-- PostgreSQL database dump complete
--

