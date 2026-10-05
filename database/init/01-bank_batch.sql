--
-- PostgreSQL database dump
--

\restrict fQ6SVcISLhhMPgdzBwN0VpTGb3fBTKIlU9ylljSn8cHLxW7zBJIYSTZLeybThfx

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11 (Debian 17.11-1.pgdg13+2)

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
-- Name: batch_job_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE public.batch_job_execution OWNER TO postgres;

--
-- Name: batch_job_execution_context; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE public.batch_job_execution_context OWNER TO postgres;

--
-- Name: batch_job_execution_params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    parameter_name character varying(100) NOT NULL,
    parameter_type character varying(100) NOT NULL,
    parameter_value character varying(2500),
    identifying character(1) NOT NULL
);


ALTER TABLE public.batch_job_execution_params OWNER TO postgres;

--
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_job_execution_seq OWNER TO postgres;

--
-- Name: batch_job_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE public.batch_job_instance OWNER TO postgres;

--
-- Name: batch_job_instance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batch_job_instance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_job_instance_seq OWNER TO postgres;

--
-- Name: batch_step_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE public.batch_step_execution OWNER TO postgres;

--
-- Name: batch_step_execution_context; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE public.batch_step_execution_context OWNER TO postgres;

--
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_step_execution_seq OWNER TO postgres;

--
-- Name: estados_cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_cuenta (
    id bigint NOT NULL,
    cuenta_id integer,
    fecha date,
    transaccion character varying(50),
    monto numeric(15,2),
    descripcion character varying(255)
);


ALTER TABLE public.estados_cuenta OWNER TO postgres;

--
-- Name: estados_cuenta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_cuenta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_cuenta_id_seq OWNER TO postgres;

--
-- Name: estados_cuenta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_cuenta_id_seq OWNED BY public.estados_cuenta.id;


--
-- Name: eventos_transaccion_procesados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventos_transaccion_procesados (
    id bigint NOT NULL,
    event_id character varying(100) NOT NULL,
    transaccion_id integer NOT NULL,
    fecha date,
    monto numeric(15,2),
    tipo character varying(30),
    es_anomalia boolean,
    motivo_anomalia character varying(255),
    fecha_recepcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.eventos_transaccion_procesados OWNER TO postgres;

--
-- Name: eventos_transaccion_procesados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventos_transaccion_procesados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eventos_transaccion_procesados_id_seq OWNER TO postgres;

--
-- Name: eventos_transaccion_procesados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventos_transaccion_procesados_id_seq OWNED BY public.eventos_transaccion_procesados.id;


--
-- Name: intereses_procesados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intereses_procesados (
    id bigint NOT NULL,
    cuenta_id integer,
    nombre character varying(150),
    saldo_inicial numeric(15,2),
    edad integer,
    tipo character varying(30),
    tasa_interes numeric(8,5),
    interes_calculado numeric(15,2),
    saldo_final numeric(15,2)
);


ALTER TABLE public.intereses_procesados OWNER TO postgres;

--
-- Name: intereses_procesados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.intereses_procesados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.intereses_procesados_id_seq OWNER TO postgres;

--
-- Name: intereses_procesados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.intereses_procesados_id_seq OWNED BY public.intereses_procesados.id;


--
-- Name: resumen_transacciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumen_transacciones (
    id bigint NOT NULL,
    fecha date NOT NULL,
    total_transacciones integer NOT NULL,
    total_creditos numeric(15,2) NOT NULL,
    total_debitos numeric(15,2) NOT NULL,
    cantidad_anomalias integer NOT NULL
);


ALTER TABLE public.resumen_transacciones OWNER TO postgres;

--
-- Name: resumen_transacciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resumen_transacciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resumen_transacciones_id_seq OWNER TO postgres;

--
-- Name: resumen_transacciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resumen_transacciones_id_seq OWNED BY public.resumen_transacciones.id;


--
-- Name: transacciones_procesadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacciones_procesadas (
    id bigint NOT NULL,
    transaccion_id integer,
    fecha date,
    monto numeric(15,2),
    tipo character varying(30),
    es_anomalia boolean NOT NULL,
    motivo_anomalia character varying(255)
);


ALTER TABLE public.transacciones_procesadas OWNER TO postgres;

--
-- Name: transacciones_procesadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transacciones_procesadas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transacciones_procesadas_id_seq OWNER TO postgres;

--
-- Name: transacciones_procesadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transacciones_procesadas_id_seq OWNED BY public.transacciones_procesadas.id;


--
-- Name: estados_cuenta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cuenta ALTER COLUMN id SET DEFAULT nextval('public.estados_cuenta_id_seq'::regclass);


--
-- Name: eventos_transaccion_procesados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos_transaccion_procesados ALTER COLUMN id SET DEFAULT nextval('public.eventos_transaccion_procesados_id_seq'::regclass);


--
-- Name: intereses_procesados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intereses_procesados ALTER COLUMN id SET DEFAULT nextval('public.intereses_procesados_id_seq'::regclass);


--
-- Name: resumen_transacciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumen_transacciones ALTER COLUMN id SET DEFAULT nextval('public.resumen_transacciones_id_seq'::regclass);


--
-- Name: transacciones_procesadas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_procesadas ALTER COLUMN id SET DEFAULT nextval('public.transacciones_procesadas_id_seq'::regclass);


--
-- Data for Name: batch_job_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_job_execution (job_execution_id, version, job_instance_id, create_time, start_time, end_time, status, exit_code, exit_message, last_updated) FROM stdin;
11	3	6	2026-08-30 05:53:10.750838	2026-08-30 05:53:10.771825	2026-08-30 05:53:10.836281	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 05:53:10.839605
1	3	1	2026-08-30 03:30:59.394061	2026-08-30 03:30:59.415742	2026-08-30 03:30:59.50059	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 03:30:59.502589
5	3	2	2026-08-30 04:24:16.245618	2026-08-30 04:24:16.263743	2026-08-30 04:24:16.359317	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:24:16.363324
2	3	2	2026-08-30 04:02:16.989355	2026-08-30 04:02:17.015311	2026-08-30 04:02:17.108175	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:02:17.111467
7	3	2	2026-08-30 04:36:49.369813	2026-08-30 04:36:49.395285	2026-08-30 04:36:49.909054	COMPLETED	COMPLETED		2026-08-30 04:36:49.911236
3	3	2	2026-08-30 04:04:28.684662	2026-08-30 04:04:28.700153	2026-08-30 04:04:28.790995	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:04:28.791993
6	3	2	2026-08-30 04:29:36.229109	2026-08-30 04:29:36.239384	2026-08-30 04:29:36.333742	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:29:36.33514
4	3	2	2026-08-30 04:17:02.231459	2026-08-30 04:17:02.243796	2026-08-30 04:17:02.325171	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:17:02.32748
10	3	5	2026-08-30 05:37:08.694147	2026-08-30 05:37:08.723802	2026-08-30 05:37:09.412546	COMPLETED	COMPLETED		2026-08-30 05:37:09.413546
8	3	3	2026-08-30 04:40:40.617362	2026-08-30 04:40:40.640484	2026-08-30 04:40:41.054428	COMPLETED	COMPLETED		2026-08-30 04:40:41.054428
9	3	4	2026-08-30 05:33:18.715756	2026-08-30 05:33:18.742707	2026-08-30 05:33:18.810855	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 05:33:18.813683
47	3	1	2026-09-13 03:11:29.181612	2026-09-13 03:11:29.221583	2026-09-13 03:11:29.828612	COMPLETED	COMPLETED		2026-09-13 03:11:29.830117
12	3	7	2026-08-30 06:04:53.657831	2026-08-30 06:04:53.6855	2026-08-30 06:04:54.15935	COMPLETED	COMPLETED		2026-08-30 06:04:54.161351
27	3	22	2026-08-30 10:33:12.417253	2026-08-30 10:33:12.437801	2026-08-30 10:33:12.845179	COMPLETED	COMPLETED		2026-08-30 10:33:12.846181
13	3	8	2026-08-30 08:27:32.590574	2026-08-30 08:27:32.632651	2026-08-30 08:27:32.772078	FAILED	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 08:27:32.775133
39	3	6	2026-08-30 12:49:21.717556	2026-08-30 12:49:21.739096	2026-08-30 12:49:22.166211	COMPLETED	COMPLETED		2026-08-30 12:49:22.167211
14	3	9	2026-08-30 08:33:18.424948	2026-08-30 08:33:18.453502	2026-08-30 08:33:18.950889	COMPLETED	COMPLETED		2026-08-30 08:33:18.95255
15	1	10	2026-08-30 08:41:08.343391	2026-08-30 08:41:08.367851	\N	STARTED	UNKNOWN		2026-08-30 08:41:08.368851
16	1	11	2026-08-30 08:43:09.902499	2026-08-30 08:43:09.928531	\N	STARTED	UNKNOWN		2026-08-30 08:43:09.928531
28	3	23	2026-08-30 10:37:00.05248	2026-08-30 10:37:00.104689	2026-08-30 10:37:00.633136	COMPLETED	COMPLETED		2026-08-30 10:37:00.635135
17	3	12	2026-08-30 08:45:25.061513	2026-08-30 08:45:25.081452	2026-08-30 08:45:25.548155	COMPLETED	COMPLETED		2026-08-30 08:45:25.549661
18	3	13	2026-08-30 08:49:08.337164	2026-08-30 08:49:08.359142	2026-08-30 08:49:08.889741	COMPLETED	COMPLETED		2026-08-30 08:49:08.893419
29	3	24	2026-08-30 10:45:54.883185	2026-08-30 10:45:54.901815	2026-08-30 10:45:55.402944	COMPLETED	COMPLETED		2026-08-30 10:45:55.405233
19	3	14	2026-08-30 09:05:28.572448	2026-08-30 09:05:28.607662	2026-08-30 09:05:29.105287	COMPLETED	COMPLETED		2026-08-30 09:05:29.107287
40	3	33	2026-08-30 12:52:49.872455	2026-08-30 12:52:49.891827	2026-08-30 12:52:50.686808	COMPLETED	COMPLETED		2026-08-30 12:52:50.687806
20	3	15	2026-08-30 09:44:47.328038	2026-08-30 09:44:47.350513	2026-08-30 09:44:47.785288	COMPLETED	COMPLETED		2026-08-30 09:44:47.787272
30	3	25	2026-08-30 10:50:18.276725	2026-08-30 10:50:18.311355	2026-08-30 10:50:18.763513	COMPLETED	COMPLETED		2026-08-30 10:50:18.764496
21	3	16	2026-08-30 09:54:27.231449	2026-08-30 09:54:27.255128	2026-08-30 09:54:27.751208	COMPLETED	COMPLETED		2026-08-30 09:54:27.753213
48	3	40	2026-09-13 03:14:39.596139	2026-09-13 03:14:39.624909	2026-09-13 03:14:40.42368	COMPLETED	COMPLETED		2026-09-13 03:14:40.425681
22	3	17	2026-08-30 10:01:05.685195	2026-08-30 10:01:05.710212	2026-08-30 10:01:06.230865	COMPLETED	COMPLETED		2026-08-30 10:01:06.232871
31	3	26	2026-08-30 10:53:04.869015	2026-08-30 10:53:04.904162	2026-08-30 10:53:06.103872	COMPLETED	COMPLETED		2026-08-30 10:53:06.104868
23	3	18	2026-08-30 10:13:28.428661	2026-08-30 10:13:28.452088	2026-08-30 10:13:28.889604	COMPLETED	COMPLETED		2026-08-30 10:13:28.890602
41	3	34	2026-08-30 12:57:05.171839	2026-08-30 12:57:05.205022	2026-08-30 12:57:05.915874	COMPLETED	COMPLETED		2026-08-30 12:57:05.916858
24	3	19	2026-08-30 10:16:35.048389	2026-08-30 10:16:35.071023	2026-08-30 10:16:35.629733	COMPLETED	COMPLETED		2026-08-30 10:16:35.630731
32	3	27	2026-08-30 10:58:04.855175	2026-08-30 10:58:04.883605	2026-08-30 10:58:06.201174	COMPLETED	COMPLETED		2026-08-30 10:58:06.204422
25	3	20	2026-08-30 10:18:59.380241	2026-08-30 10:18:59.403412	2026-08-30 10:18:59.894229	COMPLETED	COMPLETED		2026-08-30 10:18:59.896234
26	3	21	2026-08-30 10:20:43.190428	2026-08-30 10:20:43.212828	2026-08-30 10:20:43.734591	COMPLETED	COMPLETED		2026-08-30 10:20:43.736591
33	3	28	2026-08-30 11:14:06.129234	2026-08-30 11:14:06.160261	2026-08-30 11:14:07.649854	COMPLETED	COMPLETED		2026-08-30 11:14:07.650862
42	3	35	2026-08-30 12:58:22.470166	2026-08-30 12:58:22.491945	2026-08-30 12:58:23.126481	COMPLETED	COMPLETED		2026-08-30 12:58:23.128991
34	3	29	2026-08-30 11:14:49.575475	2026-08-30 11:14:49.60186	2026-08-30 11:14:50.386757	COMPLETED	COMPLETED		2026-08-30 11:14:50.388758
49	3	41	2026-09-13 03:17:05.884226	2026-09-13 03:17:05.921192	2026-09-13 03:17:07.235767	COMPLETED	COMPLETED		2026-09-13 03:17:07.236766
35	3	30	2026-08-30 11:31:03.600567	2026-08-30 11:31:03.623533	2026-08-30 11:31:04.636436	COMPLETED	COMPLETED		2026-08-30 11:31:04.637435
43	3	36	2026-08-30 12:59:05.571695	2026-08-30 12:59:05.596086	2026-08-30 12:59:06.298238	COMPLETED	COMPLETED		2026-08-30 12:59:06.299592
36	3	31	2026-08-30 11:36:38.520313	2026-08-30 11:36:38.547237	2026-08-30 11:36:39.400368	COMPLETED	COMPLETED		2026-08-30 11:36:39.401373
37	3	32	2026-08-30 11:37:59.760959	2026-08-30 11:37:59.783987	2026-08-30 11:38:00.759654	COMPLETED	COMPLETED		2026-08-30 11:38:00.761657
44	3	37	2026-08-30 13:03:40.450332	2026-08-30 13:03:40.474652	2026-08-30 13:03:41.207069	COMPLETED	COMPLETED		2026-08-30 13:03:41.209141
38	3	4	2026-08-30 11:49:07.703316	2026-08-30 11:49:07.722661	2026-08-30 11:49:08.168234	COMPLETED	COMPLETED		2026-08-30 11:49:08.169241
45	3	38	2026-08-30 14:12:36.456075	2026-08-30 14:12:36.48812	2026-08-30 14:12:37.322204	COMPLETED	COMPLETED		2026-08-30 14:12:37.324723
46	3	39	2026-08-30 14:13:53.596327	2026-08-30 14:13:53.625965	2026-08-30 14:13:54.632112	COMPLETED	COMPLETED		2026-08-30 14:13:54.634667
\.


--
-- Data for Name: batch_job_execution_context; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_job_execution_context (job_execution_id, short_context, serialized_context) FROM stdin;
1	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
2	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
3	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
4	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
5	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
6	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
7	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
8	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
9	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
10	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
11	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
12	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
13	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
14	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
15	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAB3CAAAABAAAAAAeA==	\N
16	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAB3CAAAABAAAAAAeA==	\N
17	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
18	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
19	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
20	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
21	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
22	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
23	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
24	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
25	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
26	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
27	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
28	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
29	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
30	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
31	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
32	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
33	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
34	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
35	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
36	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
37	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
38	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
39	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
40	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
41	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
42	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
43	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
44	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
45	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
46	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
47	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
48	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
49	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAANYmF0Y2gudmVyc2lvbnQABTYuMC41eA==	\N
\.


--
-- Data for Name: batch_job_execution_params; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_job_execution_params (job_execution_id, parameter_name, parameter_type, parameter_value, identifying) FROM stdin;
8	run.id	java.lang.String	2	Y
9	run.id	java.lang.String	1	Y
10	run.id	java.lang.String	2	Y
11	run.id	java.lang.String	3	Y
12	run.id	java.lang.String	4	Y
13	run.id	java.lang.String	5	Y
14	run.id	java.lang.String	6	Y
15	run.id	java.lang.String	7	Y
16	run.id	java.lang.String	8	Y
17	run.id	java.lang.String	9	Y
18	run.id	java.lang.String	10	Y
19	run.id	java.lang.String	11	Y
20	run.id	java.lang.String	12	Y
21	run.id	java.lang.String	13	Y
22	run.id	java.lang.String	14	Y
23	run.id	java.lang.String	15	Y
24	run.id	java.lang.String	16	Y
25	run.id	java.lang.String	17	Y
26	run.id	java.lang.String	1´8	Y
27	run.id	java.lang.String	1	Y
28	run.id	java.lang.String	3	Y
29	run.id	java.lang.String	4	Y
30	run.id	java.lang.String	5	Y
31	run.id	java.lang.String	7	Y
32	run.id	java.lang.String	8	Y
33	run.id	java.lang.String	9	Y
34	run.id	java.lang.String	10	Y
35	run.id	java.lang.String	11	Y
36	run.id	java.lang.String	12	Y
37	run.id	java.lang.String	13	Y
38	run.id	java.lang.String	1	Y
39	run.id	java.lang.String	3	Y
40	run.id	java.lang.String	5	Y
41	run.id	java.lang.String	6	Y
42	run.id	java.lang.String	7	Y
43	run.id	java.lang.String	8	Y
44	run.id	java.lang.String	9	Y
45	run.id	java.lang.String	10	Y
46	run.id	java.lang.String	11	Y
48	ejecucion	java.lang.String	2	Y
49	ejecucion	java.lang.String	1	Y
\.


--
-- Data for Name: batch_job_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_job_instance (job_instance_id, version, job_name, job_key) FROM stdin;
1	0	procesarTransaccionesJob	d41d8cd98f00b204e9800998ecf8427e
2	0	procesarInteresesJob	d41d8cd98f00b204e9800998ecf8427e
3	0	procesarInteresesJob	ef84d315f17481c069e4b83dd6acd03e
4	0	procesarCuentasAnualesJob	9fd482851dc52b238e7f6920e2cb41dd
5	0	procesarCuentasAnualesJob	ef84d315f17481c069e4b83dd6acd03e
6	0	procesarCuentasAnualesJob	c5d136cf4884021bb29da21d90aac129
7	0	procesarCuentasAnualesJob	7efb57856d2259ff78e5413ae1451e7b
8	0	procesarTransaccionesJob	c10e42adfd526bbefc46ab4c787163e8
9	0	procesarInteresesJob	887ed76009758f5546472ee9d76ca4fc
10	0	procesarTransaccionesJob	11e447f40390dbd5850f84880371c394
11	0	procesarTransaccionesJob	62f47b989b414b9f8a94d41ceff537e9
12	0	procesarTransaccionesJob	cc86ea39b0b657fa3716ef9d2c292645
13	0	procesarTransaccionesJob	682b34e9a9e9f94e98c9e0c27188d833
14	0	procesarTransaccionesJob	9a61bdf8f1ba36c96612a04fdd12eafb
15	0	procesarTransaccionesJob	1111c2953b37ab0de8ecc136fb228275
16	0	procesarTransaccionesJob	e5b6e1eb33947ff86725239332a91422
17	0	procesarTransaccionesJob	676083a4aa134fee810d812d190a5836
18	0	procesarTransaccionesJob	1219de9b8b6ee69e93ebe12f3d1c1a70
19	0	procesarTransaccionesJob	1443a856f3c8987414633fc91423a638
20	0	procesarTransaccionesJob	b2812ed94a0b02905dae3d9eceb13bdc
21	0	procesarTransaccionesJob	af3a8547a50fcb039da3c65c88f17959
22	0	procesarInteresesJob	9fd482851dc52b238e7f6920e2cb41dd
23	0	procesarInteresesJob	c5d136cf4884021bb29da21d90aac129
24	0	procesarInteresesJob	7efb57856d2259ff78e5413ae1451e7b
25	0	procesarInteresesJob	c10e42adfd526bbefc46ab4c787163e8
26	0	procesarInteresesJob	11e447f40390dbd5850f84880371c394
27	0	procesarInteresesJob	62f47b989b414b9f8a94d41ceff537e9
28	0	procesarInteresesJob	cc86ea39b0b657fa3716ef9d2c292645
29	0	procesarInteresesJob	682b34e9a9e9f94e98c9e0c27188d833
30	0	procesarInteresesJob	9a61bdf8f1ba36c96612a04fdd12eafb
31	0	procesarInteresesJob	1111c2953b37ab0de8ecc136fb228275
32	0	procesarInteresesJob	e5b6e1eb33947ff86725239332a91422
33	0	procesarCuentasAnualesJob	c10e42adfd526bbefc46ab4c787163e8
34	0	procesarCuentasAnualesJob	887ed76009758f5546472ee9d76ca4fc
35	0	procesarCuentasAnualesJob	11e447f40390dbd5850f84880371c394
36	0	procesarCuentasAnualesJob	62f47b989b414b9f8a94d41ceff537e9
37	0	procesarCuentasAnualesJob	cc86ea39b0b657fa3716ef9d2c292645
38	0	procesarCuentasAnualesJob	682b34e9a9e9f94e98c9e0c27188d833
39	0	procesarCuentasAnualesJob	9a61bdf8f1ba36c96612a04fdd12eafb
40	0	procesarInteresesJob	a5d9398040271391a0f286b6b91b80c2
41	0	procesarCuentasAnualesJob	f0eb3bf6190b9450858812aef01b6ca4
\.


--
-- Data for Name: batch_step_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_step_execution (step_execution_id, version, step_name, job_execution_id, create_time, start_time, end_time, status, commit_count, read_count, filter_count, write_count, read_skip_count, write_skip_count, process_skip_count, rollback_count, exit_code, exit_message, last_updated) FROM stdin;
28	104	procesarInteresesStep	28	2026-08-30 10:37:00.121644	2026-08-30 10:37:00.128574	2026-08-30 10:37:00.622736	COMPLETED	100	1000	647	353	0	0	0	0	COMPLETED		2026-08-30 10:37:00.629131
1	3	procesarTransaccionesStep	1	2026-08-30 03:30:59.430443	2026-08-30 03:30:59.43946	2026-08-30 03:30:59.487725	FAILED	0	10	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 03:30:59.496069
21	104	procesarTransaccionesStep	21	2026-08-30 09:54:27.272502	2026-08-30 09:54:27.289234	2026-08-30 09:54:27.745519	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 09:54:27.748684
2	3	procesarInteresesStep	2	2026-08-30 04:02:17.028096	2026-08-30 04:02:17.033011	2026-08-30 04:02:17.093209	FAILED	0	10	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:02:17.101155
30	104	procesarInteresesStep	30	2026-08-30 10:50:18.324065	2026-08-30 10:50:18.32832	2026-08-30 10:50:18.757371	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:50:18.760495
3	3	procesarInteresesStep	3	2026-08-30 04:04:28.712672	2026-08-30 04:04:28.718948	2026-08-30 04:04:28.782484	FAILED	0	10	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:04:28.786995
23	104	procesarTransaccionesStep	23	2026-08-30 10:13:28.46622	2026-08-30 10:13:28.471221	2026-08-30 10:13:28.885085	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:13:28.887603
24	104	procesarTransaccionesStep	24	2026-08-30 10:16:35.086884	2026-08-30 10:16:35.089885	2026-08-30 10:16:35.624729	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:16:35.626728
22	104	procesarTransaccionesStep	22	2026-08-30 10:01:05.722147	2026-08-30 10:01:05.736736	2026-08-30 10:01:06.21971	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:01:06.227348
37	104	procesarInteresesStep	37	2026-08-30 11:37:59.797019	2026-08-30 11:37:59.803542	2026-08-30 11:38:00.751052	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 11:38:00.755529
31	104	procesarInteresesStep	31	2026-08-30 10:53:04.919201	2026-08-30 10:53:04.925637	2026-08-30 10:53:06.094348	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:53:06.099863
27	104	procesarInteresesStep	27	2026-08-30 10:33:12.451379	2026-08-30 10:33:12.46736	2026-08-30 10:33:12.840183	COMPLETED	100	1000	647	353	0	0	0	0	COMPLETED		2026-08-30 10:33:12.842181
20	104	procesarTransaccionesStep	20	2026-08-30 09:44:47.374138	2026-08-30 09:44:47.380207	2026-08-30 09:44:47.781271	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 09:44:47.783271
26	104	procesarTransaccionesStep	26	2026-08-30 10:20:43.234722	2026-08-30 10:20:43.239724	2026-08-30 10:20:43.726071	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:20:43.731578
25	104	procesarTransaccionesStep	25	2026-08-30 10:18:59.41704	2026-08-30 10:18:59.423422	2026-08-30 10:18:59.888221	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:18:59.890501
29	104	procesarInteresesStep	29	2026-08-30 10:45:54.915072	2026-08-30 10:45:54.923229	2026-08-30 10:45:55.39699	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:45:55.399497
36	104	procesarInteresesStep	36	2026-08-30 11:36:38.563002	2026-08-30 11:36:38.576679	2026-08-30 11:36:39.393855	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 11:36:39.395855
34	104	procesarInteresesStep	34	2026-08-30 11:14:49.614564	2026-08-30 11:14:49.618866	2026-08-30 11:14:50.381689	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 11:14:50.384765
33	104	procesarInteresesStep	33	2026-08-30 11:14:06.180312	2026-08-30 11:14:06.186304	2026-08-30 11:14:07.643726	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 11:14:07.646732
32	104	procesarInteresesStep	32	2026-08-30 10:58:04.899042	2026-08-30 10:58:04.905988	2026-08-30 10:58:06.193319	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 10:58:06.197645
35	104	procesarInteresesStep	35	2026-08-30 11:31:03.637329	2026-08-30 11:31:03.642851	2026-08-30 11:31:04.632187	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 11:31:04.633187
39	104	procesarCuentasAnualesStep	39	2026-08-30 12:49:21.754368	2026-08-30 12:49:21.771591	2026-08-30 12:49:22.159221	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 12:49:22.163139
38	104	procesarCuentasAnualesStep	38	2026-08-30 11:49:07.735237	2026-08-30 11:49:07.738756	2026-08-30 11:49:08.161596	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 11:49:08.166228
40	104	procesarCuentasAnualesStep	40	2026-08-30 12:52:49.906632	2026-08-30 12:52:49.912742	2026-08-30 12:52:50.680454	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 12:52:50.683463
41	104	procesarCuentasAnualesStep	41	2026-08-30 12:57:05.220917	2026-08-30 12:57:05.241933	2026-08-30 12:57:05.910936	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 12:57:05.913347
42	104	procesarCuentasAnualesStep	42	2026-08-30 12:58:22.507886	2026-08-30 12:58:22.512751	2026-08-30 12:58:23.122481	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 12:58:23.12448
4	3	procesarInteresesStep	4	2026-08-30 04:17:02.252945	2026-08-30 04:17:02.255989	2026-08-30 04:17:02.307146	FAILED	0	10	6	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:17:02.318116
13	3	procesarTransaccionesStep	13	2026-08-30 08:27:32.646333	2026-08-30 08:27:32.653838	2026-08-30 08:27:32.745029	FAILED	0	10	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 08:27:32.764066
5	3	procesarInteresesStep	5	2026-08-30 04:24:16.278399	2026-08-30 04:24:16.292452	2026-08-30 04:24:16.345274	FAILED	0	10	6	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:24:16.352112
11	3	procesarCuentasAnualesStep	11	2026-08-30 05:53:10.783616	2026-08-30 05:53:10.791154	2026-08-30 05:53:10.824128	FAILED	0	0	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 05:53:10.832769
6	3	procesarInteresesStep	6	2026-08-30 04:29:36.246903	2026-08-30 04:29:36.250918	2026-08-30 04:29:36.323219	FAILED	0	10	6	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 04:29:36.329738
12	104	procesarCuentasAnualesStep	12	2026-08-30 06:04:53.701126	2026-08-30 06:04:53.709656	2026-08-30 06:04:54.152291	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 06:04:54.154635
15	23	procesarTransaccionesStep	15	2026-08-30 08:41:08.382227	2026-08-30 08:41:08.388719	\N	STARTED	22	220	0	185	0	0	35	0	EXECUTING		2026-08-30 08:42:54.789149
14	104	procesarInteresesStep	14	2026-08-30 08:33:18.472643	2026-08-30 08:33:18.478907	2026-08-30 08:33:18.944992	COMPLETED	100	1000	647	353	0	0	0	0	COMPLETED		2026-08-30 08:33:18.947759
8	104	procesarInteresesStep	8	2026-08-30 04:40:40.654678	2026-08-30 04:40:40.660141	2026-08-30 04:40:41.04828	COMPLETED	100	1000	647	353	0	0	0	0	COMPLETED		2026-08-30 04:40:41.051281
7	104	procesarInteresesStep	7	2026-08-30 04:36:49.408155	2026-08-30 04:36:49.413161	2026-08-30 04:36:49.903371	COMPLETED	100	1000	647	353	0	0	0	0	COMPLETED		2026-08-30 04:36:49.907045
16	13	procesarTransaccionesStep	16	2026-08-30 08:43:09.943935	2026-08-30 08:43:09.950491	\N	STARTED	12	120	0	101	0	0	19	0	EXECUTING		2026-08-30 08:44:07.701205
9	3	procesarCuentasAnualesStep	9	2026-08-30 05:33:18.761789	2026-08-30 05:33:18.769663	2026-08-30 05:33:18.794453	FAILED	0	0	0	0	0	0	0	1	FAILED	org.springframework.batch.core.step.FatalStepExecutionException: Unable to process chunk\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processChunkSequentially(ChunkOrientedStep.java:556)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.processNextChunk(ChunkOrientedStep.java:406)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.lambda$doExecute$0(ChunkOrientedStep.java:377)\r\n\tat org.springframework.transaction.support.TransactionOperations.lambda$executeWithoutResult$0(TransactionOperations.java:68)\r\n\tat org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:137)\r\n\tat org.springframework.transaction.support.TransactionOperations.executeWithoutResult(TransactionOperations.java:67)\r\n\tat org.springframework.batch.core.step.item.ChunkOrientedStep.doExecute(ChunkOrientedStep.java:372)\r\n\tat org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:251)\r\n\tat org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:128)\r\n\tat org.springframework.batch.core.job.AbstractJob.handleStep(AbstractJob.java:397)\r\n\tat org.springframework.batch.core.job.SimpleJob.doExecute(SimpleJob.java:129)\r\n\tat org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:293)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher$1.run(TaskExecutorJobLauncher.java:220)\r\n\tat org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:88)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.launchJobExecution(TaskExecutorJobLauncher.java:211)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobLauncher.run(TaskExecutorJobLauncher.java:109)\r\n\tat org.springframework.batch.core.launch.support.SimpleJobOperator.start(SimpleJobOperator.java:201)\r\n\tat org.springframework.batch.core.launch.support.TaskExecutorJobOperator.start(TaskExecutorJobOperator.java:117)\r\n\tat java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:580)\r\n\tat org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:359)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:190)\r\n\tat org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:158)\r\n\tat org.springframework.transaction	2026-08-30 05:33:18.804639
10	104	procesarCuentasAnualesStep	10	2026-08-30 05:37:08.741129	2026-08-30 05:37:08.748916	2026-08-30 05:37:09.382224	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 05:37:09.405029
17	104	procesarTransaccionesStep	17	2026-08-30 08:45:25.09697	2026-08-30 08:45:25.103898	2026-08-30 08:45:25.540135	COMPLETED	100	1000	0	785	0	0	215	0	COMPLETED		2026-08-30 08:45:25.543156
18	104	procesarTransaccionesStep	18	2026-08-30 08:49:08.384943	2026-08-30 08:49:08.389896	2026-08-30 08:49:08.875678	COMPLETED	100	1000	0	785	0	0	215	0	COMPLETED		2026-08-30 08:49:08.885719
19	104	procesarTransaccionesStep	19	2026-08-30 09:05:28.621801	2026-08-30 09:05:28.626323	2026-08-30 09:05:29.092365	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 09:05:29.09977
43	104	procesarCuentasAnualesStep	43	2026-08-30 12:59:05.610181	2026-08-30 12:59:05.616891	2026-08-30 12:59:06.293238	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 12:59:06.295238
44	104	procesarCuentasAnualesStep	44	2026-08-30 13:03:40.488317	2026-08-30 13:03:40.504317	2026-08-30 13:03:41.201544	COMPLETED	100	1000	142	858	0	0	0	0	COMPLETED		2026-08-30 13:03:41.203545
45	104	procesarCuentasAnualesStep	45	2026-08-30 14:12:36.509386	2026-08-30 14:12:36.517662	2026-08-30 14:12:37.31419	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 14:12:37.318202
48	104	procesarInteresesStep	48	2026-09-13 03:14:39.639226	2026-09-13 03:14:39.645566	2026-09-13 03:14:40.415816	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-09-13 03:14:40.419328
46	104	procesarCuentasAnualesStep	46	2026-08-30 14:13:53.642406	2026-08-30 14:13:53.650025	2026-08-30 14:13:54.622281	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-08-30 14:13:54.627892
47	104	procesarTransaccionesStep	47	2026-09-13 03:11:29.247849	2026-09-13 03:11:29.266791	2026-09-13 03:11:29.813824	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-09-13 03:11:29.826099
49	104	procesarCuentasAnualesStep	49	2026-09-13 03:17:05.938238	2026-09-13 03:17:05.946216	2026-09-13 03:17:07.230258	COMPLETED	100	1000	0	1000	0	0	0	0	COMPLETED		2026-09-13 03:17:07.233257
\.


