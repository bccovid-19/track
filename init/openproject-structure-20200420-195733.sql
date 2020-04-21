-- PostgreSQL SQL dump to import OpenProject structural tables, e.g. workflows and custom fields

DROP TABLE custom_fields CASCADE;
DROP TABLE custom_fields_projects CASCADE;
DROP TABLE custom_fields_types CASCADE;
DROP TABLE custom_options CASCADE;
DROP TABLE custom_values CASCADE;
DROP TABLE enterprise_tokens CASCADE;
DROP TABLE grid_widgets CASCADE;
DROP TABLE grids CASCADE;
DROP TABLE project_statuses CASCADE;
DROP TABLE projects CASCADE;
DROP TABLE projects_types CASCADE;
DROP TABLE queries CASCADE;
DROP TABLE role_permissions CASCADE;
DROP TABLE roles CASCADE;
DROP TABLE statuses CASCADE;
DROP TABLE types CASCADE;
DROP TABLE webhooks_events CASCADE;
DROP TABLE webhooks_webhooks CASCADE;
DROP TABLE workflows CASCADE;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Debian 10.12-2.pgdg90+1)
-- Dumped by pg_dump version 10.12 (Debian 10.12-2.pgdg90+1)

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_fields (
    id integer NOT NULL,
    type character varying(30) DEFAULT ''::character varying NOT NULL,
    field_format character varying(30) DEFAULT ''::character varying NOT NULL,
    regexp character varying DEFAULT ''::character varying,
    min_length integer DEFAULT 0 NOT NULL,
    max_length integer DEFAULT 0 NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    is_for_all boolean DEFAULT false NOT NULL,
    is_filter boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 1,
    searchable boolean DEFAULT false,
    editable boolean DEFAULT true,
    visible boolean DEFAULT true NOT NULL,
    multi_value boolean DEFAULT false,
    default_value text,
    name character varying(255) DEFAULT NULL::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    content_right_to_left boolean DEFAULT false
);


ALTER TABLE public.custom_fields OWNER TO postgres;

--
-- Name: custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.custom_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_fields_id_seq OWNER TO postgres;

--
-- Name: custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.custom_fields_id_seq OWNED BY public.custom_fields.id;


