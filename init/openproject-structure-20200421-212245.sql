-- PostgreSQL SQL dump to import OpenProject structural tables, e.g. workflows and custom fields
DROP TABLE custom_fields CASCADE;
DROP TABLE custom_fields_projects CASCADE;
DROP TABLE custom_fields_types CASCADE;
DROP TABLE custom_options CASCADE;
DROP TABLE enabled_modules CASCADE;
DROP TABLE enterprise_tokens CASCADE;
DROP TABLE grid_widgets CASCADE;
DROP TABLE grids CASCADE;
DROP TABLE menu_items CASCADE;
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
DROP TABLE wikis CASCADE;
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
-- Name: enabled_modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enabled_modules (
    id integer NOT NULL,
    project_id integer,
    name character varying NOT NULL
);


ALTER TABLE public.enabled_modules OWNER TO postgres;

--
-- Name: enabled_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enabled_modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enabled_modules_id_seq OWNER TO postgres;

--
-- Name: enabled_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enabled_modules_id_seq OWNED BY public.enabled_modules.id;


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
-- Name: menu_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_items (
    id integer NOT NULL,
    name character varying,
    title character varying,
    parent_id integer,
    options text,
    navigatable_id integer,
    type character varying
);


ALTER TABLE public.menu_items OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_items_id_seq OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


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
-- Name: wikis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wikis (
    id integer NOT NULL,
    project_id integer NOT NULL,
    start_page character varying NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.wikis OWNER TO postgres;

--
-- Name: wikis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wikis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wikis_id_seq OWNER TO postgres;

--
-- Name: wikis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wikis_id_seq OWNED BY public.wikis.id;


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
-- Name: enabled_modules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enabled_modules ALTER COLUMN id SET DEFAULT nextval('public.enabled_modules_id_seq'::regclass);


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
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


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
-- Name: wikis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wikis ALTER COLUMN id SET DEFAULT nextval('public.wikis_id_seq'::regclass);


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
-- Data for Name: enabled_modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enabled_modules (id, project_id, name) FROM stdin;
10	3	calendar
11	3	board_view
12	3	work_package_tracking
13	3	news
14	3	time_tracking
15	3	wiki
16	3	costs_module
17	3	reporting_module
18	3	meetings
19	3	backlogs
30	5	calendar
31	5	board_view
32	5	work_package_tracking
33	5	news
34	5	time_tracking
35	5	wiki
36	5	costs_module
37	5	reporting_module
38	5	meetings
39	5	backlogs
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
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_items (id, name, title, parent_id, options, navigatable_id, type) FROM stdin;
2	f7f3ad8d-5bb9-4709-aa54-5429e415b764	Bugs	\N	\N	1	MenuItems::QueryMenuItem
3	96ca1901-ddc9-40cb-916b-87768551a925	Project plan	\N	\N	2	MenuItems::QueryMenuItem
4	63255f14-008f-4964-b26d-a17aabc12638	Milestones	\N	\N	3	MenuItems::QueryMenuItem
5	a6022a37-7a6f-45a3-a372-12b7ecad02a6	Tasks	\N	\N	4	MenuItems::QueryMenuItem
7	b057398b-b004-4d87-bcaa-3e70a434029b	Project plan	\N	\N	13	MenuItems::QueryMenuItem
8	fadc739b-63bd-44f8-94c3-1d35762d542e	Product backlog	\N	\N	14	MenuItems::QueryMenuItem
9	ff688e25-a2bf-48e3-825b-b34582542e7b	Sprint 1	\N	\N	15	MenuItems::QueryMenuItem
10	23ab7a6d-020e-4e56-9877-33c650306c5c	Tasks	\N	\N	16	MenuItems::QueryMenuItem
11	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	3	MenuItems::WikiMenuItem
15	wiki	Wiki	\N	---\n:new_wiki_page: true\n:index_page: true\n	5	MenuItems::WikiMenuItem
16	40992e3a-d10c-4b5d-948b-ed922c362aca	Inbound Orders	\N	\N	43	MenuItems::QueryMenuItem
17	9f7f5f9c-9eb0-467e-997d-d90d39839c12	Vancouver Island Orders	\N	\N	49	MenuItems::QueryMenuItem
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
-- Data for Name: wikis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wikis (id, project_id, start_page, status, created_at, updated_at) FROM stdin;
3	3	Wiki	1	2020-04-01 11:36:09.89397	2020-04-01 11:36:09.89397
5	5	Wiki	1	2020-04-09 00:22:35.418444	2020-04-09 00:22:35.418444
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
-- Name: enabled_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enabled_modules_id_seq', 39, true);


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
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 17, true);


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
-- Name: wikis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wikis_id_seq', 5, true);


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
-- Name: enabled_modules enabled_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enabled_modules
    ADD CONSTRAINT enabled_modules_pkey PRIMARY KEY (id);


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
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


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
-- Name: wikis wikis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wikis
    ADD CONSTRAINT wikis_pkey PRIMARY KEY (id);


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
-- Name: enabled_modules_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enabled_modules_project_id ON public.enabled_modules USING btree (project_id);


--
-- Name: index_custom_fields_on_id_and_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_custom_fields_on_id_and_type ON public.custom_fields USING btree (id, type);


--
-- Name: index_custom_fields_projects_on_custom_field_id_and_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_custom_fields_projects_on_custom_field_id_and_project_id ON public.custom_fields_projects USING btree (custom_field_id, project_id);


--
-- Name: index_enabled_modules_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_enabled_modules_on_name ON public.enabled_modules USING btree (name);


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
-- Name: index_menu_items_on_navigatable_id_and_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_menu_items_on_navigatable_id_and_title ON public.menu_items USING btree (navigatable_id, title);


--
-- Name: index_menu_items_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_menu_items_on_parent_id ON public.menu_items USING btree (parent_id);


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
-- Name: wikis_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wikis_project_id ON public.wikis USING btree (project_id);


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