--
-- Data for Name: batch_step_execution_context; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_step_execution_context (step_execution_id, short_context, serialized_context) FROM stdin;
1	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
9	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
2	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
3	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
19	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
4	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
12	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
5	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
10	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
6	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
7	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
11	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
16	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAB4dAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
8	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
13	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAACdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
14	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
18	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
15	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAADcdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
17	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
20	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
36	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
22	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
26	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
21	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
24	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
23	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
30	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
27	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
31	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
29	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
25	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
28	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
33	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
32	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAaaW50ZXJlc2VzUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADWJhdGNoLnZlcnNpb250AAU2LjAuNXQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
34	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
35	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
37	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
39	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
43	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
38	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
41	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
40	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
47	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAcdHJhbnNhY2Npb25SZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
44	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
48	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAdRmxhdEZpbGVJdGVtUmVhZGVyLnJlYWQuY291bnRzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAD6XQADmJhdGNoLnN0ZXBUeXBldAA6b3JnLnNwcmluZ2ZyYW1ld29yay5iYXRjaC5jb3JlLnN0ZXAuaXRlbS5DaHVua09yaWVudGVkU3RlcHg=	\N
46	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
42	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
45	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
49	rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAADdAAfY3VlbnRhc0FudWFsZXNSZWFkZXIucmVhZC5jb3VudHNyABFqYXZhLmxhbmcuSW50ZWdlchLioKT3gYc4AgABSQAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAPpdAANYmF0Y2gudmVyc2lvbnQABTYuMC41dAAOYmF0Y2guc3RlcFR5cGV0ADpvcmcuc3ByaW5nZnJhbWV3b3JrLmJhdGNoLmNvcmUuc3RlcC5pdGVtLkNodW5rT3JpZW50ZWRTdGVweA==	\N
\.


