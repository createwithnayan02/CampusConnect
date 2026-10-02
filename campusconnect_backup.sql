--
-- PostgreSQL database dump
--

\restrict mhtPvZDxEGyYlA9YdlZHYMwAbDvserjcRYp1xB1wK6MvME5ehVA5WPLCvsbEcqV

-- Dumped from database version 17.10
-- Dumped by pg_dump version 18.3

-- Started on 2026-10-02 17:15:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 16584)
-- Name: application_status_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_status_history (
    history_id integer NOT NULL,
    application_id integer NOT NULL,
    old_status character varying(20),
    new_status character varying(20) NOT NULL,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.application_status_history OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16583)
-- Name: application_status_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_status_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_status_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 230
-- Name: application_status_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_status_history_history_id_seq OWNED BY public.application_status_history.history_id;


--
-- TOC entry 227 (class 1259 OID 16546)
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    application_id integer NOT NULL,
    student_id integer NOT NULL,
    job_id integer NOT NULL,
    applied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'Applied'::character varying NOT NULL,
    CONSTRAINT applications_status_check CHECK (((status)::text = ANY ((ARRAY['Applied'::character varying, 'Shortlisted'::character varying, 'Interview'::character varying, 'Selected'::character varying, 'Rejected'::character varying, 'Withdrawn'::character varying])::text[])))
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16545)
-- Name: applications_application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applications_application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applications_application_id_seq OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 226
-- Name: applications_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_application_id_seq OWNED BY public.applications.application_id;


--
-- TOC entry 220 (class 1259 OID 16490)
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    company_id integer NOT NULL,
    company_name character varying(150) NOT NULL,
    industry character varying(100),
    location character varying(100),
    website character varying(255),
    email character varying(150),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16489)
-- Name: companies_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_company_id_seq OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 219
-- Name: companies_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_company_id_seq OWNED BY public.companies.company_id;


--
-- TOC entry 229 (class 1259 OID 16568)
-- Name: interviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interviews (
    interview_id integer NOT NULL,
    application_id integer NOT NULL,
    round_name character varying(50) NOT NULL,
    scheduled_at timestamp without time zone NOT NULL,
    mode character varying(20) NOT NULL,
    result character varying(20),
    remarks text,
    CONSTRAINT interviews_mode_check CHECK (((mode)::text = ANY ((ARRAY['Online'::character varying, 'Offline'::character varying])::text[]))),
    CONSTRAINT interviews_result_check CHECK (((result)::text = ANY ((ARRAY['Pending'::character varying, 'Passed'::character varying, 'Failed'::character varying])::text[])))
);


ALTER TABLE public.interviews OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16567)
-- Name: interviews_interview_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interviews_interview_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interviews_interview_id_seq OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 228
-- Name: interviews_interview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interviews_interview_id_seq OWNED BY public.interviews.interview_id;


--
-- TOC entry 224 (class 1259 OID 16511)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    job_id integer NOT NULL,
    company_id integer NOT NULL,
    title character varying(150) NOT NULL,
    job_type character varying(30) NOT NULL,
    description text,
    location character varying(100),
    minimum_cgpa numeric(3,2),
    application_deadline date NOT NULL,
    status character varying(20) DEFAULT 'Open'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT jobs_job_type_check CHECK (((job_type)::text = ANY ((ARRAY['Internship'::character varying, 'Full-Time'::character varying, 'Part-Time'::character varying])::text[]))),
    CONSTRAINT jobs_minimum_cgpa_check CHECK (((minimum_cgpa >= (0)::numeric) AND (minimum_cgpa <= (10)::numeric))),
    CONSTRAINT jobs_status_check CHECK (((status)::text = ANY ((ARRAY['Open'::character varying, 'Closed'::character varying])::text[])))
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16510)
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_job_id_seq OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 223
-- Name: jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_job_id_seq OWNED BY public.jobs.job_id;