--
-- Name: custom_fields_projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_fields_projects (
    custom_field_id integer DEFAULT 0 NOT NULL,
    project_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_fields_projects OWNER TO postgres;

--
-- Name: custom_fields_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_fields_types (
    custom_field_id integer DEFAULT 0 NOT NULL,
    type_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_fields_types OWNER TO postgres;

--
-- Name: custom_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_options (
    id integer NOT NULL,
    custom_field_id integer,
    "position" integer,
    default_value boolean,
    value text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.custom_options OWNER TO postgres;

--
-- Name: custom_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.custom_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_options_id_seq OWNER TO postgres;

--
-- Name: custom_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.custom_options_id_seq OWNED BY public.custom_options.id;


--
-- Name: custom_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_values (
    id integer NOT NULL,
    customized_type character varying(30) DEFAULT ''::character varying NOT NULL,
    customized_id integer DEFAULT 0 NOT NULL,
    custom_field_id integer DEFAULT 0 NOT NULL,
    value text
);


ALTER TABLE public.custom_values OWNER TO postgres;

--
-- Name: custom_values_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.custom_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_values_id_seq OWNER TO postgres;

--
-- Name: custom_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.custom_values_id_seq OWNED BY public.custom_values.id;


--
-- Name: enterprise_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enterprise_tokens (
    id integer NOT NULL,
    encoded_token text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.enterprise_tokens OWNER TO postgres;

--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enterprise_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enterprise_tokens_id_seq OWNER TO postgres;

--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enterprise_tokens_id_seq OWNED BY public.enterprise_tokens.id;


--
-- Name: grid_widgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grid_widgets (
    id bigint NOT NULL,
    start_row integer NOT NULL,
    end_row integer NOT NULL,
    start_column integer NOT NULL,
    end_column integer NOT NULL,
    identifier character varying,
    options text,
    grid_id bigint
);


ALTER TABLE public.grid_widgets OWNER TO postgres;

--
-- Name: grid_widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grid_widgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grid_widgets_id_seq OWNER TO postgres;

--
-- Name: grid_widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grid_widgets_id_seq OWNED BY public.grid_widgets.id;


--
-- Name: grids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grids (
    id bigint NOT NULL,
    row_count integer NOT NULL,
    column_count integer NOT NULL,
    type character varying,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    project_id bigint,
    name text,
    options text
);


ALTER TABLE public.grids OWNER TO postgres;

--
-- Name: grids_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grids_id_seq OWNER TO postgres;

--
-- Name: grids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grids_id_seq OWNED BY public.grids.id;


--
-- Name: project_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_statuses (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    explanation text,
    code integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.project_statuses OWNER TO postgres;

--
-- Name: project_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_statuses_id_seq OWNER TO postgres;

--
-- Name: project_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_statuses_id_seq OWNED BY public.project_statuses.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description text,
    public boolean DEFAULT true NOT NULL,
    parent_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    identifier character varying,
    lft integer,
    rgt integer,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: projects_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_types (
    project_id integer DEFAULT 0 NOT NULL,
    type_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.projects_types OWNER TO postgres;

--
-- Name: queries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.queries (
    id integer NOT NULL,
    project_id integer,
    name character varying DEFAULT ''::character varying NOT NULL,
    filters text,
    user_id integer DEFAULT 0 NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    column_names text,
    sort_criteria text,
    group_by character varying,
    display_sums boolean DEFAULT false NOT NULL,
    timeline_visible boolean DEFAULT false,
    show_hierarchies boolean DEFAULT false,
    timeline_zoom_level integer DEFAULT 5,
    timeline_labels text,
    highlighting_mode text,
    highlighted_attributes text,
    hidden boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    display_representation text
);


ALTER TABLE public.queries OWNER TO postgres;

--
-- Name: queries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.queries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queries_id_seq OWNER TO postgres;

--
-- Name: queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.queries_id_seq OWNED BY public.queries.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id integer NOT NULL,
    permission character varying,
    role_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_permissions_id_seq OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    "position" integer DEFAULT 1,
    assignable boolean DEFAULT true,
    builtin integer DEFAULT 0 NOT NULL,
    type character varying(30) DEFAULT 'Role'::character varying
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statuses (
    id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    is_closed boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 1,
    default_done_ratio integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    color_id integer,
    is_readonly boolean DEFAULT false
);


ALTER TABLE public.statuses OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.types (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    "position" integer DEFAULT 1,
    is_in_roadmap boolean DEFAULT true NOT NULL,
    is_milestone boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    color_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_standard boolean DEFAULT false NOT NULL,
    attribute_groups text,
    description text
);


ALTER TABLE public.types OWNER TO postgres;

--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_id_seq OWNER TO postgres;

--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;


--
-- Name: webhooks_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhooks_events (
    id integer NOT NULL,
    name character varying,
    webhooks_webhook_id integer
);


ALTER TABLE public.webhooks_events OWNER TO postgres;

--
-- Name: webhooks_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhooks_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhooks_events_id_seq OWNER TO postgres;

--
-- Name: webhooks_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhooks_events_id_seq OWNED BY public.webhooks_events.id;


--
-- Name: webhooks_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhooks_webhooks (
    id integer NOT NULL,
    name character varying,
    url text,
    description text NOT NULL,
    secret character varying,
    enabled boolean NOT NULL,
    all_projects boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.webhooks_webhooks OWNER TO postgres;

--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.webhooks_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhooks_webhooks_id_seq OWNER TO postgres;

--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.webhooks_webhooks_id_seq OWNED BY public.webhooks_webhooks.id;


--
-- Name: workflows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflows (
    id integer NOT NULL,
    type_id integer DEFAULT 0 NOT NULL,
    old_status_id integer DEFAULT 0 NOT NULL,
    new_status_id integer DEFAULT 0 NOT NULL,
    role_id integer DEFAULT 0 NOT NULL,
    assignee boolean DEFAULT false NOT NULL,
    author boolean DEFAULT false NOT NULL
);


ALTER TABLE public.workflows OWNER TO postgres;

--
-- Name: workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflows_id_seq OWNER TO postgres;

--
-- Name: workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workflows_id_seq OWNED BY public.workflows.id;


--
-- Name: custom_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_fields ALTER COLUMN id SET DEFAULT nextval('public.custom_fields_id_seq'::regclass);


--
-- Name: custom_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_options ALTER COLUMN id SET DEFAULT nextval('public.custom_options_id_seq'::regclass);


--
-- Name: custom_values id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_values ALTER COLUMN id SET DEFAULT nextval('public.custom_values_id_seq'::regclass);


--
-- Name: enterprise_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enterprise_tokens ALTER COLUMN id SET DEFAULT nextval('public.enterprise_tokens_id_seq'::regclass);


--
-- Name: grid_widgets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grid_widgets ALTER COLUMN id SET DEFAULT nextval('public.grid_widgets_id_seq'::regclass);


--
-- Name: grids id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grids ALTER COLUMN id SET DEFAULT nextval('public.grids_id_seq'::regclass);


--
-- Name: project_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_statuses ALTER COLUMN id SET DEFAULT nextval('public.project_statuses_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: queries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.queries ALTER COLUMN id SET DEFAULT nextval('public.queries_id_seq'::regclass);


--
-- Name: role_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: webhooks_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks_events ALTER COLUMN id SET DEFAULT nextval('public.webhooks_events_id_seq'::regclass);


--
-- Name: webhooks_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks_webhooks ALTER COLUMN id SET DEFAULT nextval('public.webhooks_webhooks_id_seq'::regclass);


--
-- Name: workflows id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows ALTER COLUMN id SET DEFAULT nextval('public.workflows_id_seq'::regclass);


--
-- Data for Name: custom_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_fields (id, type, field_format, regexp, min_length, max_length, is_required, is_for_all, is_filter, "position", searchable, editable, visible, multi_value, default_value, name, created_at, updated_at, content_right_to_left) FROM stdin;
1	WorkPackageCustomField	string		0	0	t	f	f	1	f	t	t	f		Facility Name	2020-04-01 11:44:16.723056	2020-04-01 11:44:16.723056	f
2	WorkPackageCustomField	list		0	0	t	f	t	2	f	t	t	f	\N	Facility Type	2020-04-01 11:48:08.549251	2020-04-01 11:48:08.573533	f
3	WorkPackageCustomField	text		0	0	f	f	f	3	f	t	t	f		Facility Address	2020-04-01 11:49:02.10187	2020-04-01 11:49:02.10187	f
4	WorkPackageCustomField	string		0	0	t	f	f	4	f	t	t	f		Contact Name	2020-04-01 11:49:46.904514	2020-04-01 11:49:46.904514	f
5	WorkPackageCustomField	string		0	0	t	f	f	5	f	t	t	f		Contact Phone	2020-04-01 11:50:19.454268	2020-04-01 11:50:19.454268	f
6	WorkPackageCustomField	list		0	0	t	f	t	6	t	t	t	f	\N	Urgency	2020-04-01 11:52:37.640744	2020-04-01 11:52:37.651356	f
7	WorkPackageCustomField	int		0	0	t	f	f	7	f	t	t	f		Face Shield Frame	2020-04-01 11:53:54.574294	2020-04-01 11:53:54.574294	f
8	WorkPackageCustomField	int		0	0	t	f	f	8	f	t	t	f		Visors	2020-04-01 11:54:22.25433	2020-04-01 11:54:22.25433	f
10	WorkPackageCustomField	text		0	0	t	f	f	10	f	t	t	f		Pickup Address	2020-04-01 12:01:07.441556	2020-04-01 12:01:07.441556	f
11	WorkPackageCustomField	text		0	0	t	f	f	11	f	t	t	f		Delivery Address	2020-04-01 12:01:25.463548	2020-04-01 12:01:25.463548	f
12	WorkPackageCustomField	string		0	0	f	f	f	12	f	t	t	f		Pickup Contact Name	2020-04-01 12:01:57.179986	2020-04-01 12:01:57.179986	f
13	WorkPackageCustomField	string		0	0	f	f	f	13	f	t	t	f		Pickup Contact Phone	2020-04-01 12:02:08.873165	2020-04-01 12:02:08.873165	f
14	WorkPackageCustomField	string		0	0	f	f	f	14	f	t	t	f		Delivery Contact Name	2020-04-01 12:02:25.471354	2020-04-01 12:02:25.471354	f
15	WorkPackageCustomField	string		0	0	f	f	f	15	f	t	t	f		Delivery Contact Phone	2020-04-01 12:02:36.557386	2020-04-01 12:02:36.557386	f
9	WorkPackageCustomField	int		0	0	t	f	f	9	f	t	t	f		Ear Savers	2020-04-01 11:55:31.23641	2020-04-04 18:11:46.459409	f
16	WorkPackageCustomField	string		0	0	f	f	f	16	t	t	t	f		Region	2020-04-09 00:07:39.641418	2020-04-09 00:08:27.545611	f
17	WorkPackageCustomField	text		0	0	f	t	f	17	f	t	t	f		Comment	2020-04-11 21:57:54.695347	2020-04-11 21:57:54.695347	f
18	WorkPackageCustomField	string		0	0	f	t	f	18	f	t	t	f		Contact Email	2020-04-11 21:58:27.280688	2020-04-13 19:07:56.348237	f
\.


--
-- Data for Name: custom_fields_projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_fields_projects (custom_field_id, project_id) FROM stdin;
1	3
2	3
3	3
4	3
5	3
6	3
7	3
8	3
9	3
10	3
11	3
12	3
13	3
14	3
15	3
16	3
1	5
2	5
3	5
4	5
5	5
6	5
7	5
8	5
9	5
10	5
11	5
12	5
13	5
14	5
15	5
16	5
\.


--
-- Data for Name: custom_fields_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_fields_types (custom_field_id, type_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	3
12	3
13	3
11	3
14	3
15	3
7	4
8	4
9	4
16	1
16	4
16	3
18	1
17	1
\.


--
-- Data for Name: custom_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_options (id, custom_field_id, "position", default_value, value, created_at, updated_at) FROM stdin;
8	6	1	f	Staff are working without face shields	2020-04-01 11:52:37.64399	2020-04-01 11:52:37.64399
9	6	2	\N	Face shields are expected to run out in days	2020-04-01 11:52:37.646647	2020-04-01 11:52:37.646647
1	2	4	f	Primary Care	2020-04-01 11:48:08.55324	2020-04-01 11:52:37.649552
2	2	5	\N	Nursing Home	2020-04-01 11:48:08.557268	2020-04-01 11:52:37.649552
3	2	6	\N	Specialist	2020-04-01 11:48:08.560131	2020-04-01 11:52:37.649552
4	2	7	\N	Hospital	2020-04-01 11:48:08.563005	2020-04-01 11:52:37.649552
5	2	8	\N	Health Authority / Other Organization	2020-04-01 11:48:08.565745	2020-04-01 11:52:37.649552
6	2	9	\N	Pharmacy	2020-04-01 11:48:08.568456	2020-04-01 11:52:37.649552
7	2	10	\N	Other	2020-04-01 11:48:08.57118	2020-04-01 11:52:37.649552
10	6	3	\N	Still have adequate stock available 	2020-04-01 11:52:37.649167	2020-04-01 11:52:37.649167
\.


--
-- Data for Name: custom_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_values (id, customized_type, customized_id, custom_field_id, value) FROM stdin;
585	WorkPackage	156	4	Maria Singson 
586	WorkPackage	156	5	6044466729
587	WorkPackage	156	9	20
588	WorkPackage	156	7	20
589	WorkPackage	156	3	2785 Ash St, Vancouver, BC V5Z 1M9
590	WorkPackage	156	1	Banfield Pavilion 
591	WorkPackage	156	2	2
593	WorkPackage	156	6	9
594	WorkPackage	156	8	0
596	WorkPackage	157	5	6043642773
597	WorkPackage	157	9	100
598	WorkPackage	157	7	0
600	WorkPackage	157	1	Mission memorial hospital 
601	WorkPackage	157	2	4
603	WorkPackage	157	6	10
604	WorkPackage	157	8	0
745	WorkPackage	172	4	Tyson Walters 
746	WorkPackage	172	5	250-732-5979
747	WorkPackage	172	9	200
748	WorkPackage	172	7	50
749	WorkPackage	172	3	1952 Bay St, Victoria, BC V8R 1J8
750	WorkPackage	172	1	Royal Jubilee Hospital (Ear Savers) / Lake Cowichan First Responders  (Face Shields) 
751	WorkPackage	172	2	3
753	WorkPackage	172	6	8
2241	WorkPackage	354	9	0
2242	WorkPackage	354	7	10
2243	WorkPackage	354	16	Ontario
2244	WorkPackage	354	8	0
2245	WorkPackage	355	9	0
2246	WorkPackage	355	7	10
2247	WorkPackage	355	16	Ontario
2248	WorkPackage	355	8	0
2249	WorkPackage	356	9	0
2250	WorkPackage	356	7	10
2251	WorkPackage	356	16	Ontario
592	WorkPackage	156	16	Vancouver
2252	WorkPackage	356	8	0
2253	WorkPackage	357	9	0
2254	WorkPackage	357	7	0
2255	WorkPackage	357	16	Ontario
2256	WorkPackage	357	8	10
2257	WorkPackage	358	9	0
2258	WorkPackage	358	7	0
2259	WorkPackage	358	16	Ontario
2260	WorkPackage	358	8	10
2261	WorkPackage	359	9	0
752	WorkPackage	172	16	Victoria
602	WorkPackage	157	16	Mission
2262	WorkPackage	359	7	0
595	WorkPackage	157	4	-
599	WorkPackage	157	3	7324 Hurd street mission bc V2v3h5
1475	WorkPackage	245	4	Nino Leetian, OT
1476	WorkPackage	245	5	778-683-2868
1477	WorkPackage	245	9	15
1478	WorkPackage	245	7	0
1479	WorkPackage	245	3	7000 Westminster Hwy, Richmond, BC
1480	WorkPackage	245	1	Richmond Hospital - Quick Response Team
1481	WorkPackage	245	2	4
1483	WorkPackage	245	6	10
1484	WorkPackage	245	8	0
2410	WorkPackage	389	16	Vancouver
2263	WorkPackage	359	16	Ontario
2264	WorkPackage	359	8	10
2265	WorkPackage	360	9	0
2266	WorkPackage	360	7	0
2267	WorkPackage	360	16	Ontario
2268	WorkPackage	360	8	10
2269	WorkPackage	361	9	0
2270	WorkPackage	361	7	0
2271	WorkPackage	361	16	Ontario
2272	WorkPackage	361	8	10
2273	WorkPackage	362	9	10
2274	WorkPackage	362	7	0
2275	WorkPackage	362	16	Ontario
2276	WorkPackage	362	8	0
2277	WorkPackage	363	9	10
2278	WorkPackage	363	7	0
2279	WorkPackage	363	16	Ontario
2280	WorkPackage	363	8	0
2281	WorkPackage	364	9	10
2282	WorkPackage	364	7	0
2283	WorkPackage	364	16	Ontario
2284	WorkPackage	364	8	0
1482	WorkPackage	245	16	Richmond
2345	WorkPackage	377	9	10
2346	WorkPackage	377	7	0
2347	WorkPackage	377	16	Alberta
2348	WorkPackage	377	8	0
2153	WorkPackage	343	3	810 Humphrey Rd\n\nParksville, BC V9P 2X3
2406	WorkPackage	389	7	0
2407	WorkPackage	389	3	255 W 62nd Ave Vancouver BC V5X 4V4 Canada
2408	WorkPackage	389	1	St. Vincent Langara
2409	WorkPackage	389	2	2
2411	WorkPackage	389	6	10
2412	WorkPackage	389	8	0
2428	WorkPackage	391	5	2506539099
2429	WorkPackage	391	9	20
2430	WorkPackage	391	7	0
2431	WorkPackage	391	3	135 Crofton Rd Salt Spring Island V8K 2R8
2432	WorkPackage	391	1	Lady Minto Gulf Island Hospital
2433	WorkPackage	391	2	4
2435	WorkPackage	391	6	10
2436	WorkPackage	391	8	0
2437	WorkPackage	392	17	\N
2439	WorkPackage	392	4	Brittany Arora
2440	WorkPackage	392	5	7809086889
2441	WorkPackage	392	9	20
2442	WorkPackage	392	7	20
2443	WorkPackage	392	3	8440 112 St, Edmonton AB  T6G 2B7
2444	WorkPackage	392	1	University of Alberta Unit 3D4
2445	WorkPackage	392	2	4
2447	WorkPackage	392	6	8
2448	WorkPackage	392	8	20
2422	WorkPackage	390	16	Surrey
2446	WorkPackage	392	16	Alberta
2434	WorkPackage	391	16	Salt Spring
2449	WorkPackage	345	17	\N
2451	WorkPackage	393	9	10
2452	WorkPackage	393	7	0
2453	WorkPackage	393	16	Alberta
2454	WorkPackage	393	8	0
2455	WorkPackage	394	9	10
2450	WorkPackage	345	18	carol.polowick@ahs.ca
755	WorkPackage	173	4	Sharon 
756	WorkPackage	173	5	6048054724
757	WorkPackage	173	9	1
758	WorkPackage	173	7	1
759	WorkPackage	173	3	855 West 12th
760	WorkPackage	173	1	Vancouver General hospital 
761	WorkPackage	173	2	4
763	WorkPackage	173	6	8
764	WorkPackage	173	8	1
1425	WorkPackage	240	4	Dr Jeevan Grewal
1426	WorkPackage	240	5	604-351-2997
1427	WorkPackage	240	9	0
1428	WorkPackage	240	7	2
1429	WorkPackage	240	3	4349 Hastings St, Burnaby BC, V5C 2J8
1430	WorkPackage	240	1	Doctors on Hastings 
1431	WorkPackage	240	2	1
1433	WorkPackage	240	6	8
1434	WorkPackage	240	8	2
762	WorkPackage	173	16	Vancouver
1432	WorkPackage	240	16	Vancouver
1485	WorkPackage	246	4	Michelle Fedio
1486	WorkPackage	246	5	7802888953
1487	WorkPackage	246	9	2
1488	WorkPackage	246	7	1
1489	WorkPackage	246	3	7708 Esert Cresent T6M 0W2
1490	WorkPackage	246	1	University of Alberta (PCICU-GSICU)
1491	WorkPackage	246	2	1
1493	WorkPackage	246	6	10
1494	WorkPackage	246	8	1
1495	WorkPackage	247	4	Jessica Conti
1496	WorkPackage	247	5	514-515-9322
1497	WorkPackage	247	9	30
1498	WorkPackage	247	7	0
1499	WorkPackage	247	3	899 West 12th Ave, Vancouver, V5Z 1M9
1500	WorkPackage	247	1	VGH Ortho Trauma AND COVID Unit
1501	WorkPackage	247	2	4
1503	WorkPackage	247	6	10
1504	WorkPackage	247	8	0
1492	WorkPackage	246	16	Alberta
1502	WorkPackage	247	16	Vancouver
1462	WorkPackage	243	16	Richmond
1834	WorkPackage	303	16	Burnaby
2349	WorkPackage	378	9	10
1727	WorkPackage	293	4	FARWA AMIRI
1728	WorkPackage	293	5	778-239-2684
1729	WorkPackage	293	9	30
1730	WorkPackage	293	7	0
1731	WorkPackage	293	3	1080 BURRARD ST
1732	WorkPackage	293	1	ST PAULS CARDIOLOGY LAB
1733	WorkPackage	293	2	4
1735	WorkPackage	293	6	10
1736	WorkPackage	293	8	0
1777	WorkPackage	298	4	Joy nantes
1778	WorkPackage	298	5	6048053827
1779	WorkPackage	298	9	50
1780	WorkPackage	298	7	0
1781	WorkPackage	298	3	5544 Sunshine Coast Hwy, Sechelt, BC V0N 3A0
1782	WorkPackage	298	1	Sechelt hospital 
1783	WorkPackage	298	2	4
1785	WorkPackage	298	6	10
1786	WorkPackage	298	8	0
1827	WorkPackage	303	4	Donna Leung
1828	WorkPackage	303	5	6043072703
1829	WorkPackage	303	9	75
1830	WorkPackage	303	7	0
1831	WorkPackage	303	3	3935 Kincaid St, Burnaby, BC  V5G 2X6
1832	WorkPackage	303	1	Burnaby Hospital Intensive Care Unit
1833	WorkPackage	303	2	4
1835	WorkPackage	303	6	9
1836	WorkPackage	303	8	0
1867	WorkPackage	307	4	Iris Dela Pena
1868	WorkPackage	307	5	778-384-8646
1869	WorkPackage	307	9	50
1870	WorkPackage	307	7	0
1871	WorkPackage	307	3	13750 96 Avenue, Surrey, BC V3V 1Z2
1872	WorkPackage	307	1	Surrey Memorial Hospital T8 Neurology (COVID-19 Cohort)
1873	WorkPackage	307	2	4
1875	WorkPackage	307	6	10
1876	WorkPackage	307	8	0
1897	WorkPackage	310	4	Shanaz Ali
1898	WorkPackage	310	5	7786894495
1899	WorkPackage	310	9	50
1900	WorkPackage	310	7	0
1901	WorkPackage	310	3	13750 96th Avenue Surrey, B.C. V3V 1Z2
1902	WorkPackage	310	1	SMH 5east
1903	WorkPackage	310	2	4
1905	WorkPackage	310	6	10
1906	WorkPackage	310	8	0
1927	WorkPackage	313	4	Michelle Allen
1928	WorkPackage	313	5	6049160287
1929	WorkPackage	313	9	15
1930	WorkPackage	313	7	0
1932	WorkPackage	313	1	Tri Cities Health Unit 
1933	WorkPackage	313	2	1
1935	WorkPackage	313	6	10
1936	WorkPackage	313	8	0
1957	WorkPackage	316	4	DR SUMEET DHILLON
1958	WorkPackage	316	5	6043669627
1959	WorkPackage	316	9	3
1960	WorkPackage	316	7	3
1961	WorkPackage	316	3	Address: 7110 120 St #103, Surrey, BC V3W 3M8
1962	WorkPackage	316	1	scott road family clinic
1963	WorkPackage	316	2	1
1965	WorkPackage	316	6	8
1966	WorkPackage	316	8	6
1734	WorkPackage	293	16	Vancouver
2350	WorkPackage	378	7	0
1874	WorkPackage	307	16	Surrey
1964	WorkPackage	316	16	Surrey
1472	WorkPackage	244	16	Mission
1704	WorkPackage	290	16	Coquitlam
1784	WorkPackage	298	16	Sechelt
1904	WorkPackage	310	16	Surrey
1931	WorkPackage	313	3	200-205 Newport Drive\n\nPort Moody, B.C.\n\nV3H 5C9
1934	WorkPackage	313	16	Port Moody
1987	WorkPackage	319	4	Melissa
1988	WorkPackage	319	5	778-863-7889
1989	WorkPackage	319	9	10
1990	WorkPackage	319	7	4
1991	WorkPackage	319	3	600 W 10th Ave, Vancouver, BC V5Z 4E6
1020	WorkPackage	199	1	Vancouver General Hospital
1022	WorkPackage	199	16	Vancouver
1435	WorkPackage	241	4	Carmen Culbert
1436	WorkPackage	241	5	604 8312342
1437	WorkPackage	241	9	40
1438	WorkPackage	241	7	0
1439	WorkPackage	241	3	15521 Russell ave White Rock, V4b5m2
1440	WorkPackage	241	1	Peace arch hospital
1441	WorkPackage	241	2	1
1443	WorkPackage	241	6	9
1444	WorkPackage	241	8	0
1505	WorkPackage	248	4	Aileen Acal
1506	WorkPackage	248	5	2369899369
1507	WorkPackage	248	9	30
1508	WorkPackage	248	7	30
1509	WorkPackage	248	3	1081 Burrard St. Vancouver BC V6Z 1Y6
1510	WorkPackage	248	1	St. Paul’s Hospital Cardiology Lab
1511	WorkPackage	248	2	4
1513	WorkPackage	248	6	8
1514	WorkPackage	248	8	50
1442	WorkPackage	241	16	White Rock
2285	WorkPackage	365	4	Sonia Yucoco Martinez 
2286	WorkPackage	365	5	7802988501
2287	WorkPackage	365	9	40
2289	WorkPackage	365	3	11220 83ave Edmonton, AB T6G 2B7
2290	WorkPackage	365	1	Mazankowski heart institute 
2291	WorkPackage	365	2	4
2293	WorkPackage	365	6	10
2294	WorkPackage	365	8	0
2351	WorkPackage	378	16	Alberta
2352	WorkPackage	378	8	0
1015	WorkPackage	199	4	Sharon 
1016	WorkPackage	199	5	604 805 4724
1017	WorkPackage	199	9	1
1018	WorkPackage	199	7	1
1019	WorkPackage	199	3	855 West 12th
1021	WorkPackage	199	2	4
1023	WorkPackage	199	6	8
1024	WorkPackage	199	8	1
2292	WorkPackage	365	16	Alberta
2365	WorkPackage	382	17	\N
2366	WorkPackage	382	18	\N
2367	WorkPackage	382	4	George Michael
2368	WorkPackage	382	5	123456789
2369	WorkPackage	382	9	20
2370	WorkPackage	382	7	20
2371	WorkPackage	382	3	1234 Something Ln
2372	WorkPackage	382	1	Peter Rabbit
2373	WorkPackage	382	2	4
2375	WorkPackage	382	6	8
2376	WorkPackage	382	8	20
2374	WorkPackage	382	16	Timbuktu
2401	WorkPackage	389	17	\N
2402	WorkPackage	389	18	\N
2403	WorkPackage	389	4	Juliet Felizardo
2404	WorkPackage	389	5	6047274921
2405	WorkPackage	389	9	60
1697	WorkPackage	290	4	Hazel Julaily
1698	WorkPackage	290	5	604-339-7423
1699	WorkPackage	290	9	120
1700	WorkPackage	290	7	0
1701	WorkPackage	290	3	1010 Alderson Avenue Coquitlam, BC V3K 1W1
1702	WorkPackage	290	1	Foyer Maillard
1703	WorkPackage	290	2	2
1705	WorkPackage	290	6	10
1706	WorkPackage	290	8	0
1737	WorkPackage	294	4	Connie Macinas
1738	WorkPackage	294	5	604 783 3757
1739	WorkPackage	294	9	200
1740	WorkPackage	294	7	100
1741	WorkPackage	294	3	33386 Bevan Ave. Abbotsford BC v2s 5G6
1742	WorkPackage	294	1	Bevan Village
1743	WorkPackage	294	2	2
1745	WorkPackage	294	6	9
1746	WorkPackage	294	8	200
1747	WorkPackage	295	4	Manpreet Brar
1748	WorkPackage	295	5	7788919843
1749	WorkPackage	295	9	30
1750	WorkPackage	295	7	0
1751	WorkPackage	295	3	7000 Westminster hwy Richmond bc
1752	WorkPackage	295	1	Richmond Hospital 
1753	WorkPackage	295	2	4
1755	WorkPackage	295	6	9
1756	WorkPackage	295	8	0
1787	WorkPackage	299	4	Erica Dhaliwal
1788	WorkPackage	299	5	778 995 3477 
1789	WorkPackage	299	9	50
1790	WorkPackage	299	7	0
1791	WorkPackage	299	3	13750 96 Ave Surrey, BC V3V 1Z2 
1792	WorkPackage	299	1	Surrey Memorial Hospital 5East   
1793	WorkPackage	299	2	4
1795	WorkPackage	299	6	10
1796	WorkPackage	299	8	0
1797	WorkPackage	300	4	Hannah Allen
1798	WorkPackage	300	5	6043698949
1799	WorkPackage	300	9	30
1800	WorkPackage	300	7	0
1801	WorkPackage	300	3	7000 Westminster Hwy, Richmond BC, V6X 1A2
1802	WorkPackage	300	1	Richmond Hospital - Inpatient psychiatry unit 
1803	WorkPackage	300	2	4
1805	WorkPackage	300	6	10
1806	WorkPackage	300	8	0
1837	WorkPackage	304	4	Jana McJannet
1838	WorkPackage	304	5	7782302331
1839	WorkPackage	304	9	25
1840	WorkPackage	304	7	0
1841	WorkPackage	304	3	231 E. 15th Street North Vancouver, BC V7L2L7
1842	WorkPackage	304	1	Lions Gate Hospital - Rehabilitation Services
1843	WorkPackage	304	2	4
1845	WorkPackage	304	6	10
1846	WorkPackage	304	8	0
1877	WorkPackage	308	4	Letty James
1878	WorkPackage	308	5	360 812 1388
1879	WorkPackage	308	9	1
1880	WorkPackage	308	7	1
1881	WorkPackage	308	3	475 Guilford Way Port Moody BC V3H 3W9
1794	WorkPackage	299	16	Surrey
1844	WorkPackage	304	16	Vancouver
1512	WorkPackage	248	16	Vancouver
1744	WorkPackage	294	16	Abbotsford
1445	WorkPackage	242	4	Megan Fekete
1446	WorkPackage	242	5	7786287271
1447	WorkPackage	242	9	100
1448	WorkPackage	242	7	0
1449	WorkPackage	242	3	855 W 12 ave 
1450	WorkPackage	242	1	Vancouver General Hospital
1451	WorkPackage	242	2	4
1453	WorkPackage	242	6	10
1454	WorkPackage	242	8	0
1515	WorkPackage	249	4	Tracy Johnson - We have masks and shields, but no ear savers
1516	WorkPackage	249	5	604-329-2689
1517	WorkPackage	249	9	40
1518	WorkPackage	249	7	0
1519	WorkPackage	249	3	11666 Laity Street, Maple Ridge, BC, V2X7G5
1520	WorkPackage	249	1	Ridge Meadows Hospital, 2 West
1521	WorkPackage	249	2	4
1523	WorkPackage	249	6	10
1524	WorkPackage	249	8	0
1452	WorkPackage	242	16	Vancouver
1707	WorkPackage	291	4	Jimmy Tran
1708	WorkPackage	291	5	7788881838
1709	WorkPackage	291	9	70
1710	WorkPackage	291	7	0
1711	WorkPackage	291	3	13750 96 Ave, Surrey, BC V3V 1Z2
1712	WorkPackage	291	1	Surrey memorial hospital / 3 south orthopaedics 
1713	WorkPackage	291	2	4
1715	WorkPackage	291	6	9
1716	WorkPackage	291	8	0
1757	WorkPackage	296	4	Leanne 
1758	WorkPackage	296	5	7782399087
1759	WorkPackage	296	9	25
1760	WorkPackage	296	7	0
1761	WorkPackage	296	3	231 E 15th St, North Vancouver V7L2L7
1762	WorkPackage	296	1	Lions Gate Hospital
1763	WorkPackage	296	2	4
1765	WorkPackage	296	6	10
1766	WorkPackage	296	8	0
1807	WorkPackage	301	4	Kirandeep Sidhu - Dialysis RN
1808	WorkPackage	301	5	306-500-9500
1809	WorkPackage	301	9	15
1810	WorkPackage	301	7	30
1811	WorkPackage	301	3	2100 Bovaird Drive E, Brampton. ON
1812	WorkPackage	301	1	Brampton civic hospital
1813	WorkPackage	301	2	1
1815	WorkPackage	301	6	8
1816	WorkPackage	301	8	60
1847	WorkPackage	305	4	Cory Endique
1848	WorkPackage	305	5	+16043661320
1849	WorkPackage	305	9	70
1850	WorkPackage	305	7	0
1851	WorkPackage	305	3	7801 Argyle St, Vancouver, BC V5P 3L6
1852	WorkPackage	305	1	Holy Family Hospital
1853	WorkPackage	305	2	2
1855	WorkPackage	305	6	10
1856	WorkPackage	305	8	70
1882	WorkPackage	308	1	Eagle Ridge Hospital ACE
1883	WorkPackage	308	2	4
1885	WorkPackage	308	6	8
1886	WorkPackage	308	8	2
1907	WorkPackage	311	4	Kirsten Fewtrell
1908	WorkPackage	311	5	6048093430
1909	WorkPackage	311	9	40
1910	WorkPackage	311	7	0
1911	WorkPackage	311	3	3935 Kincaid St
1912	WorkPackage	311	1	Burnaby Hospital Medical Imaging
1913	WorkPackage	311	2	4
1915	WorkPackage	311	6	10
1916	WorkPackage	311	8	0
1937	WorkPackage	314	4	Elizabeth Dogherty, Acting Clinical Nurse Leader 
1938	WorkPackage	314	5	604-351-7711
1939	WorkPackage	314	9	25
1940	WorkPackage	314	7	0
1941	WorkPackage	314	3	1081 Burrard St., Vancouver BC, V6Z1Y6
1942	WorkPackage	314	1	St. Paul's Hospital - Urban Health Unit (10C)
1943	WorkPackage	314	2	4
1945	WorkPackage	314	6	9
1946	WorkPackage	314	8	0
1764	WorkPackage	296	16	Vancouver
1854	WorkPackage	305	16	Vancouver
2295	WorkPackage	366	4	MARLENE ALBUTRA
1522	WorkPackage	249	16	Maple Ridge
1714	WorkPackage	291	16	Surrey
1814	WorkPackage	301	16	Ontario
1884	WorkPackage	308	16	Port Moody
1944	WorkPackage	314	16	Vancouver
1967	WorkPackage	317	4	Erin Celms
1968	WorkPackage	317	5	780-782-7749
1969	WorkPackage	317	9	100
1970	WorkPackage	317	7	0
1971	WorkPackage	317	3	11821-123 Street, Edmonton, T5L0G7
1972	WorkPackage	317	1	McMan Youth Family and Community Services 
1973	WorkPackage	317	2	7
1975	WorkPackage	317	6	10
1976	WorkPackage	317	8	0
1992	WorkPackage	319	1	BC Cancer Agency Functional Imaging PET/CT
1993	WorkPackage	319	2	5
1995	WorkPackage	319	6	9
1996	WorkPackage	319	8	4
1974	WorkPackage	317	16	Alberta
1994	WorkPackage	319	16	Vancouver
2007	WorkPackage	321	4	Nikki Van Rootselaar 
2008	WorkPackage	321	5	403-634-5319
1754	WorkPackage	295	16	Richmond
2010	WorkPackage	321	7	0
2011	WorkPackage	321	3	960 19th St. South Lethbridge Alberta T1J 1W5
2012	WorkPackage	321	1	Lethbridge Regional Day Procedures 
2013	WorkPackage	321	2	1
2015	WorkPackage	321	6	10
2016	WorkPackage	321	8	0
2014	WorkPackage	321	16	Alberta
2022	WorkPackage	322	1	Semiahmoo Dental Centre
2023	WorkPackage	322	2	7
2025	WorkPackage	322	6	8
2026	WorkPackage	322	8	0
2028	WorkPackage	323	7	0
2029	WorkPackage	323	16	Alberta
1914	WorkPackage	311	16	Burnaby
2024	WorkPackage	322	16	Langley
1455	WorkPackage	243	4	Tracey McIntosh
1456	WorkPackage	243	5	604-312-4355
1457	WorkPackage	243	9	9
1458	WorkPackage	243	7	0
1459	WorkPackage	243	3	8100 Westminister Hwy,  Richmond
1460	WorkPackage	243	1	Richmond Hospital, PPS PROGRAM
1461	WorkPackage	243	2	4
1463	WorkPackage	243	6	10
1464	WorkPackage	243	8	0
1525	WorkPackage	250	4	Sabrina Harker
1526	WorkPackage	250	5	6047658476
1527	WorkPackage	250	9	25
1528	WorkPackage	250	7	0
1529	WorkPackage	250	3	56-2991 Lougheed Hwy, Coquitlam BC V3B 6J6
1530	WorkPackage	250	1	Ablecare Medical
1531	WorkPackage	250	2	1
1533	WorkPackage	250	6	10
1534	WorkPackage	250	8	0
1717	WorkPackage	292	4	Moira Adams
1718	WorkPackage	292	5	7783874263
1719	WorkPackage	292	9	12
1720	WorkPackage	292	7	0
1721	WorkPackage	292	3	19709A Salish Road, Pitt Meadows, BC. V3Y2G1
1722	WorkPackage	292	1	Katzie Health & Community Centre
1723	WorkPackage	292	2	1
1725	WorkPackage	292	6	8
1726	WorkPackage	292	8	0
1767	WorkPackage	297	4	Wendy Upton
1768	WorkPackage	297	5	604-375-4558
1769	WorkPackage	297	9	75
1770	WorkPackage	297	7	0
1771	WorkPackage	297	3	12275 224 Street Maple Ridge BC V2X 6H5 
1772	WorkPackage	297	1	Chartwell Willow 
1773	WorkPackage	297	2	2
1775	WorkPackage	297	6	8
1776	WorkPackage	297	8	0
1817	WorkPackage	302	4	Blossom De Vera
1818	WorkPackage	302	5	778-319-6295
1819	WorkPackage	302	9	200
1820	WorkPackage	302	7	200
1821	WorkPackage	302	3	899 West 12th Avenue, Vancouver. V5Z 1M9
1822	WorkPackage	302	1	Vancouver General Hospital 
1823	WorkPackage	302	2	4
1825	WorkPackage	302	6	9
1826	WorkPackage	302	8	280
1857	WorkPackage	306	4	Cory Endique
1858	WorkPackage	306	5	+16043661320
1859	WorkPackage	306	9	0
1860	WorkPackage	306	7	70
1861	WorkPackage	306	3	7801 Argyle St, Vancouver, BC V5P 3L6
1862	WorkPackage	306	1	Holy Family Hospital
1863	WorkPackage	306	2	2
1865	WorkPackage	306	6	10
1866	WorkPackage	306	8	0
1887	WorkPackage	309	4	Raman
1888	WorkPackage	309	5	778-714-0520
1889	WorkPackage	309	9	6
1890	WorkPackage	309	7	6
1892	WorkPackage	309	1	Vivacare
1893	WorkPackage	309	2	1
1895	WorkPackage	309	6	8
1896	WorkPackage	309	8	12
1917	WorkPackage	312	4	Noelle Gray
1918	WorkPackage	312	5	2502084296
1919	WorkPackage	312	9	0
1920	WorkPackage	312	7	30
1921	WorkPackage	312	3	9888 Fifth Street, Sidney, BC, V8L 2X3
1922	WorkPackage	312	1	Sidney Care Home
1923	WorkPackage	312	2	2
1925	WorkPackage	312	6	8
1926	WorkPackage	312	8	30
1947	WorkPackage	315	4	Bining, Ramn
1948	WorkPackage	315	5	6476378689
1949	WorkPackage	315	9	25
1950	WorkPackage	315	7	25
1951	WorkPackage	315	3	1 Black Oak Drive, Brampton, ON
1952	WorkPackage	315	1	Truck Drivers During Coronavirus 
1953	WorkPackage	315	2	5
1955	WorkPackage	315	6	10
1956	WorkPackage	315	8	50
1824	WorkPackage	302	16	Vancouver
1864	WorkPackage	306	16	Vancouver
1954	WorkPackage	315	16	Ontario
1804	WorkPackage	300	16	Richmond
1532	WorkPackage	250	16	Coquitlam
1724	WorkPackage	292	16	Pitt Medows
1774	WorkPackage	297	16	Abbotsford
1891	WorkPackage	309	3	6345 120 St #120, Delta, BC V4E 2A6
1924	WorkPackage	312	16	Vancouver Island
1977	WorkPackage	318	4	Kiely Landrigan 
1978	WorkPackage	318	5	6047154720
1979	WorkPackage	318	9	30
1980	WorkPackage	318	7	0
1981	WorkPackage	318	3	2775 Laurel St, Vancouver, BC V5Z 1M9
1982	WorkPackage	318	1	Vancouver General Hospital, Clinical Nutrition Dietitians
1983	WorkPackage	318	2	4
1985	WorkPackage	318	6	10
1986	WorkPackage	318	8	0
1984	WorkPackage	318	16	Vancouver
1997	WorkPackage	320	4	Hanako Yokota (I can pick up and deliver)
1998	WorkPackage	320	5	6047160307
1999	WorkPackage	320	9	50
2000	WorkPackage	320	7	25
2001	WorkPackage	320	3	899 W 12th Ave, Vancouver, BC V5Z 1M9
2002	WorkPackage	320	1	Vancouver General Hospital gift shop (not for resale but acting as a general pick up point for all medical professionals at VGH)
2003	WorkPackage	320	2	4
2005	WorkPackage	320	6	9
2006	WorkPackage	320	8	30
2004	WorkPackage	320	16	Vancouver
2017	WorkPackage	322	4	Sheila Wolf
2018	WorkPackage	322	5	604-839-4417
2019	WorkPackage	322	9	25
2020	WorkPackage	322	7	0
2021	WorkPackage	322	3	6238 216n Street, Langley BC , V2Y 2N6
2027	WorkPackage	323	9	10
1894	WorkPackage	309	16	Delta
1182	WorkPackage	215	16	Surrey
1172	WorkPackage	214	16	Vancouver
1192	WorkPackage	216	16	Vancouver
1202	WorkPackage	217	16	Vancouver
2296	WorkPackage	366	5	7788627107
1212	WorkPackage	218	16	Vancouver
1222	WorkPackage	219	16	Vancouver
1232	WorkPackage	220	16	Vancouver
1465	WorkPackage	244	4	Ronnda B
1466	WorkPackage	244	5	778 242 7278
1467	WorkPackage	244	9	300
1468	WorkPackage	244	7	0
1469	WorkPackage	244	3	7324 Hurd Street mission BC. V2V 3H5
1470	WorkPackage	244	1	The Residence in Missiom
1471	WorkPackage	244	2	2
2297	WorkPackage	366	9	30
1473	WorkPackage	244	6	10
1474	WorkPackage	244	8	0
2298	WorkPackage	366	7	0
2299	WorkPackage	366	3	650 North Penticton St Vancouver BC V5K 3L8
1165	WorkPackage	214	4	Naomi Watt
1166	WorkPackage	214	5	6043453199
1167	WorkPackage	214	9	20
1168	WorkPackage	214	7	0
1169	WorkPackage	214	3	1081 Burrard Street, Vancouver BC, V6Z1Y6
1170	WorkPackage	214	1	RAAC 
1171	WorkPackage	214	2	4
1173	WorkPackage	214	6	10
1174	WorkPackage	214	8	0
1175	WorkPackage	215	4	Pierre Suson 
1176	WorkPackage	215	5	778.881.6471
1177	WorkPackage	215	9	0
1178	WorkPackage	215	7	30
1179	WorkPackage	215	3	13750 96th Ave, Surrey BC, V3V 1Z2
1180	WorkPackage	215	1	Home Health Surrey Memorial Hospital 
1181	WorkPackage	215	2	4
1183	WorkPackage	215	6	8
1184	WorkPackage	215	8	60
1185	WorkPackage	216	4	Sally Co
1186	WorkPackage	216	5	7789998854
1187	WorkPackage	216	9	2
1188	WorkPackage	216	7	2
1189	WorkPackage	216	3	1081 Burrard St, Vancouver, BC V6Z 1Y6
1190	WorkPackage	216	1	St. Paul's Hospital, Renal Department (6B)
1191	WorkPackage	216	2	4
1193	WorkPackage	216	6	9
1194	WorkPackage	216	8	2
1195	WorkPackage	217	4	Noemi nellas
1196	WorkPackage	217	5	6043384139
1197	WorkPackage	217	9	50
1198	WorkPackage	217	7	0
1199	WorkPackage	217	3	4950 Heather St. Vancouver
1200	WorkPackage	217	1	Parkview 4th&5th floor
1201	WorkPackage	217	2	1
1203	WorkPackage	217	6	10
1204	WorkPackage	217	8	0
1205	WorkPackage	218	4	Kimberley Co
1206	WorkPackage	218	5	6729994531
1207	WorkPackage	218	9	2
1208	WorkPackage	218	7	2
1209	WorkPackage	218	3	7000 Westminster Hwy, Richmond, BC V6X 1A2
1210	WorkPackage	218	1	Richmond General Hospital, Radiology
1211	WorkPackage	218	2	4
1213	WorkPackage	218	6	9
1214	WorkPackage	218	8	2
1215	WorkPackage	219	4	Jennifer Nguyen 
1216	WorkPackage	219	5	604-838-2383
1217	WorkPackage	219	9	50
1218	WorkPackage	219	7	0
1219	WorkPackage	219	3	899 West 12th ave, Vancouver 
1220	WorkPackage	219	1	Vancouver General Hospital - General Radiology 
1221	WorkPackage	219	2	1
1223	WorkPackage	219	6	10
1224	WorkPackage	219	8	0
1225	WorkPackage	220	4	Cheryl Prinzen
1226	WorkPackage	220	5	778-8746518
1227	WorkPackage	220	9	50
1228	WorkPackage	220	7	0
1229	WorkPackage	220	3	1081 Burrard
1230	WorkPackage	220	1	St Paul's Hosptial
1231	WorkPackage	220	2	4
1233	WorkPackage	220	6	10
1234	WorkPackage	220	8	0
2300	WorkPackage	366	1	THE BLOOM GROUP (Hospice Services)
2301	WorkPackage	366	2	7
2303	WorkPackage	366	6	8
2304	WorkPackage	366	8	0
2353	WorkPackage	379	9	0
2354	WorkPackage	379	7	10
2355	WorkPackage	379	16	Alberta
2356	WorkPackage	379	8	0
2357	WorkPackage	380	9	0
2358	WorkPackage	380	7	0
2359	WorkPackage	380	16	Alberta
2360	WorkPackage	380	8	10
2361	WorkPackage	381	9	10
2362	WorkPackage	381	7	0
2363	WorkPackage	381	16	Alberta
2364	WorkPackage	381	8	0
2302	WorkPackage	366	16	Vancouver
2377	WorkPackage	383	9	0
2378	WorkPackage	383	7	10
2379	WorkPackage	383	16	Timbuktu
2380	WorkPackage	383	8	0
2381	WorkPackage	384	9	0
2382	WorkPackage	384	7	10
2383	WorkPackage	384	16	Timbuktu
2384	WorkPackage	384	8	0
2385	WorkPackage	385	9	0
2386	WorkPackage	385	7	0
2387	WorkPackage	385	16	Timbuktu
2388	WorkPackage	385	8	10
2389	WorkPackage	386	9	0
2390	WorkPackage	386	7	0
2391	WorkPackage	386	16	Timbuktu
2392	WorkPackage	386	8	10
2393	WorkPackage	387	9	10
2394	WorkPackage	387	7	0
2395	WorkPackage	387	16	Timbuktu
2396	WorkPackage	387	8	0
2397	WorkPackage	388	9	10
2398	WorkPackage	388	7	0
2399	WorkPackage	388	16	Timbuktu
2030	WorkPackage	323	8	0
2031	WorkPackage	324	9	10
2032	WorkPackage	324	7	0
2033	WorkPackage	324	16	Alberta
2034	WorkPackage	324	8	0
2035	WorkPackage	325	9	10
2036	WorkPackage	325	7	0
2037	WorkPackage	325	16	Alberta
2038	WorkPackage	325	8	0
2039	WorkPackage	326	9	10
2040	WorkPackage	326	7	0
2041	WorkPackage	326	16	Alberta
2042	WorkPackage	326	8	0
2043	WorkPackage	327	9	10
2044	WorkPackage	327	7	0
2045	WorkPackage	327	16	Alberta
2046	WorkPackage	327	8	0
2047	WorkPackage	328	9	10
2048	WorkPackage	328	7	0
2049	WorkPackage	328	16	Alberta
2050	WorkPackage	328	8	0
2051	WorkPackage	329	9	10
2052	WorkPackage	329	7	0
2053	WorkPackage	329	16	Alberta
2054	WorkPackage	329	8	0
2055	WorkPackage	330	9	10
2056	WorkPackage	330	7	0
2057	WorkPackage	330	16	Alberta
2058	WorkPackage	330	8	0
2059	WorkPackage	331	9	10
2060	WorkPackage	331	7	0
2061	WorkPackage	331	16	Alberta
2062	WorkPackage	331	8	0
2063	WorkPackage	332	9	10
2064	WorkPackage	332	7	0
2065	WorkPackage	332	16	Alberta
2066	WorkPackage	332	8	0
2067	WorkPackage	333	4	Gilma Johnston
2068	WorkPackage	333	5	6043071417
2069	WorkPackage	333	9	200
2070	WorkPackage	333	7	0
2071	WorkPackage	333	3	475 Guildford Way Port Moody BC 
2072	WorkPackage	333	1	Eagle Ridge Hospital
2073	WorkPackage	333	2	4
2075	WorkPackage	333	6	10
2076	WorkPackage	333	8	0
2077	WorkPackage	334	9	10
2078	WorkPackage	334	7	0
2079	WorkPackage	334	16	Alberta
2080	WorkPackage	334	8	0
2081	WorkPackage	335	9	10
2082	WorkPackage	335	7	0
2083	WorkPackage	335	16	Alberta
2084	WorkPackage	335	8	0
2085	WorkPackage	336	9	10
2086	WorkPackage	336	7	0
2087	WorkPackage	336	16	Alberta
2088	WorkPackage	336	8	0
2089	WorkPackage	337	4	Gilma Johnston
2090	WorkPackage	337	5	6043071417
2091	WorkPackage	337	9	200
2092	WorkPackage	337	7	0
2093	WorkPackage	337	3	475 Guildford Way Port Moody BC 
2094	WorkPackage	337	1	Eagle Ridge Hospital
2095	WorkPackage	337	2	4
2097	WorkPackage	337	6	10
2098	WorkPackage	337	8	0
2099	WorkPackage	338	4	Tracey Mcintosh. I made a previous order without our room number😫
2100	WorkPackage	338	5	604-312-4355
2101	WorkPackage	338	9	9
2102	WorkPackage	338	7	0
2103	WorkPackage	338	3	Room 1752 Blue Zone, 8100 Westminster Hwy, Richmond BC
2104	WorkPackage	338	1	Personalized Support & Stabilization Program - Richmond Hospital
2105	WorkPackage	338	2	4
2107	WorkPackage	338	6	8
2108	WorkPackage	338	8	0
2009	WorkPackage	321	9	50
2109	WorkPackage	339	4	Kristan Myers
2110	WorkPackage	339	5	7809405656
2111	WorkPackage	339	9	50
2112	WorkPackage	339	7	0
2113	WorkPackage	339	3	4210 48 Street
2114	WorkPackage	339	1	Leduc Hospital ER
2115	WorkPackage	339	2	4
2117	WorkPackage	339	6	10
2118	WorkPackage	339	8	0
2119	WorkPackage	340	4	Sydney Warkman
2120	WorkPackage	340	5	6046554267
2121	WorkPackage	340	9	2
2122	WorkPackage	340	7	2
2123	WorkPackage	340	3	21203 89th Avenue Langley B.C. V1M 2E2
2124	WorkPackage	340	1	Dr. R Warkman
2125	WorkPackage	340	2	7
2127	WorkPackage	340	6	8
2128	WorkPackage	340	8	2
2074	WorkPackage	333	16	Port Moody
2106	WorkPackage	338	16	Richmond
2116	WorkPackage	339	16	Alberta
2126	WorkPackage	340	16	Langley
754	WorkPackage	172	8	60
2129	WorkPackage	341	4	Sarah Webster
2130	WorkPackage	341	5	780-293-5163
2131	WorkPackage	341	9	100
2132	WorkPackage	341	7	0
2305	WorkPackage	367	9	10
2134	WorkPackage	341	1	Glenrose Rehabilitation Hospital 
2135	WorkPackage	341	2	4
2306	WorkPackage	367	7	0
2137	WorkPackage	341	6	9
2138	WorkPackage	341	8	0
2139	WorkPackage	342	4	John Jacob
2140	WorkPackage	342	5	604-671-2868
2141	WorkPackage	342	9	200
2142	WorkPackage	342	7	0
2143	WorkPackage	342	3	4480 Oak Street, Vancouver, BC, V6H 3V4
2144	WorkPackage	342	1	BC Children's Hospital
2145	WorkPackage	342	2	4
2147	WorkPackage	342	6	10
2148	WorkPackage	342	8	0
2149	WorkPackage	343	4	Kim hansen
2150	WorkPackage	343	5	778-552-7078
2151	WorkPackage	343	9	2
2152	WorkPackage	343	7	2
2146	WorkPackage	342	16	Vancouver
2154	WorkPackage	343	1	Home support
2155	WorkPackage	343	2	7
2157	WorkPackage	343	6	8
2158	WorkPackage	343	8	4
2136	WorkPackage	341	16	Alberta
2133	WorkPackage	341	3	10230 111 Ave NW\n\nEdmonton, Alberta
2156	WorkPackage	343	16	Vancouver Island
2159	WorkPackage	344	4	Brenda Poole
2160	WorkPackage	344	5	6047417990
2161	WorkPackage	344	9	2
2162	WorkPackage	344	7	2
2164	WorkPackage	344	1	Sechelt Fire Department
2165	WorkPackage	344	2	7
2167	WorkPackage	344	6	8
2168	WorkPackage	344	8	2
2169	WorkPackage	345	4	Carol Polowick
2170	WorkPackage	345	5	7807355018 work 780-719-4129 cell
2171	WorkPackage	345	9	50
2172	WorkPackage	345	7	0
2173	WorkPackage	345	3	10240 Kingsway Avenue Edmonton AB
2174	WorkPackage	345	1	Royal Alexandra Hospital Renal Outpatient  Dialysis Unit
2175	WorkPackage	345	2	4
2177	WorkPackage	345	6	10
2178	WorkPackage	345	8	0
2179	WorkPackage	346	4	linda
2180	WorkPackage	346	5	2507530744 leave message if not home with your number.Will be home in  morning until wednesday april15
2181	WorkPackage	346	9	0
2182	WorkPackage	346	7	0
2183	WorkPackage	346	3	nanaimo
2184	WorkPackage	346	1	i work for a dept.store as cashier and would really feel safer with a shield not just a plexiglass that does not cover the whole front 
2185	WorkPackage	346	2	7
2187	WorkPackage	346	6	8
2188	WorkPackage	346	8	2
2189	WorkPackage	347	4	Jennifer Du
2190	WorkPackage	347	5	604 506 6099
2191	WorkPackage	347	9	50
2192	WorkPackage	347	7	0
2193	WorkPackage	347	3	330 Heatley Avenue, Vancouver BC, V6A 3G3, Canada.
2194	WorkPackage	347	1	Heatley Community Health Centre, DTES, Vancouver Coastal Health
2195	WorkPackage	347	2	5
2197	WorkPackage	347	6	10
2198	WorkPackage	347	8	0
2166	WorkPackage	344	16	Sechelt
2186	WorkPackage	346	16	Vancouver Island
2176	WorkPackage	345	16	Alberta
2196	WorkPackage	347	16	Vancouver
2199	WorkPackage	348	4	Dylan Moulton
2200	WorkPackage	348	5	780-235-2868
2202	WorkPackage	348	7	0
2203	WorkPackage	348	3	9117 82 Ave NW, Edmonton, AB
2204	WorkPackage	348	1	Medi Drugs Millcreek Pharmacy
2205	WorkPackage	348	2	6
2207	WorkPackage	348	6	10
2208	WorkPackage	348	8	0
2209	WorkPackage	349	4	Brittany Arora
2210	WorkPackage	349	5	7809086889
2212	WorkPackage	349	7	0
2213	WorkPackage	349	3	University of Alberta Hospital T6G 2B7
2214	WorkPackage	349	1	AHS ENT UofA
2215	WorkPackage	349	2	4
2217	WorkPackage	349	6	10
2218	WorkPackage	349	8	0
2216	WorkPackage	349	16	Alberta
2206	WorkPackage	348	16	Alberta
2163	WorkPackage	344	3	P.O. Box 944, 5525 Trail Ave, Sechelt BC V0N3A0
2307	WorkPackage	367	16	Alberta
2308	WorkPackage	367	8	0
2309	WorkPackage	368	9	10
2310	WorkPackage	368	7	0
2311	WorkPackage	368	16	Alberta
2312	WorkPackage	368	8	0
2313	WorkPackage	369	9	10
2314	WorkPackage	369	7	0
2315	WorkPackage	369	16	Alberta
2316	WorkPackage	369	8	0
2317	WorkPackage	370	9	10
2318	WorkPackage	370	7	0
2319	WorkPackage	370	16	Alberta
2320	WorkPackage	370	8	0
2321	WorkPackage	371	9	10
2322	WorkPackage	371	7	0
2323	WorkPackage	371	16	Alberta
2324	WorkPackage	371	8	0
2325	WorkPackage	372	9	10
2326	WorkPackage	372	7	0
2327	WorkPackage	372	16	Alberta
2328	WorkPackage	372	8	0
2329	WorkPackage	373	9	10
2330	WorkPackage	373	7	0
2331	WorkPackage	373	16	Alberta
2332	WorkPackage	373	8	0
2333	WorkPackage	374	9	10
2334	WorkPackage	374	7	0
2335	WorkPackage	374	16	Alberta
2336	WorkPackage	374	8	0
2337	WorkPackage	375	9	10
2338	WorkPackage	375	7	0
2339	WorkPackage	375	16	Alberta
2340	WorkPackage	375	8	0
2341	WorkPackage	376	9	10
2342	WorkPackage	376	7	0
2343	WorkPackage	376	16	Alberta
2344	WorkPackage	376	8	0
2096	WorkPackage	337	16	Port Moody
2400	WorkPackage	388	8	0
2413	WorkPackage	390	17	\N
2414	WorkPackage	390	18	\N
2415	WorkPackage	390	4	Erica Dhaliwal
2416	WorkPackage	390	5	778 995 3477
2417	WorkPackage	390	9	50
2418	WorkPackage	390	7	0
2419	WorkPackage	390	3	13750 96 Ave, Surrey, BC, V3V 1Z2
2420	WorkPackage	390	1	Surrey Memorial Hospital 5East
2421	WorkPackage	390	2	4
2423	WorkPackage	390	6	10
2424	WorkPackage	390	8	0
2425	WorkPackage	391	17	\N
2426	WorkPackage	391	18	\N
2427	WorkPackage	391	4	Danielle Poland
2201	WorkPackage	348	9	10
2211	WorkPackage	349	9	20
2456	WorkPackage	394	7	0
2457	WorkPackage	394	16	Alberta
2458	WorkPackage	394	8	0
2459	WorkPackage	395	9	10
2460	WorkPackage	395	7	0
2461	WorkPackage	395	16	Alberta
2462	WorkPackage	395	8	0
2463	WorkPackage	396	9	10
2464	WorkPackage	396	7	0
2465	WorkPackage	396	16	Alberta
2466	WorkPackage	396	8	0
2467	WorkPackage	397	9	10
2468	WorkPackage	397	7	0
2469	WorkPackage	397	16	Alberta
2470	WorkPackage	397	8	0
2471	WorkPackage	365	17	\N
2288	WorkPackage	365	7	0
2473	WorkPackage	398	17	\N
2474	WorkPackage	398	18	\N
2475	WorkPackage	398	4	Shavaun MacDonald
2476	WorkPackage	398	5	7809952900
2477	WorkPackage	398	9	0
2478	WorkPackage	398	7	80
2479	WorkPackage	398	3	1952 Bay Street Victoria BC V8R 1J8
2480	WorkPackage	398	1	Royal Jubilee Hospital
2481	WorkPackage	398	2	4
2483	WorkPackage	398	6	9
2484	WorkPackage	398	8	80
2485	WorkPackage	399	17	\N
2486	WorkPackage	399	18	\N
2487	WorkPackage	399	4	Shavaun MacDonald
2488	WorkPackage	399	5	7809952900
2489	WorkPackage	399	9	0
2490	WorkPackage	399	7	15
2491	WorkPackage	399	3	1 Hospital Way Victoria BC V8Z 6R5
2492	WorkPackage	399	1	Victoria General Hospital
2493	WorkPackage	399	2	4
2495	WorkPackage	399	6	9
2496	WorkPackage	399	8	15
2438	WorkPackage	392	18	tyerman@ualberta.ca
2497	WorkPackage	348	17	\N
2498	WorkPackage	348	18	millcreek@medi-drugs.ca
2482	WorkPackage	398	16	Vancouver Island
2565	WorkPackage	414	9	0
2494	WorkPackage	399	16	Vancouver Island
2499	WorkPackage	349	17	\N
2501	WorkPackage	400	9	10
2502	WorkPackage	400	7	0
2503	WorkPackage	400	16	Alberta
2504	WorkPackage	400	8	0
2500	WorkPackage	349	18	tyerman@ualberta.ca
2472	WorkPackage	365	18	sbmartinez29@outlook.com
2505	WorkPackage	401	9	10
2506	WorkPackage	401	7	0
2507	WorkPackage	401	16	Alberta
2508	WorkPackage	401	8	0
2509	WorkPackage	402	9	10
2510	WorkPackage	402	7	0
2511	WorkPackage	402	16	Alberta
2512	WorkPackage	402	8	0
2513	WorkPackage	403	9	10
2514	WorkPackage	403	7	0
2515	WorkPackage	403	16	Alberta
2516	WorkPackage	403	8	0
2517	WorkPackage	404	9	10
2518	WorkPackage	404	7	0
2519	WorkPackage	404	16	Alberta
2520	WorkPackage	404	8	0
2521	WorkPackage	246	17	\N
2522	WorkPackage	246	18	fedio@ualberta.ca
2523	WorkPackage	339	17	\N
2524	WorkPackage	339	18	educaidtraining@gmail.com
2525	WorkPackage	341	17	\N
2526	WorkPackage	341	18	swebster191@gmail.com
2527	WorkPackage	312	17	\N
2528	WorkPackage	312	18	\N
2529	WorkPackage	405	9	0
2530	WorkPackage	405	7	10
2531	WorkPackage	405	16	Vancouver Island
2532	WorkPackage	405	8	0
2533	WorkPackage	406	9	0
2534	WorkPackage	406	7	10
2535	WorkPackage	406	16	Vancouver Island
2536	WorkPackage	406	8	0
2537	WorkPackage	407	9	0
2538	WorkPackage	407	7	10
2539	WorkPackage	407	16	Vancouver Island
2540	WorkPackage	407	8	0
2541	WorkPackage	408	9	0
2542	WorkPackage	408	7	0
2543	WorkPackage	408	16	Vancouver Island
2544	WorkPackage	408	8	10
2545	WorkPackage	409	9	0
2546	WorkPackage	409	7	0
2547	WorkPackage	409	16	Vancouver Island
2548	WorkPackage	409	8	10
2549	WorkPackage	410	9	0
2550	WorkPackage	410	7	0
2551	WorkPackage	410	16	Vancouver Island
2552	WorkPackage	410	8	10
2553	WorkPackage	411	9	0
2554	WorkPackage	411	7	10
2555	WorkPackage	411	16	Vancouver Island
2556	WorkPackage	411	8	0
2557	WorkPackage	412	9	0
2558	WorkPackage	412	7	10
2559	WorkPackage	412	16	Vancouver Island
2560	WorkPackage	412	8	0
2561	WorkPackage	413	9	0
2562	WorkPackage	413	7	10
2563	WorkPackage	413	16	Vancouver Island
2564	WorkPackage	413	8	0
2566	WorkPackage	414	7	10
2567	WorkPackage	414	16	Vancouver Island
2568	WorkPackage	414	8	0
2569	WorkPackage	415	9	0
2570	WorkPackage	415	7	10
2571	WorkPackage	415	16	Vancouver Island
2572	WorkPackage	415	8	0
2573	WorkPackage	416	9	0
2574	WorkPackage	416	7	10
2575	WorkPackage	416	16	Vancouver Island
2576	WorkPackage	416	8	0
2577	WorkPackage	417	9	0
2578	WorkPackage	417	7	10
2579	WorkPackage	417	16	Vancouver Island
2580	WorkPackage	417	8	0
2581	WorkPackage	418	9	0
2582	WorkPackage	418	7	10
2583	WorkPackage	418	16	Vancouver Island
2584	WorkPackage	418	8	0
2585	WorkPackage	419	9	0
2586	WorkPackage	419	7	0
2587	WorkPackage	419	16	Vancouver Island
2588	WorkPackage	419	8	10
2589	WorkPackage	420	9	0
2590	WorkPackage	420	7	0
2591	WorkPackage	420	16	Vancouver Island
2592	WorkPackage	420	8	10
2593	WorkPackage	421	9	0
2594	WorkPackage	421	7	0
2595	WorkPackage	421	16	Vancouver Island
2596	WorkPackage	421	8	10
2597	WorkPackage	422	9	0
2598	WorkPackage	422	7	0
2599	WorkPackage	422	16	Vancouver Island
2600	WorkPackage	422	8	10
2601	WorkPackage	423	9	0
2602	WorkPackage	423	7	0
2603	WorkPackage	423	16	Vancouver Island
2604	WorkPackage	423	8	10
2605	WorkPackage	424	9	0
2606	WorkPackage	424	7	0
2607	WorkPackage	424	16	Vancouver Island
2608	WorkPackage	424	8	10
2609	WorkPackage	425	9	0
2610	WorkPackage	425	7	0
2611	WorkPackage	425	16	Vancouver Island
2612	WorkPackage	425	8	10
2613	WorkPackage	426	9	0
2614	WorkPackage	426	7	0
2615	WorkPackage	426	16	Vancouver Island
2616	WorkPackage	426	8	10
2617	WorkPackage	427	9	0
2618	WorkPackage	427	7	10
2619	WorkPackage	427	16	Vancouver Island
2620	WorkPackage	427	8	0
2621	WorkPackage	428	9	0
2622	WorkPackage	428	7	10
2623	WorkPackage	428	16	Vancouver Island
2624	WorkPackage	428	8	0
2625	WorkPackage	429	9	0
2626	WorkPackage	429	7	0
2627	WorkPackage	429	16	Vancouver Island
2628	WorkPackage	429	8	10
2629	WorkPackage	430	9	0
2630	WorkPackage	430	7	0
2631	WorkPackage	430	16	Vancouver Island
2632	WorkPackage	430	8	10
\.


--
-- Data for Name: enterprise_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enterprise_tokens (id, encoded_token, created_at, updated_at) FROM stdin;
1	-----BEGIN OPENPROJECT-EE TOKEN-----\r\neyJkYXRhIjoic1crMU1Fb0pWMDFRMCtsYlN5WTArbFh0MTlSVzZUS0RDc1di\r\neUEyWTNsZHVCVDBlUXEzWUdqanJGVE9PXG5xUkNhaEFGK0JQYzF2QkdOOG5w\r\nOFJIZ2pYVnFhK3U2SnJOSnE3WXVqdjJ5NGd2YVNJUlZuR2JlYXBFL05cbmNs\r\na1pteE90d041Y1BDeC9NQ1dnUjZ2ZHlqOVNwQTZGbXNBRVFnQkdvNDRFamhN\r\nVG01eTdIMmVvSGdEdVxuWmVMRW1iUk5zakhjOWRMUG1QSHU2OWhNa0ZqYi9m\r\nRFNta25IcWNHQUxNZC9tSnU3cFBjQ2JXWi81Y0FzXG5ncjJwVDEwbXlIL05Z\r\nbGlIXG4iLCJrZXkiOiJmYnpzdDRMVnE2OXNEZXk5UlB1RUxuQ2w0NUZiQUE1\r\neDZvUWFmY05ZQjN2LzJDQUhWR2lYNjhtOWxFd3Zcbkt2Uy9mcFNya1FLM2ZK\r\neHFhQVZaSUV5Qk9ub3RseVUrU3V5Nit0Vm1QdWEwOG50bjRzVW1IeEZWRkly\r\nSlxuUXpxdEU4K2lMNlRJNEVyWkZ3Wm5vYjlrSVNKenhuam5EOWRUakhsUG5s\r\nRXR6bDh3K01Ha0w4WjFOcHdDXG5BSG5kZ3hoWXZ3WlM2c3o3QVpIb2MydkIv\r\nUHhoNWNNRFJzMm9iRitlKzFONG4wc1VTSXY1dkxuUFM5dUZcbkFBb3hYNmNX\r\ncDVvZEFmOEFzWllid3RwaWxNeFFhRW9qS2R6a3o3dTUrNnVBa1NIWlZIRTY5\r\nME9HUzlUYVxuelRIUUpTOUlMWC8rcERCZnh3M2o1NURrRU9Vd3BLZHJzcldy\r\nd3FjVWJCUXZrTjRSb2pKRW1SWFlhcmVuXG44NDU3OGxNRDlUSWs4RnlmMGNT\r\nNkhzU2JXbjdZUXF0YmxDM0NpWWRZOEF6cDMzOS9wOFV2VjBkZmdJMExcbjZi\r\nQ2RMZnpXWTdQM2phTGE5SkF2N3ZQMSt1dlFKcFhwUHBOWGkrT0oyUTBGZWp3\r\nd01qTEpmcE9MNUx5NlxuUHlLUWR4U0trM0ZHdXR6WkhqYVhtc1JYUHArWXYy\r\ncGlxYUFEditYUEkwemFuaDM5TUlpcWJadDg4RWFGXG5XZ3Y1YVNjZW5iYjBZ\r\nWDA3U05iZW9zT29oR0twQkd6RFpVQUhyeWxvYW45U3RQa0pVYy85bzJpMDcr\r\neXRcbmVRZXlPcDVmYWQ4TmxDdk91Wlo5bnJoSUpVSUVTaFdJS1I3RURmdEVF\r\neEJ3QndzOXlwWU81WEN0N05jRVxuU2hlTE03WFlTZm5SOHZCbHRENmo5Rjhq\r\nRVdNUW9OekozVkdnQ2hBbDF4NUw4REYxbXZmV3U2cE44S00vXG4rYjVpei9w\r\nRmtlNWxxVEZYQmhDS2lPZ2piMlFNQUsvdFd2Ti93ZmZRdm1nKytJaS9FNkFI\r\neUFDVlhsa0JcbnhjdWFuOVUxcms3aDlpeEVBSk1IS01ZUkwzc240b2tYOGVh\r\nN1NaYkQrZlN0UTBBOEV1SEZJRFVYTXl2TVxucXMxSUF3S2JRQWhVaStxd0tk\r\nSEQ3aEsxSEJwZTZ4ajgvV25XVmJTQzZDcks4cHZFQlAzRUFNWi9VdE56XG4v\r\nbStvN1JKUTF1UllNWG81Y3RML1NjT3N4NkVaNXZFd1hQT2hHV0c0ZjRzc3Zr\r\nMHdZRE1nVVVKM0t6WjZcblBQZjJOOW9WSHRxL2tZZVhwcDJZVG5BUGVUcDBy\r\nVDJmQUtSS3Y4WC9Bei8xamZVc0tTeHI2eFg5QVBTalxuOHdTWFlMK2Nmdlkz\r\nNmdXQmRwZ2lKZ1pQbnhQTTlEUVhxUkVrTEFvWlBRLzVhTzR5bHd0MTdVaFh2\r\naTVyXG5DUHI5OVdiL0t4czdtSUtCdDhLblpSYnJnSHBnRDA4OEdxSEdNa2hj\r\nMjU2ZkxLTk8xckZmSFNVanp3by9cbmg3c1F5OEY5VGE1b24ybmRwbTJiK2gx\r\neXpDVkc5S2orOW56YmFham9POHJ0WFZvSnFhTFlhYnJxV014L1xucnNGWHNu\r\ndnFhYUs2SGQ4bWtNdkJMdEFjdXhtaGJsVGVmWXdJTngrYjl1dDI2ZnVMbVBp\r\nU1hqcjNNdFEyXG5JSTZORy9vYXBFUWlxSVdodWJ1dE5JU25UaXV4Kzl2elVI\r\nRTc4Y3A5TnNEeTUybXR1NGpoY1lBNXliY09cbmFkZnUzRzcvaDMvTE5BZVdT\r\ndDdBa2l1Snh6TEl4Zz09XG4iLCJpdiI6IjNsTjg2MU9TbFcrNjJzM1lXclVn\r\nR0E9PVxuIn0=\r\n-----END OPENPROJECT-EE TOKEN-----	2020-03-31 23:48:51.483534	2020-03-31 23:48:51.483534
\.


--
-- Data for Name: grid_widgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grid_widgets (id, start_row, end_row, start_column, end_column, identifier, options, grid_id) FROM stdin;
1	1	2	1	2	work_package_query	---\n:query_id: 5\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '1'\n	1
2	1	2	2	3	work_package_query	---\n:query_id: 6\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '7'\n	1
3	1	2	3	4	work_package_query	---\n:query_id: 7\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '12'\n	1
4	1	2	4	5	work_package_query	---\n:query_id: 8\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '14'\n	1
5	1	2	1	2	work_package_query	---\n:query_id: 9\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
6	1	2	2	3	work_package_query	---\n:query_id: 10\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
7	1	2	3	4	work_package_query	---\n:query_id: 11\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
8	1	2	4	5	work_package_query	---\n:query_id: 12\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	2
9	1	2	1	2	work_package_query	---\n:query_id: 17\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '1'\n	3
10	1	2	2	3	work_package_query	---\n:query_id: 18\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '7'\n	3
11	1	2	3	4	work_package_query	---\n:query_id: 19\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '12'\n	3
12	1	2	4	5	work_package_query	---\n:query_id: 20\n:filters:\n- :status:\n    :operator: "="\n    :values:\n    - '14'\n	3
13	1	2	1	2	work_package_query	---\n:query_id: 21\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	4
14	1	2	2	3	work_package_query	---\n:query_id: 22\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	4
15	1	2	3	4	work_package_query	---\n:query_id: 23\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	4
16	1	2	4	5	work_package_query	---\n:query_id: 24\n:filters:\n- :manualSort:\n    :operator: ow\n    :values: []\n	4
17	1	2	1	3	custom_text	---\n:name: Welcome\n:text: "![Teaser](/api/v3/attachments/8/content)"\n	5
18	2	5	1	2	custom_text	---\n:name: Getting started\n:text: |\n  We are glad you joined! We suggest to try a few things to get started in OpenProject.\n\n  Discover the most important features with our [Guided Tour](/projects/demo-project/work_packages/?start_onboarding_tour=true).\n\n  _Try the following steps:_\n\n  1. *Invite new members to your project*: &rightarrow; Go to [Members](/projects/demo-project/members) in the project navigation.\n  2. *View the work in your project*: &rightarrow; Go to [Work packages](/projects/demo-project/work_packages) in the project navigation.\n  3. *Create a new work package*: &rightarrow; Go to [Work packages &rightarrow; Create](/projects/demo-project/work_packages/new).\n  4. *Create and update a project plan*: &rightarrow; Go to [Project plan](/projects/demo-project/work_packages?query_id=2) in the project navigation.\n  5. *Activate further modules*: &rightarrow; Go to [Project settings &rightarrow; Modules](/projects/demo-project/settings/modules).\n  6. *Complete your tasks in the project*: &rightarrow; Go to [Work packages &rightarrow; Tasks](/projects/demo-project/work_packages/details/9/overview?query_id=4).\n\n  Here you will find our [User Guides](https://docs.openproject.org/user-guide/).\n  Please let us know if you have any questions or need support. Contact us: [support[at]openproject.com](mailto:support@openproject.com).\n	5
19	2	3	2	3	project_status	\N	5
20	3	4	2	3	members	---\n:name: Members\n	5
21	4	5	2	3	work_packages_overview	---\n:name: Work packages\n	5
22	5	6	1	3	work_packages_table	---\n:name: Milestones\n:queryId: '3'\n	5
23	1	2	1	3	custom_text	---\n:name: Welcome\n:text: "![Teaser](/api/v3/attachments/9/content)"\n	6
24	2	5	1	2	custom_text	---\n:name: Getting started\n:text: |\n  We are glad you joined! We suggest to try a few things to get started in OpenProject.\n\n  Discover the most important features with our [Guided Tour](/projects/your-scrum-project/backlogs?start_scrum_onboarding_tour=true).\n\n  _Try the following steps:_\n\n  1. *Invite new members to your project*: &rightarrow; Go to [Members](/projects/your-scrum-project/members) in the project navigation.\n  2. *View your Product backlog and Sprint backlogs*: &rightarrow; Go to [Backlogs](/projects/your-scrum-project/backlogs) in the project navigation.\n  3. *View your Task board*: &rightarrow; Go to [Backlogs](/projects/your-scrum-project/backlogs) &rightarrow; Click on right arrow on Sprint &rightarrow; Select [Task Board](/projects/your-scrum-project/sprints/3/taskboard).\n  4. *Create a new work package*: &rightarrow; Go to [Work packages &rightarrow; Create](/projects/your-scrum-project/work_packages/new).\n  5. *Create and update a project plan*: &rightarrow; Go to [Project plan](/projects/your-scrum-project/work_packages?query_id=13) in the project navigation.\n  6. *Create a Sprint wiki*: &rightarrow; Go to [Backlogs](/projects/your-scrum-project/backlogs) and open the sprint wiki from the right drop down menu in a sprint. You can edit the [wiki template](/projects/your-scrum-project/wiki/) based on your needs.\n  7. *Activate further modules*: &rightarrow; Go to [Project settings &rightarrow; Modules](/projects/your-scrum-project/settings/modules).\n\n  Here you will find our [User Guides](https://docs.openproject.org/user-guide/).\n  Please let us know if you have any questions or need support. Contact us: [support[at]openproject.com](mailto:support@openproject.com).\n	6
25	2	3	2	3	project_status	\N	6
26	3	4	2	3	members	---\n:name: Members\n	6
27	4	5	2	3	work_packages_overview	---\n:name: Work packages\n	6
28	5	6	1	3	work_packages_table	---\n:name: Project plan\n:queryId: '13'\n	6
29	1	2	1	2	project_description	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project description\n	7
30	1	2	2	3	project_status	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project status\n	7
31	2	3	1	2	project_details	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project details\n	7
32	3	4	1	3	work_packages_overview	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages overview\n	7
33	2	3	2	3	members	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Members\n	7
35	1	2	2	3	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages created by me\nqueryId: '26'\n	8
34	1	2	1	2	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages assigned to me\n	8
37	1	2	1	2	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages assigned to me\nqueryId: '29'\n	10
38	1	2	2	3	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages created by me\n	10
39	1	2	1	2	project_description	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project description\n	11
40	1	2	2	3	project_status	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project status\n	11
41	2	3	1	2	project_details	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project details\n	11
42	3	4	1	3	work_packages_overview	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages overview\n	11
43	2	3	2	3	members	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Members\n	11
44	1	2	1	2	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '32'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '1'\n	13
45	1	2	2	3	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '33'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '7'\n	13
46	1	2	3	4	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '34'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '8'\n	13
50	1	2	4	5	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '38'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '16'\n	13
51	1	2	5	6	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '39'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '12'\n	13
53	1	2	2	3	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages created by me\nqueryId: '40'\n	14
52	1	2	1	2	work_packages_table	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages assigned to me\nqueryId: '42'\n	14
54	1	2	1	2	project_description	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project description\n	15
55	1	2	2	3	project_status	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project status\n	15
56	2	3	1	2	project_details	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Project details\n	15
57	3	4	1	3	work_packages_overview	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Work packages overview\n	15
58	2	3	2	3	members	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: Members\n	15
59	1	2	1	2	time_entries_current_user	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname: My spent time\n	17
60	1	2	1	2	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '44'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '1'\n	18
61	1	2	2	3	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '45'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '7'\n	18
62	1	2	3	4	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '46'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '8'\n	18
63	1	2	1	2	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '47'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '1'\n	19
64	1	2	2	3	work_package_query	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nqueryId: '48'\nfilters:\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n  status: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n    operator: "="\n    values:\n    - '7'\n	19
\.


--
-- Data for Name: grids; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grids (id, row_count, column_count, type, user_id, created_at, updated_at, project_id, name, options) FROM stdin;
1	1	0	Boards::Grid	\N	2020-03-31 23:26:46.034823	2020-03-31 23:26:46.034823	1	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n
2	1	0	Boards::Grid	\N	2020-03-31 23:26:46.159973	2020-03-31 23:26:46.159973	1	Task board	---\nhighlightingMode: priority\n
3	1	0	Boards::Grid	\N	2020-03-31 23:26:48.842444	2020-03-31 23:26:48.842444	2	Kanban board	---\ntype: action\nattribute: status\nhighlightingMode: priority\n
4	1	0	Boards::Grid	\N	2020-03-31 23:26:49.008504	2020-03-31 23:26:49.008504	2	Task board	---\nhighlightingMode: priority\n
5	5	2	Grids::Overview	\N	2020-03-31 23:26:49.248202	2020-03-31 23:26:49.248202	1	\N	\N
6	5	2	Grids::Overview	\N	2020-03-31 23:26:49.329676	2020-03-31 23:26:49.329676	2	\N	\N
7	3	2	Grids::Overview	\N	2020-04-01 12:08:57.575359	2020-04-01 12:08:57.575359	3	\N	\N
8	1	2	Grids::MyPage	2	2020-04-01 13:21:18.371521	2020-04-01 13:21:19.679154	\N	\N	\N
10	1	2	Grids::MyPage	6	2020-04-01 18:49:51.76111	2020-04-01 18:49:52.735573	\N	\N	\N
11	3	2	Grids::Overview	\N	2020-04-01 22:10:03.505375	2020-04-01 22:10:03.505375	4	\N	\N
12	1	1	Grids::MyPage	16	2020-04-03 00:18:01.652325	2020-04-03 00:18:01.652325	\N	\N	\N
13	1	5	Boards::Grid	\N	2020-04-08 22:47:55.958305	2020-04-08 22:49:41.295243	3	Production Orders	---\ntype: action\nattribute: status\nfilters:\n- type:\n    operator: "="\n    values:\n    - '4'\n
14	1	2	Grids::MyPage	13	2020-04-09 00:16:20.415801	2020-04-09 00:16:29.363707	\N	\N	\N
15	3	2	Grids::Overview	\N	2020-04-09 00:23:40.982185	2020-04-09 00:23:40.982185	5	\N	\N
16	1	1	Grids::MyPage	28	2020-04-09 21:08:16.503998	2020-04-09 21:08:16.503998	\N	\N	\N
17	1	1	Grids::MyPage	27	2020-04-10 02:21:55.873437	2020-04-10 02:22:01.786342	\N	\N	\N
18	1	3	Boards::Grid	\N	2020-04-10 19:03:54.215208	2020-04-10 19:07:41.970987	5	Victoria Production	---\ntype: action\nattribute: status\nfilters:\n- customField16:\n    operator: "="\n    values:\n    - Victoria\n
19	1	2	Boards::Grid	\N	2020-04-10 19:08:16.73731	2020-04-10 19:08:58.348388	5	My Production	---\ntype: action\nattribute: status\nfilters:\n- assignee:\n    operator: "="\n    values:\n    - me\n
20	1	1	Grids::MyPage	30	2020-04-11 17:13:49.431069	2020-04-11 17:13:49.431069	\N	\N	\N
22	1	1	Grids::MyPage	33	2020-04-13 15:53:55.1691	2020-04-13 15:53:55.1691	\N	\N	\N
\.


--
-- Data for Name: project_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_statuses (id, project_id, explanation, code, created_at, updated_at) FROM stdin;
3	3		\N	2020-04-01 11:36:09.976368	2020-04-01 11:36:09.976368
5	5		\N	2020-04-09 00:22:35.444236	2020-04-09 00:22:35.444236
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, name, description, public, parent_id, created_at, updated_at, identifier, lft, rgt, active) FROM stdin;
3	PPE		f	\N	2020-04-01 11:36:09.851579	2020-04-09 00:23:32.906037	ppe	1	4	t
5	PPE Production		f	3	2020-04-09 00:22:35.396873	2020-04-09 00:23:32.906037	ppe-production	2	3	t
\.


--
-- Data for Name: projects_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_types (project_id, type_id) FROM stdin;
3	1
3	3
3	4
5	4
\.


--
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.queries (id, project_id, name, filters, user_id, is_public, column_names, sort_criteria, group_by, display_sums, timeline_visible, show_hierarchies, timeline_zoom_level, timeline_labels, highlighting_mode, highlighted_attributes, hidden, created_at, updated_at, display_representation) FROM stdin;
25	\N	!!!__O__o__O__!!!	---\nstatus_id:\n  :operator: o\n  :values: []\nassigned_to_id:\n  :operator: "="\n  :values:\n  - me\n	2	f	---\n- :id\n- :project\n- :type\n- :subject\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-01 13:21:19.378389	2020-04-01 13:21:19.408494	\N
26	\N	!!!__O__o__O__!!!	---\nstatus_id:\n  :operator: o\n  :values: []\nauthor_id:\n  :operator: "="\n  :values:\n  - me\n	2	f	---\n- :id\n- :project\n- :type\n- :subject\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-01 13:21:19.411288	2020-04-01 13:21:19.436585	\N
27	3	Unnamed list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	2	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-01 13:24:55.730482	2020-04-01 13:24:55.737776	\N
30	3	All open	---\nstatus_id:\n  :operator: o\n  :values: []\n	13	f	---\n- :type\n- :id\n- :subject\n- :status\n- :assigned_to\n- :priority\n- :cf_4\n- :cf_5\n- :cf_9\n- :cf_7\n- :cf_1\n- :cf_2\n- :cf_6\n- :cf_8\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	f	2020-04-04 23:14:01.831358	2020-04-04 23:14:01.839046	\N
31	3	All open	---\nstatus_id:\n  :operator: o\n  :values: []\n	13	f	---\n- :type\n- :id\n- :subject\n- :status\n- :assigned_to\n- :priority\n- :cf_4\n- :cf_5\n- :cf_9\n- :cf_7\n- :cf_1\n- :cf_2\n- :cf_6\n- :cf_8\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	f	2020-04-04 23:14:02.399972	2020-04-04 23:14:02.413624	\N
34	3	Produced	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '8'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-08 22:48:35.46509	2020-04-08 22:52:22.18753	\N
38	3	In Delivery	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '16'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-08 22:49:24.050517	2020-04-08 22:52:31.490133	\N
39	3	Closed	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '12'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-08 22:49:40.990677	2020-04-08 22:52:34.933412	\N
33	3	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-08 22:48:28.716421	2020-04-08 23:00:59.255735	\N
32	3	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-08 22:47:56.445326	2020-04-08 23:00:59.392092	\N
40	\N	!!!__O__o__O__!!!	---\nstatus_id:\n  :operator: o\n  :values: []\nauthor_id:\n  :operator: "="\n  :values:\n  - me\n	13	f	---\n- :id\n- :project\n- :type\n- :subject\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-09 00:16:22.165821	2020-04-09 00:16:22.194442	\N
41	\N	!!!__O__o__O__!!!	---\nstatus_id:\n  :operator: o\n  :values: []\nassigned_to_id:\n  :operator: "="\n  :values:\n  - me\n	13	f	---\n- :id\n- :project\n- :type\n- :subject\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-09 00:16:22.190622	2020-04-09 00:16:22.227598	\N
42	\N	!!!__O__o__O__!!!	---\nstatus_id:\n  :operator: o\n  :values: []\nassigned_to_id:\n  :operator: "="\n  :values:\n  - me\n	13	f	---\n- :id\n- :project\n- :type\n- :subject\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-09 00:16:29.212334	2020-04-09 00:16:29.222111	\N
46	5	Produced	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '8'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-10 19:07:41.658812	2020-04-10 19:07:41.666339	\N
47	5	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-10 19:08:17.856715	2020-04-10 19:10:17.375022	\N
48	5	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-10 19:08:26.733799	2020-04-10 19:10:17.974697	\N
43	3	Inbound Orders	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\n	15	t	---\n- :status\n- :cf_1\n- :cf_2\n- :cf_16\n- :cf_7\n- :cf_8\n- :cf_9\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	f	2020-04-09 21:19:01.061689	2020-04-11 08:25:40.474613	\N
44	5	New	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '1'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-10 19:03:54.739268	2020-04-11 17:38:56.829717	\N
45	5	In progress	---\nstatus_id:\n  :operator: "="\n  :values:\n  - '7'\n	13	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-10 19:07:37.814987	2020-04-11 17:38:56.987441	\N
50	3	Alberta Orders	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\ncf_16:\n  :operator: "~"\n  :values:\n  - Alberta\n	15	t	---\n- :status\n- :cf_1\n- :cf_2\n- :cf_16\n- :cf_7\n- :cf_8\n- :cf_9\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	f	2020-04-11 19:03:34.408117	2020-04-11 19:03:34.425574	\N
51	3	Unnamed list	---\nmanual_sort:\n  :operator: ow\n  :values: []\n	15	t	\N	---\n- - manual_sorting\n  - asc\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	t	2020-04-12 23:29:28.652135	2020-04-12 23:29:28.658785	\N
49	3	Vancouver Island Orders	---\nstatus_id:\n  :operator: o\n  :values: []\ntype_id:\n  :operator: "="\n  :values:\n  - '1'\ncf_16:\n  :operator: "~"\n  :values:\n  - Vancouver Island\n	15	t	---\n- :status\n- :cf_1\n- :cf_2\n- :cf_16\n- :cf_7\n- :cf_8\n- :cf_9\n	---\n- - id\n  - asc\n	\N	f	f	t	5	\N	inline	\N	f	2020-04-11 00:08:25.585395	2020-04-13 21:32:20.501467	\N
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, permission, role_id, created_at, updated_at) FROM stdin;
1	edit_project	3	2020-03-31 23:26:25.284241	2020-03-31 23:26:25.284241
2	select_project_modules	3	2020-03-31 23:26:25.286005	2020-03-31 23:26:25.286005
3	manage_members	3	2020-03-31 23:26:25.2872	2020-03-31 23:26:25.2872
4	view_members	3	2020-03-31 23:26:25.28844	2020-03-31 23:26:25.28844
5	manage_versions	3	2020-03-31 23:26:25.289692	2020-03-31 23:26:25.289692
6	manage_types	3	2020-03-31 23:26:25.291045	2020-03-31 23:26:25.291045
7	add_subprojects	3	2020-03-31 23:26:25.292231	2020-03-31 23:26:25.292231
8	copy_projects	3	2020-03-31 23:26:25.293369	2020-03-31 23:26:25.293369
9	view_work_packages	3	2020-03-31 23:26:25.294522	2020-03-31 23:26:25.294522
10	add_work_packages	3	2020-03-31 23:26:25.295759	2020-03-31 23:26:25.295759
11	edit_work_packages	3	2020-03-31 23:26:25.296979	2020-03-31 23:26:25.296979
12	move_work_packages	3	2020-03-31 23:26:25.298235	2020-03-31 23:26:25.298235
13	add_work_package_notes	3	2020-03-31 23:26:25.299521	2020-03-31 23:26:25.299521
14	edit_work_package_notes	3	2020-03-31 23:26:25.300706	2020-03-31 23:26:25.300706
15	edit_own_work_package_notes	3	2020-03-31 23:26:25.302131	2020-03-31 23:26:25.302131
16	manage_categories	3	2020-03-31 23:26:25.303541	2020-03-31 23:26:25.303541
17	export_work_packages	3	2020-03-31 23:26:25.304879	2020-03-31 23:26:25.304879
18	delete_work_packages	3	2020-03-31 23:26:25.306204	2020-03-31 23:26:25.306204
19	manage_work_package_relations	3	2020-03-31 23:26:25.307411	2020-03-31 23:26:25.307411
20	manage_subtasks	3	2020-03-31 23:26:25.308701	2020-03-31 23:26:25.308701
21	manage_public_queries	3	2020-03-31 23:26:25.309939	2020-03-31 23:26:25.309939
22	save_queries	3	2020-03-31 23:26:25.311199	2020-03-31 23:26:25.311199
23	view_work_package_watchers	3	2020-03-31 23:26:25.312492	2020-03-31 23:26:25.312492
24	add_work_package_watchers	3	2020-03-31 23:26:25.313825	2020-03-31 23:26:25.313825
25	delete_work_package_watchers	3	2020-03-31 23:26:25.315141	2020-03-31 23:26:25.315141
26	assign_versions	3	2020-03-31 23:26:25.316366	2020-03-31 23:26:25.316366
27	view_time_entries	3	2020-03-31 23:26:25.317633	2020-03-31 23:26:25.317633
28	log_time	3	2020-03-31 23:26:25.318935	2020-03-31 23:26:25.318935
29	edit_time_entries	3	2020-03-31 23:26:25.320185	2020-03-31 23:26:25.320185
30	view_own_time_entries	3	2020-03-31 23:26:25.321471	2020-03-31 23:26:25.321471
31	edit_own_time_entries	3	2020-03-31 23:26:25.322796	2020-03-31 23:26:25.322796
32	manage_project_activities	3	2020-03-31 23:26:25.324197	2020-03-31 23:26:25.324197
33	manage_news	3	2020-03-31 23:26:25.325497	2020-03-31 23:26:25.325497
34	comment_news	3	2020-03-31 23:26:25.326756	2020-03-31 23:26:25.326756
35	view_wiki_pages	3	2020-03-31 23:26:25.328127	2020-03-31 23:26:25.328127
36	list_attachments	3	2020-03-31 23:26:25.329479	2020-03-31 23:26:25.329479
37	manage_wiki	3	2020-03-31 23:26:25.330836	2020-03-31 23:26:25.330836
38	manage_wiki_menu	3	2020-03-31 23:26:25.332138	2020-03-31 23:26:25.332138
39	rename_wiki_pages	3	2020-03-31 23:26:25.333439	2020-03-31 23:26:25.333439
40	change_wiki_parent_page	3	2020-03-31 23:26:25.334665	2020-03-31 23:26:25.334665
41	delete_wiki_pages	3	2020-03-31 23:26:25.336009	2020-03-31 23:26:25.336009
42	export_wiki_pages	3	2020-03-31 23:26:25.337237	2020-03-31 23:26:25.337237
43	view_wiki_edits	3	2020-03-31 23:26:25.338474	2020-03-31 23:26:25.338474
44	edit_wiki_pages	3	2020-03-31 23:26:25.339751	2020-03-31 23:26:25.339751
45	delete_wiki_pages_attachments	3	2020-03-31 23:26:25.341046	2020-03-31 23:26:25.341046
46	protect_wiki_pages	3	2020-03-31 23:26:25.342226	2020-03-31 23:26:25.342226
47	browse_repository	3	2020-03-31 23:26:25.343478	2020-03-31 23:26:25.343478
48	commit_access	3	2020-03-31 23:26:25.344928	2020-03-31 23:26:25.344928
49	manage_repository	3	2020-03-31 23:26:25.346255	2020-03-31 23:26:25.346255
50	view_changesets	3	2020-03-31 23:26:25.347601	2020-03-31 23:26:25.347601
51	view_commit_author_statistics	3	2020-03-31 23:26:25.348964	2020-03-31 23:26:25.348964
52	manage_forums	3	2020-03-31 23:26:25.3503	2020-03-31 23:26:25.3503
53	add_messages	3	2020-03-31 23:26:25.351552	2020-03-31 23:26:25.351552
54	edit_messages	3	2020-03-31 23:26:25.352765	2020-03-31 23:26:25.352765
55	edit_own_messages	3	2020-03-31 23:26:25.353965	2020-03-31 23:26:25.353965
56	delete_messages	3	2020-03-31 23:26:25.355179	2020-03-31 23:26:25.355179
57	delete_own_messages	3	2020-03-31 23:26:25.356364	2020-03-31 23:26:25.356364
58	view_calendar	3	2020-03-31 23:26:25.357563	2020-03-31 23:26:25.357563
59	view_documents	3	2020-03-31 23:26:25.358802	2020-03-31 23:26:25.358802
60	manage_documents	3	2020-03-31 23:26:25.360164	2020-03-31 23:26:25.360164
61	view_own_hourly_rate	3	2020-03-31 23:26:25.361306	2020-03-31 23:26:25.361306
62	view_hourly_rates	3	2020-03-31 23:26:25.362402	2020-03-31 23:26:25.362402
63	edit_own_hourly_rate	3	2020-03-31 23:26:25.363539	2020-03-31 23:26:25.363539
64	edit_hourly_rates	3	2020-03-31 23:26:25.364656	2020-03-31 23:26:25.364656
65	view_cost_rates	3	2020-03-31 23:26:25.365886	2020-03-31 23:26:25.365886
66	log_own_costs	3	2020-03-31 23:26:25.366973	2020-03-31 23:26:25.366973
67	log_costs	3	2020-03-31 23:26:25.368134	2020-03-31 23:26:25.368134
68	edit_own_cost_entries	3	2020-03-31 23:26:25.369219	2020-03-31 23:26:25.369219
69	edit_cost_entries	3	2020-03-31 23:26:25.370448	2020-03-31 23:26:25.370448
70	view_cost_objects	3	2020-03-31 23:26:25.372176	2020-03-31 23:26:25.372176
71	view_cost_entries	3	2020-03-31 23:26:25.373489	2020-03-31 23:26:25.373489
72	view_own_cost_entries	3	2020-03-31 23:26:25.374778	2020-03-31 23:26:25.374778
73	edit_cost_objects	3	2020-03-31 23:26:25.375999	2020-03-31 23:26:25.375999
76	view_meetings	3	2020-03-31 23:26:25.379695	2020-03-31 23:26:25.379695
77	create_meetings	3	2020-03-31 23:26:25.380933	2020-03-31 23:26:25.380933
78	edit_meetings	3	2020-03-31 23:26:25.382163	2020-03-31 23:26:25.382163
79	delete_meetings	3	2020-03-31 23:26:25.383396	2020-03-31 23:26:25.383396
80	meetings_send_invite	3	2020-03-31 23:26:25.384739	2020-03-31 23:26:25.384739
81	create_meeting_agendas	3	2020-03-31 23:26:25.385937	2020-03-31 23:26:25.385937
82	close_meeting_agendas	3	2020-03-31 23:26:25.387221	2020-03-31 23:26:25.387221
83	send_meeting_agendas_notification	3	2020-03-31 23:26:25.388372	2020-03-31 23:26:25.388372
84	send_meeting_agendas_icalendar	3	2020-03-31 23:26:25.389532	2020-03-31 23:26:25.389532
85	create_meeting_minutes	3	2020-03-31 23:26:25.390651	2020-03-31 23:26:25.390651
86	send_meeting_minutes_notification	3	2020-03-31 23:26:25.391809	2020-03-31 23:26:25.391809
87	view_master_backlog	3	2020-03-31 23:26:25.392976	2020-03-31 23:26:25.392976
88	view_taskboards	3	2020-03-31 23:26:25.394145	2020-03-31 23:26:25.394145
89	update_sprints	3	2020-03-31 23:26:25.395294	2020-03-31 23:26:25.395294
90	show_board_views	3	2020-03-31 23:26:25.396569	2020-03-31 23:26:25.396569
91	manage_board_views	3	2020-03-31 23:26:25.398053	2020-03-31 23:26:25.398053
92	manage_overview	3	2020-03-31 23:26:25.399352	2020-03-31 23:26:25.399352
93	view_work_packages	4	2020-03-31 23:26:25.425624	2020-03-31 23:26:25.425624
94	export_work_packages	4	2020-03-31 23:26:25.427059	2020-03-31 23:26:25.427059
95	add_work_packages	4	2020-03-31 23:26:25.428414	2020-03-31 23:26:25.428414
96	move_work_packages	4	2020-03-31 23:26:25.429933	2020-03-31 23:26:25.429933
97	edit_work_packages	4	2020-03-31 23:26:25.431239	2020-03-31 23:26:25.431239
98	assign_versions	4	2020-03-31 23:26:25.432399	2020-03-31 23:26:25.432399
99	add_work_package_notes	4	2020-03-31 23:26:25.433675	2020-03-31 23:26:25.433675
100	edit_own_work_package_notes	4	2020-03-31 23:26:25.434932	2020-03-31 23:26:25.434932
101	manage_work_package_relations	4	2020-03-31 23:26:25.436145	2020-03-31 23:26:25.436145
102	manage_subtasks	4	2020-03-31 23:26:25.437467	2020-03-31 23:26:25.437467
103	manage_public_queries	4	2020-03-31 23:26:25.438727	2020-03-31 23:26:25.438727
104	save_queries	4	2020-03-31 23:26:25.440053	2020-03-31 23:26:25.440053
105	view_work_package_watchers	4	2020-03-31 23:26:25.44135	2020-03-31 23:26:25.44135
106	add_work_package_watchers	4	2020-03-31 23:26:25.442574	2020-03-31 23:26:25.442574
107	delete_work_package_watchers	4	2020-03-31 23:26:25.443735	2020-03-31 23:26:25.443735
108	view_calendar	4	2020-03-31 23:26:25.44492	2020-03-31 23:26:25.44492
109	comment_news	4	2020-03-31 23:26:25.446191	2020-03-31 23:26:25.446191
110	manage_news	4	2020-03-31 23:26:25.447615	2020-03-31 23:26:25.447615
111	log_time	4	2020-03-31 23:26:25.449302	2020-03-31 23:26:25.449302
112	view_time_entries	4	2020-03-31 23:26:25.450611	2020-03-31 23:26:25.450611
113	view_own_time_entries	4	2020-03-31 23:26:25.451903	2020-03-31 23:26:25.451903
114	edit_own_time_entries	4	2020-03-31 23:26:25.453211	2020-03-31 23:26:25.453211
115	view_timelines	4	2020-03-31 23:26:25.454507	2020-03-31 23:26:25.454507
116	edit_timelines	4	2020-03-31 23:26:25.455795	2020-03-31 23:26:25.455795
117	delete_timelines	4	2020-03-31 23:26:25.457311	2020-03-31 23:26:25.457311
118	view_reportings	4	2020-03-31 23:26:25.458771	2020-03-31 23:26:25.458771
119	edit_reportings	4	2020-03-31 23:26:25.459686	2020-03-31 23:26:25.459686
120	delete_reportings	4	2020-03-31 23:26:25.460592	2020-03-31 23:26:25.460592
121	manage_wiki	4	2020-03-31 23:26:25.461663	2020-03-31 23:26:25.461663
122	manage_wiki_menu	4	2020-03-31 23:26:25.462739	2020-03-31 23:26:25.462739
123	rename_wiki_pages	4	2020-03-31 23:26:25.46368	2020-03-31 23:26:25.46368
124	change_wiki_parent_page	4	2020-03-31 23:26:25.464613	2020-03-31 23:26:25.464613
125	delete_wiki_pages	4	2020-03-31 23:26:25.465764	2020-03-31 23:26:25.465764
126	view_wiki_pages	4	2020-03-31 23:26:25.467289	2020-03-31 23:26:25.467289
127	export_wiki_pages	4	2020-03-31 23:26:25.468661	2020-03-31 23:26:25.468661
128	view_wiki_edits	4	2020-03-31 23:26:25.469699	2020-03-31 23:26:25.469699
129	edit_wiki_pages	4	2020-03-31 23:26:25.470722	2020-03-31 23:26:25.470722
130	delete_wiki_pages_attachments	4	2020-03-31 23:26:25.471758	2020-03-31 23:26:25.471758
131	protect_wiki_pages	4	2020-03-31 23:26:25.472732	2020-03-31 23:26:25.472732
132	list_attachments	4	2020-03-31 23:26:25.473782	2020-03-31 23:26:25.473782
133	add_messages	4	2020-03-31 23:26:25.474797	2020-03-31 23:26:25.474797
134	edit_own_messages	4	2020-03-31 23:26:25.475726	2020-03-31 23:26:25.475726
135	delete_own_messages	4	2020-03-31 23:26:25.476732	2020-03-31 23:26:25.476732
136	browse_repository	4	2020-03-31 23:26:25.477798	2020-03-31 23:26:25.477798
137	view_changesets	4	2020-03-31 23:26:25.478801	2020-03-31 23:26:25.478801
138	commit_access	4	2020-03-31 23:26:25.479723	2020-03-31 23:26:25.479723
139	view_commit_author_statistics	4	2020-03-31 23:26:25.480762	2020-03-31 23:26:25.480762
140	view_members	4	2020-03-31 23:26:25.481915	2020-03-31 23:26:25.481915
141	manage_board_views	4	2020-03-31 23:26:25.482988	2020-03-31 23:26:25.482988
142	show_board_views	4	2020-03-31 23:26:25.484	2020-03-31 23:26:25.484
143	view_documents	4	2020-03-31 23:26:25.484971	2020-03-31 23:26:25.484971
144	manage_documents	4	2020-03-31 23:26:25.486019	2020-03-31 23:26:25.486019
145	view_master_backlog	4	2020-03-31 23:26:25.486967	2020-03-31 23:26:25.486967
146	view_taskboards	4	2020-03-31 23:26:25.487943	2020-03-31 23:26:25.487943
147	show_board_views	4	2020-03-31 23:26:25.488881	2020-03-31 23:26:25.488881
148	manage_board_views	4	2020-03-31 23:26:25.489902	2020-03-31 23:26:25.489902
149	view_work_packages	5	2020-03-31 23:26:25.500724	2020-03-31 23:26:25.500724
150	add_work_package_notes	5	2020-03-31 23:26:25.501825	2020-03-31 23:26:25.501825
151	edit_own_work_package_notes	5	2020-03-31 23:26:25.502749	2020-03-31 23:26:25.502749
152	save_queries	5	2020-03-31 23:26:25.503655	2020-03-31 23:26:25.503655
153	view_calendar	5	2020-03-31 23:26:25.504653	2020-03-31 23:26:25.504653
154	comment_news	5	2020-03-31 23:26:25.505642	2020-03-31 23:26:25.505642
155	view_timelines	5	2020-03-31 23:26:25.506568	2020-03-31 23:26:25.506568
156	view_reportings	5	2020-03-31 23:26:25.507461	2020-03-31 23:26:25.507461
157	view_wiki_pages	5	2020-03-31 23:26:25.508433	2020-03-31 23:26:25.508433
158	export_wiki_pages	5	2020-03-31 23:26:25.509413	2020-03-31 23:26:25.509413
159	list_attachments	5	2020-03-31 23:26:25.510329	2020-03-31 23:26:25.510329
160	add_messages	5	2020-03-31 23:26:25.511222	2020-03-31 23:26:25.511222
161	edit_own_messages	5	2020-03-31 23:26:25.512171	2020-03-31 23:26:25.512171
162	delete_own_messages	5	2020-03-31 23:26:25.513084	2020-03-31 23:26:25.513084
163	browse_repository	5	2020-03-31 23:26:25.514052	2020-03-31 23:26:25.514052
164	view_changesets	5	2020-03-31 23:26:25.514977	2020-03-31 23:26:25.514977
165	show_board_views	5	2020-03-31 23:26:25.515924	2020-03-31 23:26:25.515924
166	view_documents	5	2020-03-31 23:26:25.51683	2020-03-31 23:26:25.51683
167	view_master_backlog	5	2020-03-31 23:26:25.517725	2020-03-31 23:26:25.517725
168	view_taskboards	5	2020-03-31 23:26:25.51864	2020-03-31 23:26:25.51864
169	show_board_views	5	2020-03-31 23:26:25.519571	2020-03-31 23:26:25.519571
170	add_project	6	2020-03-31 23:26:25.531833	2020-03-31 23:26:25.531833
171	view_work_packages	1	2020-03-31 23:26:25.536067	2020-03-31 23:26:25.536067
172	view_calendar	1	2020-03-31 23:26:25.537457	2020-03-31 23:26:25.537457
173	comment_news	1	2020-03-31 23:26:25.539192	2020-03-31 23:26:25.539192
174	browse_repository	1	2020-03-31 23:26:25.541192	2020-03-31 23:26:25.541192
175	view_changesets	1	2020-03-31 23:26:25.542952	2020-03-31 23:26:25.542952
176	view_wiki_pages	1	2020-03-31 23:26:25.544728	2020-03-31 23:26:25.544728
177	view_work_packages	2	2020-03-31 23:26:25.550414	2020-03-31 23:26:25.550414
178	browse_repository	2	2020-03-31 23:26:25.551747	2020-03-31 23:26:25.551747
179	view_changesets	2	2020-03-31 23:26:25.553048	2020-03-31 23:26:25.553048
180	view_wiki_pages	2	2020-03-31 23:26:25.554239	2020-03-31 23:26:25.554239
181	view_own_hourly_rate	4	2020-03-31 23:26:25.565337	2020-03-31 23:26:25.565337
182	view_cost_rates	4	2020-03-31 23:26:25.56743	2020-03-31 23:26:25.56743
183	log_own_costs	4	2020-03-31 23:26:25.569162	2020-03-31 23:26:25.569162
184	edit_own_cost_entries	4	2020-03-31 23:26:25.570835	2020-03-31 23:26:25.570835
185	view_cost_objects	4	2020-03-31 23:26:25.572697	2020-03-31 23:26:25.572697
186	view_own_cost_entries	4	2020-03-31 23:26:25.574434	2020-03-31 23:26:25.574434
74	save_cost_reports	\N	2020-03-31 23:26:25.377199	2020-03-31 23:26:25.377199
75	save_private_cost_reports	\N	2020-03-31 23:26:25.378452	2020-03-31 23:26:25.378452
187	create_meetings	4	2020-03-31 23:26:25.607154	2020-03-31 23:26:25.607154
188	edit_meetings	4	2020-03-31 23:26:25.609547	2020-03-31 23:26:25.609547
189	delete_meetings	4	2020-03-31 23:26:25.61192	2020-03-31 23:26:25.61192
190	view_meetings	4	2020-03-31 23:26:25.614062	2020-03-31 23:26:25.614062
191	create_meeting_agendas	4	2020-03-31 23:26:25.616287	2020-03-31 23:26:25.616287
192	close_meeting_agendas	4	2020-03-31 23:26:25.618258	2020-03-31 23:26:25.618258
193	send_meeting_agendas_notification	4	2020-03-31 23:26:25.620122	2020-03-31 23:26:25.620122
194	send_meeting_agendas_icalendar	4	2020-03-31 23:26:25.622227	2020-03-31 23:26:25.622227
195	create_meeting_minutes	4	2020-03-31 23:26:25.623985	2020-03-31 23:26:25.623985
196	send_meeting_minutes_notification	4	2020-03-31 23:26:25.625839	2020-03-31 23:26:25.625839
197	view_meetings	5	2020-03-31 23:26:25.632251	2020-03-31 23:26:25.632251
198	manage_overview	3	2020-03-31 23:26:49.396606	2020-03-31 23:26:49.396606
199	view_work_packages	7	2020-04-01 13:22:37.956067	2020-04-01 13:22:37.956067
200	view_calendar	7	2020-04-01 13:22:37.957594	2020-04-01 13:22:37.957594
201	comment_news	7	2020-04-01 13:22:37.95871	2020-04-01 13:22:37.95871
202	browse_repository	7	2020-04-01 13:22:37.959672	2020-04-01 13:22:37.959672
203	view_changesets	7	2020-04-01 13:22:37.96062	2020-04-01 13:22:37.96062
204	view_wiki_pages	7	2020-04-01 13:22:37.961596	2020-04-01 13:22:37.961596
205	view_work_packages	8	2020-04-01 13:28:43.115964	2020-04-01 13:28:43.115964
206	view_calendar	8	2020-04-01 13:28:43.117384	2020-04-01 13:28:43.117384
207	comment_news	8	2020-04-01 13:28:43.118546	2020-04-01 13:28:43.118546
208	browse_repository	8	2020-04-01 13:28:43.119713	2020-04-01 13:28:43.119713
209	view_changesets	8	2020-04-01 13:28:43.12093	2020-04-01 13:28:43.12093
210	view_wiki_pages	8	2020-04-01 13:28:43.1221	2020-04-01 13:28:43.1221
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, "position", assignable, builtin, type) FROM stdin;
1	Non member	1	t	1	Role
2	Anonymous	2	t	2	Role
4	Member	3	t	0	Role
5	Reader	4	t	0	Role
3	Project admin	8	t	0	Role
6	Project creator	6	f	0	GlobalRole
7	Producer	9	t	0	Role
8	Coordinator	10	t	0	Role
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statuses (id, name, is_closed, is_default, "position", default_done_ratio, created_at, updated_at, color_id, is_readonly) FROM stdin;
1	New	f	t	1	\N	2020-03-31 23:26:26.148759	2020-03-31 23:26:26.148759	96	f
4	Confirmed	f	f	2	\N	2020-03-31 23:26:26.166558	2020-04-01 12:22:27.839363	31	f
9	In testing	f	f	8	\N	2020-03-31 23:26:26.188819	2020-04-01 13:19:29.796032	102	f
10	Tested	f	f	9	\N	2020-03-31 23:26:26.193265	2020-04-01 13:19:29.796032	104	f
11	Test failed	f	f	10	\N	2020-03-31 23:26:26.197771	2020-04-01 13:19:29.796032	34	f
17	Sanitizing	f	f	11	\N	2020-04-01 13:17:32.650956	2020-04-01 13:19:29.796032	61	f
14	Rejected	t	f	16	\N	2020-03-31 23:26:26.213949	2020-04-01 13:19:29.796032	28	f
6	Scheduled	f	f	3	\N	2020-03-31 23:26:26.175762	2020-04-01 13:19:29.796032	117	f
7	In progress	f	f	4	\N	2020-03-31 23:26:26.180051	2020-04-01 13:19:29.796032	88	f
13	On hold	f	f	15	\N	2020-03-31 23:26:26.208734	2020-04-01 13:19:29.796032	138	f
12	Closed	t	f	14	\N	2020-03-31 23:26:26.203078	2020-04-01 13:19:29.796032	18	f
8	Produced	f	f	6	\N	2020-03-31 23:26:26.184115	2020-04-01 13:19:29.796032	101	f
16	In Delivery	f	f	13	\N	2020-04-01 13:15:51.055243	2020-04-01 13:19:29.796032	80	f
18	Sanitized	f	f	12	\N	2020-04-01 13:18:47.175098	2020-04-01 13:19:29.796032	9	f
15	In transit	f	f	7	\N	2020-04-01 13:15:31.553638	2020-04-01 13:19:38.923171	120	f
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.types (id, name, "position", is_in_roadmap, is_milestone, is_default, color_id, created_at, updated_at, is_standard, attribute_groups, description) FROM stdin;
4	Production Order	3	t	f	t	3	2020-03-31 23:26:26.111414	2020-04-09 00:10:18.720948	f	---\n- - Request\n  - - custom_field_16\n    - custom_field_7\n    - custom_field_8\n    - custom_field_9\n- - :people\n  - - assignee\n    - responsible\n- - :estimates_and_time\n  - - estimated_time\n    - spent_time\n- - :details\n  - - priority\n	
3	Delivery	2	f	f	t	13	2020-03-31 23:26:26.10692	2020-04-09 00:11:00.521953	f	---\n- - Pickup\n  - - custom_field_16\n    - custom_field_10\n    - custom_field_12\n    - custom_field_13\n- - Delivery\n  - - custom_field_11\n    - custom_field_14\n    - custom_field_15\n- - :people\n  - - assignee\n    - responsible\n- - :details\n  - - date\n    - category\n    - priority\n	
1	Order	1	t	f	t	2	2020-03-31 23:26:26.096558	2020-04-12 23:28:51.883815	f	---\n- - Facility\n  - - custom_field_1\n    - custom_field_2\n    - custom_field_3\n    - custom_field_16\n- - Contact\n  - - custom_field_4\n    - custom_field_5\n    - custom_field_18\n- - Request\n  - - custom_field_6\n    - custom_field_7\n    - custom_field_8\n    - custom_field_9\n    - custom_field_17\n- - :people\n  - - responsible\n- - :details\n  - - category\n    - priority\n    - percentage_done\n	
\.


--
-- Data for Name: webhooks_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhooks_events (id, name, webhooks_webhook_id) FROM stdin;
7	work_package:updated	1
8	work_package:created	1
\.


--
-- Data for Name: webhooks_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhooks_webhooks (id, name, url, description, secret, enabled, all_projects, created_at, updated_at) FROM stdin;
1	WorkPackage Manager	http://workpackage-manager/update			t	t	2020-04-04 04:00:56.362113	2020-04-06 05:20:58.702553
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflows (id, type_id, old_status_id, new_status_id, role_id, assignee, author) FROM stdin;
1	1	1	1	3	f	f
3	1	1	7	3	f	f
5	1	1	13	3	f	f
7	1	1	14	3	f	f
9	1	1	12	3	f	f
11	1	7	1	3	f	f
13	1	7	7	3	f	f
15	1	7	13	3	f	f
17	1	7	14	3	f	f
19	1	7	12	3	f	f
21	1	13	1	3	f	f
23	1	13	7	3	f	f
25	1	13	13	3	f	f
27	1	13	14	3	f	f
29	1	13	12	3	f	f
31	1	14	1	3	f	f
33	1	14	7	3	f	f
35	1	14	13	3	f	f
37	1	14	14	3	f	f
39	1	14	12	3	f	f
41	1	12	1	3	f	f
43	1	12	7	3	f	f
45	1	12	13	3	f	f
47	1	12	14	3	f	f
49	1	12	12	3	f	f
149	3	1	1	3	f	f
150	3	1	1	4	f	f
153	3	1	6	3	f	f
154	3	1	6	4	f	f
155	3	1	7	3	f	f
156	3	1	7	4	f	f
157	3	1	13	3	f	f
158	3	1	13	4	f	f
159	3	1	14	3	f	f
160	3	1	14	4	f	f
161	3	1	12	3	f	f
162	3	1	12	4	f	f
177	3	6	1	3	f	f
178	3	6	1	4	f	f
181	3	6	6	3	f	f
182	3	6	6	4	f	f
183	3	6	7	3	f	f
184	3	6	7	4	f	f
185	3	6	13	3	f	f
186	3	6	13	4	f	f
187	3	6	14	3	f	f
188	3	6	14	4	f	f
189	3	6	12	3	f	f
190	3	6	12	4	f	f
191	3	7	1	3	f	f
192	3	7	1	4	f	f
195	3	7	6	3	f	f
196	3	7	6	4	f	f
197	3	7	7	3	f	f
198	3	7	7	4	f	f
199	3	7	13	3	f	f
200	3	7	13	4	f	f
201	3	7	14	3	f	f
202	3	7	14	4	f	f
203	3	7	12	3	f	f
204	3	7	12	4	f	f
205	3	13	1	3	f	f
206	3	13	1	4	f	f
209	3	13	6	3	f	f
210	3	13	6	4	f	f
211	3	13	7	3	f	f
212	3	13	7	4	f	f
213	3	13	13	3	f	f
214	3	13	13	4	f	f
215	3	13	14	3	f	f
216	3	13	14	4	f	f
217	3	13	12	3	f	f
218	3	13	12	4	f	f
219	3	14	1	3	f	f
220	3	14	1	4	f	f
223	3	14	6	3	f	f
224	3	14	6	4	f	f
225	3	14	7	3	f	f
226	3	14	7	4	f	f
227	3	14	13	3	f	f
228	3	14	13	4	f	f
229	3	14	14	3	f	f
230	3	14	14	4	f	f
231	3	14	12	3	f	f
232	3	14	12	4	f	f
233	3	12	1	3	f	f
234	3	12	1	4	f	f
237	3	12	6	3	f	f
238	3	12	6	4	f	f
239	3	12	7	3	f	f
240	3	12	7	4	f	f
241	3	12	13	3	f	f
242	3	12	13	4	f	f
243	3	12	14	3	f	f
244	3	12	14	4	f	f
245	3	12	12	3	f	f
246	3	12	12	4	f	f
247	4	1	1	3	f	f
1173	1	1	1	7	f	f
1174	1	1	7	7	f	f
1175	1	1	13	7	f	f
1176	1	1	14	7	f	f
253	4	1	7	3	f	f
255	4	1	8	3	f	f
257	4	1	9	3	f	f
259	4	1	10	3	f	f
261	4	1	11	3	f	f
263	4	1	13	3	f	f
265	4	1	14	3	f	f
267	4	1	12	3	f	f
1177	1	1	12	7	f	f
1178	1	7	1	7	f	f
1179	1	7	7	7	f	f
1180	1	7	13	7	f	f
1181	1	7	14	7	f	f
1182	1	7	12	7	f	f
1183	1	13	1	7	f	f
1184	1	13	7	7	f	f
1185	1	13	13	7	f	f
1186	1	13	14	7	f	f
1187	1	13	12	7	f	f
1188	1	14	1	7	f	f
1189	1	14	7	7	f	f
1190	1	14	13	7	f	f
1191	1	14	14	7	f	f
1192	1	14	12	7	f	f
1193	1	12	1	7	f	f
1194	1	12	7	7	f	f
1195	1	12	13	7	f	f
1196	1	12	14	7	f	f
1197	1	12	12	7	f	f
1198	3	1	1	7	f	f
1199	3	1	6	7	f	f
1200	3	1	7	7	f	f
1201	3	1	13	7	f	f
1202	3	1	14	7	f	f
1203	3	1	12	7	f	f
1204	3	6	1	7	f	f
1205	3	6	6	7	f	f
1206	3	6	7	7	f	f
1207	3	6	13	7	f	f
1208	3	6	14	7	f	f
1209	3	6	12	7	f	f
1210	3	7	1	7	f	f
1211	3	7	6	7	f	f
1212	3	7	7	7	f	f
1213	3	7	13	7	f	f
1214	3	7	14	7	f	f
1215	3	7	12	7	f	f
1216	3	13	1	7	f	f
1217	3	13	6	7	f	f
1218	3	13	7	7	f	f
1219	3	13	13	7	f	f
1220	3	13	14	7	f	f
313	4	7	1	3	f	f
1221	3	13	12	7	f	f
1222	3	14	1	7	f	f
1223	3	14	6	7	f	f
1224	3	14	7	7	f	f
319	4	7	7	3	f	f
321	4	7	8	3	f	f
323	4	7	9	3	f	f
325	4	7	10	3	f	f
327	4	7	11	3	f	f
329	4	7	13	3	f	f
331	4	7	14	3	f	f
333	4	7	12	3	f	f
335	4	8	1	3	f	f
1225	3	14	13	7	f	f
1226	3	14	14	7	f	f
1227	3	14	12	7	f	f
1228	3	12	1	7	f	f
341	4	8	7	3	f	f
343	4	8	8	3	f	f
345	4	8	9	3	f	f
347	4	8	10	3	f	f
349	4	8	11	3	f	f
351	4	8	13	3	f	f
353	4	8	14	3	f	f
355	4	8	12	3	f	f
357	4	9	1	3	f	f
1229	3	12	6	7	f	f
1230	3	12	7	7	f	f
1231	3	12	13	7	f	f
1232	3	12	14	7	f	f
363	4	9	7	3	f	f
365	4	9	8	3	f	f
367	4	9	9	3	f	f
369	4	9	10	3	f	f
371	4	9	11	3	f	f
373	4	9	13	3	f	f
375	4	9	14	3	f	f
377	4	9	12	3	f	f
379	4	10	1	3	f	f
1233	3	12	12	7	f	f
1234	4	1	1	7	f	f
1235	4	1	7	7	f	f
1236	4	1	8	7	f	f
385	4	10	7	3	f	f
387	4	10	8	3	f	f
389	4	10	9	3	f	f
391	4	10	10	3	f	f
393	4	10	11	3	f	f
395	4	10	13	3	f	f
397	4	10	14	3	f	f
399	4	10	12	3	f	f
401	4	11	1	3	f	f
1237	4	1	9	7	f	f
1238	4	1	10	7	f	f
1239	4	1	11	7	f	f
1240	4	1	13	7	f	f
407	4	11	7	3	f	f
409	4	11	8	3	f	f
411	4	11	9	3	f	f
413	4	11	10	3	f	f
415	4	11	11	3	f	f
417	4	11	13	3	f	f
419	4	11	14	3	f	f
421	4	11	12	3	f	f
423	4	13	1	3	f	f
1241	4	1	14	7	f	f
1242	4	1	12	7	f	f
1243	4	7	1	7	f	f
1244	4	7	7	7	f	f
429	4	13	7	3	f	f
431	4	13	8	3	f	f
433	4	13	9	3	f	f
435	4	13	10	3	f	f
437	4	13	11	3	f	f
439	4	13	13	3	f	f
441	4	13	14	3	f	f
443	4	13	12	3	f	f
445	4	14	1	3	f	f
1245	4	7	8	7	f	f
1246	4	7	9	7	f	f
1247	4	7	10	7	f	f
1248	4	7	11	7	f	f
451	4	14	7	3	f	f
453	4	14	8	3	f	f
455	4	14	9	3	f	f
457	4	14	10	3	f	f
459	4	14	11	3	f	f
461	4	14	13	3	f	f
463	4	14	14	3	f	f
465	4	14	12	3	f	f
467	4	12	1	3	f	f
1249	4	7	13	7	f	f
1250	4	7	14	7	f	f
1251	4	7	12	7	f	f
1252	4	8	1	7	f	f
473	4	12	7	3	f	f
475	4	12	8	3	f	f
477	4	12	9	3	f	f
479	4	12	10	3	f	f
481	4	12	11	3	f	f
483	4	12	13	3	f	f
485	4	12	14	3	f	f
487	4	12	12	3	f	f
1253	4	8	7	7	f	f
1254	4	8	8	7	f	f
1255	4	8	9	7	f	f
1256	4	8	10	7	f	f
1257	4	8	11	7	f	f
1258	4	8	13	7	f	f
1259	4	8	14	7	f	f
1260	4	8	12	7	f	f
1261	4	9	1	7	f	f
1262	4	9	7	7	f	f
1263	4	9	8	7	f	f
1264	4	9	9	7	f	f
1265	4	9	10	7	f	f
1266	4	9	11	7	f	f
1267	4	9	13	7	f	f
1268	4	9	14	7	f	f
1269	4	9	12	7	f	f
1270	4	10	1	7	f	f
1271	4	10	7	7	f	f
1272	4	10	8	7	f	f
1273	4	10	9	7	f	f
1274	4	10	10	7	f	f
1275	4	10	11	7	f	f
1276	4	10	13	7	f	f
1277	4	10	14	7	f	f
1278	4	10	12	7	f	f
1279	4	11	1	7	f	f
1280	4	11	7	7	f	f
1281	4	11	8	7	f	f
1282	4	11	9	7	f	f
1283	4	11	10	7	f	f
1284	4	11	11	7	f	f
1285	4	11	13	7	f	f
1286	4	11	14	7	f	f
1287	4	11	12	7	f	f
1288	4	13	1	7	f	f
1289	4	13	7	7	f	f
1290	4	13	8	7	f	f
1291	4	13	9	7	f	f
1292	4	13	10	7	f	f
1293	4	13	11	7	f	f
1294	4	13	13	7	f	f
1295	4	13	14	7	f	f
1296	4	13	12	7	f	f
1297	4	14	1	7	f	f
1298	4	14	7	7	f	f
1299	4	14	8	7	f	f
1300	4	14	9	7	f	f
1301	4	14	10	7	f	f
1302	4	14	11	7	f	f
1303	4	14	13	7	f	f
1304	4	14	14	7	f	f
1305	4	14	12	7	f	f
1306	4	12	1	7	f	f
1307	4	12	7	7	f	f
1308	4	12	8	7	f	f
1309	4	12	9	7	f	f
1310	4	12	10	7	f	f
1311	4	12	11	7	f	f
1312	4	12	13	7	f	f
1313	4	12	14	7	f	f
1314	4	12	12	7	f	f
2702	1	1	4	4	f	f
2703	1	1	13	4	f	f
2704	1	1	14	4	f	f
2705	1	4	7	4	f	f
2706	1	4	8	4	f	f
2707	1	4	16	4	f	f
2708	1	4	12	4	f	f
2709	1	4	13	4	f	f
2710	1	4	14	4	f	f
2711	1	7	7	4	f	f
2712	1	7	8	4	f	f
2713	1	7	16	4	f	f
2714	1	7	12	4	f	f
2715	1	7	13	4	f	f
2716	1	7	14	4	f	f
2717	1	8	16	4	f	f
2718	1	8	12	4	f	f
2719	1	8	13	4	f	f
2720	1	8	14	4	f	f
2721	1	16	16	4	f	f
2722	1	16	12	4	f	f
2723	1	16	13	4	f	f
2724	1	16	14	4	f	f
2725	1	12	1	4	f	f
2726	1	12	14	4	f	f
2727	1	13	1	4	f	f
2728	1	13	4	4	f	f
2729	1	13	7	4	f	f
2730	1	13	8	4	f	f
2731	1	13	16	4	f	f
2732	1	13	12	4	f	f
2733	1	13	14	4	f	f
2734	1	14	1	4	f	f
2666	4	1	1	4	f	f
2667	4	1	7	4	f	f
2668	4	1	8	4	f	f
2669	4	1	12	4	f	f
2670	4	1	13	4	f	f
2671	4	1	14	4	f	f
2672	4	7	1	4	f	f
2673	4	7	7	4	f	f
2674	4	7	8	4	f	f
2675	4	7	12	4	f	f
2676	4	7	13	4	f	f
2677	4	7	14	4	f	f
2678	4	8	1	4	f	f
2679	4	8	7	4	f	f
2680	4	8	8	4	f	f
2681	4	8	12	4	f	f
2682	4	8	13	4	f	f
2683	4	8	14	4	f	f
2684	4	12	1	4	f	f
2685	4	12	7	4	f	f
2686	4	12	8	4	f	f
2687	4	12	12	4	f	f
2688	4	12	13	4	f	f
2689	4	12	14	4	f	f
2690	4	13	1	4	f	f
2691	4	13	7	4	f	f
2692	4	13	8	4	f	f
2693	4	13	12	4	f	f
2694	4	13	13	4	f	f
2695	4	13	14	4	f	f
2696	4	14	1	4	f	f
2697	4	14	7	4	f	f
2698	4	14	8	4	f	f
2699	4	14	12	4	f	f
2700	4	14	13	4	f	f
2701	4	14	14	4	f	f
1613	1	1	1	8	f	f
1614	1	1	7	8	f	f
1615	1	1	13	8	f	f
1616	1	1	14	8	f	f
1617	1	1	12	8	f	f
1618	1	7	1	8	f	f
1619	1	7	7	8	f	f
1620	1	7	13	8	f	f
1621	1	7	14	8	f	f
1622	1	7	12	8	f	f
1623	1	13	1	8	f	f
1624	1	13	7	8	f	f
1625	1	13	13	8	f	f
1626	1	13	14	8	f	f
1627	1	13	12	8	f	f
1628	1	14	1	8	f	f
1629	1	14	7	8	f	f
1630	1	14	13	8	f	f
1631	1	14	14	8	f	f
1632	1	14	12	8	f	f
1633	1	12	1	8	f	f
1634	1	12	7	8	f	f
1635	1	12	13	8	f	f
1636	1	12	14	8	f	f
1637	1	12	12	8	f	f
1638	3	1	1	8	f	f
1639	3	1	6	8	f	f
1640	3	1	7	8	f	f
1641	3	1	13	8	f	f
1642	3	1	14	8	f	f
1643	3	1	12	8	f	f
1644	3	6	1	8	f	f
1645	3	6	6	8	f	f
1646	3	6	7	8	f	f
1647	3	6	13	8	f	f
1648	3	6	14	8	f	f
1649	3	6	12	8	f	f
1650	3	7	1	8	f	f
1651	3	7	6	8	f	f
1652	3	7	7	8	f	f
1653	3	7	13	8	f	f
1654	3	7	14	8	f	f
1655	3	7	12	8	f	f
1656	3	13	1	8	f	f
1657	3	13	6	8	f	f
1658	3	13	7	8	f	f
1659	3	13	13	8	f	f
1660	3	13	14	8	f	f
1661	3	13	12	8	f	f
1662	3	14	1	8	f	f
1663	3	14	6	8	f	f
1664	3	14	7	8	f	f
1665	3	14	13	8	f	f
1666	3	14	14	8	f	f
1667	3	14	12	8	f	f
1668	3	12	1	8	f	f
1669	3	12	6	8	f	f
1670	3	12	7	8	f	f
1671	3	12	13	8	f	f
1672	3	12	14	8	f	f
1673	3	12	12	8	f	f
1674	4	1	1	8	f	f
1675	4	1	7	8	f	f
1676	4	1	8	8	f	f
1677	4	1	9	8	f	f
1678	4	1	10	8	f	f
1679	4	1	11	8	f	f
1680	4	1	13	8	f	f
1681	4	1	14	8	f	f
1682	4	1	12	8	f	f
1683	4	7	1	8	f	f
1684	4	7	7	8	f	f
1685	4	7	8	8	f	f
1686	4	7	9	8	f	f
1687	4	7	10	8	f	f
1688	4	7	11	8	f	f
1689	4	7	13	8	f	f
1690	4	7	14	8	f	f
1691	4	7	12	8	f	f
1692	4	8	1	8	f	f
1693	4	8	7	8	f	f
1694	4	8	8	8	f	f
1695	4	8	9	8	f	f
1696	4	8	10	8	f	f
1697	4	8	11	8	f	f
1698	4	8	13	8	f	f
1699	4	8	14	8	f	f
1700	4	8	12	8	f	f
1701	4	9	1	8	f	f
1702	4	9	7	8	f	f
1703	4	9	8	8	f	f
1704	4	9	9	8	f	f
1705	4	9	10	8	f	f
1706	4	9	11	8	f	f
1707	4	9	13	8	f	f
1708	4	9	14	8	f	f
1709	4	9	12	8	f	f
1710	4	10	1	8	f	f
1711	4	10	7	8	f	f
1712	4	10	8	8	f	f
1713	4	10	9	8	f	f
1714	4	10	10	8	f	f
1715	4	10	11	8	f	f
1716	4	10	13	8	f	f
1717	4	10	14	8	f	f
1718	4	10	12	8	f	f
1719	4	11	1	8	f	f
1720	4	11	7	8	f	f
1721	4	11	8	8	f	f
1722	4	11	9	8	f	f
1723	4	11	10	8	f	f
1724	4	11	11	8	f	f
1725	4	11	13	8	f	f
1726	4	11	14	8	f	f
1727	4	11	12	8	f	f
1728	4	13	1	8	f	f
1729	4	13	7	8	f	f
1730	4	13	8	8	f	f
1731	4	13	9	8	f	f
1732	4	13	10	8	f	f
1733	4	13	11	8	f	f
1734	4	13	13	8	f	f
1735	4	13	14	8	f	f
1736	4	13	12	8	f	f
1737	4	14	1	8	f	f
1738	4	14	7	8	f	f
1739	4	14	8	8	f	f
1740	4	14	9	8	f	f
1741	4	14	10	8	f	f
1742	4	14	11	8	f	f
1743	4	14	13	8	f	f
1744	4	14	14	8	f	f
1745	4	14	12	8	f	f
1746	4	12	1	8	f	f
1747	4	12	7	8	f	f
1748	4	12	8	8	f	f
1749	4	12	9	8	f	f
1750	4	12	10	8	f	f
1751	4	12	11	8	f	f
1752	4	12	13	8	f	f
1753	4	12	14	8	f	f
1754	4	12	12	8	f	f
\.


--
-- Name: custom_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_fields_id_seq', 18, true);


--
-- Name: custom_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_options_id_seq', 10, true);


--
-- Name: custom_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_values_id_seq', 2632, true);


--
-- Name: enterprise_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enterprise_tokens_id_seq', 1, true);


--
-- Name: grid_widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grid_widgets_id_seq', 65, true);


--
-- Name: grids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grids_id_seq', 22, true);


--
-- Name: project_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_statuses_id_seq', 5, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 5, true);


--
-- Name: queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.queries_id_seq', 51, true);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 210, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 8, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statuses_id_seq', 18, true);


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.types_id_seq', 7, true);


--
-- Name: webhooks_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhooks_events_id_seq', 8, true);


--
-- Name: webhooks_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhooks_webhooks_id_seq', 1, true);


--
-- Name: workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workflows_id_seq', 2734, true);


--
-- Name: custom_fields custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_fields
    ADD CONSTRAINT custom_fields_pkey PRIMARY KEY (id);


--
-- Name: custom_options custom_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_options
    ADD CONSTRAINT custom_options_pkey PRIMARY KEY (id);


--
-- Name: custom_values custom_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_values
    ADD CONSTRAINT custom_values_pkey PRIMARY KEY (id);


--
-- Name: enterprise_tokens enterprise_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enterprise_tokens
    ADD CONSTRAINT enterprise_tokens_pkey PRIMARY KEY (id);


--
-- Name: grid_widgets grid_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grid_widgets
    ADD CONSTRAINT grid_widgets_pkey PRIMARY KEY (id);


--
-- Name: grids grids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grids
    ADD CONSTRAINT grids_pkey PRIMARY KEY (id);


--
-- Name: project_statuses project_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_statuses
    ADD CONSTRAINT project_statuses_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: webhooks_events webhooks_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks_events
    ADD CONSTRAINT webhooks_events_pkey PRIMARY KEY (id);


--
-- Name: webhooks_webhooks webhooks_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks_webhooks
    ADD CONSTRAINT webhooks_webhooks_pkey PRIMARY KEY (id);


--
-- Name: workflows workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (id);


--
-- Name: custom_fields_types_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX custom_fields_types_unique ON public.custom_fields_types USING btree (custom_field_id, type_id);


--
-- Name: custom_values_customized; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_values_customized ON public.custom_values USING btree (customized_type, customized_id);


--
-- Name: index_custom_fields_on_id_and_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_custom_fields_on_id_and_type ON public.custom_fields USING btree (id, type);


--
-- Name: index_custom_fields_projects_on_custom_field_id_and_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_custom_fields_projects_on_custom_field_id_and_project_id ON public.custom_fields_projects USING btree (custom_field_id, project_id);


--
-- Name: index_custom_values_on_custom_field_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_custom_values_on_custom_field_id ON public.custom_values USING btree (custom_field_id);


--
-- Name: index_grid_widgets_on_grid_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grid_widgets_on_grid_id ON public.grid_widgets USING btree (grid_id);


--
-- Name: index_grids_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grids_on_project_id ON public.grids USING btree (project_id);


--
-- Name: index_grids_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grids_on_user_id ON public.grids USING btree (user_id);


--
-- Name: index_project_statuses_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_project_statuses_on_project_id ON public.project_statuses USING btree (project_id);


--
-- Name: index_projects_on_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_projects_on_identifier ON public.projects USING btree (identifier);


--
-- Name: index_projects_on_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_projects_on_lft ON public.projects USING btree (lft);


--
-- Name: index_projects_on_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_projects_on_rgt ON public.projects USING btree (rgt);


--
-- Name: index_queries_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_queries_on_project_id ON public.queries USING btree (project_id);


--
-- Name: index_queries_on_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_queries_on_updated_at ON public.queries USING btree (updated_at);


--
-- Name: index_queries_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_queries_on_user_id ON public.queries USING btree (user_id);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_statuses_on_color_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_statuses_on_color_id ON public.statuses USING btree (color_id);


--
-- Name: index_statuses_on_is_closed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_statuses_on_is_closed ON public.statuses USING btree (is_closed);


--
-- Name: index_statuses_on_is_default; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_statuses_on_is_default ON public.statuses USING btree (is_default);


--
-- Name: index_statuses_on_position; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_statuses_on_position ON public.statuses USING btree ("position");


--
-- Name: index_types_on_color_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_types_on_color_id ON public.types USING btree (color_id);


--
-- Name: index_webhooks_events_on_webhooks_webhook_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_webhooks_events_on_webhooks_webhook_id ON public.webhooks_events USING btree (webhooks_webhook_id);


--
-- Name: index_workflows_on_new_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_workflows_on_new_status_id ON public.workflows USING btree (new_status_id);


--
-- Name: index_workflows_on_old_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_workflows_on_old_status_id ON public.workflows USING btree (old_status_id);


--
-- Name: index_workflows_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_workflows_on_role_id ON public.workflows USING btree (role_id);


--
-- Name: projects_types_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_types_project_id ON public.projects_types USING btree (project_id);


--
-- Name: projects_types_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX projects_types_unique ON public.projects_types USING btree (project_id, type_id);


--
-- Name: wkfs_role_type_old_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wkfs_role_type_old_status ON public.workflows USING btree (role_id, type_id, old_status_id);


--
-- Name: project_statuses fk_rails_3cf2a2e96d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_statuses
    ADD CONSTRAINT fk_rails_3cf2a2e96d FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: webhooks_events fk_rails_a166925c91; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhooks_events
    ADD CONSTRAINT fk_rails_a166925c91 FOREIGN KEY (webhooks_webhook_id) REFERENCES public.webhooks_webhooks(id);


--
-- PostgreSQL database dump complete
--