--
-- Data for Name: estados_cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estados_cuenta (id, cuenta_id, fecha, transaccion, monto, descripcion) FROM stdin;
1	103	2024-03-08	deposito	3000.00	Retiro parcial
2	110	2024-07-24	retiro	1500.00	\N
3	109	2024-03-18	deposito	3000.00	Ingreso mensual
4	105	2024-03-24	deposito	1000.00	Ingreso navideño
5	120	2024-04-11	compra	\N	Ingreso mensual
6	120	2024-02-26	compra	1000.00	\N
7	102	2024-12-18	compra	3000.00	\N
8	105	2024-06-21	compra	3000.00	Ingreso extra
9	111	2024-09-16	compra	2500.00	Ingreso mensual
10	106	2024-02-12	deposito	-100.00	Ingreso navideño
11	106	2024-06-21	deposito	2000.00	Ingreso extra
12	106	2024-07-11	compra	1500.00	Ingreso navideño
13	108	2024-02-15	compra	3000.00	Ingreso mensual
14	110	2024-11-13	compra	-500.00	Ingreso mensual
15	109	2024-12-04	retiro	1000.00	Compra en tienda
16	102	2024-04-19	deposito	2000.00	\N
17	108	2024-07-19	retiro	2000.00	Retiro parcial
18	104	2024-08-26	retiro	2500.00	Compra en tienda
19	120	2024-03-09	retiro	3000.00	Compra en tienda
20	109	2024-05-02	deposito	3000.00	Ingreso mensual
21	116	2024-12-24	compra	2500.00	Compra en tienda
22	114	2024-07-08	compra	5000.00	Ingreso mensual
23	119	2024-08-15	retiro	1500.00	Ingreso extra
24	103	2024-10-05	compra	1000.00	Retiro parcial
25	102	2024-09-30	depósito	2000.00	Ingreso navideño
26	119	2024-07-25	retiro	-500.00	Ingreso mensual
27	103	2024-08-11	pago	1000.00	Compra en tienda
28	103	2024-12-19	compra	5000.00	Retiro parcial
29	111	2024-03-10	retiro	-500.00	Retiro parcial
30	111	2024-04-26	retiro	2000.00	Ingreso navideño
31	108	2024-12-22	deposito	1000.00	Ingreso extra
32	117	2024-01-11	deposito	-1000.00	Ingreso extra
33	113	2024-01-24	compra	5000.00	Compra en tienda
34	109	2024-11-20	retiro	-1000.00	Retiro parcial
35	113	2024-01-25	deposito	-500.00	Ingreso navideño
36	109	2024-10-15	retiro	-500.00	Ingreso extra
37	103	2024-05-09	retiro	3000.00	Ingreso extra
38	114	2024-09-30	deposito	1000.00	Ingreso mensual
39	120	2024-01-13	deposito	1000.00	Retiro parcial
40	113	2024-02-29	retiro	2500.00	Ingreso mensual
41	109	2024-11-27	deposito	2000.00	\N
42	117	2024-05-30	deposito	1000.00	Ingreso navideño
43	118	2024-09-01	retiro	-100.00	Ingreso navideño
44	112	2024-04-01	retiro	3000.00	Retiro parcial
45	105	2024-01-17	compra	-500.00	Ingreso mensual
46	116	2024-11-22	compra	2500.00	Compra en tienda
47	108	2024-05-14	deposito	3000.00	Ingreso extra
48	111	2024-07-19	compra	-100.00	Compra en tienda
49	107	2024-11-30	deposito	3000.00	Compra en tienda
50	111	2024-09-25	depósito	2000.00	Ingreso navideño
51	107	2024-02-29	deposito	-500.00	\N
52	102	2024-11-05	retiro	\N	Ingreso navideño
53	114	2024-04-23	retiro	2000.00	Compra en tienda
54	109	2024-03-09	deposito	3000.00	\N
55	104	2024-11-01	retiro	-500.00	Ingreso navideño
56	104	2024-02-02	retiro	-100.00	Ingreso mensual
57	113	2024-05-02	retiro	-100.00	Retiro parcial
58	113	2024-01-11	deposito	3000.00	Retiro parcial
59	105	2024-12-01	deposito	2000.00	Ingreso mensual
60	109	2024-07-05	retiro	-500.00	Compra en tienda
61	106	2024-04-06	retiro	2500.00	Compra en tienda
62	116	2024-06-25	retiro	2000.00	\N
63	114	2024-09-04	compra	2500.00	Retiro parcial
64	110	2024-02-15	deposito	0.00	Compra en tienda
65	109	2024-11-26	retiro	2000.00	\N
66	118	2024-05-19	retiro	2000.00	\N
67	112	2024-07-23	compra	3000.00	Retiro parcial
68	120	2024-08-18	deposito	1500.00	Compra en tienda
69	104	2024-07-31	deposito	\N	Compra en tienda
70	102	2024-10-16	deposito	2500.00	Retiro parcial
71	117	2024-01-12	retiro	\N	Ingreso extra
72	103	2024-05-07	compra	2000.00	Retiro parcial
73	115	2024-08-15	compra	2000.00	Compra en tienda
74	107	2024-09-28	retiro	-500.00	Ingreso extra
75	116	2024-02-15	deposito	3000.00	Ingreso extra
76	120	2024-10-27	retiro	3000.00	Ingreso extra
77	119	2024-07-19	compra	2000.00	Compra en tienda
78	118	2024-12-09	retiro	3000.00	\N
79	115	2024-10-13	compra	2000.00	Compra en tienda
80	101	2024-02-16	compra	-100.00	Retiro parcial
81	118	2024-04-27	retiro	2000.00	Ingreso mensual
82	110	2024-02-11	compra	-100.00	Ingreso extra
83	118	2024-03-05	retiro	0.00	Ingreso navideño
84	106	2024-08-29	pago	2000.00	\N
85	105	2024-03-03	retiro	2500.00	Retiro parcial
86	107	2024-11-09	retiro	1000.00	Compra en tienda
87	119	2024-06-11	compra	-500.00	\N
88	105	2024-04-01	depósito	1000.00	Retiro parcial
89	116	2024-02-09	deposito	-100.00	\N
90	114	2024-02-20	depósito	3000.00	Compra en tienda
91	113	2024-04-27	retiro	3000.00	\N
92	110	2024-03-02	deposito	2000.00	Compra en tienda
93	101	2024-02-19	compra	2000.00	Retiro parcial
94	102	2024-11-23	deposito	1000.00	\N
95	112	2024-03-08	retiro	2500.00	\N
96	111	2024-03-25	retiro	2500.00	Ingreso extra
97	117	2024-05-18	deposito	\N	Ingreso mensual
98	114	2024-02-14	retiro	3000.00	Ingreso mensual
99	112	2024-10-17	retiro	-500.00	Retiro parcial
100	108	2024-01-05	pago	-500.00	Retiro parcial
101	116	2024-08-02	compra	-500.00	Compra en tienda
102	107	2024-06-22	retiro	3000.00	Ingreso navideño
103	105	2024-06-04	pago	-500.00	Ingreso extra
104	106	2024-07-28	deposito	2000.00	Ingreso mensual
105	119	2024-03-24	compra	1500.00	\N
106	103	2024-09-24	retiro	-500.00	Ingreso extra
107	107	2024-10-26	retiro	3000.00	Ingreso mensual
108	114	2024-02-13	compra	2000.00	Ingreso extra
109	116	2024-08-09	compra	-500.00	Ingreso extra
110	114	2024-04-14	depósito	2000.00	\N
111	118	2024-08-26	compra	5000.00	Compra en tienda
112	101	2024-01-07	deposito	2500.00	Retiro parcial
113	118	2024-08-04	compra	3000.00	\N
114	106	2024-08-27	deposito	2500.00	\N
115	120	2024-05-24	retiro	-500.00	Compra en tienda
116	104	2024-11-07	compra	1000.00	Ingreso navideño
117	115	2024-06-17	compra	1000.00	Ingreso navideño
118	110	2024-02-17	compra	2500.00	Ingreso extra
119	107	2024-01-28	retiro	1500.00	\N
120	102	2024-11-24	retiro	-100.00	Retiro parcial
121	106	2024-10-23	compra	-500.00	Ingreso navideño
122	106	2024-08-31	compra	2500.00	\N
123	114	2024-10-01	compra	2000.00	Ingreso extra
124	119	2024-05-21	retiro	1500.00	\N
125	109	2024-05-21	retiro	3000.00	Ingreso extra
126	103	2024-07-12	deposito	\N	\N
127	120	2024-12-17	retiro	1500.00	\N
128	120	2024-12-28	retiro	-500.00	Ingreso navideño
129	106	2024-11-20	pago	-100.00	Ingreso extra
130	101	2024-07-16	retiro	2500.00	Ingreso navideño
131	109	2024-11-12	compra	-100.00	Ingreso navideño
132	103	2024-03-15	compra	5000.00	\N
133	118	2024-12-08	retiro	1000.00	Ingreso mensual
134	107	2024-12-30	retiro	-500.00	\N
135	107	2024-07-17	retiro	2000.00	Ingreso mensual
136	114	2024-10-16	retiro	\N	Ingreso mensual
137	118	2024-03-05	compra	2000.00	Ingreso navideño
138	116	2024-11-23	compra	2000.00	Ingreso navideño
139	103	2024-03-19	compra	3000.00	Ingreso extra
140	110	2024-06-22	pago	2000.00	\N
141	105	2024-10-26	compra	-1000.00	Ingreso extra
142	114	2024-04-16	deposito	2000.00	Compra en tienda
143	103	2024-10-29	compra	2500.00	\N
144	111	2024-03-03	compra	2000.00	Compra en tienda
145	104	2024-09-06	retiro	-500.00	\N
146	118	2024-08-13	deposito	-500.00	\N
147	110	2024-11-27	retiro	2000.00	Retiro parcial
148	114	2024-05-07	retiro	3000.00	Ingreso navideño
149	113	2024-09-30	deposito	-500.00	Ingreso extra
150	106	2024-11-26	pago	1500.00	Retiro parcial
151	116	2024-04-19	pago	1500.00	Ingreso navideño
152	117	2024-06-25	deposito	2500.00	\N
153	106	2024-04-03	retiro	2000.00	\N
154	105	2024-09-21	retiro	3000.00	Ingreso navideño
155	120	2024-09-16	deposito	1500.00	Ingreso mensual
156	103	2024-01-27	retiro	2000.00	Ingreso mensual
157	114	2024-07-04	compra	-100.00	\N
158	106	2024-04-26	compra	1000.00	Ingreso extra
159	109	2024-11-10	retiro	2500.00	\N
160	119	2024-05-21	compra	1000.00	Ingreso extra
161	110	2024-08-19	retiro	2500.00	Retiro parcial
162	106	2024-10-02	retiro	1500.00	Compra en tienda
163	116	2024-06-17	depósito	1500.00	Ingreso navideño
164	109	2024-05-20	compra	-500.00	Compra en tienda
165	107	2024-09-26	compra	-100.00	\N
166	110	2024-02-14	deposito	2500.00	Ingreso navideño
167	105	2024-09-09	compra	-500.00	Compra en tienda
168	104	2024-11-09	compra	3000.00	Ingreso mensual
169	114	2024-05-22	compra	2000.00	Ingreso navideño
170	116	2024-11-14	deposito	2500.00	Ingreso navideño
171	102	2024-02-08	deposito	3000.00	Compra en tienda
172	105	2024-05-10	retiro	2500.00	Ingreso navideño
173	107	2024-11-16	deposito	1500.00	Ingreso extra
174	114	2024-10-30	retiro	0.00	Compra en tienda
175	102	2024-08-12	deposito	2500.00	Retiro parcial
176	115	2024-10-25	deposito	0.00	Ingreso mensual
177	107	2024-11-26	depósito	-500.00	Compra en tienda
178	109	2024-12-05	retiro	2500.00	Ingreso mensual
179	119	2024-02-18	pago	1000.00	Ingreso extra
180	103	2024-10-29	compra	2500.00	Ingreso navideño
181	103	2024-07-05	retiro	3000.00	Ingreso mensual
182	112	2024-12-16	compra	-100.00	Ingreso mensual
183	117	2024-02-01	retiro	-100.00	\N
184	107	2024-12-06	depósito	2500.00	Retiro parcial
185	108	2024-07-17	retiro	2500.00	Retiro parcial
186	116	2024-09-15	compra	3000.00	Retiro parcial
187	115	2024-04-22	compra	1500.00	Ingreso extra
188	102	2024-09-24	retiro	1500.00	Compra en tienda
189	114	2024-10-20	compra	-100.00	Ingreso navideño
190	113	2024-04-05	deposito	1000.00	Ingreso navideño
191	117	2024-11-17	depósito	3000.00	Ingreso mensual
192	110	2024-09-11	deposito	1000.00	Retiro parcial
193	104	2024-03-01	retiro	-500.00	Ingreso extra
194	102	2024-12-28	retiro	-500.00	Compra en tienda
195	119	2024-10-28	retiro	2000.00	Ingreso extra
196	104	2024-07-19	retiro	1000.00	Compra en tienda
197	110	2024-02-23	deposito	1000.00	Retiro parcial
198	114	2024-02-07	retiro	3000.00	Ingreso extra
199	109	2024-09-11	depósito	-100.00	Ingreso extra
200	107	2024-07-02	depósito	2500.00	\N
201	101	2024-07-09	retiro	-1000.00	Ingreso mensual
202	114	2024-10-01	compra	1500.00	Ingreso mensual
203	114	2024-07-09	compra	-500.00	\N
204	116	2024-06-15	retiro	3000.00	Compra en tienda
205	117	2024-02-10	compra	2500.00	Ingreso mensual
206	104	2024-01-11	retiro	1000.00	Compra en tienda
207	117	2024-03-27	deposito	1500.00	Compra en tienda
208	119	2024-09-25	deposito	1000.00	Ingreso mensual
209	112	2024-08-25	compra	2500.00	Ingreso navideño
210	107	2024-01-24	deposito	3000.00	Compra en tienda
211	115	2024-02-22	pago	3000.00	\N
212	119	2024-07-11	deposito	2500.00	\N
213	117	2024-09-27	pago	3000.00	Ingreso extra
214	120	2024-09-01	deposito	1500.00	Compra en tienda
215	110	2024-04-26	compra	3000.00	Ingreso mensual
216	114	2024-03-03	compra	1500.00	Ingreso mensual
217	111	2024-07-08	compra	2500.00	Ingreso extra
218	108	2024-08-16	deposito	-100.00	Compra en tienda
219	106	2024-12-16	deposito	2500.00	\N
220	117	2024-08-07	compra	3000.00	Ingreso navideño
221	108	2024-12-20	compra	-100.00	Ingreso navideño
222	103	2024-05-06	compra	2000.00	Retiro parcial
223	106	2024-02-22	retiro	-500.00	Compra en tienda
224	118	2024-01-30	retiro	2500.00	Ingreso mensual
225	117	2024-02-15	retiro	-100.00	Compra en tienda
226	107	2024-07-01	deposito	-100.00	Retiro parcial
227	107	2024-03-21	deposito	\N	Compra en tienda
228	116	2024-03-23	deposito	2000.00	Compra en tienda
229	113	2024-12-04	deposito	-500.00	\N
230	105	2024-08-03	deposito	1500.00	Ingreso navideño
231	115	2024-11-17	compra	-500.00	Ingreso extra
232	107	2024-03-07	deposito	3000.00	\N
233	106	2024-06-26	deposito	1000.00	Compra en tienda
234	118	2024-04-12	compra	-500.00	Compra en tienda
235	120	2024-02-14	deposito	2500.00	\N
236	111	2024-06-07	compra	1500.00	\N
237	119	2024-08-03	compra	5000.00	Compra en tienda
238	108	2024-01-18	compra	2000.00	Ingreso extra
239	101	2024-10-16	deposito	-100.00	Retiro parcial
240	115	2024-06-22	deposito	-500.00	Ingreso extra
241	105	2024-04-15	retiro	3000.00	Ingreso navideño
242	112	2024-03-23	deposito	1000.00	Ingreso mensual
243	118	2024-08-25	deposito	-100.00	\N
244	107	2024-10-24	retiro	2500.00	Ingreso navideño
245	107	2024-12-08	compra	\N	Retiro parcial
246	120	2024-10-30	deposito	1000.00	Ingreso navideño
247	111	2024-02-15	retiro	2500.00	Compra en tienda
248	106	2024-10-19	deposito	\N	\N
249	108	2024-12-12	compra	2000.00	Ingreso extra
250	108	2024-12-12	compra	-100.00	Ingreso extra
251	104	2024-07-10	compra	1500.00	\N
252	102	2024-02-09	retiro	1500.00	Ingreso navideño
253	103	2024-09-24	deposito	1500.00	\N
254	112	2024-06-12	deposito	3000.00	Ingreso navideño
255	105	2024-08-11	deposito	\N	Compra en tienda
256	112	2024-04-01	compra	2500.00	\N
257	108	2024-12-08	retiro	1500.00	\N
258	108	2024-09-30	retiro	-500.00	\N
259	106	2024-07-20	deposito	2500.00	Retiro parcial
260	102	2024-04-29	retiro	2000.00	\N
261	113	2024-07-20	compra	2500.00	Retiro parcial
262	119	2024-10-24	compra	2000.00	\N
263	107	2024-03-18	compra	5000.00	\N
264	108	2024-02-21	depósito	1500.00	Retiro parcial
265	120	2024-03-24	retiro	2000.00	Compra en tienda
266	112	2024-07-05	depósito	1000.00	Compra en tienda
267	104	2024-01-07	compra	1000.00	Retiro parcial
268	112	2024-12-11	retiro	3000.00	\N
269	110	2024-11-03	compra	-100.00	Ingreso extra
270	108	2024-09-29	deposito	\N	Ingreso extra
271	113	2024-12-28	deposito	2000.00	\N
272	116	2024-11-02	depósito	2000.00	Ingreso mensual
273	106	2024-02-02	compra	1500.00	Compra en tienda
274	114	2024-05-30	compra	2500.00	\N
275	113	2024-12-11	depósito	1500.00	Compra en tienda
276	107	2024-02-16	compra	2500.00	Ingreso mensual
277	102	2024-03-11	deposito	-100.00	\N
278	108	2024-03-13	deposito	2000.00	Retiro parcial
279	101	2024-03-22	retiro	2000.00	Retiro parcial
280	105	2024-04-03	retiro	1000.00	Retiro parcial
281	105	2024-08-14	retiro	1000.00	Ingreso navideño
282	103	2024-07-23	compra	3000.00	Retiro parcial
283	109	2024-01-21	depósito	2000.00	Ingreso navideño
284	103	2024-02-12	compra	3000.00	Compra en tienda
285	120	2024-02-03	retiro	2500.00	\N
286	102	2024-11-01	compra	-100.00	Retiro parcial
287	111	2024-02-16	retiro	2000.00	Ingreso mensual
288	104	2024-08-08	compra	-100.00	Ingreso mensual
289	106	2024-09-27	compra	-100.00	Ingreso mensual
290	106	2024-04-04	compra	2500.00	Retiro parcial
291	117	2024-08-29	retiro	1000.00	Ingreso mensual
292	116	2024-05-13	retiro	1000.00	Ingreso mensual
293	106	2024-05-04	compra	-500.00	Retiro parcial
294	105	2024-12-13	compra	3000.00	Ingreso mensual
295	120	2024-03-04	compra	2500.00	\N
296	104	2024-10-10	retiro	2500.00	Ingreso navideño
297	116	2024-11-01	deposito	-100.00	Compra en tienda
298	101	2024-06-03	deposito	2000.00	Compra en tienda
299	118	2024-08-19	compra	1500.00	Ingreso mensual
300	106	2024-09-03	compra	3000.00	\N
301	101	2024-09-25	deposito	2500.00	Ingreso mensual
302	101	2024-12-26	deposito	-100.00	\N
303	118	2024-04-18	deposito	3000.00	Retiro parcial
304	111	2024-03-28	deposito	5000.00	Ingreso navideño
305	118	2024-10-11	compra	3000.00	Ingreso mensual
306	109	2024-11-09	retiro	2000.00	Compra en tienda
307	109	2024-10-31	retiro	5000.00	\N
308	108	2024-01-26	retiro	3000.00	Ingreso mensual
309	114	2024-10-29	retiro	2500.00	Ingreso mensual
310	111	2024-07-30	depósito	3000.00	Compra en tienda
311	110	2024-11-15	compra	-100.00	Retiro parcial
312	116	2024-01-17	retiro	-100.00	Ingreso navideño
313	101	2024-02-04	depósito	2500.00	Compra en tienda
314	106	2024-07-25	compra	1500.00	\N
315	107	2024-08-11	retiro	-100.00	Ingreso extra
316	104	2024-07-30	compra	3000.00	Retiro parcial
317	119	2024-02-29	compra	\N	Ingreso mensual
318	115	2024-10-31	compra	1500.00	Ingreso mensual
319	111	2024-04-09	retiro	2500.00	Ingreso mensual
320	114	2024-02-21	pago	-500.00	Ingreso extra
321	104	2024-01-31	retiro	1500.00	Compra en tienda
322	117	2024-08-26	depósito	3000.00	Ingreso mensual
323	114	2024-10-03	compra	3000.00	Ingreso extra
324	101	2024-03-07	retiro	-100.00	\N
325	102	2024-12-24	pago	3000.00	Ingreso extra
326	119	2024-07-27	retiro	-500.00	Compra en tienda
327	116	2024-10-31	retiro	3000.00	\N
328	108	2024-10-23	retiro	2000.00	Compra en tienda
329	118	2024-01-19	retiro	5000.00	Ingreso extra
330	112	2024-11-22	compra	2000.00	Ingreso navideño
331	101	2024-01-17	pago	-100.00	\N
332	117	2024-09-05	deposito	2000.00	Ingreso mensual
333	108	2024-06-30	compra	2500.00	\N
334	109	2024-01-22	retiro	-100.00	\N
335	104	2024-05-26	deposito	2500.00	Ingreso navideño
336	108	2024-10-31	deposito	-500.00	Retiro parcial
337	109	2024-10-21	deposito	2500.00	Ingreso navideño
338	115	2024-07-12	compra	1500.00	\N
339	106	2024-03-23	compra	2000.00	Compra en tienda
340	115	2024-06-19	compra	2000.00	\N
341	113	2024-06-13	deposito	-500.00	Ingreso mensual
342	109	2024-02-12	compra	-100.00	Retiro parcial
343	104	2024-03-19	retiro	-500.00	Ingreso extra
344	110	2024-11-25	compra	2000.00	Ingreso mensual
345	104	2024-07-16	compra	1000.00	\N
346	120	2024-10-03	deposito	2500.00	Compra en tienda
347	120	2024-12-21	compra	-500.00	Compra en tienda
348	103	2024-07-29	compra	3000.00	Ingreso navideño
349	107	2024-04-09	deposito	1000.00	Ingreso mensual
350	115	2024-12-22	retiro	-100.00	Ingreso mensual
351	108	2024-09-22	retiro	-500.00	Ingreso extra
352	111	2024-12-04	depósito	1000.00	Ingreso extra
353	110	2024-07-08	retiro	2000.00	\N
354	116	2024-10-07	compra	3000.00	Retiro parcial
355	103	2024-09-02	retiro	1500.00	Ingreso navideño
356	108	2024-03-12	deposito	-500.00	Ingreso mensual
357	113	2024-09-14	deposito	2000.00	Ingreso mensual
358	118	2024-09-01	compra	-100.00	Ingreso mensual
359	112	2024-06-12	retiro	-500.00	Ingreso navideño
360	119	2024-12-23	compra	-500.00	Ingreso navideño
361	112	2024-07-17	retiro	-100.00	Ingreso mensual
362	105	2024-12-17	retiro	\N	Retiro parcial
363	115	2024-04-04	deposito	-100.00	Ingreso extra
364	120	2024-07-10	compra	3000.00	\N
365	104	2024-04-02	deposito	1500.00	Retiro parcial
366	109	2024-01-21	deposito	2000.00	\N
367	118	2024-06-15	retiro	3000.00	\N
368	105	2024-04-21	retiro	1500.00	Ingreso extra
369	103	2024-03-10	compra	3000.00	\N
370	104	2024-07-17	compra	\N	Retiro parcial
371	104	2024-05-23	compra	1500.00	Ingreso extra
372	119	2024-05-22	deposito	1000.00	Ingreso mensual
373	111	2024-05-04	deposito	\N	Ingreso navideño
374	116	2024-09-12	deposito	3000.00	Ingreso mensual
375	116	2024-10-06	retiro	2500.00	Ingreso extra
376	116	2024-09-22	deposito	2000.00	Ingreso extra
377	107	2024-08-08	compra	-500.00	Retiro parcial
378	117	2024-11-01	deposito	\N	\N
379	110	2024-12-13	deposito	1000.00	Ingreso extra
380	102	2024-05-23	pago	-500.00	Ingreso mensual
381	120	2024-07-26	retiro	\N	Ingreso mensual
382	113	2024-12-03	retiro	2000.00	Ingreso navideño
383	114	2024-05-14	retiro	3000.00	\N
384	102	2024-08-30	retiro	\N	Ingreso navideño
385	110	2024-05-01	retiro	2500.00	Compra en tienda
386	111	2024-05-10	retiro	1500.00	Compra en tienda
387	103	2024-07-15	pago	3000.00	\N
388	102	2024-08-03	pago	1000.00	\N
389	112	2024-11-25	deposito	1500.00	Ingreso navideño
390	117	2024-04-27	compra	3000.00	Retiro parcial
391	110	2024-08-11	compra	-500.00	Compra en tienda
392	116	2024-12-06	retiro	2000.00	Ingreso mensual
393	112	2024-08-26	retiro	1500.00	\N
394	107	2024-03-09	deposito	-500.00	Ingreso mensual
395	107	2024-06-15	compra	\N	\N
396	117	2024-03-07	retiro	3000.00	Ingreso mensual
397	101	2024-10-06	deposito	1500.00	Ingreso mensual
398	116	2024-01-03	deposito	2500.00	Ingreso navideño
399	117	2024-12-08	retiro	3000.00	Ingreso extra
400	108	2024-11-02	deposito	2500.00	Ingreso extra
401	102	2024-02-14	retiro	3000.00	\N
402	119	2024-10-24	depósito	1000.00	Ingreso navideño
403	118	2024-03-26	compra	1500.00	\N
404	102	2024-10-12	retiro	1500.00	Ingreso mensual
405	110	2024-01-14	pago	1500.00	Retiro parcial
406	111	2024-11-04	retiro	3000.00	Retiro parcial
407	109	2024-02-13	pago	-500.00	Ingreso extra
408	114	2024-03-16	compra	\N	Retiro parcial
409	109	2024-10-18	compra	1000.00	Retiro parcial
410	105	2024-01-12	deposito	1000.00	Retiro parcial
411	103	2024-12-08	deposito	-500.00	Compra en tienda
412	115	2024-12-28	deposito	2500.00	\N
413	116	2024-04-05	compra	-500.00	Ingreso navideño
414	107	2024-05-31	deposito	-100.00	Retiro parcial
415	101	2024-12-22	deposito	2500.00	Ingreso navideño
416	104	2024-11-05	pago	2000.00	Ingreso mensual
417	110	2024-11-23	compra	1500.00	Ingreso mensual
418	101	2024-04-26	compra	1500.00	Ingreso extra
419	115	2024-11-13	compra	2000.00	Compra en tienda
420	101	2024-06-12	deposito	2000.00	Ingreso extra
421	109	2024-07-14	depósito	2000.00	Ingreso mensual
422	101	2024-11-22	retiro	1000.00	\N
423	106	2024-09-26	deposito	-500.00	Ingreso extra
424	119	2024-10-18	retiro	-100.00	Compra en tienda
425	102	2024-08-24	retiro	-500.00	Retiro parcial
426	113	2024-02-27	deposito	1000.00	Ingreso mensual
427	108	2024-07-17	compra	3000.00	Ingreso extra
428	112	2024-01-20	retiro	5000.00	\N
429	119	2024-07-01	deposito	2000.00	\N
430	117	2024-03-29	compra	2000.00	Compra en tienda
431	113	2024-03-09	compra	-100.00	Compra en tienda
432	111	2024-10-31	retiro	-500.00	\N
433	120	2024-04-15	pago	1000.00	Compra en tienda
434	112	2024-10-06	deposito	2000.00	Ingreso extra
435	102	2024-05-26	pago	2500.00	Ingreso mensual
436	105	2024-05-24	compra	3000.00	Ingreso mensual
437	107	2024-03-03	retiro	1500.00	\N
438	118	2024-06-09	retiro	\N	Ingreso navideño
439	105	2024-05-13	deposito	-100.00	Retiro parcial
440	106	2024-01-29	deposito	2500.00	\N
441	104	2024-06-24	retiro	1000.00	\N
442	109	2024-08-30	deposito	3000.00	\N
443	118	2024-12-17	deposito	2500.00	Ingreso extra
444	104	2024-04-15	compra	3000.00	Ingreso navideño
445	107	2024-05-02	deposito	2500.00	Retiro parcial
446	118	2024-11-14	retiro	-500.00	\N
447	102	2024-10-04	compra	-500.00	Retiro parcial
448	114	2024-04-23	deposito	1500.00	Compra en tienda
449	119	2024-11-18	retiro	3000.00	Ingreso navideño
450	111	2024-01-25	depósito	2500.00	Compra en tienda
451	117	2024-09-13	pago	1500.00	Ingreso extra
452	102	2024-05-11	retiro	-100.00	Ingreso extra
453	112	2024-05-30	pago	-100.00	Ingreso navideño
454	106	2024-07-20	compra	2000.00	Compra en tienda
455	103	2024-12-23	retiro	2500.00	\N
456	120	2024-02-07	deposito	1500.00	Retiro parcial
457	120	2024-01-16	compra	2000.00	\N
458	109	2024-11-14	deposito	1500.00	Compra en tienda
459	113	2024-09-08	deposito	-100.00	Ingreso navideño
460	109	2024-03-10	deposito	3000.00	Retiro parcial
461	106	2024-02-22	compra	1000.00	Ingreso navideño
462	105	2024-07-10	retiro	3000.00	Ingreso mensual
463	102	2024-12-09	deposito	1500.00	Ingreso extra
464	119	2024-08-17	compra	2500.00	\N
465	120	2024-05-15	retiro	-500.00	Ingreso navideño
466	110	2024-11-15	deposito	0.00	\N
467	114	2024-12-29	deposito	2000.00	Compra en tienda
468	102	2024-10-06	retiro	-500.00	\N
469	109	2024-06-25	deposito	2500.00	Retiro parcial
470	104	2024-08-09	compra	3000.00	\N
471	116	2024-03-10	retiro	\N	Ingreso mensual
472	115	2024-01-23	compra	1000.00	Ingreso extra
473	119	2024-08-08	compra	1000.00	\N
474	108	2024-11-23	retiro	1500.00	Compra en tienda
475	112	2024-06-01	retiro	3000.00	Compra en tienda
476	104	2024-01-13	compra	3000.00	Ingreso navideño
477	117	2024-04-25	compra	-100.00	Retiro parcial
478	115	2024-11-24	retiro	1500.00	\N
479	112	2024-08-09	deposito	1500.00	Ingreso mensual
480	114	2024-06-08	retiro	2000.00	\N
481	120	2024-04-03	compra	2000.00	Retiro parcial
482	113	2024-10-29	deposito	2000.00	\N
483	115	2024-03-10	deposito	3000.00	Ingreso extra
484	117	2024-11-07	compra	3000.00	Ingreso navideño
485	114	2024-04-16	compra	1500.00	Retiro parcial
486	104	2024-01-04	deposito	1000.00	Ingreso mensual
487	113	2024-12-02	deposito	2000.00	Compra en tienda
488	106	2024-06-28	retiro	1500.00	Ingreso mensual
489	101	2024-08-24	compra	0.00	Compra en tienda
490	104	2024-05-31	retiro	\N	\N
491	105	2024-05-29	deposito	3000.00	Ingreso navideño
492	115	2024-03-01	retiro	1000.00	\N
493	104	2024-07-03	deposito	2000.00	Compra en tienda
494	120	2024-02-12	compra	1500.00	Retiro parcial
495	112	2024-04-06	compra	1500.00	Ingreso navideño
496	120	2024-07-28	retiro	3000.00	Ingreso mensual
497	110	2024-06-20	retiro	-500.00	Ingreso navideño
498	115	2024-04-25	retiro	-100.00	Ingreso mensual
499	111	2024-09-25	compra	2500.00	Ingreso navideño
500	102	2024-03-30	compra	3000.00	\N
501	116	2024-05-15	retiro	1000.00	Compra en tienda
502	105	2024-01-29	compra	1000.00	Ingreso navideño
503	110	2024-04-17	compra	3000.00	Ingreso navideño
504	108	2024-11-21	deposito	-500.00	Ingreso navideño
505	105	2024-04-20	retiro	-500.00	Retiro parcial
506	110	2024-11-01	retiro	-500.00	Ingreso navideño
507	108	2024-04-01	retiro	2500.00	\N
508	120	2024-07-13	deposito	1500.00	Ingreso mensual
509	117	2024-04-27	deposito	1500.00	Ingreso navideño
510	120	2024-12-27	compra	-100.00	\N
511	104	2024-07-07	deposito	-100.00	\N
512	111	2024-08-15	deposito	1500.00	Ingreso extra
513	106	2024-08-27	depósito	2000.00	Compra en tienda
514	109	2024-08-29	retiro	2500.00	Retiro parcial
515	113	2024-12-13	compra	\N	Ingreso navideño
516	105	2024-07-01	compra	1500.00	\N
517	112	2024-07-18	deposito	1000.00	Ingreso extra
518	117	2024-11-15	deposito	0.00	Ingreso navideño
519	103	2024-10-11	deposito	2500.00	\N
520	102	2024-10-20	depósito	3000.00	Ingreso extra
521	102	2024-03-02	compra	1000.00	Ingreso extra
522	115	2024-03-13	compra	1500.00	Ingreso extra
523	108	2024-10-01	retiro	1000.00	Retiro parcial
524	116	2024-05-28	compra	3000.00	Compra en tienda
525	102	2024-12-27	retiro	\N	Compra en tienda
526	104	2024-08-13	retiro	-500.00	Ingreso mensual
527	119	2024-09-19	retiro	-500.00	Ingreso navideño
528	114	2024-11-03	retiro	2000.00	\N
529	116	2024-04-04	compra	\N	Ingreso navideño
530	108	2024-02-03	retiro	2500.00	Ingreso mensual
531	109	2024-06-20	deposito	3000.00	\N
532	106	2024-03-25	compra	2000.00	Ingreso extra
533	106	2024-08-22	compra	-500.00	Ingreso mensual
534	115	2024-10-24	retiro	1000.00	\N
535	102	2024-10-01	compra	-500.00	Compra en tienda
536	119	2024-12-13	retiro	1500.00	Ingreso extra
537	106	2024-06-25	deposito	1000.00	Retiro parcial
538	105	2024-04-10	retiro	-500.00	Retiro parcial
539	115	2024-02-22	deposito	1500.00	\N
540	113	2024-08-30	retiro	2000.00	Ingreso extra
541	115	2024-04-24	deposito	2000.00	Ingreso mensual
542	106	2024-01-30	retiro	-500.00	Compra en tienda
543	118	2024-06-19	deposito	3000.00	\N
544	113	2024-06-09	deposito	3000.00	Ingreso navideño
545	110	2024-03-24	compra	-100.00	Ingreso extra
546	107	2024-03-29	retiro	2000.00	Retiro parcial
547	112	2024-04-29	retiro	2500.00	Ingreso navideño
548	102	2024-05-18	compra	1000.00	\N
549	102	2024-06-26	retiro	-100.00	Ingreso navideño
550	101	2024-03-07	deposito	3000.00	\N
551	111	2024-10-06	deposito	1500.00	Retiro parcial
552	112	2024-08-07	retiro	3000.00	\N
553	112	2024-09-06	deposito	0.00	Compra en tienda
554	118	2024-10-03	deposito	3000.00	Ingreso mensual
555	118	2024-05-12	pago	-500.00	\N
556	116	2024-11-14	deposito	3000.00	\N
557	110	2024-03-07	retiro	-100.00	Retiro parcial
558	116	2024-04-28	deposito	1000.00	Ingreso navideño
559	116	2024-10-12	deposito	-100.00	Ingreso extra
560	118	2024-04-07	deposito	1000.00	Compra en tienda
561	118	2024-01-19	retiro	1000.00	\N
562	111	2024-07-07	deposito	2500.00	Retiro parcial
563	118	2024-07-14	deposito	3000.00	Ingreso navideño
564	117	2024-09-04	retiro	5000.00	\N
565	102	2024-08-09	compra	3000.00	Ingreso navideño
566	118	2024-01-06	compra	3000.00	Compra en tienda
567	120	2024-11-18	retiro	2000.00	Ingreso extra
568	108	2024-06-21	retiro	2500.00	\N
569	105	2024-07-04	deposito	1000.00	\N
570	101	2024-08-01	retiro	2000.00	Ingreso extra
571	110	2024-08-05	deposito	1000.00	\N
572	107	2024-04-03	retiro	-500.00	\N
573	104	2024-08-29	retiro	2500.00	Ingreso mensual
574	108	2024-11-17	deposito	-100.00	Ingreso mensual
575	103	2024-05-08	compra	1000.00	Ingreso mensual
576	102	2024-03-13	compra	-100.00	Ingreso extra
577	102	2024-10-11	retiro	1500.00	Ingreso mensual
578	101	2024-04-20	compra	-100.00	Ingreso navideño
579	114	2024-04-13	compra	-100.00	Ingreso extra
580	105	2024-03-11	retiro	\N	Ingreso navideño
581	105	2024-02-14	retiro	-100.00	Ingreso navideño
582	112	2024-09-27	deposito	2000.00	\N
583	119	2024-02-16	deposito	-500.00	Retiro parcial
584	101	2024-04-08	retiro	-100.00	\N
585	118	2024-08-01	deposito	2500.00	\N
586	108	2024-04-17	compra	2000.00	Retiro parcial
587	106	2024-03-15	compra	2500.00	Ingreso extra
588	105	2024-01-12	retiro	1500.00	Ingreso extra
589	102	2024-04-03	retiro	3000.00	Ingreso mensual
590	106	2024-12-11	deposito	-100.00	\N
591	112	2024-10-16	retiro	-100.00	Ingreso navideño
592	106	2024-02-22	compra	1500.00	Ingreso extra
593	120	2024-08-06	deposito	-500.00	Retiro parcial
594	105	2024-11-30	deposito	-500.00	Ingreso navideño
595	103	2024-09-04	deposito	-500.00	Ingreso navideño
596	115	2024-07-26	compra	-500.00	Retiro parcial
597	104	2024-10-01	pago	-500.00	Retiro parcial
598	109	2024-03-18	compra	-500.00	Ingreso extra
599	118	2024-09-12	compra	-100.00	Retiro parcial
600	111	2024-08-05	retiro	-100.00	Compra en tienda
601	103	2024-10-26	compra	2000.00	Ingreso mensual
602	109	2024-02-17	deposito	1000.00	Ingreso navideño
603	114	2024-08-10	deposito	-500.00	Retiro parcial
604	109	2024-09-03	retiro	\N	Ingreso navideño
605	115	2024-09-14	compra	-100.00	Ingreso mensual
606	114	2024-02-19	retiro	1000.00	Ingreso navideño
607	104	2024-04-02	retiro	-100.00	Ingreso mensual
608	106	2024-12-07	retiro	2500.00	Ingreso navideño
609	108	2024-01-29	retiro	3000.00	Ingreso navideño
610	101	2024-01-17	retiro	-100.00	Compra en tienda
611	116	2024-05-25	deposito	3000.00	Ingreso mensual
612	118	2024-01-11	retiro	\N	\N
613	110	2024-12-24	retiro	3000.00	Retiro parcial
614	102	2024-10-10	retiro	-100.00	Ingreso navideño
615	106	2024-07-12	deposito	-100.00	Retiro parcial
616	114	2024-03-26	deposito	2000.00	Ingreso navideño
617	105	2024-06-07	deposito	2000.00	Ingreso mensual
618	120	2024-02-27	retiro	5000.00	\N
619	119	2024-07-25	retiro	2500.00	Ingreso navideño
620	114	2024-09-16	compra	\N	Ingreso extra
621	106	2024-08-31	compra	-100.00	Ingreso navideño
622	103	2024-06-25	deposito	1500.00	\N
623	112	2024-12-01	compra	2000.00	Ingreso extra
624	106	2024-04-10	deposito	-500.00	\N
625	109	2024-05-11	retiro	3000.00	Compra en tienda
626	114	2024-12-22	depósito	1500.00	Ingreso mensual
627	105	2024-12-09	retiro	1500.00	Ingreso navideño
628	109	2024-07-20	deposito	1500.00	Ingreso navideño
629	109	2024-11-11	compra	3000.00	Ingreso mensual
630	105	2024-04-18	pago	3000.00	Retiro parcial
631	114	2024-12-10	deposito	1500.00	\N
632	105	2024-05-23	compra	-100.00	Ingreso extra
633	103	2024-04-03	compra	2500.00	Retiro parcial
634	102	2024-04-23	compra	2000.00	Ingreso navideño
635	101	2024-06-30	deposito	1500.00	Ingreso extra
636	106	2024-01-29	compra	1000.00	Retiro parcial
637	105	2024-12-04	compra	1000.00	\N
638	105	2024-01-27	deposito	2000.00	Retiro parcial
639	105	2024-08-16	deposito	2500.00	Ingreso extra
640	117	2024-08-02	deposito	-100.00	Compra en tienda
641	113	2024-10-29	compra	2000.00	Compra en tienda
642	104	2024-02-17	depósito	1500.00	Retiro parcial
643	118	2024-02-18	deposito	2500.00	\N
644	107	2024-05-08	compra	\N	Retiro parcial
645	117	2024-11-17	depósito	1500.00	Retiro parcial
646	105	2024-11-28	deposito	1500.00	Ingreso extra
647	103	2024-05-09	deposito	-500.00	Retiro parcial
648	112	2024-03-15	compra	\N	Ingreso extra
649	108	2024-09-03	compra	1000.00	Retiro parcial
650	114	2024-10-10	compra	1500.00	\N
651	118	2024-02-07	compra	3000.00	Ingreso extra
652	107	2024-12-12	retiro	2000.00	Ingreso mensual
653	103	2024-04-22	compra	-100.00	Compra en tienda
654	102	2024-04-16	deposito	1500.00	Ingreso mensual
655	101	2024-09-05	deposito	2500.00	Ingreso extra
656	117	2024-03-01	deposito	3000.00	Ingreso extra
657	107	2024-08-28	pago	-500.00	Retiro parcial
658	119	2024-05-13	deposito	2000.00	Ingreso navideño
659	104	2024-10-01	deposito	-100.00	\N
660	107	2024-06-18	compra	2000.00	Retiro parcial
661	112	2024-05-11	pago	1500.00	Ingreso navideño
662	101	2024-04-29	deposito	3000.00	Ingreso extra
663	107	2024-10-31	retiro	-100.00	\N
664	117	2024-05-21	deposito	1500.00	Ingreso extra
665	119	2024-02-13	retiro	3000.00	Retiro parcial
666	113	2024-09-13	retiro	\N	\N
667	102	2024-03-07	retiro	2500.00	Ingreso mensual
668	106	2024-12-04	retiro	2000.00	Ingreso extra
669	116	2024-08-20	deposito	1500.00	\N
670	115	2024-10-24	retiro	1500.00	\N
671	119	2024-09-11	compra	2000.00	Compra en tienda
672	112	2024-03-19	depósito	1500.00	Compra en tienda
673	119	2024-02-11	deposito	0.00	Compra en tienda
674	111	2024-06-29	deposito	2500.00	Ingreso mensual
675	115	2024-11-03	compra	1000.00	Ingreso navideño
676	101	2024-11-11	compra	1000.00	Ingreso navideño
677	113	2024-02-29	deposito	2000.00	Ingreso navideño
678	109	2024-05-24	retiro	1000.00	Retiro parcial
679	116	2024-07-11	compra	-500.00	\N
680	111	2024-09-26	retiro	-500.00	Compra en tienda
681	117	2024-01-13	retiro	1000.00	Compra en tienda
682	114	2024-09-23	deposito	-100.00	Ingreso navideño
683	113	2024-09-02	depósito	3000.00	Compra en tienda
684	108	2024-11-07	retiro	2500.00	Ingreso extra
685	113	2024-05-11	compra	2500.00	\N
686	116	2024-06-30	retiro	1000.00	Ingreso extra
687	110	2024-07-13	deposito	3000.00	Ingreso extra
688	116	2024-06-27	deposito	5000.00	Ingreso navideño
689	108	2024-11-14	compra	3000.00	\N
690	118	2024-10-07	compra	3000.00	Retiro parcial
691	104	2024-05-31	retiro	1500.00	Retiro parcial
692	104	2024-08-30	retiro	-100.00	\N
693	118	2024-04-04	retiro	2000.00	\N
694	116	2024-08-28	deposito	2500.00	\N
695	111	2024-01-18	compra	2500.00	\N
696	116	2024-11-18	retiro	3000.00	Ingreso extra
697	103	2024-06-03	compra	-100.00	Ingreso extra
698	114	2024-09-01	retiro	2500.00	\N
699	110	2024-11-03	compra	-500.00	Ingreso mensual
700	112	2024-01-12	depósito	1500.00	Ingreso extra
701	109	2024-06-20	retiro	1000.00	Retiro parcial
702	117	2024-07-20	retiro	2500.00	\N
703	119	2024-08-20	deposito	2500.00	Compra en tienda
704	110	2024-11-21	retiro	-100.00	\N
705	115	2024-04-08	compra	1000.00	Ingreso navideño
706	103	2024-09-13	compra	\N	\N
707	119	2024-04-11	pago	2000.00	Ingreso extra
708	101	2024-01-30	depósito	3000.00	Compra en tienda
709	116	2024-03-08	compra	2000.00	Ingreso extra
710	102	2024-08-13	compra	5000.00	Retiro parcial
711	118	2024-03-14	deposito	3000.00	Retiro parcial
712	118	2024-04-21	deposito	-500.00	Ingreso navideño
713	112	2024-02-08	deposito	-500.00	\N
714	116	2024-07-05	retiro	2000.00	\N
715	115	2024-09-17	compra	2500.00	\N
716	106	2024-06-15	compra	2500.00	Ingreso navideño
717	114	2024-10-22	retiro	1500.00	Retiro parcial
718	108	2024-12-17	deposito	1000.00	Retiro parcial
719	111	2024-10-22	depósito	3000.00	\N
720	108	2024-04-17	retiro	1500.00	Ingreso extra
721	111	2024-06-24	compra	1000.00	\N
722	101	2024-06-20	deposito	-100.00	\N
723	104	2024-05-08	deposito	-100.00	\N
724	118	2024-11-08	compra	-500.00	Ingreso navideño
725	102	2024-01-14	compra	1500.00	Retiro parcial
726	105	2024-03-07	deposito	1000.00	Ingreso extra
727	105	2024-04-26	deposito	-500.00	Ingreso mensual
728	111	2024-04-18	compra	-100.00	Ingreso mensual
729	107	2024-12-14	compra	1500.00	Retiro parcial
730	104	2024-08-12	deposito	1000.00	Ingreso mensual
731	106	2024-11-22	deposito	2500.00	Compra en tienda
732	105	2024-04-29	compra	-100.00	Ingreso mensual
733	110	2024-07-02	pago	2500.00	Compra en tienda
734	117	2024-06-13	retiro	1500.00	Ingreso extra
735	116	2024-11-13	compra	1500.00	Ingreso extra
736	104	2024-07-28	deposito	-500.00	Ingreso navideño
737	114	2024-12-05	retiro	1500.00	Compra en tienda
738	114	2024-11-14	deposito	-100.00	Ingreso mensual
739	109	2024-05-15	deposito	2500.00	Retiro parcial
740	111	2024-07-21	retiro	1500.00	Ingreso mensual
741	106	2024-10-12	compra	1500.00	Ingreso navideño
742	119	2024-09-20	compra	2500.00	Retiro parcial
743	115	2024-04-13	depósito	3000.00	Ingreso extra
744	113	2024-11-08	compra	1500.00	\N
745	111	2024-09-26	retiro	1000.00	Ingreso mensual
746	110	2024-08-03	compra	1000.00	\N
747	110	2024-09-09	retiro	-100.00	Compra en tienda
748	103	2024-06-05	depósito	-100.00	Retiro parcial
749	107	2024-03-19	compra	1000.00	Ingreso extra
750	101	2024-08-04	compra	2000.00	Compra en tienda
751	111	2024-05-01	deposito	1500.00	Ingreso extra
752	109	2024-09-23	retiro	-500.00	Ingreso mensual
753	104	2024-05-23	compra	3000.00	Ingreso navideño
754	110	2024-03-10	retiro	-100.00	\N
755	105	2024-05-16	deposito	-500.00	Ingreso extra
756	115	2024-11-29	deposito	1000.00	Ingreso extra
757	103	2024-01-17	compra	-100.00	Compra en tienda
758	103	2024-09-28	deposito	-100.00	Ingreso mensual
759	111	2024-02-09	retiro	3000.00	Ingreso extra
760	119	2024-01-29	deposito	0.00	\N
761	116	2024-02-16	compra	2000.00	\N
762	107	2024-11-27	retiro	2500.00	\N
763	102	2024-11-14	compra	1500.00	Retiro parcial
764	116	2024-04-06	deposito	3000.00	Ingreso mensual
765	116	2024-02-14	deposito	1000.00	Ingreso extra
766	107	2024-12-26	deposito	2000.00	\N
767	114	2024-05-20	retiro	1000.00	Ingreso navideño
768	117	2024-07-11	compra	2500.00	Ingreso extra
769	114	2024-04-10	depósito	-500.00	Ingreso navideño
770	102	2024-09-08	depósito	2000.00	Compra en tienda
771	105	2024-09-28	compra	2500.00	\N
772	120	2024-09-15	retiro	-500.00	Compra en tienda
773	101	2024-01-09	compra	1500.00	\N
774	108	2024-11-17	retiro	-100.00	\N
775	111	2024-06-08	retiro	3000.00	Ingreso extra
776	116	2024-10-15	compra	-100.00	Ingreso navideño
777	119	2024-07-16	deposito	2500.00	Ingreso navideño
778	116	2024-02-01	retiro	3000.00	Ingreso navideño
779	106	2024-03-12	compra	3000.00	Ingreso extra
780	119	2024-09-23	compra	2000.00	Retiro parcial
781	106	2024-11-11	deposito	-500.00	Ingreso extra
782	118	2024-03-03	retiro	1500.00	Ingreso mensual
783	106	2024-07-01	compra	3000.00	Ingreso mensual
784	116	2024-10-29	compra	3000.00	Retiro parcial
785	115	2024-06-24	deposito	-500.00	Ingreso navideño
786	108	2024-07-08	retiro	-100.00	Ingreso navideño
787	110	2024-08-08	compra	-500.00	Ingreso extra
788	101	2024-07-20	retiro	2000.00	Compra en tienda
789	110	2024-02-08	compra	\N	Retiro parcial
790	102	2024-07-20	compra	1500.00	Ingreso mensual
791	108	2024-04-16	compra	3000.00	Compra en tienda
792	105	2024-09-01	deposito	\N	Ingreso mensual
793	103	2024-09-29	compra	-100.00	\N
794	107	2024-10-10	deposito	2000.00	Ingreso mensual
795	107	2024-01-24	deposito	-500.00	Ingreso mensual
796	112	2024-09-02	compra	1500.00	\N
797	106	2024-06-17	deposito	2000.00	Ingreso navideño
798	101	2024-11-23	compra	1500.00	Compra en tienda
799	107	2024-05-05	compra	3000.00	Ingreso mensual
800	115	2024-08-12	retiro	2000.00	Ingreso extra
801	101	2024-06-28	depósito	1500.00	Ingreso extra
802	112	2024-08-24	deposito	3000.00	Retiro parcial
803	116	2024-06-08	deposito	-500.00	\N
804	107	2024-02-14	compra	1500.00	Retiro parcial
805	119	2024-09-29	deposito	-100.00	Ingreso mensual
806	110	2024-05-30	compra	2500.00	Ingreso mensual
807	112	2024-03-20	deposito	3000.00	Retiro parcial
808	114	2024-07-26	compra	2000.00	Ingreso navideño
809	106	2024-10-19	retiro	1500.00	\N
810	107	2024-05-05	deposito	2500.00	\N
811	105	2024-02-15	deposito	1000.00	Ingreso extra
812	106	2024-03-18	deposito	1500.00	Ingreso mensual
813	104	2024-03-16	compra	2000.00	Compra en tienda
814	113	2024-08-16	compra	2000.00	Ingreso navideño
815	112	2024-01-09	compra	5000.00	Ingreso extra
816	113	2024-10-09	compra	-500.00	Ingreso extra
817	105	2024-02-06	retiro	-100.00	Retiro parcial
818	107	2024-10-17	pago	2500.00	\N
819	101	2024-04-03	pago	1500.00	Retiro parcial
820	105	2024-02-18	retiro	3000.00	Retiro parcial
821	102	2024-07-28	retiro	1000.00	\N
822	116	2024-03-19	compra	-500.00	Ingreso navideño
823	102	2024-12-06	deposito	2500.00	Retiro parcial
824	101	2024-08-31	deposito	3000.00	\N
825	120	2024-03-21	deposito	2500.00	Ingreso navideño
826	114	2024-06-06	retiro	2000.00	Ingreso extra
827	110	2024-06-06	compra	-100.00	Compra en tienda
828	107	2024-12-16	compra	3000.00	Compra en tienda
829	116	2024-06-12	deposito	1500.00	Ingreso mensual
830	115	2024-09-27	deposito	2500.00	Ingreso navideño
831	104	2024-05-30	retiro	2500.00	Compra en tienda
832	109	2024-07-15	compra	0.00	Compra en tienda
833	118	2024-05-22	retiro	1000.00	Ingreso extra
834	119	2024-08-06	deposito	1000.00	Retiro parcial
835	108	2024-10-12	pago	-100.00	Compra en tienda
836	103	2024-10-03	compra	1500.00	Ingreso navideño
837	108	2024-12-01	retiro	1000.00	\N
838	106	2024-05-30	depósito	2500.00	Ingreso navideño
839	101	2024-01-12	compra	-500.00	\N
840	109	2024-08-05	compra	3000.00	Ingreso navideño
841	114	2024-05-18	deposito	\N	Retiro parcial
842	115	2024-01-10	compra	2500.00	\N
843	101	2024-05-25	deposito	-100.00	Ingreso mensual
844	114	2024-01-22	depósito	-500.00	Ingreso mensual
845	107	2024-01-02	retiro	2000.00	Ingreso extra
846	119	2024-09-09	deposito	2000.00	Ingreso navideño
847	120	2024-02-07	retiro	-100.00	Ingreso mensual
848	112	2024-08-11	deposito	\N	\N
849	101	2024-09-02	depósito	3000.00	Ingreso navideño
850	107	2024-02-07	deposito	\N	Ingreso navideño
851	101	2024-09-30	deposito	-500.00	\N
852	106	2024-09-15	deposito	2000.00	\N
853	110	2024-05-26	retiro	3000.00	\N
854	105	2024-09-23	compra	1000.00	\N
855	118	2024-05-20	retiro	\N	Ingreso mensual
856	109	2024-04-03	compra	1500.00	Ingreso extra
857	107	2024-08-29	depósito	-100.00	Retiro parcial
858	111	2024-10-29	retiro	2500.00	\N
859	117	2024-03-11	deposito	2500.00	Retiro parcial
860	112	2024-06-21	retiro	1500.00	\N
861	105	2024-02-21	compra	1000.00	Ingreso extra
862	107	2024-12-03	compra	-500.00	\N
863	108	2024-12-20	retiro	2000.00	Retiro parcial
864	105	2024-04-22	retiro	-500.00	\N
865	107	2024-02-18	pago	2000.00	Compra en tienda
866	101	2024-09-01	compra	\N	\N
867	118	2024-10-27	depósito	2500.00	Compra en tienda
868	102	2024-05-30	retiro	3000.00	\N
869	103	2024-04-20	depósito	2000.00	Retiro parcial
870	119	2024-06-25	compra	2500.00	Ingreso extra
871	111	2024-08-08	compra	3000.00	\N
872	108	2024-01-27	retiro	2000.00	Ingreso extra
873	107	2024-05-11	retiro	3000.00	Compra en tienda
874	101	2024-11-24	deposito	-100.00	\N
875	104	2024-06-20	compra	-500.00	Ingreso extra
876	109	2024-08-19	retiro	-500.00	Compra en tienda
877	101	2024-05-27	deposito	\N	Ingreso navideño
878	108	2024-12-20	depósito	2500.00	Ingreso mensual
879	104	2024-01-18	retiro	5000.00	Ingreso extra
880	113	2024-05-02	compra	-100.00	Retiro parcial
881	114	2024-02-15	deposito	3000.00	Ingreso mensual
882	104	2024-09-19	deposito	2500.00	Compra en tienda
883	105	2024-08-07	deposito	2500.00	\N
884	108	2024-11-19	retiro	2000.00	Ingreso navideño
885	102	2024-11-29	compra	\N	Compra en tienda
886	108	2024-01-22	depósito	-500.00	\N
887	114	2024-02-21	depósito	1000.00	Compra en tienda
888	109	2024-02-07	compra	2000.00	Compra en tienda
889	111	2024-04-29	deposito	5000.00	Ingreso mensual
890	117	2024-11-25	retiro	3000.00	Ingreso navideño
891	112	2024-08-30	depósito	-500.00	Retiro parcial
892	112	2024-11-06	deposito	2000.00	Retiro parcial
893	101	2024-04-22	compra	2500.00	Ingreso mensual
894	107	2024-06-16	retiro	2500.00	Ingreso mensual
895	114	2024-05-17	compra	-100.00	Ingreso extra
896	113	2024-02-13	pago	3000.00	Ingreso extra
897	118	2024-10-23	retiro	1500.00	Compra en tienda
898	106	2024-10-28	retiro	2500.00	Ingreso navideño
899	105	2024-01-08	compra	-100.00	Ingreso extra
900	116	2024-12-18	deposito	\N	Ingreso navideño
901	112	2024-02-26	deposito	3000.00	Ingreso mensual
902	110	2024-04-03	deposito	-100.00	\N
903	111	2024-02-16	retiro	1500.00	\N
904	119	2024-04-30	compra	2500.00	Ingreso navideño
905	117	2024-07-31	compra	1000.00	\N
906	115	2024-10-17	retiro	-100.00	Retiro parcial
907	120	2024-05-01	compra	3000.00	Retiro parcial
908	107	2024-04-06	retiro	\N	Ingreso mensual
909	119	2024-10-26	compra	2000.00	Retiro parcial
910	105	2024-10-07	compra	-100.00	Ingreso navideño
911	116	2024-09-06	deposito	-100.00	Retiro parcial
912	118	2024-04-12	deposito	-100.00	Ingreso extra
913	118	2024-12-28	compra	1500.00	\N
914	113	2024-11-21	retiro	1000.00	Compra en tienda
915	104	2024-08-25	deposito	1500.00	Retiro parcial
916	117	2024-04-20	deposito	1000.00	Retiro parcial
917	110	2024-07-08	deposito	1500.00	Ingreso navideño
918	113	2024-09-03	retiro	3000.00	\N
919	115	2024-01-10	deposito	-1000.00	Retiro parcial
920	102	2024-05-11	retiro	2000.00	\N
921	108	2024-02-20	retiro	-100.00	Compra en tienda
922	107	2024-12-21	compra	1500.00	\N
923	102	2024-12-17	deposito	-100.00	Compra en tienda
924	115	2024-04-30	compra	2500.00	\N
925	114	2024-11-17	compra	-100.00	Compra en tienda
926	106	2024-06-08	compra	2500.00	Ingreso navideño
927	117	2024-07-20	compra	-500.00	Compra en tienda
928	111	2024-03-11	depósito	-500.00	Ingreso extra
929	116	2024-05-14	compra	3000.00	\N
930	113	2024-05-09	compra	2500.00	Ingreso mensual
931	120	2024-08-12	retiro	-500.00	\N
932	116	2024-07-28	compra	-1000.00	Ingreso navideño
933	104	2024-11-17	retiro	2000.00	Ingreso navideño
934	108	2024-09-22	deposito	1000.00	Compra en tienda
935	117	2024-02-01	deposito	1500.00	Ingreso mensual
936	115	2024-02-09	compra	0.00	\N
937	111	2024-04-27	deposito	-100.00	Compra en tienda
938	104	2024-08-10	deposito	-500.00	Ingreso navideño
939	117	2024-04-19	retiro	\N	Retiro parcial
940	107	2024-01-15	deposito	-100.00	Ingreso navideño
941	114	2024-02-19	deposito	-500.00	\N
942	110	2024-09-10	deposito	2500.00	\N
943	116	2024-10-07	retiro	2000.00	Compra en tienda
944	112	2024-11-09	deposito	1000.00	Compra en tienda
945	101	2024-01-25	deposito	1000.00	Ingreso extra
946	119	2024-06-04	compra	3000.00	\N
947	105	2024-01-11	pago	2500.00	Retiro parcial
948	119	2024-05-26	compra	1000.00	Compra en tienda
949	119	2024-10-27	deposito	2500.00	\N
950	102	2024-07-16	deposito	-500.00	Ingreso navideño
951	112	2024-02-12	retiro	2000.00	Ingreso navideño
952	115	2024-01-05	compra	1500.00	\N
953	113	2024-11-13	pago	2000.00	Ingreso extra
954	111	2024-12-27	compra	-500.00	Ingreso mensual
955	120	2024-11-02	depósito	3000.00	Ingreso extra
956	114	2024-11-13	compra	2500.00	Ingreso extra
957	115	2024-12-01	pago	-100.00	Ingreso mensual
958	107	2024-05-13	compra	1000.00	Ingreso navideño
959	108	2024-09-25	deposito	1500.00	Ingreso extra
960	114	2024-08-31	deposito	3000.00	Ingreso mensual
961	102	2024-02-09	compra	-100.00	\N
962	114	2024-04-02	retiro	2000.00	Ingreso mensual
963	118	2024-08-17	deposito	3000.00	Ingreso mensual
964	116	2024-07-16	retiro	3000.00	\N
965	111	2024-03-07	deposito	\N	Ingreso mensual
966	112	2024-10-01	deposito	1000.00	Retiro parcial
967	107	2024-04-21	deposito	1000.00	Retiro parcial
968	114	2024-05-30	compra	2000.00	\N
969	118	2024-12-04	retiro	1000.00	Ingreso extra
970	120	2024-06-05	compra	1000.00	Retiro parcial
971	113	2024-01-11	compra	-100.00	\N
972	109	2024-03-22	depósito	1500.00	Compra en tienda
973	113	2024-11-07	compra	-500.00	Ingreso navideño
974	105	2024-01-04	retiro	1000.00	Ingreso navideño
975	118	2024-04-03	deposito	3000.00	Compra en tienda
976	108	2024-06-13	compra	1000.00	Retiro parcial
977	105	2024-02-11	pago	1500.00	Retiro parcial
978	109	2024-11-09	compra	3000.00	Ingreso mensual
979	118	2024-11-11	compra	3000.00	Ingreso navideño
980	111	2024-06-20	compra	-100.00	Ingreso navideño
981	112	2024-11-13	deposito	-500.00	\N
982	111	2024-12-11	pago	1500.00	Ingreso mensual
983	109	2024-01-27	deposito	1000.00	Compra en tienda
984	115	2024-02-14	deposito	1000.00	Compra en tienda
985	110	2024-11-13	compra	2500.00	Retiro parcial
986	103	2024-06-20	retiro	3000.00	Ingreso mensual
987	104	2024-10-20	compra	1500.00	Ingreso mensual
988	112	2024-12-27	retiro	-1000.00	Ingreso navideño
989	106	2024-04-23	compra	-500.00	Ingreso extra
990	119	2024-02-07	compra	3000.00	Ingreso navideño
991	119	2024-12-15	deposito	1500.00	\N
992	110	2024-04-12	depósito	3000.00	Compra en tienda
993	104	2024-10-23	compra	-100.00	\N
994	112	2024-12-20	retiro	-500.00	Retiro parcial
995	119	2024-02-17	deposito	2500.00	\N
996	104	2024-01-08	deposito	2500.00	Ingreso navideño
997	118	2024-04-28	deposito	-100.00	\N
998	117	2024-10-28	deposito	-100.00	\N
999	105	2024-09-12	deposito	2500.00	Retiro parcial
1000	118	2024-05-20	pago	2000.00	\N
\.