--
-- TOC entry 222 (class 1259 OID 16502)
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    skill_name character varying(100) NOT NULL,
    category character varying(100)
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16501)
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_skill_id_seq OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 221
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- TOC entry 225 (class 1259 OID 16529)
-- Name: student_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_skills (
    student_id integer NOT NULL,
    skill_id integer NOT NULL,
    proficiency_level character varying(20) NOT NULL,
    CONSTRAINT student_skills_proficiency_level_check CHECK (((proficiency_level)::text = ANY ((ARRAY['Beginner'::character varying, 'Intermediate'::character varying, 'Advanced'::character varying])::text[])))
);


ALTER TABLE public.student_skills OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16476)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    roll_number character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(15),
    department character varying(100) NOT NULL,
    year integer NOT NULL,
    cgpa numeric(3,2) NOT NULL,
    graduation_year integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT students_cgpa_check CHECK (((cgpa >= (0)::numeric) AND (cgpa <= (10)::numeric))),
    CONSTRAINT students_year_check CHECK (((year >= 1) AND (year <= 4)))
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16475)
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 217
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- TOC entry 4788 (class 2604 OID 16587)
-- Name: application_status_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_status_history ALTER COLUMN history_id SET DEFAULT nextval('public.application_status_history_history_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16549)
-- Name: applications application_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN application_id SET DEFAULT nextval('public.applications_application_id_seq'::regclass);


--
-- TOC entry 4778 (class 2604 OID 16493)
-- Name: companies company_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN company_id SET DEFAULT nextval('public.companies_company_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 16571)
-- Name: interviews interview_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews ALTER COLUMN interview_id SET DEFAULT nextval('public.interviews_interview_id_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 16514)
-- Name: jobs job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN job_id SET DEFAULT nextval('public.jobs_job_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 16505)
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 16479)
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- TOC entry 4997 (class 0 OID 16584)
-- Dependencies: 231
-- Data for Name: application_status_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_status_history (history_id, application_id, old_status, new_status, changed_at) FROM stdin;
1	1	Applied	Shortlisted	2026-09-05 10:00:00
2	3	Applied	Rejected	2026-09-10 16:30:00
3	4	Applied	Shortlisted	2026-09-06 11:15:00
4	6	Applied	Interview	2026-09-08 14:00:00
5	8	Applied	Interview	2026-09-12 10:30:00
6	10	Applied	Shortlisted	2026-09-10 12:00:00
7	11	Applied	Selected	2026-09-15 17:00:00
8	12	Applied	Interview	2026-09-16 13:00:00
9	15	Applied	Shortlisted	2026-09-18 11:00:00
10	20	Applied	Interview	2026-09-20 15:00:00
\.


--
-- TOC entry 4993 (class 0 OID 16546)
-- Dependencies: 227
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (application_id, student_id, job_id, applied_at, status) FROM stdin;
1	1	1	2026-09-01 10:15:00	Shortlisted
2	1	5	2026-09-02 11:30:00	Applied
3	2	2	2026-09-01 09:45:00	Interview
4	2	5	2026-09-03 14:20:00	Selected
5	3	3	2026-09-02 10:00:00	Rejected
6	3	4	2026-09-04 12:10:00	Shortlisted
7	4	2	2026-09-05 09:30:00	Applied
8	4	5	2026-09-05 15:00:00	Interview
9	5	1	2026-09-06 11:45:00	Applied
10	5	6	2026-09-07 13:20:00	Shortlisted
11	6	5	2026-09-01 10:30:00	Selected
12	6	6	2026-09-04 16:15:00	Interview
13	7	1	2026-09-08 09:20:00	Rejected
14	7	3	2026-09-09 12:30:00	Applied
15	8	2	2026-09-10 10:00:00	Shortlisted
16	8	7	2026-09-11 14:45:00	Applied
17	9	1	2026-09-12 11:10:00	Applied
18	9	8	2026-09-13 15:30:00	Rejected
19	10	5	2026-09-14 09:50:00	Selected
20	10	6	2026-09-15 13:40:00	Interview
21	3	2	2026-10-02 15:57:01.211008	Applied
22	5	7	2026-10-02 16:27:50.668222	Applied
\.


--
-- TOC entry 4986 (class 0 OID 16490)
-- Dependencies: 220
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (company_id, company_name, industry, location, website, email, created_at) FROM stdin;
1	TechNova Solutions	Information Technology	Pune	https://www.technova.example.com	hr@technova.example.com	2026-09-29 15:48:31.02201
2	InnoSoft Technologies	Software Development	Bangalore	https://www.innosoft.example.com	careers@innosoft.example.com	2026-09-29 15:48:31.02201
3	DataSphere Analytics	Data Analytics	Mumbai	https://www.datasphere.example.com	hr@datasphere.example.com	2026-09-29 15:48:31.02201
4	CloudPeak Systems	Cloud Computing	Hyderabad	https://www.cloudpeak.example.com	jobs@cloudpeak.example.com	2026-09-29 15:48:31.02201
5	FinEdge Technologies	FinTech	Pune	https://www.finedge.example.com	careers@finedge.example.com	2026-09-29 15:48:31.02201
\.


--
-- TOC entry 4995 (class 0 OID 16568)
-- Dependencies: 229
-- Data for Name: interviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interviews (interview_id, application_id, round_name, scheduled_at, mode, result, remarks) FROM stdin;
1	3	Technical Round	2026-09-20 10:00:00	Online	Passed	Good understanding of programming concepts.
2	3	HR Round	2026-09-22 11:00:00	Online	Pending	HR discussion scheduled.
3	8	Technical Round	2026-09-21 14:00:00	Offline	Passed	Strong technical performance.
4	8	HR Round	2026-09-23 12:00:00	Offline	Pending	Final HR discussion.
5	11	Technical Round	2026-09-19 10:30:00	Online	Passed	Strong SQL and analytical skills.
6	12	Technical Round	2026-09-24 15:00:00	Online	Passed	Good knowledge of data analysis.
7	15	Technical Round	2026-09-25 11:00:00	Offline	Passed	Good web development fundamentals.
8	20	Technical Round	2026-09-26 10:00:00	Online	Pending	Technical evaluation in progress.
\.


--
-- TOC entry 4990 (class 0 OID 16511)
-- Dependencies: 224
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (job_id, company_id, title, job_type, description, location, minimum_cgpa, application_deadline, status, created_at) FROM stdin;
1	1	Python Developer Intern	Internship	Work on Python-based web applications and backend development.	Pune	7.50	2026-10-15	Open	2026-09-29 15:51:48.508926
2	1	Full Stack Developer	Full-Time	Develop and maintain web applications using modern technologies.	Pune	8.00	2026-10-20	Open	2026-09-29 15:51:48.508926
3	2	Java Developer Intern	Internship	Assist in developing and testing enterprise Java applications.	Bangalore	7.00	2026-10-12	Open	2026-09-29 15:51:48.508926
4	2	Software Engineer	Full-Time	Design, develop and maintain scalable software solutions.	Bangalore	8.50	2026-10-25	Open	2026-09-29 15:51:48.508926
5	3	Data Analyst Intern	Internship	Analyze datasets and prepare reports to support business decisions.	Mumbai	7.50	2026-10-18	Open	2026-09-29 15:51:48.508926
6	3	Junior Data Analyst	Full-Time	Work with business data, SQL queries and analytical dashboards.	Mumbai	8.00	2026-10-30	Open	2026-09-29 15:51:48.508926
7	4	Cloud Engineering Intern	Internship	Assist with cloud infrastructure and deployment activities.	Hyderabad	8.00	2026-10-22	Open	2026-09-29 15:51:48.508926
8	5	Software Developer Intern	Internship	Develop software solutions for financial technology applications.	Pune	7.50	2026-10-28	Open	2026-09-29 15:51:48.508926
\.


--
-- TOC entry 4988 (class 0 OID 16502)
-- Dependencies: 222
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (skill_id, skill_name, category) FROM stdin;
1	Python	Programming
2	Java	Programming
3	C++	Programming
4	JavaScript	Web Development
5	HTML/CSS	Web Development
6	SQL	Database
7	Flask	Web Development
8	React	Web Development
9	Data Analysis	Data Science
10	Git/GitHub	Tools
\.


--
-- TOC entry 4991 (class 0 OID 16529)
-- Dependencies: 225
-- Data for Name: student_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_skills (student_id, skill_id, proficiency_level) FROM stdin;
1	1	Advanced
1	6	Intermediate
1	7	Intermediate
2	4	Advanced
2	5	Advanced
2	6	Intermediate
2	8	Intermediate
3	2	Advanced
3	6	Advanced
3	10	Intermediate
4	4	Advanced
4	5	Advanced
4	8	Intermediate
5	3	Advanced
5	6	Intermediate
5	10	Advanced
6	4	Advanced
6	6	Advanced
6	9	Advanced
7	1	Intermediate
7	3	Intermediate
7	6	Intermediate
8	4	Intermediate
8	5	Advanced
8	8	Advanced
9	1	Advanced
9	6	Intermediate
9	10	Intermediate
10	4	Advanced
10	6	Advanced
10	9	Advanced
11	2	Advanced
11	6	Advanced
11	10	Intermediate
12	1	Intermediate
12	5	Advanced
12	7	Intermediate
13	3	Advanced
13	6	Intermediate
13	10	Advanced
14	4	Advanced
14	6	Advanced
14	9	Intermediate
15	1	Intermediate
15	3	Advanced
15	6	Intermediate
\.


--
-- TOC entry 4984 (class 0 OID 16476)
-- Dependencies: 218
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, roll_number, name, email, phone, department, year, cgpa, graduation_year, created_at) FROM stdin;
1	IT001	Aarav Sharma	aarav.sharma@example.com	9876501001	Information Technology	4	8.72	2027	2026-09-29 15:17:40.368681
2	IT002	Riya Patil	riya.patil@example.com	9876501002	Information Technology	3	9.15	2028	2026-09-29 15:17:40.368681
3	IT003	Aditya Kulkarni	aditya.kulkarni@example.com	9876501003	Information Technology	4	8.45	2027	2026-09-29 15:17:40.368681
4	IT004	Sneha Joshi	sneha.joshi@example.com	9876501004	Information Technology	3	8.91	2028	2026-09-29 15:17:40.368681
5	IT005	Kabir Deshmukh	kabir.deshmukh@example.com	9876501005	Computer Engineering	4	7.86	2027	2026-09-29 15:17:40.368681
6	IT006	Ananya More	ananya.more@example.com	9876501006	Computer Engineering	3	9.32	2028	2026-09-29 15:17:40.368681
7	IT007	Rahul Pawar	rahul.pawar@example.com	9876501007	Information Technology	4	8.18	2027	2026-09-29 15:17:40.368681
8	IT008	Meera Shah	meera.shah@example.com	9876501008	Computer Engineering	3	8.67	2028	2026-09-29 15:17:40.368681
9	IT009	Omkar Jadhav	omkar.jadhav@example.com	9876501009	Information Technology	4	7.54	2027	2026-09-29 15:17:40.368681
10	IT010	Ishita Verma	ishita.verma@example.com	9876501010	Information Technology	3	9.48	2028	2026-09-29 15:17:40.368681
11	IT011	Arjun Nair	arjun.nair@example.com	9876501011	Computer Engineering	4	8.36	2027	2026-09-29 15:17:40.368681
12	IT012	Priya Singh	priya.singh@example.com	9876501012	Information Technology	3	8.79	2028	2026-09-29 15:17:40.368681
13	IT013	Vivek Mishra	vivek.mishra@example.com	9876501013	Information Technology	4	7.92	2027	2026-09-29 15:17:40.368681
14	IT014	Kavya Reddy	kavya.reddy@example.com	9876501014	Computer Engineering	3	9.06	2028	2026-09-29 15:17:40.368681
15	IT015	Yash Thakur	yash.thakur@example.com	9876501015	Information Technology	4	8.11	2027	2026-09-29 15:17:40.368681
\.


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 230
-- Name: application_status_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_status_history_history_id_seq', 10, true);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 226
-- Name: applications_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_application_id_seq', 22, true);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 219
-- Name: companies_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_company_id_seq', 5, true);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 228
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interviews_interview_id_seq', 8, true);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 223
-- Name: jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_job_id_seq', 8, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 221
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 10, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 217
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 15, true);


--
-- TOC entry 4829 (class 2606 OID 16590)
-- Name: application_status_history application_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_status_history
    ADD CONSTRAINT application_status_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 4820 (class 2606 OID 16554)
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (application_id);


--
-- TOC entry 4806 (class 2606 OID 16500)
-- Name: companies companies_company_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_company_name_key UNIQUE (company_name);


--
-- TOC entry 4808 (class 2606 OID 16498)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (company_id);


--
-- TOC entry 4827 (class 2606 OID 16577)
-- Name: interviews interviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_pkey PRIMARY KEY (interview_id);


--
-- TOC entry 4815 (class 2606 OID 16523)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- TOC entry 4810 (class 2606 OID 16507)
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- TOC entry 4812 (class 2606 OID 16509)
-- Name: skills skills_skill_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_skill_name_key UNIQUE (skill_name);


--
-- TOC entry 4818 (class 2606 OID 16534)
-- Name: student_skills student_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_skills
    ADD CONSTRAINT student_skills_pkey PRIMARY KEY (student_id, skill_id);


--
-- TOC entry 4800 (class 2606 OID 16488)
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- TOC entry 4802 (class 2606 OID 16484)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4804 (class 2606 OID 16486)
-- Name: students students_roll_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_roll_number_key UNIQUE (roll_number);


--
-- TOC entry 4824 (class 2606 OID 16556)
-- Name: applications unique_student_job; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT unique_student_job UNIQUE (student_id, job_id);


--
-- TOC entry 4821 (class 1259 OID 16599)
-- Name: idx_applications_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_job_id ON public.applications USING btree (job_id);


--
-- TOC entry 4822 (class 1259 OID 16598)
-- Name: idx_applications_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_student_id ON public.applications USING btree (student_id);


--
-- TOC entry 4825 (class 1259 OID 16600)
-- Name: idx_interviews_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_interviews_application_id ON public.interviews USING btree (application_id);


--
-- TOC entry 4813 (class 1259 OID 16596)
-- Name: idx_jobs_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_jobs_company_id ON public.jobs USING btree (company_id);


--
-- TOC entry 4830 (class 1259 OID 16601)
-- Name: idx_status_history_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_status_history_application_id ON public.application_status_history USING btree (application_id);


--
-- TOC entry 4816 (class 1259 OID 16597)
-- Name: idx_student_skills_skill_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_student_skills_skill_id ON public.student_skills USING btree (skill_id);


--
-- TOC entry 4834 (class 2606 OID 16562)
-- Name: applications fk_applications_job; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT fk_applications_job FOREIGN KEY (job_id) REFERENCES public.jobs(job_id) ON DELETE CASCADE;


--
-- TOC entry 4835 (class 2606 OID 16557)
-- Name: applications fk_applications_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT fk_applications_student FOREIGN KEY (student_id) REFERENCES public.students(student_id) ON DELETE CASCADE;


--
-- TOC entry 4836 (class 2606 OID 16578)
-- Name: interviews fk_interviews_application; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT fk_interviews_application FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON DELETE CASCADE;


--
-- TOC entry 4831 (class 2606 OID 16524)
-- Name: jobs fk_jobs_company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_jobs_company FOREIGN KEY (company_id) REFERENCES public.companies(company_id);


--
-- TOC entry 4837 (class 2606 OID 16591)
-- Name: application_status_history fk_status_history_application; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_status_history
    ADD CONSTRAINT fk_status_history_application FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON DELETE CASCADE;


--
-- TOC entry 4832 (class 2606 OID 16540)
-- Name: student_skills fk_student_skills_skill; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_skills
    ADD CONSTRAINT fk_student_skills_skill FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id) ON DELETE CASCADE;


--
-- TOC entry 4833 (class 2606 OID 16535)
-- Name: student_skills fk_student_skills_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_skills
    ADD CONSTRAINT fk_student_skills_student FOREIGN KEY (student_id) REFERENCES public.students(student_id) ON DELETE CASCADE;


-- Completed on 2026-10-02 17:15:57

--
-- PostgreSQL database dump complete
--

\unrestrict mhtPvZDxEGyYlA9YdlZHYMwAbDvserjcRYp1xB1wK6MvME5ehVA5WPLCvsbEcqV

