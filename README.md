# Proyecto Microservicios Bancarios - Semana 8

## 1. Descripción

Este proyecto corresponde a la evolución de una arquitectura de microservicios bancarios desarrollada durante las semanas anteriores.

En esta etapa se implementa una arquitectura distribuida utilizando Spring Boot y Spring Cloud, incorporando componentes de infraestructura para configuración centralizada, descubrimiento de servicios, seguridad, comunicación mediante eventos y tolerancia a fallos.

La solución está compuesta por los siguientes microservicios:

- `ms-cuentas`
- `ms-intereses`
- `ms-transacciones`

Además del componente:

- `bff-web`

El despliegue completo de la solución se realiza mediante contenedores Docker utilizando Docker Compose.

---

# 2. Arquitectura implementada

La solución incorpora los siguientes componentes:

- **Eureka Server:** registro y descubrimiento de servicios.
- **Config Server:** configuración centralizada de los microservicios.
- **Authorization Server:** autenticación OAuth2 y generación de tokens JWT.
- **Kafka:** comunicación asíncrona mediante eventos.
- **PostgreSQL:** almacenamiento persistente.
- **Resilience4j:** manejo de fallos mediante Circuit Breaker.
- **Spring Boot Actuator:** monitoreo del estado de los servicios.
- **Docker Compose:** administración de la infraestructura completa.

Flujo general:

```text
Usuario
   |
   v
BFF Web
   |
   |
   +----------------------+
   |                      |
   v                      v

Microservicios        Kafka

   |
   v

PostgreSQL
```

---

# 3. Componentes principales

## Eureka Server

Se implementó Eureka como servidor de descubrimiento de servicios.

Los microservicios se registran automáticamente permitiendo la comunicación mediante nombres de servicio, evitando depender de direcciones IP fijas.

Servicios registrados:

- `ms-cuentas`
- `ms-intereses`
- `ms-transacciones`
- `bff-web`

---

## Config Server

La configuración de los microservicios fue externalizada mediante Spring Cloud Config.

Los archivos de configuración se administran mediante el repositorio:

```text
config-repo/
```

Ejemplo:

```text
ms-transacciones-docker.properties
```

Los microservicios obtienen sus propiedades desde Config Server durante el inicio, permitiendo separar la configuración del código fuente.

---

## Seguridad OAuth2 / JWT

La autenticación fue implementada mediante OAuth2 utilizando un Authorization Server.

Flujo implementado:

```text
Usuario
   |
   v

Authorization Server

   |
   v

Token JWT

   |
   v

Servicios protegidos
```

Los microservicios validan los tokens JWT utilizando Spring Security.

---

## Comunicación mediante Kafka

Se incorporó Apache Kafka para comunicación basada en eventos.

Ejemplo implementado:

```text
ms-transacciones

        |
        v

transacciones.procesadas

        |
        v

Consumidores Kafka
```

La publicación de eventos fue validada mediante el tópico:

```text
transacciones.procesadas
```

---

## Resilience4j Circuit Breaker

Se implementó Resilience4j para controlar fallos en la comunicación entre servicios.

El Circuit Breaker permite:

- Detectar fallos consecutivos.
- Evitar llamadas repetidas a servicios no disponibles.
- Entregar respuestas controladas ante errores.

---

## Persistencia PostgreSQL

La solución utiliza PostgreSQL como motor de persistencia.

Base utilizada:

```text
bank_batch
```

La persistencia fue validada mediante consultas directas a la base de datos, comprobando la existencia y almacenamiento de información generada por los servicios.

---

## Spring Boot Actuator

Se habilitaron endpoints de monitoreo utilizando Spring Boot Actuator.

Ejemplo:

```text
/actuator/health
```

Estos endpoints permiten verificar el estado de ejecución de los servicios.

---

# 4. Infraestructura Docker

La arquitectura completa se ejecuta mediante Docker Compose.

Principales contenedores:

```text
authorization-server

config-server

eureka-server

bff-web

ms-cuentas

ms-intereses

ms-transacciones

postgres

kafka-1

kafka-2

kafka-3
```

## Comandos utilizados

Levantar servicios:

```bash
docker compose up -d
```

Ver estado de contenedores:

```bash
docker compose ps
```

Consultar logs:

```bash
docker compose logs nombre-servicio
```

Detener servicios:

```bash
docker compose down
```

---

# 5. Validaciones realizadas

Durante la implementación se verificó:

- Estado de los contenedores mediante Docker Compose.
- Registro de servicios mediante Eureka.
- Obtención de configuración mediante Config Server.
- Persistencia en PostgreSQL.
- Publicación de eventos mediante Kafka.
- Autenticación mediante OAuth2/JWT.
- Funcionamiento de Circuit Breaker con Resilience4j.
- Estado de salud mediante Spring Boot Actuator.

---

# 6. Tecnologías utilizadas

| Tecnología | Uso |
|---|---|
| Java 21 | Desarrollo backend |
| Spring Boot | Creación de microservicios |
| Spring Cloud | Infraestructura distribuida |
| Spring Security OAuth2 | Seguridad JWT |
| Eureka Server | Descubrimiento de servicios |
| Config Server | Configuración centralizada |
| Apache Kafka | Comunicación basada en eventos |
| PostgreSQL | Persistencia |
| Resilience4j | Tolerancia a fallos |
| Spring Boot Actuator | Monitoreo |
| Docker Compose | Contenerización |