--
-- Data for Name: eventos_transaccion_procesados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eventos_transaccion_procesados (id, event_id, transaccion_id, fecha, monto, tipo, es_anomalia, motivo_anomalia, fecha_recepcion) FROM stdin;
1	bbd21931-b8ce-46ed-9d46-94862e01d6dc	152	2024-10-25	1500.00	invalid	t	Tipo de transacción no válido: invalid	2026-10-03 00:55:51.811165
2	9e5f0778-0923-439b-b5ba-788648fa0e22	152	2024-10-25	1500.00	invalid	t	Tipo de transacción no válido: invalid	2026-10-03 01:04:08.923265
3	1419dd77-79cd-43f3-a5d9-21b3bc2be0a7	152	2024-10-25	1500.00	invalid	t	Tipo de transacción no válido: invalid	2026-10-03 01:15:21.72939
4	4b55868d-af37-4cb4-b73b-b44c424672c9	152	2024-10-25	1500.00	invalid	t	Tipo de transacción no válido: invalid	2026-10-03 01:17:08.252957
\.


--
-- Data for Name: intereses_procesados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.intereses_procesados (id, cuenta_id, nombre, saldo_inicial, edad, tipo, tasa_interes, interes_calculado, saldo_final) FROM stdin;
1	137	Bob Johnson	7000.00	\N	prestamo	0.01000	70.00	6930.00
2	114	Unknown	0.00	30	desconocido	0.00000	0.00	0.00
3	133	Alice Brown	12000.00	100	desconocido	0.00000	0.00	12000.00
4	106	Jane Smith	12000.00	40	prestamo	0.01000	120.00	11880.00
5	122	Bob Johnson	7000.00	40	desconocido	0.00000	0.00	7000.00
6	108	Jane Smith	12000.00	100	prestamo	0.01000	120.00	11880.00
7	124	Bob Johnson	12000.00	35	desconocido	0.00000	0.00	12000.00
8	138	Steve Rogers	10000.00	25	desconocido	0.00000	0.00	10000.00
9	113	Charlie Green	0.00	35	desconocido	0.00000	0.00	0.00
10	133	Steve Rogers	12000.00	40	prestamo	0.01000	120.00	11880.00
11	102	Alice Brown	12000.00	45	desconocido	0.00000	0.00	12000.00
12	130	Diana Prince	12000.00	45	desconocido	0.00000	0.00	12000.00
13	137	Steve Rogers	12000.00	30	ahorro	0.00500	60.00	12060.00
14	145	Charlie Green	8000.00	\N	ahorro	0.00500	40.00	8040.00
15	127	Bob Johnson	5000.00	30	ahorro	0.00500	25.00	5025.00
16	117	Steve Rogers	12000.00	100	ahorro	0.00500	60.00	12060.00
17	128	Diana Prince	7000.00	100	prestamo	0.01000	70.00	6930.00
18	147	Alice Brown	8000.00	100	desconocido	0.00000	0.00	8000.00
19	148	John Doe	7000.00	\N	prestamo	0.01000	70.00	6930.00
20	142	Steve Rogers	5000.00	\N	desconocido	0.00000	0.00	5000.00
21	109	Charlie Green	7000.00	45	desconocido	0.00000	0.00	7000.00
22	103	Jane Smith	8000.00	30	desconocido	0.00000	0.00	8000.00
23	110	Unknown	5000.00	35	desconocido	0.00000	0.00	5000.00
24	111	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
25	136	Charlie Green	8000.00	100	desconocido	0.00000	0.00	8000.00
26	146	Steve Rogers	0.00	30	ahorro	0.00500	0.00	0.00
27	134	Charlie Green	8000.00	\N	desconocido	0.00000	0.00	8000.00
28	113	Alice Brown	10000.00	45	prestamo	0.01000	100.00	9900.00
29	107	Alice Brown	0.00	25	prestamo	0.01000	0.00	0.00
30	111	Diana Prince	5000.00	30	prestamo	0.01000	50.00	4950.00
31	103	Jane Smith	7000.00	40	desconocido	0.00000	0.00	7000.00
32	110	Jane Smith	8000.00	100	ahorro	0.00500	40.00	8040.00
33	116	Diana Prince	0.00	\N	prestamo	0.01000	0.00	0.00
34	105	Diana Prince	10000.00	25	prestamo	0.01000	100.00	9900.00
35	141	Unknown	7000.00	\N	ahorro	0.00500	35.00	7035.00
36	120	John Doe	0.00	\N	desconocido	0.00000	0.00	0.00
37	143	Steve Rogers	12000.00	30	ahorro	0.00500	60.00	12060.00
38	140	John Doe	0.00	45	desconocido	0.00000	0.00	0.00
39	107	Diana Prince	0.00	25	ahorro	0.00500	0.00	0.00
40	133	Alice Brown	10000.00	45	desconocido	0.00000	0.00	10000.00
41	136	Steve Rogers	5000.00	40	desconocido	0.00000	0.00	5000.00
42	150	Charlie Green	0.00	40	desconocido	0.00000	0.00	0.00
43	137	Steve Rogers	0.00	35	prestamo	0.01000	0.00	0.00
44	126	Jane Smith	5000.00	25	desconocido	0.00000	0.00	5000.00
45	133	Diana Prince	8000.00	40	prestamo	0.01000	80.00	7920.00
46	126	Bob Johnson	12000.00	35	prestamo	0.01000	120.00	11880.00
47	104	Steve Rogers	8000.00	45	desconocido	0.00000	0.00	8000.00
48	143	Charlie Green	0.00	\N	desconocido	0.00000	0.00	0.00
49	133	Steve Rogers	0.00	100	desconocido	0.00000	0.00	0.00
50	121	Alice Brown	12000.00	100	desconocido	0.00000	0.00	12000.00
51	118	John Doe	8000.00	40	prestamo	0.01000	80.00	7920.00
52	104	Jane Smith	12000.00	\N	ahorro	0.00500	60.00	12060.00
53	127	John Doe	5000.00	100	desconocido	0.00000	0.00	5000.00
54	108	John Doe	8000.00	45	prestamo	0.01000	80.00	7920.00
55	123	Diana Prince	7000.00	\N	desconocido	0.00000	0.00	7000.00
56	138	Alice Brown	5000.00	\N	desconocido	0.00000	0.00	5000.00
57	121	Steve Rogers	8000.00	\N	desconocido	0.00000	0.00	8000.00
58	107	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
59	119	John Doe	10000.00	100	desconocido	0.00000	0.00	10000.00
60	122	Jane Smith	12000.00	25	prestamo	0.01000	120.00	11880.00
61	132	Jane Smith	10000.00	100	desconocido	0.00000	0.00	10000.00
62	137	Bob Johnson	8000.00	\N	ahorro	0.00500	40.00	8040.00
63	139	Bob Johnson	0.00	35	prestamo	0.01000	0.00	0.00
64	102	Alice Brown	8000.00	\N	ahorro	0.00500	40.00	8040.00
65	133	Steve Rogers	10000.00	25	desconocido	0.00000	0.00	10000.00
66	141	Bob Johnson	0.00	\N	ahorro	0.00500	0.00	0.00
67	140	Bob Johnson	8000.00	40	desconocido	0.00000	0.00	8000.00
68	126	Alice Brown	12000.00	\N	prestamo	0.01000	120.00	11880.00
69	110	Charlie Green	7000.00	45	desconocido	0.00000	0.00	7000.00
70	123	John Doe	12000.00	100	prestamo	0.01000	120.00	11880.00
71	140	Steve Rogers	7000.00	40	ahorro	0.00500	35.00	7035.00
72	128	Jane Smith	8000.00	35	ahorro	0.00500	40.00	8040.00
73	107	Diana Prince	0.00	25	desconocido	0.00000	0.00	0.00
74	107	Unknown	5000.00	\N	ahorro	0.00500	25.00	5025.00
75	120	Bob Johnson	0.00	40	desconocido	0.00000	0.00	0.00
76	111	Charlie Green	12000.00	40	desconocido	0.00000	0.00	12000.00
77	106	Steve Rogers	7000.00	40	desconocido	0.00000	0.00	7000.00
78	120	Unknown	0.00	40	prestamo	0.01000	0.00	0.00
79	132	Unknown	10000.00	30	desconocido	0.00000	0.00	10000.00
80	137	Alice Brown	8000.00	100	desconocido	0.00000	0.00	8000.00
81	119	Bob Johnson	10000.00	25	desconocido	0.00000	0.00	10000.00
82	136	Charlie Green	10000.00	35	desconocido	0.00000	0.00	10000.00
83	130	Charlie Green	0.00	25	desconocido	0.00000	0.00	0.00
84	137	John Doe	0.00	40	desconocido	0.00000	0.00	0.00
85	102	Bob Johnson	8000.00	45	desconocido	0.00000	0.00	8000.00
86	114	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
87	112	Steve Rogers	10000.00	\N	ahorro	0.00500	50.00	10050.00
88	140	Jane Smith	0.00	35	desconocido	0.00000	0.00	0.00
89	110	Charlie Green	7000.00	25	desconocido	0.00000	0.00	7000.00
90	105	Jane Smith	8000.00	40	prestamo	0.01000	80.00	7920.00
91	111	John Doe	5000.00	35	desconocido	0.00000	0.00	5000.00
92	134	Alice Brown	10000.00	30	prestamo	0.01000	100.00	9900.00
93	149	Bob Johnson	8000.00	\N	ahorro	0.00500	40.00	8040.00
94	124	Bob Johnson	10000.00	25	prestamo	0.01000	100.00	9900.00
95	147	Alice Brown	12000.00	40	ahorro	0.00500	60.00	12060.00
96	122	Bob Johnson	0.00	100	desconocido	0.00000	0.00	0.00
97	102	Jane Smith	7000.00	\N	prestamo	0.01000	70.00	6930.00
98	138	John Doe	12000.00	\N	prestamo	0.01000	120.00	11880.00
99	121	Steve Rogers	5000.00	35	prestamo	0.01000	50.00	4950.00
100	139	Alice Brown	5000.00	100	desconocido	0.00000	0.00	5000.00
101	136	Alice Brown	10000.00	\N	ahorro	0.00500	50.00	10050.00
102	103	Charlie Green	8000.00	30	desconocido	0.00000	0.00	8000.00
103	147	Bob Johnson	7000.00	100	desconocido	0.00000	0.00	7000.00
104	127	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
105	149	Alice Brown	10000.00	25	desconocido	0.00000	0.00	10000.00
106	115	Charlie Green	8000.00	45	desconocido	0.00000	0.00	8000.00
107	131	Steve Rogers	8000.00	\N	desconocido	0.00000	0.00	8000.00
108	148	Bob Johnson	0.00	30	desconocido	0.00000	0.00	0.00
109	106	Unknown	7000.00	30	ahorro	0.00500	35.00	7035.00
110	120	Jane Smith	5000.00	40	desconocido	0.00000	0.00	5000.00
111	108	Jane Smith	10000.00	100	ahorro	0.00500	50.00	10050.00
112	130	Steve Rogers	5000.00	45	prestamo	0.01000	50.00	4950.00
113	113	Jane Smith	10000.00	\N	desconocido	0.00000	0.00	10000.00
114	135	Charlie Green	12000.00	\N	desconocido	0.00000	0.00	12000.00
115	150	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
116	123	Diana Prince	0.00	30	ahorro	0.00500	0.00	0.00
117	146	Jane Smith	12000.00	100	desconocido	0.00000	0.00	12000.00
118	105	Steve Rogers	8000.00	25	desconocido	0.00000	0.00	8000.00
119	127	Diana Prince	0.00	\N	desconocido	0.00000	0.00	0.00
120	113	Charlie Green	0.00	30	desconocido	0.00000	0.00	0.00
121	145	Diana Prince	0.00	25	desconocido	0.00000	0.00	0.00
122	123	Bob Johnson	5000.00	25	ahorro	0.00500	25.00	5025.00
123	142	John Doe	0.00	35	desconocido	0.00000	0.00	0.00
124	141	Steve Rogers	8000.00	35	ahorro	0.00500	40.00	8040.00
125	146	Charlie Green	7000.00	30	ahorro	0.00500	35.00	7035.00
126	133	John Doe	12000.00	35	desconocido	0.00000	0.00	12000.00
127	128	John Doe	0.00	35	desconocido	0.00000	0.00	0.00
128	124	Diana Prince	12000.00	45	ahorro	0.00500	60.00	12060.00
129	112	Bob Johnson	8000.00	25	desconocido	0.00000	0.00	8000.00
130	126	Diana Prince	12000.00	\N	desconocido	0.00000	0.00	12000.00
131	149	Alice Brown	8000.00	\N	prestamo	0.01000	80.00	7920.00
132	116	Unknown	12000.00	25	prestamo	0.01000	120.00	11880.00
133	111	Unknown	5000.00	100	desconocido	0.00000	0.00	5000.00
134	107	Unknown	12000.00	30	desconocido	0.00000	0.00	12000.00
135	121	John Doe	0.00	35	desconocido	0.00000	0.00	0.00
136	123	Bob Johnson	12000.00	45	desconocido	0.00000	0.00	12000.00
137	108	Alice Brown	10000.00	\N	ahorro	0.00500	50.00	10050.00
138	121	John Doe	0.00	\N	desconocido	0.00000	0.00	0.00
139	134	Charlie Green	7000.00	45	desconocido	0.00000	0.00	7000.00
140	108	Jane Smith	12000.00	45	desconocido	0.00000	0.00	12000.00
141	143	Charlie Green	5000.00	40	desconocido	0.00000	0.00	5000.00
142	115	Bob Johnson	7000.00	25	desconocido	0.00000	0.00	7000.00
143	135	Diana Prince	7000.00	100	desconocido	0.00000	0.00	7000.00
144	115	Steve Rogers	7000.00	25	desconocido	0.00000	0.00	7000.00
145	137	Steve Rogers	8000.00	\N	desconocido	0.00000	0.00	8000.00
146	141	Bob Johnson	8000.00	30	prestamo	0.01000	80.00	7920.00
147	112	John Doe	7000.00	\N	desconocido	0.00000	0.00	7000.00
148	111	John Doe	0.00	25	desconocido	0.00000	0.00	0.00
149	121	John Doe	0.00	\N	ahorro	0.00500	0.00	0.00
150	117	Bob Johnson	5000.00	\N	prestamo	0.01000	50.00	4950.00
151	120	Diana Prince	0.00	\N	ahorro	0.00500	0.00	0.00
152	120	Jane Smith	5000.00	40	prestamo	0.01000	50.00	4950.00
153	140	Alice Brown	5000.00	25	ahorro	0.00500	25.00	5025.00
154	129	John Doe	12000.00	35	desconocido	0.00000	0.00	12000.00
155	130	Jane Smith	10000.00	45	prestamo	0.01000	100.00	9900.00
156	122	Jane Smith	5000.00	100	desconocido	0.00000	0.00	5000.00
157	138	Diana Prince	5000.00	\N	desconocido	0.00000	0.00	5000.00
158	130	John Doe	5000.00	35	desconocido	0.00000	0.00	5000.00
159	126	Alice Brown	7000.00	25	desconocido	0.00000	0.00	7000.00
160	145	Steve Rogers	0.00	\N	ahorro	0.00500	0.00	0.00
161	107	Steve Rogers	10000.00	\N	ahorro	0.00500	50.00	10050.00
162	119	Diana Prince	10000.00	25	desconocido	0.00000	0.00	10000.00
163	147	Jane Smith	12000.00	25	prestamo	0.01000	120.00	11880.00
164	146	Jane Smith	0.00	25	desconocido	0.00000	0.00	0.00
165	116	Steve Rogers	10000.00	30	desconocido	0.00000	0.00	10000.00
166	123	Alice Brown	0.00	25	desconocido	0.00000	0.00	0.00
167	103	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
168	140	John Doe	0.00	30	desconocido	0.00000	0.00	0.00
169	120	Charlie Green	7000.00	\N	desconocido	0.00000	0.00	7000.00
170	105	Jane Smith	7000.00	40	desconocido	0.00000	0.00	7000.00
171	150	Bob Johnson	8000.00	40	ahorro	0.00500	40.00	8040.00
172	132	Bob Johnson	5000.00	\N	desconocido	0.00000	0.00	5000.00
173	122	Unknown	12000.00	45	prestamo	0.01000	120.00	11880.00
174	120	Alice Brown	12000.00	45	desconocido	0.00000	0.00	12000.00
175	140	John Doe	7000.00	30	ahorro	0.00500	35.00	7035.00
176	143	Charlie Green	5000.00	100	ahorro	0.00500	25.00	5025.00
177	123	Steve Rogers	0.00	\N	prestamo	0.01000	0.00	0.00
178	144	Alice Brown	8000.00	45	ahorro	0.00500	40.00	8040.00
179	101	Diana Prince	8000.00	35	ahorro	0.00500	40.00	8040.00
180	132	John Doe	7000.00	30	desconocido	0.00000	0.00	7000.00
181	123	Bob Johnson	10000.00	\N	ahorro	0.00500	50.00	10050.00
182	135	Steve Rogers	10000.00	45	desconocido	0.00000	0.00	10000.00
183	119	Steve Rogers	8000.00	40	prestamo	0.01000	80.00	7920.00
184	127	Steve Rogers	5000.00	45	ahorro	0.00500	25.00	5025.00
185	150	Charlie Green	12000.00	45	prestamo	0.01000	120.00	11880.00
186	104	Jane Smith	10000.00	\N	desconocido	0.00000	0.00	10000.00
187	110	Charlie Green	8000.00	\N	prestamo	0.01000	80.00	7920.00
188	148	Jane Smith	8000.00	25	ahorro	0.00500	40.00	8040.00
189	109	Steve Rogers	5000.00	45	prestamo	0.01000	50.00	4950.00
190	145	Steve Rogers	0.00	\N	prestamo	0.01000	0.00	0.00
191	109	Steve Rogers	10000.00	\N	prestamo	0.01000	100.00	9900.00
192	132	John Doe	12000.00	45	desconocido	0.00000	0.00	12000.00
193	131	Alice Brown	7000.00	45	ahorro	0.00500	35.00	7035.00
194	150	Alice Brown	10000.00	40	desconocido	0.00000	0.00	10000.00
195	121	Alice Brown	12000.00	35	desconocido	0.00000	0.00	12000.00
196	145	Alice Brown	7000.00	\N	ahorro	0.00500	35.00	7035.00
197	148	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
198	120	Charlie Green	7000.00	40	desconocido	0.00000	0.00	7000.00
199	134	Diana Prince	12000.00	30	ahorro	0.00500	60.00	12060.00
200	103	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
201	137	Alice Brown	0.00	45	ahorro	0.00500	0.00	0.00
202	140	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
203	133	Alice Brown	7000.00	30	ahorro	0.00500	35.00	7035.00
204	114	Bob Johnson	5000.00	30	desconocido	0.00000	0.00	5000.00
205	114	Steve Rogers	5000.00	100	prestamo	0.01000	50.00	4950.00
206	105	Diana Prince	5000.00	30	desconocido	0.00000	0.00	5000.00
207	116	Alice Brown	8000.00	35	desconocido	0.00000	0.00	8000.00
208	140	John Doe	0.00	45	desconocido	0.00000	0.00	0.00
209	142	Alice Brown	0.00	100	prestamo	0.01000	0.00	0.00
210	125	Jane Smith	12000.00	30	desconocido	0.00000	0.00	12000.00
211	119	Charlie Green	5000.00	35	desconocido	0.00000	0.00	5000.00
212	114	Charlie Green	7000.00	100	desconocido	0.00000	0.00	7000.00
213	112	John Doe	12000.00	\N	ahorro	0.00500	60.00	12060.00
214	128	Jane Smith	7000.00	100	desconocido	0.00000	0.00	7000.00
215	118	Bob Johnson	10000.00	45	desconocido	0.00000	0.00	10000.00
216	150	Jane Smith	8000.00	\N	desconocido	0.00000	0.00	8000.00
217	129	Charlie Green	10000.00	40	desconocido	0.00000	0.00	10000.00
218	143	Jane Smith	12000.00	40	desconocido	0.00000	0.00	12000.00
219	124	Steve Rogers	8000.00	25	desconocido	0.00000	0.00	8000.00
220	127	Steve Rogers	0.00	\N	prestamo	0.01000	0.00	0.00
221	125	Charlie Green	12000.00	25	desconocido	0.00000	0.00	12000.00
222	126	Diana Prince	0.00	35	prestamo	0.01000	0.00	0.00
223	118	Bob Johnson	8000.00	\N	ahorro	0.00500	40.00	8040.00
224	114	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
225	114	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
226	138	Diana Prince	7000.00	35	desconocido	0.00000	0.00	7000.00
227	141	Charlie Green	7000.00	35	desconocido	0.00000	0.00	7000.00
228	140	Jane Smith	8000.00	30	desconocido	0.00000	0.00	8000.00
229	110	Steve Rogers	8000.00	30	prestamo	0.01000	80.00	7920.00
230	140	Steve Rogers	12000.00	\N	ahorro	0.00500	60.00	12060.00
231	107	Alice Brown	10000.00	40	prestamo	0.01000	100.00	9900.00
232	124	John Doe	7000.00	30	prestamo	0.01000	70.00	6930.00
233	123	Steve Rogers	12000.00	35	desconocido	0.00000	0.00	12000.00
234	144	Charlie Green	7000.00	\N	prestamo	0.01000	70.00	6930.00
235	132	Alice Brown	5000.00	\N	ahorro	0.00500	25.00	5025.00
236	122	Jane Smith	0.00	100	desconocido	0.00000	0.00	0.00
237	116	Alice Brown	12000.00	30	desconocido	0.00000	0.00	12000.00
238	111	Steve Rogers	5000.00	35	ahorro	0.00500	25.00	5025.00
239	129	Unknown	0.00	35	desconocido	0.00000	0.00	0.00
240	117	Steve Rogers	10000.00	\N	desconocido	0.00000	0.00	10000.00
241	126	Jane Smith	7000.00	40	ahorro	0.00500	35.00	7035.00
242	101	Diana Prince	12000.00	40	prestamo	0.01000	120.00	11880.00
243	147	John Doe	0.00	35	desconocido	0.00000	0.00	0.00
244	119	Diana Prince	10000.00	40	ahorro	0.00500	50.00	10050.00
245	144	John Doe	0.00	\N	prestamo	0.01000	0.00	0.00
246	123	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
247	122	Charlie Green	5000.00	\N	prestamo	0.01000	50.00	4950.00
248	102	Bob Johnson	12000.00	35	desconocido	0.00000	0.00	12000.00
249	106	Diana Prince	0.00	30	prestamo	0.01000	0.00	0.00
250	134	Diana Prince	12000.00	35	prestamo	0.01000	120.00	11880.00
251	125	Steve Rogers	0.00	100	ahorro	0.00500	0.00	0.00
252	110	Jane Smith	7000.00	40	ahorro	0.00500	35.00	7035.00
253	139	Alice Brown	12000.00	100	desconocido	0.00000	0.00	12000.00
254	115	Alice Brown	7000.00	\N	ahorro	0.00500	35.00	7035.00
255	106	Diana Prince	5000.00	100	desconocido	0.00000	0.00	5000.00
256	114	Steve Rogers	7000.00	45	desconocido	0.00000	0.00	7000.00
257	117	Bob Johnson	7000.00	40	ahorro	0.00500	35.00	7035.00
258	103	Charlie Green	0.00	30	desconocido	0.00000	0.00	0.00
259	109	Diana Prince	0.00	40	desconocido	0.00000	0.00	0.00
260	111	John Doe	12000.00	40	desconocido	0.00000	0.00	12000.00
261	107	John Doe	12000.00	45	desconocido	0.00000	0.00	12000.00
262	102	Jane Smith	5000.00	\N	prestamo	0.01000	50.00	4950.00
263	103	Diana Prince	8000.00	45	prestamo	0.01000	80.00	7920.00
264	109	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
265	122	Diana Prince	8000.00	30	ahorro	0.00500	40.00	8040.00
266	137	John Doe	10000.00	\N	prestamo	0.01000	100.00	9900.00
267	136	Diana Prince	0.00	30	desconocido	0.00000	0.00	0.00
268	123	John Doe	8000.00	\N	ahorro	0.00500	40.00	8040.00
269	106	Alice Brown	12000.00	100	ahorro	0.00500	60.00	12060.00
270	123	Alice Brown	10000.00	\N	desconocido	0.00000	0.00	10000.00
271	129	Steve Rogers	7000.00	40	ahorro	0.00500	35.00	7035.00
272	142	John Doe	8000.00	100	desconocido	0.00000	0.00	8000.00
273	138	Jane Smith	7000.00	45	ahorro	0.00500	35.00	7035.00
274	122	Diana Prince	5000.00	25	desconocido	0.00000	0.00	5000.00
275	126	Charlie Green	0.00	35	desconocido	0.00000	0.00	0.00
276	129	Steve Rogers	7000.00	45	ahorro	0.00500	35.00	7035.00
277	106	Charlie Green	12000.00	35	ahorro	0.00500	60.00	12060.00
278	121	Bob Johnson	5000.00	25	desconocido	0.00000	0.00	5000.00
279	149	Charlie Green	0.00	100	prestamo	0.01000	0.00	0.00
280	143	Diana Prince	0.00	40	desconocido	0.00000	0.00	0.00
281	121	Charlie Green	5000.00	\N	ahorro	0.00500	25.00	5025.00
282	116	John Doe	12000.00	\N	desconocido	0.00000	0.00	12000.00
283	133	Jane Smith	12000.00	45	ahorro	0.00500	60.00	12060.00
284	114	Steve Rogers	10000.00	45	desconocido	0.00000	0.00	10000.00
285	135	Alice Brown	12000.00	45	prestamo	0.01000	120.00	11880.00
286	102	Alice Brown	12000.00	30	desconocido	0.00000	0.00	12000.00
287	104	Unknown	10000.00	25	ahorro	0.00500	50.00	10050.00
288	145	Jane Smith	0.00	25	prestamo	0.01000	0.00	0.00
289	138	Alice Brown	0.00	45	ahorro	0.00500	0.00	0.00
290	114	John Doe	8000.00	25	desconocido	0.00000	0.00	8000.00
291	141	Steve Rogers	7000.00	45	desconocido	0.00000	0.00	7000.00
292	115	John Doe	5000.00	35	ahorro	0.00500	25.00	5025.00
293	101	Steve Rogers	10000.00	100	ahorro	0.00500	50.00	10050.00
294	128	Diana Prince	8000.00	35	desconocido	0.00000	0.00	8000.00
295	120	Alice Brown	10000.00	100	desconocido	0.00000	0.00	10000.00
296	150	Unknown	10000.00	100	desconocido	0.00000	0.00	10000.00
297	121	Alice Brown	5000.00	40	desconocido	0.00000	0.00	5000.00
298	114	Bob Johnson	8000.00	45	desconocido	0.00000	0.00	8000.00
299	117	Alice Brown	5000.00	\N	ahorro	0.00500	25.00	5025.00
300	147	Diana Prince	8000.00	\N	ahorro	0.00500	40.00	8040.00
301	109	Bob Johnson	0.00	\N	desconocido	0.00000	0.00	0.00
302	112	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
303	149	Diana Prince	5000.00	25	desconocido	0.00000	0.00	5000.00
304	120	Alice Brown	5000.00	45	desconocido	0.00000	0.00	5000.00
305	138	Diana Prince	5000.00	40	ahorro	0.00500	25.00	5025.00
306	112	Jane Smith	0.00	\N	desconocido	0.00000	0.00	0.00
307	149	Charlie Green	12000.00	40	prestamo	0.01000	120.00	11880.00
308	141	Alice Brown	5000.00	\N	desconocido	0.00000	0.00	5000.00
309	149	Steve Rogers	10000.00	40	desconocido	0.00000	0.00	10000.00
310	118	John Doe	7000.00	35	prestamo	0.01000	70.00	6930.00
311	132	Bob Johnson	7000.00	100	desconocido	0.00000	0.00	7000.00
312	141	Alice Brown	10000.00	30	desconocido	0.00000	0.00	10000.00
313	123	Unknown	7000.00	100	prestamo	0.01000	70.00	6930.00
314	118	John Doe	10000.00	100	desconocido	0.00000	0.00	10000.00
315	138	Jane Smith	0.00	\N	desconocido	0.00000	0.00	0.00
316	123	Alice Brown	8000.00	45	desconocido	0.00000	0.00	8000.00
317	129	Bob Johnson	12000.00	45	prestamo	0.01000	120.00	11880.00
318	144	Charlie Green	7000.00	30	desconocido	0.00000	0.00	7000.00
319	126	Diana Prince	5000.00	45	ahorro	0.00500	25.00	5025.00
320	136	Steve Rogers	12000.00	35	desconocido	0.00000	0.00	12000.00
321	105	John Doe	10000.00	\N	ahorro	0.00500	50.00	10050.00
322	115	Bob Johnson	7000.00	35	desconocido	0.00000	0.00	7000.00
323	147	John Doe	0.00	30	ahorro	0.00500	0.00	0.00
324	145	Bob Johnson	0.00	35	ahorro	0.00500	0.00	0.00
325	138	Charlie Green	0.00	100	prestamo	0.01000	0.00	0.00
326	134	Unknown	7000.00	45	ahorro	0.00500	35.00	7035.00
327	123	Charlie Green	5000.00	40	desconocido	0.00000	0.00	5000.00
328	115	John Doe	10000.00	35	prestamo	0.01000	100.00	9900.00
329	146	Bob Johnson	10000.00	40	desconocido	0.00000	0.00	10000.00
330	113	John Doe	8000.00	25	desconocido	0.00000	0.00	8000.00
331	132	Steve Rogers	5000.00	45	desconocido	0.00000	0.00	5000.00
332	101	Jane Smith	7000.00	45	desconocido	0.00000	0.00	7000.00
333	123	Unknown	10000.00	35	prestamo	0.01000	100.00	9900.00
334	140	Unknown	12000.00	40	desconocido	0.00000	0.00	12000.00
335	105	Diana Prince	7000.00	100	ahorro	0.00500	35.00	7035.00
336	128	Steve Rogers	5000.00	\N	ahorro	0.00500	25.00	5025.00
337	113	Unknown	0.00	40	desconocido	0.00000	0.00	0.00
338	106	Charlie Green	10000.00	100	ahorro	0.00500	50.00	10050.00
339	116	Diana Prince	8000.00	100	ahorro	0.00500	40.00	8040.00
340	140	John Doe	0.00	30	desconocido	0.00000	0.00	0.00
341	127	Diana Prince	8000.00	30	ahorro	0.00500	40.00	8040.00
342	110	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
343	115	Diana Prince	0.00	40	desconocido	0.00000	0.00	0.00
344	138	Charlie Green	5000.00	\N	desconocido	0.00000	0.00	5000.00
345	150	Diana Prince	8000.00	35	desconocido	0.00000	0.00	8000.00
346	101	Steve Rogers	5000.00	35	desconocido	0.00000	0.00	5000.00
347	105	Alice Brown	0.00	25	prestamo	0.01000	0.00	0.00
348	150	Steve Rogers	0.00	25	desconocido	0.00000	0.00	0.00
349	137	Charlie Green	7000.00	\N	desconocido	0.00000	0.00	7000.00
350	124	John Doe	0.00	35	prestamo	0.01000	0.00	0.00
351	132	John Doe	0.00	40	desconocido	0.00000	0.00	0.00
352	113	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
353	119	Steve Rogers	0.00	35	desconocido	0.00000	0.00	0.00
354	113	Charlie Green	7000.00	\N	desconocido	0.00000	0.00	7000.00
355	146	Charlie Green	8000.00	25	desconocido	0.00000	0.00	8000.00
356	121	Alice Brown	5000.00	25	desconocido	0.00000	0.00	5000.00
357	143	John Doe	12000.00	35	prestamo	0.01000	120.00	11880.00
358	118	Jane Smith	5000.00	25	desconocido	0.00000	0.00	5000.00
359	144	Diana Prince	8000.00	100	prestamo	0.01000	80.00	7920.00
360	127	John Doe	12000.00	100	ahorro	0.00500	60.00	12060.00
361	120	John Doe	0.00	\N	desconocido	0.00000	0.00	0.00
362	133	Steve Rogers	5000.00	35	prestamo	0.01000	50.00	4950.00
363	114	Jane Smith	12000.00	100	desconocido	0.00000	0.00	12000.00
364	139	Charlie Green	12000.00	45	desconocido	0.00000	0.00	12000.00
365	132	Alice Brown	12000.00	100	desconocido	0.00000	0.00	12000.00
366	108	Alice Brown	5000.00	25	desconocido	0.00000	0.00	5000.00
367	107	John Doe	8000.00	35	desconocido	0.00000	0.00	8000.00
368	107	Bob Johnson	8000.00	45	desconocido	0.00000	0.00	8000.00
369	118	Charlie Green	5000.00	100	desconocido	0.00000	0.00	5000.00
370	149	Steve Rogers	0.00	\N	prestamo	0.01000	0.00	0.00
371	107	Alice Brown	10000.00	45	prestamo	0.01000	100.00	9900.00
372	128	Diana Prince	7000.00	\N	desconocido	0.00000	0.00	7000.00
373	102	Diana Prince	5000.00	35	desconocido	0.00000	0.00	5000.00
374	127	Charlie Green	7000.00	30	desconocido	0.00000	0.00	7000.00
375	112	Bob Johnson	5000.00	25	ahorro	0.00500	25.00	5025.00
376	120	Jane Smith	5000.00	\N	desconocido	0.00000	0.00	5000.00
377	146	John Doe	0.00	45	desconocido	0.00000	0.00	0.00
378	132	Bob Johnson	8000.00	100	prestamo	0.01000	80.00	7920.00
379	112	Jane Smith	0.00	100	desconocido	0.00000	0.00	0.00
380	129	Steve Rogers	7000.00	\N	desconocido	0.00000	0.00	7000.00
381	136	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
382	134	Diana Prince	12000.00	100	ahorro	0.00500	60.00	12060.00
383	105	Jane Smith	10000.00	25	desconocido	0.00000	0.00	10000.00
384	112	Bob Johnson	0.00	25	ahorro	0.00500	0.00	0.00
385	150	John Doe	7000.00	40	ahorro	0.00500	35.00	7035.00
386	111	Steve Rogers	10000.00	\N	desconocido	0.00000	0.00	10000.00
387	149	Unknown	8000.00	40	ahorro	0.00500	40.00	8040.00
388	109	John Doe	8000.00	25	desconocido	0.00000	0.00	8000.00
389	147	John Doe	0.00	30	ahorro	0.00500	0.00	0.00
390	144	Alice Brown	8000.00	30	desconocido	0.00000	0.00	8000.00
391	120	Bob Johnson	5000.00	45	desconocido	0.00000	0.00	5000.00
392	133	John Doe	10000.00	\N	desconocido	0.00000	0.00	10000.00
393	114	Jane Smith	5000.00	35	ahorro	0.00500	25.00	5025.00
394	114	Steve Rogers	10000.00	100	desconocido	0.00000	0.00	10000.00
395	132	Diana Prince	7000.00	\N	desconocido	0.00000	0.00	7000.00
396	147	Unknown	5000.00	45	desconocido	0.00000	0.00	5000.00
397	104	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
398	108	Alice Brown	0.00	100	prestamo	0.01000	0.00	0.00
399	126	Unknown	12000.00	25	desconocido	0.00000	0.00	12000.00
400	118	Jane Smith	10000.00	45	ahorro	0.00500	50.00	10050.00
401	110	John Doe	8000.00	25	desconocido	0.00000	0.00	8000.00
402	116	Steve Rogers	7000.00	\N	desconocido	0.00000	0.00	7000.00
403	107	John Doe	7000.00	25	desconocido	0.00000	0.00	7000.00
404	133	Alice Brown	5000.00	35	prestamo	0.01000	50.00	4950.00
405	115	Bob Johnson	10000.00	45	desconocido	0.00000	0.00	10000.00
406	134	Diana Prince	10000.00	40	desconocido	0.00000	0.00	10000.00
407	145	John Doe	5000.00	35	desconocido	0.00000	0.00	5000.00
408	141	John Doe	10000.00	35	prestamo	0.01000	100.00	9900.00
409	103	John Doe	0.00	45	desconocido	0.00000	0.00	0.00
410	117	Alice Brown	10000.00	100	desconocido	0.00000	0.00	10000.00
411	106	Diana Prince	8000.00	25	desconocido	0.00000	0.00	8000.00
412	128	Jane Smith	8000.00	30	desconocido	0.00000	0.00	8000.00
413	103	Jane Smith	7000.00	25	desconocido	0.00000	0.00	7000.00
414	120	Jane Smith	5000.00	\N	ahorro	0.00500	25.00	5025.00
415	109	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
416	135	Charlie Green	12000.00	\N	prestamo	0.01000	120.00	11880.00
417	129	Diana Prince	0.00	30	desconocido	0.00000	0.00	0.00
418	130	John Doe	0.00	40	ahorro	0.00500	0.00	0.00
419	130	Jane Smith	8000.00	25	prestamo	0.01000	80.00	7920.00
420	104	Bob Johnson	12000.00	30	prestamo	0.01000	120.00	11880.00
421	144	Steve Rogers	10000.00	\N	prestamo	0.01000	100.00	9900.00
422	120	Jane Smith	0.00	25	prestamo	0.01000	0.00	0.00
423	101	John Doe	10000.00	35	prestamo	0.01000	100.00	9900.00
424	102	Jane Smith	0.00	\N	desconocido	0.00000	0.00	0.00
425	145	Alice Brown	0.00	100	desconocido	0.00000	0.00	0.00
426	136	Jane Smith	7000.00	40	ahorro	0.00500	35.00	7035.00
427	122	Alice Brown	10000.00	45	desconocido	0.00000	0.00	10000.00
428	121	Diana Prince	7000.00	45	prestamo	0.01000	70.00	6930.00
429	134	Charlie Green	10000.00	45	prestamo	0.01000	100.00	9900.00
430	137	Jane Smith	8000.00	\N	desconocido	0.00000	0.00	8000.00
431	130	Alice Brown	0.00	25	desconocido	0.00000	0.00	0.00
432	116	Alice Brown	12000.00	40	desconocido	0.00000	0.00	12000.00
433	133	Alice Brown	5000.00	35	desconocido	0.00000	0.00	5000.00
434	126	Bob Johnson	0.00	\N	ahorro	0.00500	0.00	0.00
435	129	Jane Smith	10000.00	\N	desconocido	0.00000	0.00	10000.00
436	138	Unknown	10000.00	30	desconocido	0.00000	0.00	10000.00
437	148	Unknown	5000.00	100	ahorro	0.00500	25.00	5025.00
438	124	Steve Rogers	7000.00	\N	desconocido	0.00000	0.00	7000.00
439	110	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
440	139	Jane Smith	0.00	100	desconocido	0.00000	0.00	0.00
441	107	Alice Brown	7000.00	100	prestamo	0.01000	70.00	6930.00
442	142	Steve Rogers	7000.00	30	desconocido	0.00000	0.00	7000.00
443	113	John Doe	0.00	30	prestamo	0.01000	0.00	0.00
444	107	Alice Brown	10000.00	40	desconocido	0.00000	0.00	10000.00
445	140	Charlie Green	5000.00	\N	prestamo	0.01000	50.00	4950.00
446	113	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
447	114	Bob Johnson	7000.00	\N	desconocido	0.00000	0.00	7000.00
448	102	Bob Johnson	5000.00	\N	desconocido	0.00000	0.00	5000.00
449	138	Jane Smith	7000.00	45	prestamo	0.01000	70.00	6930.00
450	143	Charlie Green	0.00	45	desconocido	0.00000	0.00	0.00
451	103	Jane Smith	10000.00	100	desconocido	0.00000	0.00	10000.00
452	107	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
453	112	Bob Johnson	10000.00	30	ahorro	0.00500	50.00	10050.00
454	107	Bob Johnson	0.00	35	desconocido	0.00000	0.00	0.00
455	142	Steve Rogers	0.00	25	ahorro	0.00500	0.00	0.00
456	148	Charlie Green	8000.00	\N	ahorro	0.00500	40.00	8040.00
457	144	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
458	118	Diana Prince	7000.00	40	prestamo	0.01000	70.00	6930.00
459	114	Steve Rogers	10000.00	\N	desconocido	0.00000	0.00	10000.00
460	103	Jane Smith	5000.00	\N	ahorro	0.00500	25.00	5025.00
461	150	Diana Prince	10000.00	25	desconocido	0.00000	0.00	10000.00
462	125	John Doe	0.00	25	desconocido	0.00000	0.00	0.00
463	150	Jane Smith	8000.00	\N	desconocido	0.00000	0.00	8000.00
464	123	John Doe	5000.00	35	desconocido	0.00000	0.00	5000.00
465	120	John Doe	7000.00	30	prestamo	0.01000	70.00	6930.00
466	138	Bob Johnson	10000.00	30	desconocido	0.00000	0.00	10000.00
467	141	John Doe	12000.00	25	ahorro	0.00500	60.00	12060.00
468	113	Steve Rogers	7000.00	45	desconocido	0.00000	0.00	7000.00
469	102	Charlie Green	12000.00	40	ahorro	0.00500	60.00	12060.00
470	137	Jane Smith	7000.00	\N	ahorro	0.00500	35.00	7035.00
471	103	Diana Prince	10000.00	100	desconocido	0.00000	0.00	10000.00
472	136	Alice Brown	5000.00	25	prestamo	0.01000	50.00	4950.00
473	145	Steve Rogers	0.00	100	desconocido	0.00000	0.00	0.00
474	138	John Doe	10000.00	25	desconocido	0.00000	0.00	10000.00
475	117	Diana Prince	12000.00	\N	desconocido	0.00000	0.00	12000.00
476	131	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
477	132	Unknown	12000.00	\N	prestamo	0.01000	120.00	11880.00
478	146	Bob Johnson	0.00	30	desconocido	0.00000	0.00	0.00
479	108	John Doe	8000.00	45	prestamo	0.01000	80.00	7920.00
480	112	Jane Smith	5000.00	40	desconocido	0.00000	0.00	5000.00
481	119	Steve Rogers	5000.00	45	desconocido	0.00000	0.00	5000.00
482	137	Alice Brown	8000.00	\N	desconocido	0.00000	0.00	8000.00
483	127	Charlie Green	7000.00	30	desconocido	0.00000	0.00	7000.00
484	109	Unknown	0.00	25	desconocido	0.00000	0.00	0.00
485	118	John Doe	0.00	40	desconocido	0.00000	0.00	0.00
486	121	John Doe	0.00	25	ahorro	0.00500	0.00	0.00
487	105	Bob Johnson	8000.00	40	ahorro	0.00500	40.00	8040.00
488	119	John Doe	8000.00	\N	ahorro	0.00500	40.00	8040.00
489	122	Bob Johnson	5000.00	40	ahorro	0.00500	25.00	5025.00
490	122	Diana Prince	7000.00	\N	ahorro	0.00500	35.00	7035.00
491	113	John Doe	12000.00	\N	ahorro	0.00500	60.00	12060.00
492	131	Bob Johnson	7000.00	35	desconocido	0.00000	0.00	7000.00
493	111	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
494	114	Diana Prince	0.00	\N	ahorro	0.00500	0.00	0.00
495	139	Charlie Green	5000.00	35	desconocido	0.00000	0.00	5000.00
496	134	Bob Johnson	5000.00	25	prestamo	0.01000	50.00	4950.00
497	150	Alice Brown	7000.00	35	ahorro	0.00500	35.00	7035.00
498	103	John Doe	5000.00	\N	prestamo	0.01000	50.00	4950.00
499	108	Alice Brown	5000.00	30	desconocido	0.00000	0.00	5000.00
500	140	Alice Brown	8000.00	40	ahorro	0.00500	40.00	8040.00
501	147	Charlie Green	7000.00	25	prestamo	0.01000	70.00	6930.00
502	110	Bob Johnson	7000.00	35	desconocido	0.00000	0.00	7000.00
503	143	Charlie Green	10000.00	35	desconocido	0.00000	0.00	10000.00
504	137	Bob Johnson	5000.00	40	desconocido	0.00000	0.00	5000.00
505	124	John Doe	7000.00	\N	desconocido	0.00000	0.00	7000.00
506	140	Alice Brown	5000.00	35	prestamo	0.01000	50.00	4950.00
507	112	Steve Rogers	8000.00	30	prestamo	0.01000	80.00	7920.00
508	102	Alice Brown	8000.00	45	prestamo	0.01000	80.00	7920.00
509	131	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
510	104	Steve Rogers	10000.00	25	prestamo	0.01000	100.00	9900.00
511	128	Diana Prince	0.00	35	desconocido	0.00000	0.00	0.00
512	133	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
513	138	Alice Brown	8000.00	45	prestamo	0.01000	80.00	7920.00
514	121	Bob Johnson	8000.00	35	desconocido	0.00000	0.00	8000.00
515	130	John Doe	5000.00	25	prestamo	0.01000	50.00	4950.00
516	143	Diana Prince	0.00	35	desconocido	0.00000	0.00	0.00
517	116	Diana Prince	0.00	30	desconocido	0.00000	0.00	0.00
518	136	Diana Prince	5000.00	40	prestamo	0.01000	50.00	4950.00
519	105	Unknown	10000.00	45	prestamo	0.01000	100.00	9900.00
520	107	Alice Brown	10000.00	\N	desconocido	0.00000	0.00	10000.00
521	135	Steve Rogers	12000.00	25	ahorro	0.00500	60.00	12060.00
522	126	John Doe	5000.00	45	ahorro	0.00500	25.00	5025.00
523	101	Alice Brown	8000.00	25	desconocido	0.00000	0.00	8000.00
524	111	John Doe	0.00	\N	ahorro	0.00500	0.00	0.00
525	121	Steve Rogers	12000.00	30	desconocido	0.00000	0.00	12000.00
526	138	Alice Brown	12000.00	30	ahorro	0.00500	60.00	12060.00
527	116	Bob Johnson	0.00	45	desconocido	0.00000	0.00	0.00
528	101	John Doe	8000.00	30	desconocido	0.00000	0.00	8000.00
529	133	John Doe	0.00	25	ahorro	0.00500	0.00	0.00
530	129	Diana Prince	8000.00	45	ahorro	0.00500	40.00	8040.00
531	138	Jane Smith	12000.00	30	prestamo	0.01000	120.00	11880.00
532	127	Diana Prince	7000.00	40	desconocido	0.00000	0.00	7000.00
533	137	Jane Smith	10000.00	45	desconocido	0.00000	0.00	10000.00
534	115	Jane Smith	12000.00	45	desconocido	0.00000	0.00	12000.00
535	123	John Doe	5000.00	25	ahorro	0.00500	25.00	5025.00
536	109	Diana Prince	0.00	\N	desconocido	0.00000	0.00	0.00
537	122	Charlie Green	10000.00	45	desconocido	0.00000	0.00	10000.00
538	135	John Doe	10000.00	\N	desconocido	0.00000	0.00	10000.00
539	102	Jane Smith	5000.00	40	prestamo	0.01000	50.00	4950.00
540	110	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
541	112	Jane Smith	10000.00	\N	ahorro	0.00500	50.00	10050.00
542	132	Bob Johnson	10000.00	100	desconocido	0.00000	0.00	10000.00
543	104	Jane Smith	8000.00	\N	desconocido	0.00000	0.00	8000.00
544	120	Steve Rogers	0.00	30	prestamo	0.01000	0.00	0.00
545	126	Alice Brown	8000.00	\N	prestamo	0.01000	80.00	7920.00
546	124	Steve Rogers	0.00	45	desconocido	0.00000	0.00	0.00
547	127	Charlie Green	5000.00	\N	ahorro	0.00500	25.00	5025.00
548	132	Diana Prince	8000.00	45	desconocido	0.00000	0.00	8000.00
549	131	Jane Smith	10000.00	40	desconocido	0.00000	0.00	10000.00
550	123	Alice Brown	12000.00	35	desconocido	0.00000	0.00	12000.00
551	134	John Doe	8000.00	40	desconocido	0.00000	0.00	8000.00
552	114	Steve Rogers	0.00	45	desconocido	0.00000	0.00	0.00
553	111	Bob Johnson	0.00	\N	prestamo	0.01000	0.00	0.00
554	139	Charlie Green	10000.00	40	ahorro	0.00500	50.00	10050.00
555	133	John Doe	10000.00	35	desconocido	0.00000	0.00	10000.00
556	147	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
557	145	Bob Johnson	12000.00	35	desconocido	0.00000	0.00	12000.00
558	104	Diana Prince	0.00	30	ahorro	0.00500	0.00	0.00
559	115	Diana Prince	0.00	\N	desconocido	0.00000	0.00	0.00
560	144	Bob Johnson	12000.00	35	desconocido	0.00000	0.00	12000.00
561	101	Charlie Green	12000.00	35	desconocido	0.00000	0.00	12000.00
562	134	Charlie Green	12000.00	30	desconocido	0.00000	0.00	12000.00
563	121	Bob Johnson	7000.00	30	desconocido	0.00000	0.00	7000.00
564	114	Steve Rogers	7000.00	100	ahorro	0.00500	35.00	7035.00
565	145	Diana Prince	12000.00	35	prestamo	0.01000	120.00	11880.00
566	147	Steve Rogers	8000.00	30	ahorro	0.00500	40.00	8040.00
567	117	Alice Brown	5000.00	25	desconocido	0.00000	0.00	5000.00
568	131	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
569	115	Bob Johnson	8000.00	45	desconocido	0.00000	0.00	8000.00
570	109	Jane Smith	5000.00	100	desconocido	0.00000	0.00	5000.00
571	126	Alice Brown	8000.00	30	desconocido	0.00000	0.00	8000.00
572	143	Bob Johnson	10000.00	30	ahorro	0.00500	50.00	10050.00
573	114	Diana Prince	0.00	\N	prestamo	0.01000	0.00	0.00
574	139	Steve Rogers	0.00	\N	ahorro	0.00500	0.00	0.00
575	149	Bob Johnson	12000.00	45	desconocido	0.00000	0.00	12000.00
576	119	Steve Rogers	5000.00	\N	desconocido	0.00000	0.00	5000.00
577	104	Steve Rogers	0.00	45	desconocido	0.00000	0.00	0.00
578	128	John Doe	8000.00	\N	prestamo	0.01000	80.00	7920.00
579	120	Steve Rogers	7000.00	30	ahorro	0.00500	35.00	7035.00
580	110	Steve Rogers	10000.00	25	desconocido	0.00000	0.00	10000.00
581	116	John Doe	12000.00	\N	desconocido	0.00000	0.00	12000.00
582	133	Steve Rogers	0.00	\N	ahorro	0.00500	0.00	0.00
583	135	Bob Johnson	7000.00	40	desconocido	0.00000	0.00	7000.00
584	142	Jane Smith	8000.00	40	desconocido	0.00000	0.00	8000.00
585	134	Bob Johnson	10000.00	30	desconocido	0.00000	0.00	10000.00
586	118	Charlie Green	12000.00	\N	prestamo	0.01000	120.00	11880.00
587	134	Alice Brown	0.00	45	desconocido	0.00000	0.00	0.00
588	120	Charlie Green	7000.00	\N	prestamo	0.01000	70.00	6930.00
589	132	Alice Brown	12000.00	\N	ahorro	0.00500	60.00	12060.00
590	126	Alice Brown	5000.00	40	prestamo	0.01000	50.00	4950.00
591	143	Alice Brown	0.00	35	prestamo	0.01000	0.00	0.00
592	104	Steve Rogers	0.00	40	desconocido	0.00000	0.00	0.00
593	141	Jane Smith	0.00	40	prestamo	0.01000	0.00	0.00
594	106	Alice Brown	5000.00	45	desconocido	0.00000	0.00	5000.00
595	105	Steve Rogers	10000.00	35	prestamo	0.01000	100.00	9900.00
596	150	Bob Johnson	12000.00	100	ahorro	0.00500	60.00	12060.00
597	133	Steve Rogers	10000.00	45	prestamo	0.01000	100.00	9900.00
598	149	Charlie Green	12000.00	25	desconocido	0.00000	0.00	12000.00
599	112	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
600	142	Bob Johnson	0.00	100	desconocido	0.00000	0.00	0.00
601	106	Unknown	8000.00	25	desconocido	0.00000	0.00	8000.00
602	131	Steve Rogers	0.00	30	desconocido	0.00000	0.00	0.00
603	102	John Doe	12000.00	\N	desconocido	0.00000	0.00	12000.00
604	105	Alice Brown	8000.00	25	prestamo	0.01000	80.00	7920.00
605	137	Alice Brown	0.00	25	desconocido	0.00000	0.00	0.00
606	143	Unknown	7000.00	\N	ahorro	0.00500	35.00	7035.00
607	141	Jane Smith	8000.00	30	prestamo	0.01000	80.00	7920.00
608	140	Steve Rogers	5000.00	\N	prestamo	0.01000	50.00	4950.00
609	124	Jane Smith	12000.00	45	desconocido	0.00000	0.00	12000.00
610	143	Alice Brown	8000.00	40	ahorro	0.00500	40.00	8040.00
611	110	Alice Brown	5000.00	25	desconocido	0.00000	0.00	5000.00
612	129	Jane Smith	10000.00	25	prestamo	0.01000	100.00	9900.00
613	118	John Doe	12000.00	\N	desconocido	0.00000	0.00	12000.00
614	142	Jane Smith	8000.00	100	desconocido	0.00000	0.00	8000.00
615	114	Diana Prince	5000.00	25	desconocido	0.00000	0.00	5000.00
616	104	Jane Smith	0.00	25	desconocido	0.00000	0.00	0.00
617	130	Steve Rogers	0.00	35	desconocido	0.00000	0.00	0.00
618	139	Alice Brown	12000.00	35	desconocido	0.00000	0.00	12000.00
619	150	Bob Johnson	10000.00	35	desconocido	0.00000	0.00	10000.00
620	120	Jane Smith	0.00	40	ahorro	0.00500	0.00	0.00
621	119	Unknown	5000.00	\N	ahorro	0.00500	25.00	5025.00
622	128	Alice Brown	5000.00	40	desconocido	0.00000	0.00	5000.00
623	146	Charlie Green	7000.00	40	ahorro	0.00500	35.00	7035.00
624	125	John Doe	0.00	40	ahorro	0.00500	0.00	0.00
625	108	Alice Brown	8000.00	35	desconocido	0.00000	0.00	8000.00
626	140	Diana Prince	7000.00	\N	desconocido	0.00000	0.00	7000.00
627	150	Steve Rogers	7000.00	30	desconocido	0.00000	0.00	7000.00
628	138	Unknown	8000.00	\N	prestamo	0.01000	80.00	7920.00
629	113	Diana Prince	8000.00	40	desconocido	0.00000	0.00	8000.00
630	115	Bob Johnson	8000.00	45	desconocido	0.00000	0.00	8000.00
631	139	Jane Smith	0.00	30	desconocido	0.00000	0.00	0.00
632	147	John Doe	8000.00	40	desconocido	0.00000	0.00	8000.00
633	109	John Doe	0.00	30	ahorro	0.00500	0.00	0.00
634	106	Bob Johnson	7000.00	100	desconocido	0.00000	0.00	7000.00
635	140	Bob Johnson	0.00	\N	ahorro	0.00500	0.00	0.00
636	137	Diana Prince	8000.00	\N	desconocido	0.00000	0.00	8000.00
637	133	Steve Rogers	10000.00	25	prestamo	0.01000	100.00	9900.00
638	127	John Doe	8000.00	\N	prestamo	0.01000	80.00	7920.00
639	116	Bob Johnson	12000.00	\N	prestamo	0.01000	120.00	11880.00
640	107	Jane Smith	0.00	\N	desconocido	0.00000	0.00	0.00
641	117	John Doe	0.00	100	ahorro	0.00500	0.00	0.00
642	118	John Doe	0.00	100	desconocido	0.00000	0.00	0.00
643	129	Alice Brown	5000.00	\N	ahorro	0.00500	25.00	5025.00
644	135	Unknown	10000.00	45	ahorro	0.00500	50.00	10050.00
645	116	Charlie Green	12000.00	\N	ahorro	0.00500	60.00	12060.00
646	107	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
647	105	Alice Brown	5000.00	45	desconocido	0.00000	0.00	5000.00
648	120	Jane Smith	7000.00	45	desconocido	0.00000	0.00	7000.00
649	149	John Doe	10000.00	25	ahorro	0.00500	50.00	10050.00
650	137	Steve Rogers	7000.00	35	desconocido	0.00000	0.00	7000.00
651	138	John Doe	7000.00	100	ahorro	0.00500	35.00	7035.00
652	142	Bob Johnson	8000.00	35	desconocido	0.00000	0.00	8000.00
653	136	Alice Brown	0.00	45	desconocido	0.00000	0.00	0.00
654	104	Diana Prince	8000.00	30	desconocido	0.00000	0.00	8000.00
655	138	Charlie Green	7000.00	\N	desconocido	0.00000	0.00	7000.00
656	123	Bob Johnson	12000.00	40	desconocido	0.00000	0.00	12000.00
657	144	Alice Brown	10000.00	45	ahorro	0.00500	50.00	10050.00
658	149	Alice Brown	10000.00	\N	prestamo	0.01000	100.00	9900.00
659	148	Bob Johnson	7000.00	30	ahorro	0.00500	35.00	7035.00
660	109	Diana Prince	0.00	30	ahorro	0.00500	0.00	0.00
661	116	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
662	119	John Doe	8000.00	100	desconocido	0.00000	0.00	8000.00
663	139	John Doe	10000.00	35	ahorro	0.00500	50.00	10050.00
664	107	Steve Rogers	10000.00	25	prestamo	0.01000	100.00	9900.00
665	113	John Doe	8000.00	45	prestamo	0.01000	80.00	7920.00
666	114	Alice Brown	5000.00	\N	ahorro	0.00500	25.00	5025.00
667	127	Alice Brown	0.00	\N	desconocido	0.00000	0.00	0.00
668	116	John Doe	10000.00	\N	desconocido	0.00000	0.00	10000.00
669	142	Bob Johnson	7000.00	25	ahorro	0.00500	35.00	7035.00
670	135	John Doe	12000.00	40	prestamo	0.01000	120.00	11880.00
671	125	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
672	106	Charlie Green	8000.00	25	prestamo	0.01000	80.00	7920.00
673	121	Alice Brown	8000.00	45	ahorro	0.00500	40.00	8040.00
674	138	John Doe	10000.00	30	desconocido	0.00000	0.00	10000.00
675	150	Charlie Green	12000.00	40	prestamo	0.01000	120.00	11880.00
676	140	Jane Smith	7000.00	25	prestamo	0.01000	70.00	6930.00
677	148	Diana Prince	10000.00	25	prestamo	0.01000	100.00	9900.00
678	148	Steve Rogers	0.00	\N	prestamo	0.01000	0.00	0.00
679	141	Bob Johnson	10000.00	100	ahorro	0.00500	50.00	10050.00
680	105	John Doe	0.00	35	ahorro	0.00500	0.00	0.00
681	105	Diana Prince	0.00	100	prestamo	0.01000	0.00	0.00
682	103	Unknown	7000.00	40	desconocido	0.00000	0.00	7000.00
683	148	Steve Rogers	5000.00	\N	desconocido	0.00000	0.00	5000.00
684	109	Diana Prince	7000.00	25	desconocido	0.00000	0.00	7000.00
685	111	Alice Brown	5000.00	45	prestamo	0.01000	50.00	4950.00
686	113	Bob Johnson	5000.00	35	prestamo	0.01000	50.00	4950.00
687	142	Jane Smith	10000.00	25	prestamo	0.01000	100.00	9900.00
688	148	Steve Rogers	7000.00	\N	ahorro	0.00500	35.00	7035.00
689	144	Jane Smith	7000.00	25	desconocido	0.00000	0.00	7000.00
690	103	Bob Johnson	0.00	100	desconocido	0.00000	0.00	0.00
691	114	Alice Brown	8000.00	\N	prestamo	0.01000	80.00	7920.00
692	129	Steve Rogers	5000.00	\N	prestamo	0.01000	50.00	4950.00
693	123	Steve Rogers	12000.00	\N	desconocido	0.00000	0.00	12000.00
694	107	Jane Smith	10000.00	\N	prestamo	0.01000	100.00	9900.00
695	134	Steve Rogers	0.00	35	desconocido	0.00000	0.00	0.00
696	113	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
697	116	Steve Rogers	7000.00	40	desconocido	0.00000	0.00	7000.00
698	127	Diana Prince	5000.00	100	ahorro	0.00500	25.00	5025.00
699	125	Diana Prince	0.00	\N	prestamo	0.01000	0.00	0.00
700	129	Unknown	10000.00	35	prestamo	0.01000	100.00	9900.00
701	105	Jane Smith	12000.00	45	desconocido	0.00000	0.00	12000.00
702	114	Alice Brown	7000.00	35	ahorro	0.00500	35.00	7035.00
703	145	Diana Prince	7000.00	45	prestamo	0.01000	70.00	6930.00
704	106	Bob Johnson	5000.00	35	desconocido	0.00000	0.00	5000.00
705	121	John Doe	12000.00	45	desconocido	0.00000	0.00	12000.00
706	134	Steve Rogers	8000.00	\N	desconocido	0.00000	0.00	8000.00
707	131	Bob Johnson	10000.00	\N	prestamo	0.01000	100.00	9900.00
708	131	John Doe	10000.00	100	desconocido	0.00000	0.00	10000.00
709	129	Alice Brown	0.00	30	prestamo	0.01000	0.00	0.00
710	111	Steve Rogers	10000.00	30	ahorro	0.00500	50.00	10050.00
711	139	Jane Smith	8000.00	45	desconocido	0.00000	0.00	8000.00
712	125	Jane Smith	5000.00	\N	ahorro	0.00500	25.00	5025.00
713	124	Diana Prince	10000.00	45	desconocido	0.00000	0.00	10000.00
714	119	Unknown	5000.00	40	prestamo	0.01000	50.00	4950.00
715	144	John Doe	0.00	25	desconocido	0.00000	0.00	0.00
716	146	Bob Johnson	5000.00	40	desconocido	0.00000	0.00	5000.00
717	114	Alice Brown	7000.00	25	desconocido	0.00000	0.00	7000.00
718	113	Bob Johnson	12000.00	\N	desconocido	0.00000	0.00	12000.00
719	127	Charlie Green	7000.00	\N	desconocido	0.00000	0.00	7000.00
720	124	John Doe	12000.00	\N	desconocido	0.00000	0.00	12000.00
721	139	Jane Smith	10000.00	\N	desconocido	0.00000	0.00	10000.00
722	108	Steve Rogers	5000.00	30	desconocido	0.00000	0.00	5000.00
723	136	John Doe	8000.00	35	desconocido	0.00000	0.00	8000.00
724	129	Steve Rogers	10000.00	45	desconocido	0.00000	0.00	10000.00
725	123	John Doe	7000.00	40	desconocido	0.00000	0.00	7000.00
726	103	John Doe	7000.00	\N	ahorro	0.00500	35.00	7035.00
727	140	Bob Johnson	0.00	40	desconocido	0.00000	0.00	0.00
728	129	John Doe	0.00	40	prestamo	0.01000	0.00	0.00
729	102	Charlie Green	10000.00	35	prestamo	0.01000	100.00	9900.00
730	142	Charlie Green	12000.00	\N	desconocido	0.00000	0.00	12000.00
731	110	Bob Johnson	5000.00	45	desconocido	0.00000	0.00	5000.00
732	149	Bob Johnson	8000.00	25	desconocido	0.00000	0.00	8000.00
733	142	Alice Brown	12000.00	\N	desconocido	0.00000	0.00	12000.00
734	130	Unknown	12000.00	100	ahorro	0.00500	60.00	12060.00
735	111	Steve Rogers	0.00	\N	desconocido	0.00000	0.00	0.00
736	107	John Doe	0.00	35	desconocido	0.00000	0.00	0.00
737	144	John Doe	10000.00	\N	desconocido	0.00000	0.00	10000.00
738	142	Alice Brown	10000.00	25	ahorro	0.00500	50.00	10050.00
739	111	John Doe	0.00	45	prestamo	0.01000	0.00	0.00
740	105	Alice Brown	10000.00	25	prestamo	0.01000	100.00	9900.00
741	125	Alice Brown	10000.00	100	ahorro	0.00500	50.00	10050.00
742	125	Diana Prince	5000.00	35	prestamo	0.01000	50.00	4950.00
743	122	Charlie Green	8000.00	25	desconocido	0.00000	0.00	8000.00
744	137	Diana Prince	0.00	100	prestamo	0.01000	0.00	0.00
745	123	John Doe	7000.00	25	prestamo	0.01000	70.00	6930.00
746	138	Steve Rogers	0.00	40	prestamo	0.01000	0.00	0.00
747	137	Alice Brown	7000.00	40	ahorro	0.00500	35.00	7035.00
748	123	Unknown	10000.00	100	ahorro	0.00500	50.00	10050.00
749	122	Alice Brown	5000.00	\N	ahorro	0.00500	25.00	5025.00
750	139	Charlie Green	0.00	25	desconocido	0.00000	0.00	0.00
751	110	Diana Prince	8000.00	40	desconocido	0.00000	0.00	8000.00
752	137	Jane Smith	8000.00	100	ahorro	0.00500	40.00	8040.00
753	139	Charlie Green	7000.00	\N	prestamo	0.01000	70.00	6930.00
754	132	Charlie Green	5000.00	100	ahorro	0.00500	25.00	5025.00
755	143	Steve Rogers	8000.00	40	prestamo	0.01000	80.00	7920.00
756	144	Alice Brown	7000.00	\N	prestamo	0.01000	70.00	6930.00
757	148	Alice Brown	8000.00	100	desconocido	0.00000	0.00	8000.00
758	106	Diana Prince	7000.00	30	desconocido	0.00000	0.00	7000.00
759	137	Charlie Green	5000.00	40	desconocido	0.00000	0.00	5000.00
760	106	Charlie Green	0.00	35	desconocido	0.00000	0.00	0.00
761	118	Jane Smith	12000.00	35	ahorro	0.00500	60.00	12060.00
762	107	Jane Smith	0.00	40	prestamo	0.01000	0.00	0.00
763	143	Bob Johnson	12000.00	45	desconocido	0.00000	0.00	12000.00
764	140	Diana Prince	5000.00	100	prestamo	0.01000	50.00	4950.00
765	114	Bob Johnson	7000.00	\N	ahorro	0.00500	35.00	7035.00
766	109	Diana Prince	7000.00	25	desconocido	0.00000	0.00	7000.00
767	132	Unknown	5000.00	35	desconocido	0.00000	0.00	5000.00
768	110	Steve Rogers	0.00	25	desconocido	0.00000	0.00	0.00
769	139	Diana Prince	12000.00	100	desconocido	0.00000	0.00	12000.00
770	150	Diana Prince	8000.00	\N	desconocido	0.00000	0.00	8000.00
771	102	Charlie Green	0.00	30	ahorro	0.00500	0.00	0.00
772	145	Steve Rogers	12000.00	30	ahorro	0.00500	60.00	12060.00
773	107	Jane Smith	0.00	100	desconocido	0.00000	0.00	0.00
774	144	Charlie Green	8000.00	25	desconocido	0.00000	0.00	8000.00
775	116	Steve Rogers	0.00	40	desconocido	0.00000	0.00	0.00
776	135	Bob Johnson	0.00	40	desconocido	0.00000	0.00	0.00
777	139	Charlie Green	10000.00	\N	desconocido	0.00000	0.00	10000.00
778	138	Bob Johnson	8000.00	\N	desconocido	0.00000	0.00	8000.00
779	142	Unknown	7000.00	45	desconocido	0.00000	0.00	7000.00
780	123	Jane Smith	8000.00	40	desconocido	0.00000	0.00	8000.00
781	127	Jane Smith	8000.00	100	ahorro	0.00500	40.00	8040.00
782	145	Bob Johnson	12000.00	25	desconocido	0.00000	0.00	12000.00
783	128	Jane Smith	0.00	45	desconocido	0.00000	0.00	0.00
784	133	John Doe	12000.00	\N	prestamo	0.01000	120.00	11880.00
785	145	Jane Smith	7000.00	100	desconocido	0.00000	0.00	7000.00
786	145	Charlie Green	10000.00	30	desconocido	0.00000	0.00	10000.00
787	124	Steve Rogers	10000.00	100	desconocido	0.00000	0.00	10000.00
788	140	Charlie Green	0.00	35	desconocido	0.00000	0.00	0.00
789	114	Bob Johnson	0.00	\N	prestamo	0.01000	0.00	0.00
790	101	Bob Johnson	8000.00	\N	ahorro	0.00500	40.00	8040.00
791	128	Jane Smith	8000.00	25	desconocido	0.00000	0.00	8000.00
792	128	Diana Prince	8000.00	40	ahorro	0.00500	40.00	8040.00
793	111	Jane Smith	7000.00	\N	ahorro	0.00500	35.00	7035.00
794	145	Steve Rogers	12000.00	100	ahorro	0.00500	60.00	12060.00
795	114	Steve Rogers	5000.00	\N	desconocido	0.00000	0.00	5000.00
796	119	John Doe	12000.00	35	desconocido	0.00000	0.00	12000.00
797	101	Bob Johnson	12000.00	100	desconocido	0.00000	0.00	12000.00
798	107	Unknown	10000.00	30	desconocido	0.00000	0.00	10000.00
799	105	Steve Rogers	0.00	35	desconocido	0.00000	0.00	0.00
800	104	John Doe	0.00	45	ahorro	0.00500	0.00	0.00
801	122	Bob Johnson	10000.00	\N	ahorro	0.00500	50.00	10050.00
802	128	Steve Rogers	8000.00	100	ahorro	0.00500	40.00	8040.00
803	117	Jane Smith	0.00	25	desconocido	0.00000	0.00	0.00
804	135	Alice Brown	8000.00	100	ahorro	0.00500	40.00	8040.00
805	149	Alice Brown	0.00	35	ahorro	0.00500	0.00	0.00
806	121	Jane Smith	12000.00	40	desconocido	0.00000	0.00	12000.00
807	125	Bob Johnson	10000.00	30	desconocido	0.00000	0.00	10000.00
808	126	John Doe	10000.00	100	prestamo	0.01000	100.00	9900.00
809	138	Bob Johnson	0.00	35	prestamo	0.01000	0.00	0.00
810	149	Bob Johnson	5000.00	45	ahorro	0.00500	25.00	5025.00
811	134	Diana Prince	12000.00	40	prestamo	0.01000	120.00	11880.00
812	102	Jane Smith	12000.00	\N	desconocido	0.00000	0.00	12000.00
813	120	Diana Prince	12000.00	45	desconocido	0.00000	0.00	12000.00
814	101	Bob Johnson	10000.00	35	desconocido	0.00000	0.00	10000.00
815	121	Alice Brown	5000.00	\N	desconocido	0.00000	0.00	5000.00
816	127	Bob Johnson	0.00	\N	prestamo	0.01000	0.00	0.00
817	140	Charlie Green	8000.00	30	prestamo	0.01000	80.00	7920.00
818	122	Unknown	10000.00	30	ahorro	0.00500	50.00	10050.00
819	136	John Doe	10000.00	35	prestamo	0.01000	100.00	9900.00
820	102	Alice Brown	5000.00	35	desconocido	0.00000	0.00	5000.00
821	117	Unknown	5000.00	45	ahorro	0.00500	25.00	5025.00
822	128	Unknown	10000.00	30	prestamo	0.01000	100.00	9900.00
823	123	Alice Brown	7000.00	35	ahorro	0.00500	35.00	7035.00
824	108	John Doe	0.00	\N	desconocido	0.00000	0.00	0.00
825	134	John Doe	5000.00	45	desconocido	0.00000	0.00	5000.00
826	105	Alice Brown	0.00	30	ahorro	0.00500	0.00	0.00
827	138	Diana Prince	10000.00	30	desconocido	0.00000	0.00	10000.00
828	113	Bob Johnson	5000.00	100	desconocido	0.00000	0.00	5000.00
829	134	Steve Rogers	5000.00	\N	prestamo	0.01000	50.00	4950.00
830	147	Steve Rogers	10000.00	\N	desconocido	0.00000	0.00	10000.00
831	149	Steve Rogers	7000.00	25	ahorro	0.00500	35.00	7035.00
832	124	Unknown	12000.00	35	desconocido	0.00000	0.00	12000.00
833	149	Alice Brown	10000.00	100	prestamo	0.01000	100.00	9900.00
834	106	Unknown	8000.00	25	ahorro	0.00500	40.00	8040.00
835	131	Charlie Green	0.00	25	ahorro	0.00500	0.00	0.00
836	111	Alice Brown	8000.00	\N	desconocido	0.00000	0.00	8000.00
837	129	Steve Rogers	5000.00	35	prestamo	0.01000	50.00	4950.00
838	121	Charlie Green	0.00	45	prestamo	0.01000	0.00	0.00
839	113	Diana Prince	5000.00	35	ahorro	0.00500	25.00	5025.00
840	135	Diana Prince	8000.00	40	prestamo	0.01000	80.00	7920.00
841	129	Steve Rogers	10000.00	\N	prestamo	0.01000	100.00	9900.00
842	116	John Doe	7000.00	30	desconocido	0.00000	0.00	7000.00
843	147	Diana Prince	8000.00	45	desconocido	0.00000	0.00	8000.00
844	106	Diana Prince	10000.00	35	ahorro	0.00500	50.00	10050.00
845	122	Diana Prince	10000.00	35	ahorro	0.00500	50.00	10050.00
846	106	John Doe	5000.00	25	desconocido	0.00000	0.00	5000.00
847	114	Diana Prince	12000.00	40	desconocido	0.00000	0.00	12000.00
848	133	Jane Smith	12000.00	25	prestamo	0.01000	120.00	11880.00
849	102	Diana Prince	12000.00	30	desconocido	0.00000	0.00	12000.00
850	108	Diana Prince	5000.00	25	desconocido	0.00000	0.00	5000.00
851	120	Steve Rogers	5000.00	40	desconocido	0.00000	0.00	5000.00
852	104	John Doe	7000.00	100	prestamo	0.01000	70.00	6930.00
853	107	Steve Rogers	5000.00	25	desconocido	0.00000	0.00	5000.00
854	117	Bob Johnson	5000.00	100	prestamo	0.01000	50.00	4950.00
855	141	Jane Smith	12000.00	100	prestamo	0.01000	120.00	11880.00
856	115	Alice Brown	12000.00	\N	prestamo	0.01000	120.00	11880.00
857	103	Bob Johnson	7000.00	30	ahorro	0.00500	35.00	7035.00
858	107	Diana Prince	8000.00	25	desconocido	0.00000	0.00	8000.00
859	113	Steve Rogers	8000.00	25	desconocido	0.00000	0.00	8000.00
860	101	Bob Johnson	0.00	100	prestamo	0.01000	0.00	0.00
861	138	Charlie Green	12000.00	\N	desconocido	0.00000	0.00	12000.00
862	128	Diana Prince	7000.00	35	prestamo	0.01000	70.00	6930.00
863	146	Steve Rogers	10000.00	\N	desconocido	0.00000	0.00	10000.00
864	109	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
865	108	John Doe	8000.00	25	prestamo	0.01000	80.00	7920.00
866	135	Jane Smith	12000.00	30	desconocido	0.00000	0.00	12000.00
867	108	Jane Smith	5000.00	35	prestamo	0.01000	50.00	4950.00
868	142	Bob Johnson	0.00	100	prestamo	0.01000	0.00	0.00
869	102	Steve Rogers	7000.00	40	desconocido	0.00000	0.00	7000.00
870	110	Steve Rogers	7000.00	30	ahorro	0.00500	35.00	7035.00
871	110	Unknown	10000.00	\N	desconocido	0.00000	0.00	10000.00
872	114	Unknown	8000.00	35	ahorro	0.00500	40.00	8040.00
873	132	John Doe	12000.00	45	prestamo	0.01000	120.00	11880.00
874	145	Diana Prince	8000.00	100	desconocido	0.00000	0.00	8000.00
875	108	Diana Prince	7000.00	30	desconocido	0.00000	0.00	7000.00
876	104	Bob Johnson	10000.00	25	prestamo	0.01000	100.00	9900.00
877	111	Charlie Green	10000.00	100	desconocido	0.00000	0.00	10000.00
878	125	John Doe	7000.00	25	prestamo	0.01000	70.00	6930.00
879	136	Alice Brown	8000.00	35	desconocido	0.00000	0.00	8000.00
880	147	Bob Johnson	5000.00	\N	desconocido	0.00000	0.00	5000.00
881	116	Steve Rogers	10000.00	100	desconocido	0.00000	0.00	10000.00
882	106	Alice Brown	8000.00	40	prestamo	0.01000	80.00	7920.00
883	111	Jane Smith	0.00	\N	prestamo	0.01000	0.00	0.00
884	143	Jane Smith	10000.00	40	desconocido	0.00000	0.00	10000.00
885	123	Diana Prince	0.00	25	ahorro	0.00500	0.00	0.00
886	127	Steve Rogers	12000.00	25	desconocido	0.00000	0.00	12000.00
887	137	Diana Prince	10000.00	\N	desconocido	0.00000	0.00	10000.00
888	121	John Doe	7000.00	25	desconocido	0.00000	0.00	7000.00
889	106	Steve Rogers	0.00	35	ahorro	0.00500	0.00	0.00
890	146	Diana Prince	10000.00	30	desconocido	0.00000	0.00	10000.00
891	105	John Doe	0.00	30	desconocido	0.00000	0.00	0.00
892	109	John Doe	7000.00	40	prestamo	0.01000	70.00	6930.00
893	142	Alice Brown	8000.00	25	desconocido	0.00000	0.00	8000.00
894	114	Jane Smith	0.00	\N	desconocido	0.00000	0.00	0.00
895	126	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
896	113	Diana Prince	5000.00	25	desconocido	0.00000	0.00	5000.00
897	118	Steve Rogers	0.00	45	ahorro	0.00500	0.00	0.00
898	119	Jane Smith	0.00	35	prestamo	0.01000	0.00	0.00
899	138	Steve Rogers	5000.00	\N	desconocido	0.00000	0.00	5000.00
900	135	Alice Brown	0.00	45	prestamo	0.01000	0.00	0.00
901	112	Steve Rogers	0.00	40	prestamo	0.01000	0.00	0.00
902	115	John Doe	8000.00	100	desconocido	0.00000	0.00	8000.00
903	125	Bob Johnson	7000.00	\N	prestamo	0.01000	70.00	6930.00
904	131	Bob Johnson	10000.00	\N	desconocido	0.00000	0.00	10000.00
905	122	John Doe	12000.00	100	desconocido	0.00000	0.00	12000.00
906	130	Steve Rogers	5000.00	30	ahorro	0.00500	25.00	5025.00
907	126	John Doe	10000.00	\N	desconocido	0.00000	0.00	10000.00
908	106	John Doe	12000.00	35	prestamo	0.01000	120.00	11880.00
909	139	Alice Brown	7000.00	35	desconocido	0.00000	0.00	7000.00
910	136	Bob Johnson	0.00	\N	desconocido	0.00000	0.00	0.00
911	136	Steve Rogers	0.00	40	desconocido	0.00000	0.00	0.00
912	122	Bob Johnson	10000.00	40	ahorro	0.00500	50.00	10050.00
913	101	Jane Smith	10000.00	30	desconocido	0.00000	0.00	10000.00
914	147	Steve Rogers	12000.00	\N	desconocido	0.00000	0.00	12000.00
915	128	John Doe	5000.00	30	prestamo	0.01000	50.00	4950.00
916	142	Charlie Green	7000.00	\N	prestamo	0.01000	70.00	6930.00
917	143	Jane Smith	10000.00	25	desconocido	0.00000	0.00	10000.00
918	119	John Doe	5000.00	35	prestamo	0.01000	50.00	4950.00
919	111	John Doe	12000.00	100	desconocido	0.00000	0.00	12000.00
920	108	Alice Brown	5000.00	45	ahorro	0.00500	25.00	5025.00
921	121	Alice Brown	8000.00	30	desconocido	0.00000	0.00	8000.00
922	107	John Doe	0.00	45	desconocido	0.00000	0.00	0.00
923	125	Alice Brown	0.00	30	prestamo	0.01000	0.00	0.00
924	124	Jane Smith	10000.00	45	prestamo	0.01000	100.00	9900.00
925	123	Diana Prince	10000.00	25	ahorro	0.00500	50.00	10050.00
926	116	Diana Prince	10000.00	25	desconocido	0.00000	0.00	10000.00
927	146	Unknown	12000.00	25	desconocido	0.00000	0.00	12000.00
928	122	Jane Smith	0.00	35	desconocido	0.00000	0.00	0.00
929	101	Jane Smith	12000.00	40	desconocido	0.00000	0.00	12000.00
930	103	Bob Johnson	7000.00	\N	prestamo	0.01000	70.00	6930.00
931	111	John Doe	12000.00	100	prestamo	0.01000	120.00	11880.00
932	121	Bob Johnson	0.00	100	prestamo	0.01000	0.00	0.00
933	115	Alice Brown	8000.00	40	desconocido	0.00000	0.00	8000.00
934	135	Bob Johnson	10000.00	30	prestamo	0.01000	100.00	9900.00
935	114	Diana Prince	8000.00	30	desconocido	0.00000	0.00	8000.00
936	149	Steve Rogers	8000.00	25	prestamo	0.01000	80.00	7920.00
937	108	Diana Prince	10000.00	35	ahorro	0.00500	50.00	10050.00
938	141	Steve Rogers	0.00	40	desconocido	0.00000	0.00	0.00
939	129	Steve Rogers	7000.00	30	desconocido	0.00000	0.00	7000.00
940	108	Jane Smith	8000.00	25	desconocido	0.00000	0.00	8000.00
941	115	Charlie Green	5000.00	35	prestamo	0.01000	50.00	4950.00
942	142	Diana Prince	8000.00	\N	prestamo	0.01000	80.00	7920.00
943	150	Bob Johnson	8000.00	25	desconocido	0.00000	0.00	8000.00
944	113	Jane Smith	8000.00	45	desconocido	0.00000	0.00	8000.00
945	101	Bob Johnson	12000.00	30	desconocido	0.00000	0.00	12000.00
946	105	Alice Brown	8000.00	35	desconocido	0.00000	0.00	8000.00
947	127	Charlie Green	8000.00	100	desconocido	0.00000	0.00	8000.00
948	149	Bob Johnson	10000.00	25	desconocido	0.00000	0.00	10000.00
949	134	Diana Prince	0.00	45	desconocido	0.00000	0.00	0.00
950	110	Charlie Green	10000.00	25	prestamo	0.01000	100.00	9900.00
951	148	Charlie Green	12000.00	100	ahorro	0.00500	60.00	12060.00
952	115	Bob Johnson	0.00	30	prestamo	0.01000	0.00	0.00
953	135	John Doe	10000.00	100	desconocido	0.00000	0.00	10000.00
954	140	John Doe	7000.00	30	prestamo	0.01000	70.00	6930.00
955	113	Jane Smith	8000.00	35	desconocido	0.00000	0.00	8000.00
956	108	Jane Smith	0.00	35	ahorro	0.00500	0.00	0.00
957	130	Steve Rogers	12000.00	45	desconocido	0.00000	0.00	12000.00
958	122	Alice Brown	5000.00	30	ahorro	0.00500	25.00	5025.00
959	144	John Doe	7000.00	45	ahorro	0.00500	35.00	7035.00
960	132	Unknown	5000.00	\N	desconocido	0.00000	0.00	5000.00
961	108	Charlie Green	8000.00	\N	prestamo	0.01000	80.00	7920.00
962	132	Bob Johnson	5000.00	25	ahorro	0.00500	25.00	5025.00
963	130	John Doe	12000.00	30	desconocido	0.00000	0.00	12000.00
964	104	Bob Johnson	0.00	\N	prestamo	0.01000	0.00	0.00
965	102	Alice Brown	12000.00	30	desconocido	0.00000	0.00	12000.00
966	129	Bob Johnson	7000.00	\N	ahorro	0.00500	35.00	7035.00
967	141	Alice Brown	8000.00	25	prestamo	0.01000	80.00	7920.00
968	128	John Doe	12000.00	40	ahorro	0.00500	60.00	12060.00
969	122	Steve Rogers	10000.00	40	ahorro	0.00500	50.00	10050.00
970	123	Charlie Green	0.00	\N	prestamo	0.01000	0.00	0.00
971	104	Steve Rogers	5000.00	25	desconocido	0.00000	0.00	5000.00
972	107	Diana Prince	5000.00	45	desconocido	0.00000	0.00	5000.00
973	128	Diana Prince	8000.00	35	ahorro	0.00500	40.00	8040.00
974	113	Alice Brown	8000.00	35	desconocido	0.00000	0.00	8000.00
975	117	Alice Brown	0.00	45	desconocido	0.00000	0.00	0.00
976	129	Jane Smith	0.00	30	desconocido	0.00000	0.00	0.00
977	133	John Doe	7000.00	\N	desconocido	0.00000	0.00	7000.00
978	113	Jane Smith	0.00	25	prestamo	0.01000	0.00	0.00
979	104	Alice Brown	7000.00	45	desconocido	0.00000	0.00	7000.00
980	123	Alice Brown	0.00	25	desconocido	0.00000	0.00	0.00
981	109	Alice Brown	12000.00	40	desconocido	0.00000	0.00	12000.00
982	129	Alice Brown	5000.00	45	ahorro	0.00500	25.00	5025.00
983	146	Charlie Green	12000.00	100	desconocido	0.00000	0.00	12000.00
984	141	Bob Johnson	5000.00	40	prestamo	0.01000	50.00	4950.00
985	127	Diana Prince	8000.00	35	desconocido	0.00000	0.00	8000.00
986	116	Diana Prince	7000.00	100	ahorro	0.00500	35.00	7035.00
987	126	Charlie Green	7000.00	100	desconocido	0.00000	0.00	7000.00
988	135	Alice Brown	7000.00	\N	desconocido	0.00000	0.00	7000.00
989	111	John Doe	10000.00	35	desconocido	0.00000	0.00	10000.00
990	119	John Doe	10000.00	100	desconocido	0.00000	0.00	10000.00
991	123	Bob Johnson	5000.00	45	ahorro	0.00500	25.00	5025.00
992	129	Unknown	7000.00	35	desconocido	0.00000	0.00	7000.00
993	105	Steve Rogers	10000.00	35	ahorro	0.00500	50.00	10050.00
994	116	Alice Brown	10000.00	30	desconocido	0.00000	0.00	10000.00
995	101	Charlie Green	8000.00	100	prestamo	0.01000	80.00	7920.00
996	117	Diana Prince	12000.00	30	prestamo	0.01000	120.00	11880.00
997	106	John Doe	5000.00	35	ahorro	0.00500	25.00	5025.00
998	139	Charlie Green	0.00	25	desconocido	0.00000	0.00	0.00
999	114	Steve Rogers	0.00	100	prestamo	0.01000	0.00	0.00
1000	134	Bob Johnson	10000.00	35	desconocido	0.00000	0.00	10000.00
\.


--
-- Data for Name: resumen_transacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumen_transacciones (id, fecha, total_transacciones, total_creditos, total_debitos, cantidad_anomalias) FROM stdin;
\.


--
-- Data for Name: transacciones_procesadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transacciones_procesadas (id, transaccion_id, fecha, monto, tipo, es_anomalia, motivo_anomalia) FROM stdin;
1	1	2024-06-30	3000.00	credito	f	\N
2	2	2024-04-03	1200.00	credito	f	\N
3	3	2024-04-09	800.00	invalid	t	Tipo de transacción no válido: invalid
4	4	2024-05-04	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
5	5	2024-06-17	800.00	debito	f	\N
6	6	2024-11-11	1500.00	credito	f	\N
7	7	\N	700.00	debito	t	Formato de fecha inválido: 2024-13-01
8	8	2024-07-30	3000.00	debito	f	\N
9	9	2024-04-07	3000.00	invalid	t	Tipo de transacción no válido: invalid
10	10	2024-10-15	1500.00	invalid	t	Tipo de transacción no válido: invalid
11	11	2024-10-05	1200.00	debito	f	\N
12	12	2024-07-20	1200.00	debito	f	\N
13	13	2024-04-13	3000.00	credito	f	\N
14	14	2024-07-17	500.00	debito	f	\N
15	15	2024-06-01	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
16	16	2024-04-27	1000.00	invalid	t	Tipo de transacción no válido: invalid
17	17	2024-12-18	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
18	18	2024-11-30	-100.00	credito	t	Monto negativo
19	19	2024-08-16	800.00	credito	f	\N
20	20	2024-07-28	3000.00	debito	f	\N
21	21	2024-06-12	700.00	credito	f	\N
22	22	2024-06-05	1000.00	invalid	t	Tipo de transacción no válido: invalid
23	23	\N	1000.00	credito	t	Formato de fecha inválido: 2024-13-01
24	24	2024-02-18	0.00	credito	t	Monto igual a cero
25	25	2024-11-09	\N	debito	t	Monto vacío
26	26	2024-05-19	1200.00	debito	f	\N
27	27	2024-12-11	1200.00	credito	f	\N
28	28	2024-09-03	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
29	29	2024-05-27	\N	debito	t	Monto vacío
30	30	2024-02-09	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
31	31	2024-04-11	800.00	invalid	t	Tipo de transacción no válido: invalid
32	32	2024-01-01	1500.00	invalid	t	Tipo de transacción no válido: invalid
33	33	2024-12-30	1500.00	credito	f	\N
34	34	2024-11-13	-200.00	credito	t	Monto negativo
35	35	2024-12-12	-100.00	credito	t	Monto negativo
36	36	2024-07-25	1500.00	credito	f	\N
37	37	2024-08-20	800.00	credito	f	\N
38	38	2024-02-15	1500.00	debito	f	\N
39	39	2024-11-18	1200.00	invalid	t	Tipo de transacción no válido: invalid
40	40	\N	3000.00	credito	t	Formato de fecha inválido: 2024-13-01
41	41	2024-08-01	800.00	credito	f	\N
42	42	2024-07-29	500.00	credito	f	\N
43	43	2024-12-06	-100.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
44	44	2024-07-11	1000.00	credito	f	\N
45	45	2024-08-23	\N	credito	t	Monto vacío
46	46	2024-06-29	1200.00	debito	f	\N
47	47	2024-11-30	1200.00	invalid	t	Tipo de transacción no válido: invalid
48	48	2024-08-09	1500.00	credito	f	\N
49	49	2024-10-26	3000.00	debito	f	\N
50	50	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
51	51	2024-07-02	-200.00	credito	t	Monto negativo
52	52	2024-03-16	1000.00	invalid	t	Tipo de transacción no válido: invalid
53	53	2024-07-02	\N	debito	t	Monto vacío
54	54	2024-02-21	800.00	desconocido	t	Tipo de transacción no válido: desconocido
55	55	2024-01-27	3000.00	credito	f	\N
56	56	2024-09-06	1000.00	debito	f	\N
57	57	2024-07-27	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
58	58	2024-02-27	1000.00	credito	f	\N
59	59	2024-02-08	800.00	credito	f	\N
60	60	2024-04-04	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
61	61	2024-01-09	3000.00	debito	f	\N
62	62	2024-06-09	1000.00	credito	f	\N
63	63	2024-08-14	700.00	credito	f	\N
64	64	2024-03-13	1000.00	credito	f	\N
65	65	2024-10-16	\N	debito	t	Monto vacío
66	66	2024-05-28	1500.00	invalid	t	Tipo de transacción no válido: invalid
67	67	2024-11-10	800.00	credito	f	\N
68	68	2024-01-11	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
69	69	2024-09-29	1500.00	invalid	t	Tipo de transacción no válido: invalid
70	70	2024-09-18	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
71	71	2024-07-31	700.00	debito	f	\N
72	72	2024-03-01	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
73	73	2024-07-29	1000.00	credito	f	\N
74	74	2024-07-30	1000.00	invalid	t	Tipo de transacción no válido: invalid
75	75	2024-01-28	1500.00	debito	f	\N
76	76	2024-11-16	-200.00	credito	t	Monto negativo
77	77	\N	3000.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
78	78	2024-11-25	-200.00	credito	t	Monto negativo
79	79	2024-06-02	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
80	80	2024-04-16	1200.00	invalid	t	Tipo de transacción no válido: invalid
81	81	2024-06-18	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
82	82	2024-09-13	700.00	credito	f	\N
83	83	2024-05-10	800.00	credito	f	\N
84	84	2024-09-17	3000.00	debito	f	\N
85	85	2024-03-16	1000.00	debito	f	\N
86	86	2024-11-04	1500.00	invalid	t	Tipo de transacción no válido: invalid
87	87	2024-10-22	1200.00	invalid	t	Tipo de transacción no válido: invalid
88	88	2024-04-24	3000.00	credito	f	\N
89	89	2024-07-27	800.00	debito	f	\N
90	90	2024-07-28	700.00	invalid	t	Tipo de transacción no válido: invalid
91	91	2024-01-01	800.00	credito	f	\N
92	92	2024-01-27	1200.00	debito	f	\N
93	93	2024-11-07	3000.00	debito	f	\N
94	94	2024-08-01	-200.00	credito	t	Monto negativo
95	95	2024-12-22	1000.00	credito	f	\N
96	96	2024-12-18	800.00	credito	f	\N
97	97	2024-08-17	500.00	debito	f	\N
98	98	2024-07-05	1200.00	invalid	t	Tipo de transacción no válido: invalid
99	99	2024-03-09	-200.00	credito	t	Monto negativo
100	100	2024-06-15	\N	debito	t	Monto vacío
101	101	2024-05-12	800.00	debito	f	\N
102	102	2024-11-13	-200.00	debito	t	Monto negativo
103	103	2024-04-02	1500.00	credito	f	\N
104	104	2024-04-16	1000.00	credito	f	\N
105	105	2024-12-13	3000.00	invalid	t	Tipo de transacción no válido: invalid
106	106	2024-01-21	1000.00	credito	f	\N
107	107	2024-01-16	700.00	invalid	t	Tipo de transacción no válido: invalid
108	108	2024-02-28	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
109	109	2024-09-15	1200.00	invalid	t	Tipo de transacción no válido: invalid
110	110	2024-07-05	800.00	debito	f	\N
111	111	2024-09-25	1000.00	credito	f	\N
112	112	2024-03-07	800.00	credito	f	\N
113	113	2024-07-21	1500.00	credito	f	\N
114	114	2024-02-01	700.00	invalid	t	Tipo de transacción no válido: invalid
115	115	2024-07-20	700.00	debito	f	\N
116	116	2024-10-03	1500.00	invalid	t	Tipo de transacción no válido: invalid
117	117	2024-11-10	700.00	credito	f	\N
118	118	2024-08-27	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
119	119	2024-12-06	\N	debito	t	Monto vacío
120	120	2024-09-21	-200.00	credito	t	Monto negativo
121	121	2024-08-19	700.00	debito	f	\N
122	122	2024-08-26	800.00	invalid	t	Tipo de transacción no válido: invalid
123	123	2024-05-27	3000.00	debito	f	\N
124	124	2024-08-22	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
125	125	2024-01-29	-200.00	credito	t	Monto negativo
126	126	2024-03-11	800.00	debito	f	\N
127	127	2024-04-09	700.00	invalid	t	Tipo de transacción no válido: invalid
128	128	2024-07-26	1500.00	invalid	t	Tipo de transacción no válido: invalid
129	129	2024-11-14	700.00	invalid	t	Tipo de transacción no válido: invalid
130	130	2024-07-24	1200.00	debito	f	\N
131	131	2024-07-25	1000.00	debito	f	\N
132	132	2024-12-10	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
133	133	2024-07-21	500.00	invalid	t	Tipo de transacción no válido: invalid
134	134	2024-04-06	800.00	credito	f	\N
135	135	2024-03-02	\N	debito	t	Monto vacío
136	136	2024-10-27	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
137	137	2024-06-17	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
138	138	\N	1000.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
139	139	2024-09-16	700.00	debito	f	\N
140	140	2024-08-22	1200.00	debito	f	\N
141	141	2024-07-14	3000.00	debito	f	\N
142	142	2024-11-19	3000.00	debito	f	\N
143	143	2024-09-29	700.00	credito	f	\N
144	144	2024-12-30	3000.00	debito	f	\N
145	145	2024-01-01	1200.00	debito	f	\N
146	146	2024-07-01	\N	debito	t	Monto vacío
147	147	2024-03-29	3000.00	credito	f	\N
148	148	2024-03-30	1000.00	invalid	t	Tipo de transacción no válido: invalid
149	149	2024-11-02	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
150	150	\N	1500.00	debito	t	Formato de fecha inválido: 2024-13-01
151	151	2024-12-18	3000.00	credito	f	\N
152	152	2024-10-25	1500.00	invalid	t	Tipo de transacción no válido: invalid
153	153	2024-07-28	1000.00	credito	f	\N
154	154	2024-03-04	800.00	credito	f	\N
155	155	2024-12-22	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
156	156	2024-03-02	1500.00	debito	f	\N
157	157	2024-08-17	3000.00	debito	f	\N
158	158	2024-05-26	500.00	debito	f	\N
159	159	2024-09-01	1200.00	debito	f	\N
160	160	2024-08-03	1500.00	invalid	t	Tipo de transacción no válido: invalid
161	161	2024-07-28	1500.00	credito	f	\N
162	162	2024-12-11	3000.00	debito	f	\N
163	163	2024-11-30	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
164	164	2024-03-04	3000.00	invalid	t	Tipo de transacción no válido: invalid
165	165	2024-08-30	1000.00	invalid	t	Tipo de transacción no válido: invalid
166	166	2024-04-06	800.00	credito	f	\N
167	167	2024-02-23	\N	credito	t	Monto vacío
168	168	2024-10-24	1200.00	credito	f	\N
169	169	2024-03-05	800.00	invalid	t	Tipo de transacción no válido: invalid
170	170	2024-09-07	1200.00	invalid	t	Tipo de transacción no válido: invalid
171	171	2024-05-14	\N	debito	t	Monto vacío
172	172	2024-02-07	0.00	debito	t	Monto igual a cero
173	173	2024-08-24	-100.00	debito	t	Monto negativo
174	174	2024-10-26	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
175	175	2024-09-24	1500.00	invalid	t	Tipo de transacción no válido: invalid
176	176	2024-06-07	1000.00	invalid	t	Tipo de transacción no válido: invalid
177	177	2024-10-22	3000.00	debito	f	\N
178	178	2024-05-17	3000.00	credito	f	\N
179	179	2024-07-11	3000.00	credito	f	\N
180	180	2024-05-28	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
181	181	2024-09-08	800.00	invalid	t	Tipo de transacción no válido: invalid
182	182	2024-03-02	800.00	credito	f	\N
183	183	2024-01-21	3000.00	credito	f	\N
184	184	2024-11-01	1500.00	debito	f	\N
185	185	\N	1000.00	debito	t	Formato de fecha inválido: 2024-13-01
186	186	2024-01-04	3000.00	invalid	t	Tipo de transacción no válido: invalid
187	187	2024-05-25	800.00	debito	f	\N
188	188	2024-03-15	500.00	debito	f	\N
189	189	2024-01-17	800.00	invalid	t	Tipo de transacción no válido: invalid
190	190	2024-07-26	1500.00	debito	f	\N
191	191	2024-07-26	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
192	192	2024-09-19	700.00	debito	f	\N
193	193	2024-01-16	1500.00	invalid	t	Tipo de transacción no válido: invalid
194	194	2024-12-29	-200.00	credito	t	Monto negativo
195	195	2024-06-13	800.00	debito	f	\N
196	196	2024-08-08	-200.00	credito	t	Monto negativo
197	197	2024-02-18	1200.00	credito	f	\N
198	198	2024-12-04	800.00	debito	f	\N
199	199	2024-06-01	700.00	invalid	t	Tipo de transacción no válido: invalid
200	200	2024-10-13	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
201	201	2024-11-15	-200.00	credito	t	Monto negativo
202	202	2024-01-09	\N	debito	t	Monto vacío
203	203	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
204	204	2024-04-16	1200.00	debito	f	\N
205	205	2024-08-07	1000.00	invalid	t	Tipo de transacción no válido: invalid
206	206	2024-11-20	3000.00	debito	f	\N
207	207	2024-02-08	3000.00	debito	f	\N
208	208	2024-01-29	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
209	209	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
210	210	2024-02-09	700.00	debito	f	\N
211	211	2024-04-18	800.00	invalid	t	Tipo de transacción no válido: invalid
212	212	2024-04-23	1200.00	debito	f	\N
213	213	2024-07-30	3000.00	debito	f	\N
214	214	2024-04-15	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
215	215	2024-03-01	1500.00	debito	f	\N
216	216	2024-03-05	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
217	217	2024-03-16	700.00	credito	f	\N
218	218	2024-02-16	1200.00	credito	f	\N
219	219	2024-09-28	0.00	credito	t	Monto igual a cero
220	220	2024-08-28	500.00	credito	f	\N
221	221	2024-06-19	1200.00	invalid	t	Tipo de transacción no válido: invalid
222	222	2024-03-10	-100.00	debito	t	Monto negativo
223	223	2024-10-01	3000.00	credito	f	\N
224	224	2024-12-20	500.00	credito	f	\N
225	225	2024-04-01	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
226	226	2024-04-29	-200.00	debito	t	Monto negativo
227	227	2024-04-25	800.00	debito	f	\N
228	228	2024-07-12	1500.00	invalid	t	Tipo de transacción no válido: invalid
229	229	2024-10-22	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
230	230	2024-01-13	-100.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
231	231	2024-12-25	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
232	232	2024-02-04	1500.00	invalid	t	Tipo de transacción no válido: invalid
233	233	2024-06-15	1000.00	debito	f	\N
234	234	2024-07-03	-200.00	credito	t	Monto negativo
235	235	2024-04-07	800.00	invalid	t	Tipo de transacción no válido: invalid
236	236	2024-06-29	1000.00	debito	f	\N
237	237	2024-02-21	1200.00	debito	f	\N
238	238	2024-10-09	1200.00	credito	f	\N
239	239	2024-03-04	800.00	debito	f	\N
240	240	2024-06-17	3000.00	debito	f	\N
241	241	2024-03-07	1000.00	credito	f	\N
242	242	2024-07-24	\N	credito	t	Monto vacío
243	243	2024-10-17	800.00	debito	f	\N
244	244	2024-07-23	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
245	245	2024-06-02	800.00	credito	f	\N
246	246	2024-02-10	1200.00	debito	f	\N
247	247	2024-05-13	\N	debito	t	Monto vacío
248	248	2024-12-10	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
249	249	2024-06-19	1200.00	invalid	t	Tipo de transacción no válido: invalid
250	250	2024-02-09	1200.00	debito	f	\N
251	251	2024-07-14	-200.00	debito	t	Monto negativo
252	252	2024-05-25	700.00	debito	f	\N
253	253	2024-09-02	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
254	254	2024-10-26	1200.00	invalid	t	Tipo de transacción no válido: invalid
255	255	2024-07-02	-100.00	credito	t	Monto negativo
256	256	2024-04-22	1500.00	credito	f	\N
257	257	2024-11-26	1000.00	credito	f	\N
258	258	2024-01-06	\N	credito	t	Monto vacío
259	259	2024-05-04	\N	credito	t	Monto vacío
260	260	2024-03-23	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
261	261	2024-06-26	500.00	debito	f	\N
262	262	2024-09-02	\N	debito	t	Monto vacío
263	263	2024-07-02	3000.00	invalid	t	Tipo de transacción no válido: invalid
264	264	\N	1500.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
265	265	2024-12-16	3000.00	debito	f	\N
266	266	2024-11-02	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
267	267	2024-04-06	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
268	268	2024-05-24	800.00	credito	f	\N
269	269	2024-07-27	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
270	270	\N	1200.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
271	271	2024-03-18	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
272	272	2024-09-04	3000.00	invalid	t	Tipo de transacción no válido: invalid
273	273	2024-04-26	1000.00	invalid	t	Tipo de transacción no válido: invalid
274	274	2024-01-21	1500.00	credito	f	\N
275	275	2024-08-09	700.00	credito	f	\N
276	276	2024-10-16	700.00	debito	f	\N
277	277	2024-08-12	-100.00	credito	t	Monto negativo
278	278	2024-05-25	-200.00	debito	t	Monto negativo
279	279	2024-02-24	800.00	invalid	t	Tipo de transacción no válido: invalid
280	280	2024-07-27	1200.00	credito	f	\N
281	281	2024-07-08	800.00	credito	f	\N
282	282	2024-08-08	\N	debito	t	Monto vacío
283	283	2024-08-08	0.00	debito	t	Monto igual a cero
284	284	2024-07-25	1500.00	credito	f	\N
285	285	2024-12-13	1500.00	desconocido	t	Tipo de transacción no válido: desconocido
286	286	2024-09-27	800.00	credito	f	\N
287	287	2024-11-17	800.00	debito	f	\N
288	288	2024-09-03	-200.00	debito	t	Monto negativo
289	289	2024-08-14	3000.00	debito	f	\N
290	290	2024-06-15	1500.00	debito	f	\N
291	291	2024-04-17	1000.00	invalid	t	Tipo de transacción no válido: invalid
292	292	2024-09-20	1000.00	credito	f	\N
293	293	2024-10-18	1500.00	invalid	t	Tipo de transacción no válido: invalid
294	294	2024-07-01	700.00	desconocido	t	Tipo de transacción no válido: desconocido
295	295	2024-06-12	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
296	296	2024-12-09	\N	debito	t	Monto vacío
297	297	2024-08-19	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
298	298	\N	700.00	debito	t	Formato de fecha inválido: 2024-13-01
299	299	2024-10-10	700.00	invalid	t	Tipo de transacción no válido: invalid
300	300	2024-03-28	1500.00	invalid	t	Tipo de transacción no válido: invalid
301	301	2024-10-03	1500.00	credito	f	\N
302	302	2024-10-16	\N	debito	t	Monto vacío
303	303	2024-10-19	3000.00	credito	f	\N
304	304	2024-03-03	1000.00	invalid	t	Tipo de transacción no válido: invalid
305	305	2024-10-18	700.00	invalid	t	Tipo de transacción no válido: invalid
306	306	2024-07-08	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
307	307	2024-01-02	\N	credito	t	Monto vacío
308	308	\N	\N	invalid	t	Formato de fecha inválido: 2024-13-01; Monto vacío; Tipo de transacción no válido: invalid
309	309	2024-03-23	1000.00	debito	f	\N
310	310	2024-12-14	1000.00	invalid	t	Tipo de transacción no válido: invalid
311	311	\N	1000.00	credito	t	Formato de fecha inválido: 2024-13-01
312	312	2024-06-24	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
313	313	2024-10-16	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
314	314	2024-03-22	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
315	315	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
316	316	2024-04-01	\N	credito	t	Monto vacío
317	317	2024-01-19	800.00	invalid	t	Tipo de transacción no válido: invalid
318	318	2024-06-04	1500.00	invalid	t	Tipo de transacción no válido: invalid
319	319	2024-05-08	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
320	320	2024-02-29	700.00	invalid	t	Tipo de transacción no válido: invalid
321	321	2024-03-30	-200.00	debito	t	Monto negativo
322	322	2024-01-28	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
323	323	2024-07-27	700.00	credito	f	\N
324	324	2024-09-23	800.00	invalid	t	Tipo de transacción no válido: invalid
325	325	2024-03-22	700.00	debito	f	\N
326	326	2024-12-15	1200.00	invalid	t	Tipo de transacción no válido: invalid
327	327	2024-04-30	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
328	328	2024-11-10	1000.00	debito	f	\N
329	329	2024-05-02	700.00	invalid	t	Tipo de transacción no válido: invalid
330	330	2024-12-04	\N	credito	t	Monto vacío
331	331	2024-11-13	700.00	debito	f	\N
332	332	2024-10-16	-200.00	credito	t	Monto negativo
333	333	2024-02-22	\N	debito	t	Monto vacío
334	334	2024-08-16	3000.00	debito	f	\N
335	335	2024-08-17	1000.00	debito	f	\N
336	336	2024-03-14	800.00	invalid	t	Tipo de transacción no válido: invalid
337	337	2024-10-08	3000.00	debito	f	\N
338	338	2024-06-19	800.00	invalid	t	Tipo de transacción no válido: invalid
339	339	2024-06-06	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
340	340	2024-03-05	-200.00	debito	t	Monto negativo
341	341	2024-01-28	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
342	342	2024-07-08	\N	debito	t	Monto vacío
343	343	2024-01-08	3000.00	invalid	t	Tipo de transacción no válido: invalid
344	344	2024-10-21	700.00	credito	f	\N
345	345	2024-11-19	700.00	invalid	t	Tipo de transacción no válido: invalid
346	346	2024-10-12	1500.00	invalid	t	Tipo de transacción no válido: invalid
347	347	2024-05-20	3000.00	invalid	t	Tipo de transacción no válido: invalid
348	348	2024-07-13	1500.00	credito	f	\N
349	349	2024-03-31	800.00	credito	f	\N
350	350	2024-02-02	1200.00	debito	f	\N
351	351	2024-08-31	1200.00	debito	f	\N
352	352	2024-02-02	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
353	353	2024-04-18	\N	credito	t	Monto vacío
354	354	2024-01-10	\N	debito	t	Monto vacío
355	355	2024-03-15	800.00	credito	f	\N
356	356	2024-12-17	-200.00	debito	t	Monto negativo
357	357	\N	1000.00	credito	t	Formato de fecha inválido: 2024-13-01
358	358	2024-10-10	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
359	359	2024-08-04	\N	debito	t	Monto vacío
360	360	2024-04-23	700.00	invalid	t	Tipo de transacción no válido: invalid
361	361	2024-05-08	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
362	362	2024-11-06	1500.00	debito	f	\N
363	363	2024-01-09	1000.00	invalid	t	Tipo de transacción no válido: invalid
364	364	2024-09-04	700.00	debito	f	\N
365	365	2024-10-01	1200.00	credito	f	\N
366	366	2024-07-22	700.00	debito	f	\N
367	367	2024-03-14	1500.00	debito	f	\N
368	368	2024-07-26	800.00	debito	f	\N
369	369	2024-09-29	800.00	desconocido	t	Tipo de transacción no válido: desconocido
370	370	2024-10-02	3000.00	debito	f	\N
371	371	2024-12-10	1000.00	debito	f	\N
372	372	2024-08-20	1200.00	debito	f	\N
373	373	2024-09-30	800.00	debito	f	\N
374	374	2024-07-25	800.00	desconocido	t	Tipo de transacción no válido: desconocido
375	375	2024-12-02	1000.00	credito	f	\N
376	376	2024-07-09	1200.00	credito	f	\N
377	377	2024-05-25	\N	credito	t	Monto vacío
378	378	2024-05-19	800.00	credito	f	\N
379	379	2024-03-09	1000.00	invalid	t	Tipo de transacción no válido: invalid
380	380	2024-12-26	1200.00	debito	f	\N
381	381	2024-06-25	\N	credito	t	Monto vacío
382	382	2024-07-04	500.00	invalid	t	Tipo de transacción no válido: invalid
383	383	2024-01-26	800.00	invalid	t	Tipo de transacción no válido: invalid
384	384	2024-05-30	700.00	invalid	t	Tipo de transacción no válido: invalid
385	385	2024-07-27	1500.00	invalid	t	Tipo de transacción no válido: invalid
386	386	2024-01-01	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
387	387	2024-07-10	3000.00	invalid	t	Tipo de transacción no válido: invalid
388	388	2024-09-14	\N	debito	t	Monto vacío
389	389	2024-11-19	\N	credito	t	Monto vacío
390	390	2024-12-20	1200.00	credito	f	\N
391	391	2024-09-09	500.00	credito	f	\N
392	392	2024-04-10	1000.00	debito	f	\N
393	393	\N	800.00	credito	t	Formato de fecha inválido: 2024-13-01
394	394	2024-03-14	1500.00	credito	f	\N
395	395	2024-07-09	-200.00	debito	t	Monto negativo
396	396	2024-05-23	\N	debito	t	Monto vacío
397	397	2024-02-16	700.00	debito	f	\N
398	398	2024-05-09	1000.00	invalid	t	Tipo de transacción no válido: invalid
399	399	2024-06-01	1500.00	credito	f	\N
400	400	2024-07-03	1000.00	debito	f	\N
401	401	2024-12-12	700.00	debito	f	\N
402	402	2024-07-16	\N	credito	t	Monto vacío
403	403	2024-06-29	500.00	credito	f	\N
404	404	2024-10-13	\N	credito	t	Monto vacío
405	405	2024-08-03	1500.00	credito	f	\N
406	406	2024-03-24	700.00	desconocido	t	Tipo de transacción no válido: desconocido
407	407	2024-09-21	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
408	408	2024-12-30	-200.00	debito	t	Monto negativo
409	409	2024-01-22	800.00	debito	f	\N
410	410	2024-11-23	1500.00	invalid	t	Tipo de transacción no válido: invalid
411	411	2024-12-12	-200.00	debito	t	Monto negativo
412	412	2024-12-06	1000.00	invalid	t	Tipo de transacción no válido: invalid
413	413	2024-10-21	1500.00	invalid	t	Tipo de transacción no válido: invalid
414	414	2024-08-07	\N	debito	t	Monto vacío
415	415	2024-06-29	\N	credito	t	Monto vacío
416	416	2024-11-17	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
417	417	2024-06-19	\N	debito	t	Monto vacío
418	418	2024-12-28	\N	credito	t	Monto vacío
419	419	2024-01-19	800.00	credito	f	\N
420	420	2024-05-30	1000.00	credito	f	\N
421	421	2024-09-09	-200.00	credito	t	Monto negativo
422	422	2024-09-09	-200.00	credito	t	Monto negativo
423	423	2024-08-28	800.00	invalid	t	Tipo de transacción no válido: invalid
424	424	2024-11-12	700.00	credito	f	\N
425	425	2024-01-09	1200.00	invalid	t	Tipo de transacción no válido: invalid
426	426	2024-08-28	800.00	credito	f	\N
427	427	2024-12-27	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
428	428	2024-08-09	700.00	debito	f	\N
429	429	2024-09-27	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
430	430	2024-05-07	1000.00	invalid	t	Tipo de transacción no válido: invalid
431	431	2024-05-04	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
432	432	2024-06-30	1000.00	debito	f	\N
433	433	2024-11-18	1500.00	invalid	t	Tipo de transacción no válido: invalid
434	434	2024-05-03	1500.00	desconocido	t	Tipo de transacción no válido: desconocido
435	435	2024-11-20	\N	credito	t	Monto vacío
436	436	2024-08-21	-100.00	debito	t	Monto negativo
437	437	2024-02-28	\N	credito	t	Monto vacío
438	438	2024-10-18	1500.00	invalid	t	Tipo de transacción no válido: invalid
439	439	2024-03-15	1200.00	credito	f	\N
440	440	2024-07-28	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
441	441	2024-12-04	1000.00	debito	f	\N
442	442	2024-08-06	1200.00	debito	f	\N
443	443	2024-05-11	\N	credito	t	Monto vacío
444	444	2024-04-19	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
445	445	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
446	446	2024-07-11	700.00	invalid	t	Tipo de transacción no válido: invalid
447	447	2024-02-08	1000.00	credito	f	\N
448	448	2024-06-08	\N	debito	t	Monto vacío
449	449	2024-05-19	-200.00	credito	t	Monto negativo
450	450	2024-03-07	1500.00	debito	f	\N
451	451	2024-07-02	700.00	invalid	t	Tipo de transacción no válido: invalid
452	452	2024-05-31	700.00	credito	f	\N
453	453	\N	800.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
454	454	2024-10-23	-200.00	debito	t	Monto negativo
455	455	2024-02-29	800.00	invalid	t	Tipo de transacción no válido: invalid
456	456	2024-10-18	1200.00	invalid	t	Tipo de transacción no válido: invalid
457	457	2024-03-26	1200.00	credito	f	\N
458	458	2024-10-02	-100.00	debito	t	Monto negativo
459	459	2024-01-31	1000.00	credito	f	\N
460	460	2024-08-21	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
461	461	\N	700.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
462	462	\N	1500.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
463	463	2024-04-01	-100.00	debito	t	Monto negativo
464	464	2024-07-24	1000.00	debito	f	\N
465	465	2024-03-04	700.00	credito	f	\N
466	466	2024-11-30	\N	credito	t	Monto vacío
467	467	2024-04-30	1500.00	credito	f	\N
468	468	2024-03-17	-200.00	debito	t	Monto negativo
469	469	2024-12-03	1000.00	invalid	t	Tipo de transacción no válido: invalid
470	470	2024-09-19	\N	debito	t	Monto vacío
471	471	2024-12-04	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
472	472	\N	\N	invalid	t	Formato de fecha inválido: 2024-13-01; Monto vacío; Tipo de transacción no válido: invalid
473	473	2024-08-15	700.00	invalid	t	Tipo de transacción no válido: invalid
474	474	\N	1200.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
475	475	2024-12-28	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
476	476	2024-07-06	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
477	477	2024-07-09	800.00	credito	f	\N
478	478	2024-07-06	0.00	credito	t	Monto igual a cero
479	479	2024-12-07	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
480	480	2024-06-09	700.00	debito	f	\N
481	481	2024-09-15	-100.00	credito	t	Monto negativo
482	482	2024-02-04	800.00	invalid	t	Tipo de transacción no válido: invalid
483	483	2024-11-07	1000.00	credito	f	\N
484	484	2024-04-15	700.00	credito	f	\N
485	485	2024-11-17	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
486	486	2024-09-17	800.00	invalid	t	Tipo de transacción no válido: invalid
487	487	2024-01-04	800.00	credito	f	\N
488	488	2024-12-11	\N	debito	t	Monto vacío
489	489	2024-11-15	3000.00	debito	f	\N
490	490	2024-07-26	700.00	invalid	t	Tipo de transacción no válido: invalid
491	491	2024-03-31	\N	credito	t	Monto vacío
492	492	2024-11-07	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
493	493	2024-08-29	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
494	494	2024-11-26	-200.00	debito	t	Monto negativo
495	495	2024-11-18	1500.00	credito	f	\N
496	496	2024-09-14	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
497	497	2024-04-20	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
498	498	\N	1500.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
499	499	2024-05-16	1200.00	credito	f	\N
500	500	2024-04-24	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
501	501	2024-03-24	\N	credito	t	Monto vacío
502	502	2024-02-10	-100.00	credito	t	Monto negativo
503	503	2024-02-14	1500.00	invalid	t	Tipo de transacción no válido: invalid
504	504	2024-09-16	500.00	credito	f	\N
505	505	2024-07-08	1000.00	debito	f	\N
506	506	2024-06-10	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
507	507	2024-04-05	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
508	508	2024-11-06	700.00	credito	f	\N
509	509	2024-10-31	500.00	debito	f	\N
510	510	2024-02-21	3000.00	credito	f	\N
511	511	2024-02-22	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
512	512	2024-08-14	700.00	credito	f	\N
513	513	2024-01-10	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
514	514	2024-10-20	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
515	515	2024-07-14	700.00	debito	f	\N
516	516	2024-08-21	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
517	517	2024-04-17	\N	debito	t	Monto vacío
518	518	2024-03-02	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
519	519	2024-08-24	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
520	520	2024-09-02	1200.00	debito	f	\N
521	521	2024-10-01	1500.00	credito	f	\N
522	522	2024-06-12	1500.00	invalid	t	Tipo de transacción no válido: invalid
523	523	2024-02-03	1000.00	invalid	t	Tipo de transacción no válido: invalid
524	524	2024-11-12	1200.00	invalid	t	Tipo de transacción no válido: invalid
525	525	\N	700.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
526	526	2024-03-26	700.00	invalid	t	Tipo de transacción no válido: invalid
527	527	2024-05-17	1200.00	credito	f	\N
528	528	2024-06-13	3000.00	invalid	t	Tipo de transacción no válido: invalid
529	529	2024-11-08	-100.00	credito	t	Monto negativo
530	530	2024-07-10	700.00	invalid	t	Tipo de transacción no válido: invalid
531	531	2024-01-07	700.00	credito	f	\N
532	532	2024-10-15	3000.00	credito	f	\N
533	533	2024-11-18	1500.00	credito	f	\N
534	534	2024-05-15	3000.00	invalid	t	Tipo de transacción no válido: invalid
535	535	2024-10-19	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
536	536	2024-09-30	700.00	credito	f	\N
537	537	2024-08-25	\N	credito	t	Monto vacío
538	538	2024-08-22	-200.00	credito	t	Monto negativo
539	539	2024-08-26	1500.00	debito	f	\N
540	540	2024-04-18	800.00	credito	f	\N
541	541	2024-06-22	3000.00	debito	f	\N
542	542	2024-01-07	\N	debito	t	Monto vacío
543	543	\N	1500.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
544	544	2024-10-04	800.00	debito	f	\N
545	545	2024-11-23	1000.00	debito	f	\N
546	546	2024-04-26	1200.00	debito	f	\N
547	547	2024-09-25	1200.00	credito	f	\N
548	548	2024-08-17	1500.00	debito	f	\N
549	549	2024-11-05	\N	credito	t	Monto vacío
550	550	2024-05-25	800.00	debito	f	\N
551	551	2024-03-11	\N	credito	t	Monto vacío
552	552	2024-06-01	800.00	invalid	t	Tipo de transacción no válido: invalid
553	553	2024-10-16	1500.00	debito	f	\N
554	554	2024-06-29	1200.00	credito	f	\N
555	555	2024-05-29	700.00	credito	f	\N
556	556	2024-06-16	-200.00	credito	t	Monto negativo
557	557	2024-09-06	\N	debito	t	Monto vacío
558	558	2024-10-21	700.00	invalid	t	Tipo de transacción no válido: invalid
559	559	2024-12-26	-200.00	desconocido	t	Tipo de transacción no válido: desconocido; Monto negativo
560	560	\N	-200.00	credito	t	Formato de fecha inválido: 2024-13-01; Monto negativo
561	561	2024-01-05	1500.00	invalid	t	Tipo de transacción no válido: invalid
562	562	2024-01-19	800.00	credito	f	\N
563	563	2024-08-17	1200.00	debito	f	\N
564	564	2024-07-06	800.00	credito	f	\N
565	565	2024-11-11	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
566	566	2024-07-12	1200.00	debito	f	\N
567	567	2024-01-15	700.00	credito	f	\N
568	568	2024-03-11	1200.00	debito	f	\N
569	569	2024-06-05	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
570	570	2024-03-20	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
571	571	2024-06-12	1200.00	debito	f	\N
572	572	2024-11-05	3000.00	credito	f	\N
573	573	2024-06-29	1200.00	credito	f	\N
574	574	2024-10-18	3000.00	debito	f	\N
575	575	2024-01-06	3000.00	debito	f	\N
576	576	2024-04-11	1000.00	invalid	t	Tipo de transacción no válido: invalid
577	577	2024-02-17	800.00	debito	f	\N
578	578	2024-12-05	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
579	579	2024-05-01	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
580	580	2024-11-28	700.00	invalid	t	Tipo de transacción no válido: invalid
581	581	2024-01-21	3000.00	debito	f	\N
582	582	2024-03-20	1500.00	invalid	t	Tipo de transacción no válido: invalid
583	583	2024-02-22	3000.00	invalid	t	Tipo de transacción no válido: invalid
584	584	2024-01-09	700.00	invalid	t	Tipo de transacción no válido: invalid
585	585	2024-11-17	1200.00	debito	f	\N
586	586	2024-01-31	-200.00	credito	t	Monto negativo
587	587	2024-07-10	1200.00	credito	f	\N
588	588	2024-11-22	1200.00	debito	f	\N
589	589	2024-12-30	800.00	debito	f	\N
590	590	2024-10-05	1500.00	credito	f	\N
591	591	2024-08-10	3000.00	credito	f	\N
592	592	2024-04-14	1500.00	credito	f	\N
593	593	2024-03-05	1200.00	credito	f	\N
594	594	2024-12-17	\N	debito	t	Monto vacío
595	595	\N	1000.00	debito	t	Formato de fecha inválido: 2024-13-01
596	596	2024-09-27	700.00	invalid	t	Tipo de transacción no válido: invalid
597	597	2024-01-30	500.00	credito	f	\N
598	598	2024-04-06	\N	credito	t	Monto vacío
599	599	\N	700.00	debito	t	Formato de fecha inválido: 2024-13-01
600	600	2024-02-09	1500.00	invalid	t	Tipo de transacción no válido: invalid
601	601	2024-11-16	1200.00	invalid	t	Tipo de transacción no válido: invalid
602	602	2024-06-29	-200.00	credito	t	Monto negativo
603	603	\N	-200.00	credito	t	Formato de fecha inválido: 2024-13-01; Monto negativo
604	604	2024-05-15	1000.00	credito	f	\N
605	605	2024-07-30	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
606	606	2024-05-16	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
607	607	2024-10-02	700.00	debito	f	\N
608	608	2024-05-27	1000.00	debito	f	\N
609	609	2024-11-14	3000.00	credito	f	\N
610	610	\N	\N	debito	t	Formato de fecha inválido: 2024-13-01; Monto vacío
611	611	2024-11-24	\N	debito	t	Monto vacío
612	612	2024-01-15	500.00	credito	f	\N
613	613	2024-11-17	700.00	debito	f	\N
614	614	2024-01-05	\N	debito	t	Monto vacío
615	615	2024-11-25	1500.00	invalid	t	Tipo de transacción no válido: invalid
616	616	2024-08-03	500.00	invalid	t	Tipo de transacción no válido: invalid
617	617	2024-09-17	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
618	618	2024-06-15	-100.00	credito	t	Monto negativo
619	619	2024-09-30	1000.00	credito	f	\N
620	620	2024-01-13	1000.00	credito	f	\N
621	621	2024-03-23	1200.00	debito	f	\N
622	622	2024-07-08	700.00	invalid	t	Tipo de transacción no válido: invalid
623	623	2024-03-01	800.00	debito	f	\N
624	624	2024-04-04	3000.00	credito	f	\N
625	625	2024-05-15	\N	debito	t	Monto vacío
626	626	2024-04-12	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
627	627	2024-12-29	700.00	credito	f	\N
628	628	2024-06-28	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
629	629	2024-12-26	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
630	630	2024-10-20	1500.00	desconocido	t	Tipo de transacción no válido: desconocido
631	631	2024-09-16	1500.00	credito	f	\N
632	632	2024-02-11	800.00	invalid	t	Tipo de transacción no válido: invalid
633	633	2024-10-27	1500.00	debito	f	\N
634	634	2024-06-15	1500.00	debito	f	\N
635	635	\N	1500.00	credito	t	Formato de fecha inválido: 2024-13-01
636	636	2024-08-07	1500.00	credito	f	\N
637	637	2024-07-01	700.00	desconocido	t	Tipo de transacción no válido: desconocido
638	638	2024-11-20	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
639	639	2024-09-26	-200.00	credito	t	Monto negativo
640	640	2024-10-09	3000.00	debito	f	\N
641	641	2024-11-29	1200.00	debito	f	\N
642	642	2024-03-14	700.00	credito	f	\N
643	643	2024-06-27	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
644	644	2024-05-18	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
645	645	2024-08-26	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
646	646	2024-07-20	700.00	credito	f	\N
647	647	2024-08-09	1000.00	debito	f	\N
648	648	2024-02-21	700.00	invalid	t	Tipo de transacción no válido: invalid
649	649	2024-04-16	-200.00	debito	t	Monto negativo
650	650	2024-10-31	3000.00	credito	f	\N
651	651	\N	\N	invalid	t	Formato de fecha inválido: 2024-13-01; Monto vacío; Tipo de transacción no válido: invalid
652	652	2024-04-28	-200.00	debito	t	Monto negativo
653	653	2024-08-29	1500.00	debito	f	\N
654	654	2024-04-16	800.00	debito	f	\N
655	655	2024-01-14	-200.00	credito	t	Monto negativo
656	656	2024-10-21	700.00	debito	f	\N
657	657	2024-04-30	1000.00	invalid	t	Tipo de transacción no válido: invalid
658	658	2024-10-14	1200.00	invalid	t	Tipo de transacción no válido: invalid
659	659	2024-01-26	1000.00	credito	f	\N
660	660	2024-07-17	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
661	661	2024-06-27	1200.00	debito	f	\N
662	662	2024-03-07	700.00	credito	f	\N
663	663	2024-02-25	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
664	664	2024-02-17	800.00	desconocido	t	Tipo de transacción no válido: desconocido
665	665	2024-04-13	800.00	invalid	t	Tipo de transacción no válido: invalid
666	666	2024-04-25	\N	debito	t	Monto vacío
667	667	2024-07-14	700.00	credito	f	\N
668	668	2024-02-21	\N	credito	t	Monto vacío
669	669	2024-10-16	1500.00	debito	f	\N
670	670	2024-12-07	1200.00	credito	f	\N
671	671	2024-05-17	800.00	desconocido	t	Tipo de transacción no válido: desconocido
672	672	\N	-200.00	credito	t	Formato de fecha inválido: 2024-13-01; Monto negativo
673	673	2024-04-30	-200.00	credito	t	Monto negativo
674	674	2024-10-08	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
675	675	2024-11-10	700.00	invalid	t	Tipo de transacción no válido: invalid
676	676	2024-08-07	\N	debito	t	Monto vacío
677	677	2024-09-02	700.00	invalid	t	Tipo de transacción no válido: invalid
678	678	2024-08-26	800.00	invalid	t	Tipo de transacción no válido: invalid
679	679	2024-04-19	\N	credito	t	Monto vacío
680	680	\N	1500.00	debito	t	Formato de fecha inválido: 2024-13-01
681	681	\N	1000.00	credito	t	Formato de fecha inválido: 2024-13-01
682	682	2024-01-22	700.00	credito	f	\N
683	683	2024-03-03	500.00	credito	f	\N
684	684	2024-11-04	\N	credito	t	Monto vacío
685	685	2024-12-20	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
686	686	2024-11-01	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
687	687	2024-12-12	\N	debito	t	Monto vacío
688	688	2024-08-17	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
689	689	2024-06-22	1000.00	debito	f	\N
690	690	2024-01-27	-200.00	debito	t	Monto negativo
691	691	2024-02-09	800.00	debito	f	\N
692	692	2024-09-15	\N	credito	t	Monto vacío
693	693	2024-02-13	\N	credito	t	Monto vacío
694	694	2024-04-06	1000.00	credito	f	\N
695	695	2024-10-20	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
696	696	2024-05-11	700.00	invalid	t	Tipo de transacción no válido: invalid
697	697	2024-02-01	800.00	invalid	t	Tipo de transacción no válido: invalid
698	698	2024-09-29	700.00	invalid	t	Tipo de transacción no válido: invalid
699	699	2024-12-10	800.00	desconocido	t	Tipo de transacción no válido: desconocido
700	700	2024-04-30	1000.00	debito	f	\N
701	701	2024-02-01	3000.00	desconocido	t	Tipo de transacción no válido: desconocido
702	702	\N	\N	debito	t	Formato de fecha inválido: 2024-13-01; Monto vacío
703	703	2024-05-05	1500.00	invalid	t	Tipo de transacción no válido: invalid
704	704	2024-02-19	800.00	invalid	t	Tipo de transacción no válido: invalid
705	705	2024-10-16	700.00	credito	f	\N
706	706	2024-03-20	1000.00	credito	f	\N
707	707	2024-01-14	800.00	debito	f	\N
708	708	2024-06-14	700.00	credito	f	\N
709	709	2024-05-01	1500.00	invalid	t	Tipo de transacción no válido: invalid
710	710	2024-10-24	700.00	debito	f	\N
711	711	2024-12-06	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
712	712	2024-09-11	\N	debito	t	Monto vacío
713	713	2024-07-12	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
714	714	2024-06-21	700.00	invalid	t	Tipo de transacción no válido: invalid
715	715	2024-07-07	700.00	invalid	t	Tipo de transacción no válido: invalid
716	716	\N	-200.00	debito	t	Formato de fecha inválido: 2024-13-01; Monto negativo
717	717	2024-03-22	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
718	718	2024-08-25	700.00	invalid	t	Tipo de transacción no válido: invalid
719	719	2024-09-04	1000.00	invalid	t	Tipo de transacción no válido: invalid
720	720	2024-11-27	1500.00	desconocido	t	Tipo de transacción no válido: desconocido
721	721	2024-05-25	\N	debito	t	Monto vacío
722	722	\N	1200.00	credito	t	Formato de fecha inválido: 2024-13-01
723	723	2024-04-03	-200.00	debito	t	Monto negativo
724	724	\N	1200.00	debito	t	Formato de fecha inválido: 2024-13-01
725	725	2024-02-06	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
726	726	2024-10-10	1500.00	credito	f	\N
727	727	2024-01-12	1000.00	debito	f	\N
728	728	2024-12-09	1500.00	invalid	t	Tipo de transacción no válido: invalid
729	729	2024-04-06	0.00	credito	t	Monto igual a cero
730	730	2024-03-18	800.00	debito	f	\N
731	731	2024-09-04	\N	credito	t	Monto vacío
732	732	2024-11-11	1000.00	credito	f	\N
733	733	2024-03-18	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
734	734	2024-04-13	1500.00	credito	f	\N
735	735	2024-09-23	1000.00	debito	f	\N
736	736	2024-05-11	1500.00	desconocido	t	Tipo de transacción no válido: desconocido
737	737	2024-03-17	800.00	invalid	t	Tipo de transacción no válido: invalid
738	738	2024-06-30	3000.00	invalid	t	Tipo de transacción no válido: invalid
739	739	2024-03-20	3000.00	invalid	t	Tipo de transacción no válido: invalid
740	740	2024-06-08	700.00	debito	f	\N
741	741	\N	1200.00	credito	t	Formato de fecha inválido: 2024-13-01
742	742	2024-05-14	3000.00	invalid	t	Tipo de transacción no válido: invalid
743	743	2024-01-15	700.00	debito	f	\N
744	744	2024-02-24	800.00	debito	f	\N
745	745	2024-12-23	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
746	746	2024-06-08	1500.00	invalid	t	Tipo de transacción no válido: invalid
747	747	2024-03-31	1000.00	credito	f	\N
748	748	2024-10-06	800.00	credito	f	\N
749	749	2024-06-20	1200.00	invalid	t	Tipo de transacción no válido: invalid
750	750	2024-03-03	-200.00	debito	t	Monto negativo
751	751	2024-11-13	3000.00	invalid	t	Tipo de transacción no válido: invalid
752	752	2024-05-02	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
753	753	2024-10-13	3000.00	debito	f	\N
754	754	2024-09-01	1500.00	debito	f	\N
755	755	\N	1200.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
756	756	2024-07-15	800.00	debito	f	\N
757	757	2024-10-11	1000.00	credito	f	\N
758	758	2024-06-14	1200.00	invalid	t	Tipo de transacción no válido: invalid
759	759	2024-03-31	1500.00	debito	f	\N
760	760	2024-07-28	800.00	debito	f	\N
761	761	2024-06-10	3000.00	debito	f	\N
762	762	2024-08-15	1500.00	debito	f	\N
763	763	2024-07-23	3000.00	invalid	t	Tipo de transacción no válido: invalid
764	764	2024-11-09	1000.00	credito	f	\N
765	765	2024-06-26	\N	credito	t	Monto vacío
766	766	2024-04-11	1200.00	credito	f	\N
767	767	2024-01-22	1500.00	credito	f	\N
768	768	2024-12-25	700.00	invalid	t	Tipo de transacción no válido: invalid
769	769	2024-11-25	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
770	770	2024-08-27	1500.00	credito	f	\N
771	771	2024-12-24	\N	debito	t	Monto vacío
772	772	2024-09-05	1500.00	invalid	t	Tipo de transacción no válido: invalid
773	773	2024-03-19	\N	debito	t	Monto vacío
774	774	2024-04-08	1000.00	credito	f	\N
775	775	2024-04-06	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
776	776	2024-07-13	800.00	credito	f	\N
777	777	2024-01-25	3000.00	credito	f	\N
778	778	2024-08-11	800.00	debito	f	\N
779	779	2024-03-31	-200.00	debito	t	Monto negativo
780	780	2024-02-16	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
781	781	2024-01-12	700.00	invalid	t	Tipo de transacción no válido: invalid
782	782	2024-11-18	\N	credito	t	Monto vacío
783	783	2024-02-28	1000.00	credito	f	\N
784	784	2024-08-09	\N	credito	t	Monto vacío
785	785	2024-05-07	\N	debito	t	Monto vacío
786	786	2024-08-25	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
787	787	2024-05-19	1000.00	credito	f	\N
788	788	2024-10-31	\N	debito	t	Monto vacío
789	789	2024-05-27	1000.00	credito	f	\N
790	790	2024-11-11	1000.00	credito	f	\N
791	791	2024-06-28	-200.00	credito	t	Monto negativo
792	792	2024-07-08	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
793	793	2024-12-04	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
794	794	2024-12-30	\N	credito	t	Monto vacío
795	795	2024-11-29	800.00	debito	f	\N
796	796	2024-01-16	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
797	797	2024-09-08	800.00	debito	f	\N
798	798	2024-12-07	1000.00	debito	f	\N
799	799	\N	3000.00	debito	t	Formato de fecha inválido: 2024-13-01
999	999	2024-06-19	1500.00	debito	f	\N
800	800	2024-01-27	-100.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
801	801	2024-01-14	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
802	802	2024-02-29	1200.00	credito	f	\N
803	803	2024-02-12	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
804	804	2024-07-11	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
805	805	2024-10-17	\N	debito	t	Monto vacío
806	806	2024-01-14	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
807	807	2024-12-01	700.00	debito	f	\N
808	808	2024-01-04	-200.00	debito	t	Monto negativo
809	809	2024-01-18	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
810	810	2024-10-13	\N	credito	t	Monto vacío
811	811	2024-07-24	1200.00	debito	f	\N
812	812	2024-05-20	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
813	813	2024-03-17	1200.00	invalid	t	Tipo de transacción no válido: invalid
814	814	2024-10-22	700.00	credito	f	\N
815	815	2024-11-19	\N	debito	t	Monto vacío
816	816	2024-01-28	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
817	817	2024-07-10	3000.00	invalid	t	Tipo de transacción no válido: invalid
818	818	2024-06-19	-100.00	debito	t	Monto negativo
819	819	2024-06-13	700.00	invalid	t	Tipo de transacción no válido: invalid
820	820	2024-08-12	3000.00	credito	f	\N
821	821	2024-04-07	\N	debito	t	Monto vacío
822	822	2024-09-18	1200.00	credito	f	\N
823	823	2024-01-28	-200.00	debito	t	Monto negativo
824	824	2024-04-16	3000.00	credito	f	\N
825	825	2024-05-14	700.00	invalid	t	Tipo de transacción no válido: invalid
826	826	2024-10-15	500.00	debito	f	\N
827	827	2024-02-06	-200.00	debito	t	Monto negativo
828	828	2024-05-23	1500.00	invalid	t	Tipo de transacción no válido: invalid
829	829	\N	3000.00	debito	t	Formato de fecha inválido: 2024-13-01
830	830	2024-10-10	3000.00	debito	f	\N
831	831	2024-08-03	1000.00	debito	f	\N
832	832	2024-06-26	700.00	debito	f	\N
833	833	2024-05-16	700.00	debito	f	\N
834	834	2024-02-02	3000.00	credito	f	\N
835	835	\N	1500.00	credito	t	Formato de fecha inválido: 2024-13-01
836	836	2024-06-08	1500.00	credito	f	\N
837	837	2024-07-10	1200.00	invalid	t	Tipo de transacción no válido: invalid
838	838	\N	\N	credito	t	Formato de fecha inválido: 2024-13-01; Monto vacío
839	839	2024-04-23	-200.00	credito	t	Monto negativo
840	840	2024-08-12	800.00	debito	f	\N
841	841	2024-08-15	0.00	invalid	t	Tipo de transacción no válido: invalid; Monto igual a cero
842	842	2024-10-30	1500.00	credito	f	\N
843	843	2024-03-12	1500.00	credito	f	\N
844	844	2024-11-23	-200.00	debito	t	Monto negativo
845	845	2024-08-31	1500.00	invalid	t	Tipo de transacción no válido: invalid
846	846	2024-08-30	\N	credito	t	Monto vacío
847	847	2024-10-14	1000.00	debito	f	\N
848	848	2024-06-07	1200.00	credito	f	\N
849	849	2024-05-01	-200.00	debito	t	Monto negativo
850	850	2024-12-20	3000.00	credito	f	\N
851	851	2024-03-23	\N	credito	t	Monto vacío
852	852	\N	1000.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
853	853	2024-07-03	700.00	desconocido	t	Tipo de transacción no válido: desconocido
854	854	2024-06-27	500.00	debito	f	\N
855	855	2024-08-20	-200.00	credito	t	Monto negativo
856	856	2024-07-22	-200.00	credito	t	Monto negativo
857	857	2024-10-29	800.00	debito	f	\N
858	858	2024-11-12	\N	credito	t	Monto vacío
859	859	2024-04-08	3000.00	debito	f	\N
860	860	2024-02-08	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
861	861	2024-09-13	-200.00	debito	t	Monto negativo
862	862	2024-07-24	\N	debito	t	Monto vacío
863	863	\N	-200.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid; Monto negativo
864	864	2024-10-31	0.00	credito	t	Monto igual a cero
865	865	2024-05-29	-200.00	credito	t	Monto negativo
866	866	2024-02-08	800.00	debito	f	\N
867	867	2024-03-12	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
868	868	2024-11-20	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
869	869	2024-09-26	3000.00	credito	f	\N
870	870	2024-06-23	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
871	871	2024-07-27	3000.00	debito	f	\N
872	872	2024-04-01	-200.00	debito	t	Monto negativo
873	873	2024-12-23	\N	credito	t	Monto vacío
874	874	2024-12-20	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
875	875	2024-09-01	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
876	876	2024-06-27	700.00	credito	f	\N
877	877	2024-03-19	\N	credito	t	Monto vacío
878	878	2024-01-08	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
879	879	2024-07-05	\N	debito	t	Monto vacío
880	880	2024-01-14	800.00	credito	f	\N
881	881	2024-11-06	-100.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
882	882	2024-07-08	\N	credito	t	Monto vacío
883	883	2024-04-03	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
884	884	2024-01-08	800.00	credito	f	\N
885	885	2024-05-29	1000.00	debito	f	\N
886	886	2024-12-27	1200.00	debito	f	\N
887	887	2024-02-19	3000.00	credito	f	\N
888	888	2024-12-25	\N	debito	t	Monto vacío
889	889	2024-10-10	1500.00	debito	f	\N
890	890	2024-02-29	3000.00	debito	f	\N
891	891	2024-12-24	3000.00	invalid	t	Tipo de transacción no válido: invalid
892	892	2024-06-05	500.00	debito	f	\N
893	893	2024-11-06	1000.00	invalid	t	Tipo de transacción no válido: invalid
894	894	2024-10-30	\N	credito	t	Monto vacío
895	895	2024-11-04	1500.00	credito	f	\N
896	896	\N	1500.00	debito	t	Formato de fecha inválido: 2024-13-01
897	897	2024-05-04	3000.00	credito	f	\N
898	898	2024-12-12	500.00	debito	f	\N
899	899	2024-12-14	1500.00	credito	f	\N
900	900	2024-01-19	1000.00	debito	f	\N
1000	1000	2024-12-30	1500.00	credito	f	\N
901	901	2024-06-22	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
902	902	2024-01-30	1200.00	invalid	t	Tipo de transacción no válido: invalid
903	903	2024-10-29	1500.00	debito	f	\N
904	904	2024-05-28	700.00	debito	f	\N
905	905	2024-02-11	1000.00	debito	f	\N
906	906	2024-01-19	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
907	907	2024-05-29	1200.00	debito	f	\N
908	908	2024-02-27	700.00	debito	f	\N
909	909	\N	800.00	credito	t	Formato de fecha inválido: 2024-13-01
910	910	2024-08-08	3000.00	invalid	t	Tipo de transacción no válido: invalid
911	911	2024-09-29	700.00	debito	f	\N
912	912	2024-10-10	1000.00	debito	f	\N
913	913	2024-04-06	500.00	invalid	t	Tipo de transacción no válido: invalid
914	914	2024-07-09	700.00	credito	f	\N
915	915	2024-01-21	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
916	916	2024-12-24	700.00	invalid	t	Tipo de transacción no válido: invalid
917	917	\N	800.00	credito	t	Formato de fecha inválido: 2024-13-01
918	918	2024-01-22	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
919	919	2024-05-31	1500.00	credito	f	\N
920	920	2024-05-30	800.00	debito	f	\N
921	921	2024-09-24	\N	credito	t	Monto vacío
922	922	2024-04-29	1200.00	debito	f	\N
923	923	2024-12-20	\N	desconocido	t	Monto vacío; Tipo de transacción no válido: desconocido
924	924	2024-10-30	\N	debito	t	Monto vacío
925	925	2024-11-04	\N	credito	t	Monto vacío
926	926	2024-01-23	700.00	invalid	t	Tipo de transacción no válido: invalid
927	927	\N	\N	credito	t	Formato de fecha inválido: 2024-13-01; Monto vacío
928	928	2024-04-14	1500.00	invalid	t	Tipo de transacción no válido: invalid
929	929	2024-07-06	800.00	debito	f	\N
930	930	2024-01-17	800.00	credito	f	\N
931	931	2024-12-08	\N	debito	t	Monto vacío
932	932	2024-11-22	1500.00	debito	f	\N
933	933	2024-08-01	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
934	934	2024-08-02	\N	credito	t	Monto vacío
935	935	2024-08-26	1000.00	invalid	t	Tipo de transacción no válido: invalid
936	936	2024-06-11	1500.00	credito	f	\N
937	937	2024-03-07	500.00	debito	f	\N
938	938	2024-10-08	800.00	invalid	t	Tipo de transacción no válido: invalid
939	939	2024-04-20	-200.00	debito	t	Monto negativo
940	940	2024-12-09	1000.00	credito	f	\N
941	941	2024-01-14	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
942	942	2024-03-15	1500.00	credito	f	\N
943	943	2024-02-19	-200.00	credito	t	Monto negativo
944	944	2024-07-20	\N	credito	t	Monto vacío
945	945	2024-08-13	-100.00	credito	t	Monto negativo
946	946	2024-06-04	3000.00	credito	f	\N
947	947	2024-06-02	0.00	credito	t	Monto igual a cero
948	948	2024-07-24	-200.00	credito	t	Monto negativo
949	949	2024-09-15	1000.00	desconocido	t	Tipo de transacción no válido: desconocido
950	950	2024-10-14	1000.00	debito	f	\N
951	951	2024-06-07	3000.00	invalid	t	Tipo de transacción no válido: invalid
952	952	2024-11-30	-200.00	credito	t	Monto negativo
953	953	2024-06-23	3000.00	credito	f	\N
954	954	2024-02-10	1000.00	invalid	t	Tipo de transacción no válido: invalid
955	955	2024-01-02	700.00	credito	f	\N
956	956	2024-12-01	\N	credito	t	Monto vacío
957	957	2024-12-30	700.00	invalid	t	Tipo de transacción no válido: invalid
958	958	2024-07-25	1200.00	credito	f	\N
959	959	2024-06-25	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
960	960	2024-03-29	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
961	961	2024-10-20	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
962	962	2024-08-11	-200.00	debito	t	Monto negativo
963	963	2024-10-25	-200.00	credito	t	Monto negativo
964	964	2024-07-27	1200.00	debito	f	\N
965	965	2024-08-12	3000.00	invalid	t	Tipo de transacción no válido: invalid
966	966	2024-09-19	3000.00	credito	f	\N
967	967	2024-06-22	500.00	credito	f	\N
968	968	2024-05-05	-100.00	credito	t	Monto negativo
969	969	2024-04-15	3000.00	invalid	t	Tipo de transacción no válido: invalid
970	970	2024-02-14	3000.00	invalid	t	Tipo de transacción no válido: invalid
971	971	2024-03-04	-200.00	credito	t	Monto negativo
972	972	2024-12-03	1000.00	invalid	t	Tipo de transacción no válido: invalid
973	973	\N	\N	debito	t	Formato de fecha inválido: 2024-13-01; Monto vacío
974	974	2024-08-02	1200.00	debito	f	\N
975	975	2024-04-07	1200.00	desconocido	t	Tipo de transacción no válido: desconocido
976	976	2024-02-09	800.00	invalid	t	Tipo de transacción no válido: invalid
977	977	2024-05-21	3000.00	invalid	t	Tipo de transacción no válido: invalid
978	978	2024-04-08	1500.00	invalid	t	Tipo de transacción no válido: invalid
979	979	2024-11-22	-200.00	credito	t	Monto negativo
980	980	2024-06-22	700.00	invalid	t	Tipo de transacción no válido: invalid
981	981	2024-01-20	-200.00	debito	t	Monto negativo
982	982	2024-06-08	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
983	983	2024-05-23	1500.00	invalid	t	Tipo de transacción no válido: invalid
984	984	2024-05-07	\N	debito	t	Monto vacío
985	985	2024-09-06	700.00	credito	f	\N
986	986	2024-05-13	700.00	invalid	t	Tipo de transacción no válido: invalid
987	987	2024-10-13	\N	debito	t	Monto vacío
988	988	2024-12-11	1200.00	invalid	t	Tipo de transacción no válido: invalid
989	989	2024-08-22	800.00	debito	f	\N
990	990	2024-04-27	1500.00	debito	f	\N
991	991	2024-04-08	0.00	debito	t	Monto igual a cero
992	992	2024-03-15	1000.00	credito	f	\N
993	993	\N	700.00	invalid	t	Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid
994	994	2024-06-09	700.00	invalid	t	Tipo de transacción no válido: invalid
995	995	2024-02-08	-200.00	credito	t	Monto negativo
996	996	2024-07-23	700.00	debito	f	\N
997	997	2024-06-14	-200.00	invalid	t	Tipo de transacción no válido: invalid; Monto negativo
998	998	2024-01-14	\N	invalid	t	Monto vacío; Tipo de transacción no válido: invalid
\.


--
-- Name: batch_job_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batch_job_execution_seq', 49, true);


--
-- Name: batch_job_instance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batch_job_instance_seq', 41, true);


--
-- Name: batch_step_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batch_step_execution_seq', 49, true);


--
-- Name: estados_cuenta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_cuenta_id_seq', 1000, true);


--
-- Name: eventos_transaccion_procesados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventos_transaccion_procesados_id_seq', 4, true);


--
-- Name: intereses_procesados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.intereses_procesados_id_seq', 1000, true);


--
-- Name: resumen_transacciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resumen_transacciones_id_seq', 1, false);


--
-- Name: transacciones_procesadas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transacciones_procesadas_id_seq', 1000, true);


--
-- Name: batch_job_execution_context batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_execution batch_job_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_instance batch_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- Name: batch_step_execution_context batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- Name: batch_step_execution batch_step_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- Name: estados_cuenta estados_cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cuenta
    ADD CONSTRAINT estados_cuenta_pkey PRIMARY KEY (id);


--
-- Name: eventos_transaccion_procesados eventos_transaccion_procesados_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos_transaccion_procesados
    ADD CONSTRAINT eventos_transaccion_procesados_event_id_key UNIQUE (event_id);


--
-- Name: eventos_transaccion_procesados eventos_transaccion_procesados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos_transaccion_procesados
    ADD CONSTRAINT eventos_transaccion_procesados_pkey PRIMARY KEY (id);


--
-- Name: intereses_procesados intereses_procesados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intereses_procesados
    ADD CONSTRAINT intereses_procesados_pkey PRIMARY KEY (id);


--
-- Name: batch_job_instance job_inst_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- Name: resumen_transacciones resumen_transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumen_transacciones
    ADD CONSTRAINT resumen_transacciones_pkey PRIMARY KEY (id);


--
-- Name: transacciones_procesadas transacciones_procesadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_procesadas
    ADD CONSTRAINT transacciones_procesadas_pkey PRIMARY KEY (id);


--
-- Name: batch_job_execution_context job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: batch_job_execution_params job_exec_params_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: batch_step_execution job_exec_step_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES public.batch_job_execution(job_execution_id);


--
-- Name: batch_job_execution job_inst_exec_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES public.batch_job_instance(job_instance_id);


--
-- Name: batch_step_execution_context step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES public.batch_step_execution(step_execution_id);


--
-- PostgreSQL database dump complete
--

\unrestrict fQ6SVcISLhhMPgdzBwN0VpTGb3fBTKIlU9ylljSn8cHLxW7zBJIYSTZLeybThfx

