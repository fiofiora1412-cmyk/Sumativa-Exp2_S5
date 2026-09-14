# Proyecto Backend for Frontend (BFF) – Semana 5

## 1. Descripción

Este proyecto corresponde a la continuidad del trabajo desarrollado durante la
Semana 3, incorporando una arquitectura basada en microservicios y el patrón
Backend for Frontend (BFF).

En la etapa anterior, los datos provenientes de archivos CSV fueron procesados
mediante Spring Batch y almacenados en una base de datos PostgreSQL.

Para esta etapa se incorporaron microservicios encargados de exponer la
información almacenada en las tablas de la base de datos y tres BFF
independientes, uno para cada canal de consumo:

- Web
- Mobile
- ATM

Cada BFF actúa como un backend específico para su respectivo canal. Los BFF
consumen los microservicios mediante HTTP, pudiendo combinar, transformar y
reducir la información antes de entregarla al cliente.

De esta manera, cada canal recibe una respuesta adaptada a sus necesidades,
evitando que los clientes deban consumir directamente todos los servicios
disponibles del sistema.

---

## 2. Objetivo

El objetivo de esta implementación es aplicar el patrón arquitectónico
Backend for Frontend (BFF) mediante la creación de un backend independiente
para los canales Web, Mobile y ATM.

La solución busca:

- Separar los backends de cada canal de consumo.
- Utilizar microservicios como backend real del sistema.
- Permitir que los BFF consuman información desde distintos microservicios.
- Combinar información proveniente de múltiples servicios cuando sea necesario.
- Transformar las respuestas de acuerdo con las necesidades de cada canal.
- Reducir la cantidad de información enviada a los clientes cuando corresponda.
- Mantener una estructura modular que permita extender la solución.

---

## 3. Arquitectura

El proyecto utiliza una arquitectura compuesta por Spring Batch, PostgreSQL,
microservicios y tres Backend for Frontend (BFF).

### 3.1 Flujo general

La información procesada durante la etapa anterior sigue el siguiente flujo:

    CSV
     |
     v
    Spring Batch
     |
     v
    PostgreSQL
     |
     +----------------------+----------------------+
     |                      |                      |
     v                      v                      v
    ms-transacciones      ms-cuentas          ms-intereses
       :8091                 :8092                 :8093
     |                      |                      |
     +----------------------+----------------------+
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
           BFF Web      BFF Mobile     BFF ATM
            :8081          :8082          :8083
              |             |             |
              v             v             v
             Web          Mobile          ATM

Los microservicios funcionan como backend real del sistema y son responsables
de exponer la información almacenada en PostgreSQL.

Los BFF funcionan como una capa intermedia entre los clientes y los
microservicios. Estos realizan llamadas HTTP a los servicios correspondientes
y posteriormente adaptan la información antes de entregarla al canal
solicitante.

Los BFF no acceden directamente a PostgreSQL.

---

## 4. Estrategia BFF utilizada

Se implementó una estrategia basada en un BFF independiente para cada tipo
de cliente:

- `bff-web`
- `bff-mobile`
- `bff-atm`

Cada BFF posee su propia lógica de presentación y adaptación mediante
Controllers, Services, Clients y DTOs.

Los microservicios se encargan de exponer los datos provenientes de
PostgreSQL, mientras que los BFF se encargan de consumir, combinar,
transformar y optimizar dicha información para cada canal.

### 4.1 BFF Web

El BFF Web está orientado a entregar respuestas con mayor nivel de detalle,
considerando las necesidades de una interfaz Web.

Consume información desde:

- `ms-transacciones`
- `ms-cuentas`
- `ms-intereses`

Entre sus funciones se encuentra la composición de información de cuentas,
movimientos e intereses procesados.

### 4.2 BFF Mobile

El BFF Mobile está orientado a entregar respuestas más ligeras para reducir
la cantidad de información transferida al dispositivo móvil.

Consume información desde:

- `ms-transacciones`
- `ms-cuentas`
- `ms-intereses`

Además de consumir los microservicios, transforma las respuestas para entregar
solamente los campos necesarios para determinadas operaciones del canal
Mobile.

### 4.3 BFF ATM

El BFF ATM está orientado a entregar información resumida y eficiente para
las operaciones correspondientes a este canal.

Consume información desde:

- `ms-cuentas`
- `ms-intereses`

Para determinadas respuestas, el BFF combina información proveniente de
ambos microservicios y aplica transformaciones para reducir el tamaño de la
respuesta.

Por ejemplo, en el resumen de una cuenta se limita la cantidad de movimientos
mostrados y se filtran registros de intereses que no aportan información
relevante para dicha respuesta.

---

## 5. Principio de separación entre microservicios y BFF

La solución mantiene una separación clara de responsabilidades.

Los microservicios son responsables de:

- Acceder a la información correspondiente.
- Consultar las tablas de PostgreSQL.
- Exponer los datos mediante endpoints HTTP.

Los BFF son responsables de:

- Consumir los microservicios.
- Coordinar llamadas a uno o más servicios.
- Combinar información cuando sea necesario.
- Transformar los datos.
- Definir DTOs específicos para cada canal.
- Reducir la información enviada al cliente.

Por lo tanto, el acceso a la base de datos se mantiene dentro de los
microservicios y los BFF trabajan exclusivamente como capa de adaptación
entre estos servicios y los clientes finales.

## 6. Microservicios Backend

Los microservicios corresponden al backend real de la solución. Su función es
exponer mediante APIs REST la información almacenada en PostgreSQL para que
los BFF puedan consumirla.

Cada microservicio se especializa en un conjunto de datos y mantiene su propia
estructura de Controller, Repository y Model.

Los BFF no realizan consultas directas a la base de datos. En su lugar,
consumen los endpoints expuestos por estos microservicios.

### 6.1 ms-transacciones

**Puerto:** `8091`

**Responsabilidad:**

Este microservicio expone la información de las transacciones procesadas por
Spring Batch y almacenadas en la tabla `transacciones_procesadas`.

**Tabla utilizada:**

`transacciones_procesadas`

**Endpoints:**

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/transacciones` | Obtiene las transacciones procesadas. |
| GET | `/api/transacciones/{id}` | Obtiene una transacción específica mediante su identificador. |
| GET | `/api/transacciones/anomalias` | Obtiene las transacciones identificadas como anómalas. |

**Estructura principal:**

    ms-transacciones
    └── src/main/java/com/bankxyz/transacciones
        ├── controller
        │   └── TransaccionController
        ├── model
        │   └── TransaccionProcesada
        └── repository
            └── TransaccionRepository

El modelo `TransaccionProcesada` representa información como el identificador
de la transacción, fecha, monto, tipo, indicador de anomalía y motivo de la
anomalía.

---

### 6.2 ms-cuentas

**Puerto:** `8092`

**Responsabilidad:**

Este microservicio expone los movimientos asociados a una cuenta bancaria,
utilizando la información almacenada en la tabla `estados_cuenta`.

**Tabla utilizada:**

`estados_cuenta`

**Endpoint:**

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/cuentas/{cuentaId}/movimientos` | Obtiene los movimientos asociados a una cuenta. |

**Estructura principal:**

    ms-cuentas
    └── src/main/java/com/bankxyz/ms_cuentas
        ├── controller
        │   └── CuentaController
        ├── model
        │   └── MovimientoCuenta
        └── repository
            └── CuentaRepository

El modelo `MovimientoCuenta` representa los datos de los movimientos
almacenados para una cuenta, incluyendo:

- Identificador de cuenta.
- Fecha.
- Tipo de transacción.
- Monto.
- Descripción.

---

### 6.3 ms-intereses

**Puerto:** `8093`

**Responsabilidad:**

Este microservicio expone la información de intereses procesados mediante
Spring Batch y almacenados en la tabla `intereses_procesados`.

**Tabla utilizada:**

`intereses_procesados`

**Endpoint:**

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/intereses/{cuentaId}` | Obtiene la información de intereses procesados asociada a una cuenta. |

**Estructura principal:**

    ms-intereses
    └── src/main/java/com/bankxyz/ms_intereses
        ├── controller
        │   └── InteresController
        ├── model
        │   └── Interes
        └── repository
            └── InteresRepository

El modelo `Interes` representa información como:

- Identificador de cuenta.
- Nombre.
- Saldo procesado.
- Edad.
- Tipo de cuenta.
- Tasa de interés.
- Interés calculado.
- Saldo final procesado.

---

### 6.4 Comunicación con los BFF

Los microservicios no están expuestos directamente a los clientes finales
como parte de la lógica de los canales. Los BFF actúan como intermediarios
y consumen los endpoints necesarios según las necesidades de cada frontend.

La comunicación general es:

    BFF Web ────────┐
    BFF Mobile ────┼──→ Microservicios Backend ──→ PostgreSQL
    BFF ATM ───────┘

De esta manera, los microservicios concentran el acceso y exposición de los
datos, mientras que cada BFF determina qué información debe recibir y en qué
formato debe ser entregada al cliente.

## 7. BFF Web

**Puerto:** `8081`

El BFF Web corresponde al backend específico para el canal Web.

Su función es consumir los microservicios necesarios y entregar al cliente
Web respuestas con un mayor nivel de detalle, incluyendo información
proveniente de diferentes servicios cuando la operación lo requiere.

El BFF Web no accede directamente a PostgreSQL. Todas las consultas se
realizan mediante los endpoints expuestos por los microservicios Backend.

### 7.1 Microservicios utilizados

El BFF Web consume los tres microservicios disponibles:

- `ms-transacciones` (`8091`)
- `ms-cuentas` (`8092`)
- `ms-intereses` (`8093`)

La utilización de estos servicios permite que el BFF pueda combinar
información relacionada con transacciones, movimientos de cuentas e
intereses procesados.

### 7.2 Endpoints

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/web/transacciones` | Obtiene las transacciones procesadas para el canal Web. |
| GET | `/api/web/cuentas/{cuentaId}` | Obtiene información de una cuenta combinando información de distintos microservicios. |
| GET | `/api/web/cuentas/{cuentaId}/movimientos` | Obtiene los movimientos de una cuenta para el canal Web. |

### 7.3 Composición de información

Una de las funciones principales del BFF Web es realizar la composición de
información proveniente de diferentes microservicios.

Para obtener la información de una cuenta, el BFF puede realizar consultas
a:

    ms-cuentas
         |
         | movimientos
         v
    BFF Web
         ^
         | información de intereses
         |
    ms-intereses

El servicio del BFF recibe las respuestas de los microservicios y construye
un DTO específico para el canal Web.

La respuesta puede contener información como:

- Identificador de cuenta.
- Nombre.
- Tipo de cuenta.
- Saldo inicial procesado.
- Interés calculado.
- Saldo final procesado.
- Movimientos asociados.

Los valores relacionados con saldo corresponden a la información procesada
por el sistema y no representan necesariamente un saldo disponible actual.

### 7.4 Transformación de respuestas

El BFF Web utiliza DTOs propios para evitar entregar directamente los modelos
utilizados por los microservicios.

Entre ellos se encuentran:

- `CuentaWebDTO`
- `MovimientoWebDTO`
- `MovimientoCuentaResponseDTO`
- `InteresResponseDTO`

Por ejemplo, los movimientos entregados al canal Web incluyen información
como la fecha, transacción, monto y descripción.

Esto permite que la respuesta esté adaptada al consumidor Web en lugar de
exponer directamente la estructura interna de los microservicios.

### 7.5 Estructura

    bff-web
    └── src/main/java/com/bankxyz/bff_web
        ├── client
        │   ├── TransaccionClient
        │   ├── CuentaClient
        │   └── InteresClient
        ├── controller
        │   └── WebController
        ├── dto
        │   ├── CuentaWebDTO
        │   ├── MovimientoWebDTO
        │   ├── MovimientoCuentaResponseDTO
        │   └── InteresResponseDTO
        └── service
            └── WebService

### 7.6 Responsabilidad de las capas

**Controller**

Recibe las solicitudes HTTP realizadas al BFF Web y expone los endpoints
correspondientes al canal.

**Service**

Contiene la lógica de composición y adaptación de la información recibida
desde los microservicios.

**Client**

Se encarga de realizar las llamadas HTTP hacia los microservicios Backend.

**DTO**

Define las estructuras de datos que serán entregadas específicamente al
cliente Web.

Esta separación permite mantener la lógica de consumo de servicios,
composición y exposición organizada dentro del BFF.

## 8. BFF Mobile

**Puerto:** `8082`

El BFF Mobile corresponde al backend específico para el canal Mobile.

Su objetivo es adaptar las respuestas de los microservicios a las necesidades
de una aplicación móvil, reduciendo la cantidad de información transferida
cuando esta no es necesaria para el cliente.

Al igual que los demás BFF, no accede directamente a PostgreSQL. Las
consultas se realizan mediante los microservicios Backend.

### 8.1 Microservicios utilizados

El BFF Mobile consume:

- `ms-transacciones` (`8091`)
- `ms-cuentas` (`8092`)
- `ms-intereses` (`8093`)

Estos servicios proporcionan la información necesaria para construir las
respuestas específicas del canal Mobile.

### 8.2 Endpoints

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/mobile/transacciones` | Obtiene las transacciones adaptadas para Mobile. |
| GET | `/api/mobile/cuentas/{cuentaId}` | Obtiene información resumida de una cuenta para Mobile. |
| GET | `/api/mobile/cuentas/{cuentaId}/movimientos` | Obtiene los movimientos adaptados para Mobile. |

### 8.3 Adaptación de información

El BFF Mobile transforma las respuestas obtenidas desde los microservicios
antes de entregarlas al cliente.

Un ejemplo corresponde a las transacciones.

La respuesta del microservicio contiene información detallada de una
transacción:

    {
      "transaccionId": 993,
      "fecha": null,
      "monto": 700.00,
      "tipo": "invalid",
      "esAnomalia": true,
      "motivoAnomalia": "Formato de fecha inválido: 2024-13-01; Tipo de transacción no válido: invalid"
    }

El BFF Mobile transforma esta información a una estructura más reducida:

    {
      "id": 993,
      "monto": 700.00,
      "tipo": "invalid"
    }

De esta forma, el cliente Mobile recibe solamente los campos necesarios para
esta representación.

### 8.4 Optimización del tamaño de las respuestas

Durante las pruebas realizadas mediante Postman se comparó el tamaño de las
respuestas entre los canales Web y Mobile.

Para el endpoint de transacciones se obtuvieron los siguientes resultados:

| Canal | Endpoint | Tamaño |
|---|---|---:|
| Web | `/api/web/transacciones` | 131.77 KB |
| Mobile | `/api/mobile/transacciones` | 42.18 KB |

La respuesta del canal Mobile fue considerablemente menor debido a la
transformación y reducción de los datos entregados.

La diferencia corresponde aproximadamente a una reducción del 68 % del
tamaño de la respuesta respecto de la respuesta Web utilizada como
referencia.

### 8.5 Resumen de cuentas

El endpoint:

    GET /api/mobile/cuentas/{cuentaId}

entrega una respuesta reducida respecto de la utilizada por el canal Web.

Por ejemplo, para la cuenta `101`, la respuesta Mobile contiene:

    {
      "cuentaId": 101,
      "nombre": "Diana Prince",
      "tipo": "ahorro",
      "saldoInicial": 8000.00,
      "saldoFinal": 8040.00
    }

Mientras que el BFF Web incorpora información adicional, como los
movimientos y el interés calculado.

Los valores de saldo corresponden a información procesada por el sistema y
no deben interpretarse como un saldo disponible actual.

### 8.6 Estructura

    bff-mobile
    └── src/main/java/com/bankxyz/bff_mobile
        ├── client
        │   ├── CuentaClient
        │   ├── InteresClient
        │   └── TransaccionClient
        ├── controller
        │   └── MobileController
        ├── dto
        │   ├── CuentaMobileDTO
        │   ├── InteresResponseDTO
        │   ├── MovimientoCuentaResponseDTO
        │   ├── MovimientoMobileDTO
        │   ├── TransaccionMobileDTO
        │   └── TransaccionResponseDTO
        └── service
            └── MobileService

### 8.7 Responsabilidad de las capas

**Controller**

Recibe las solicitudes HTTP dirigidas al canal Mobile y expone los endpoints
correspondientes.

**Service**

Contiene la lógica de transformación, composición y adaptación de las
respuestas para Mobile.

**Client**

Realiza las llamadas HTTP hacia los microservicios Backend.

**DTO**

Define estructuras específicas para entregar solamente la información
necesaria al cliente Mobile.

Esta separación permite mantener la lógica del canal Mobile independiente de
la implementación de los demás BFF.

## 9. BFF ATM

**Puerto:** `8083`

El BFF ATM corresponde al backend específico para el canal ATM.

Su objetivo es entregar respuestas reducidas y orientadas a las necesidades
del canal, evitando enviar información que no es necesaria para este tipo de
cliente.

El BFF ATM no accede directamente a PostgreSQL. Consume la información
mediante los microservicios Backend.

### 9.1 Microservicios utilizados

El BFF ATM utiliza los siguientes microservicios:

- `ms-cuentas` (`8092`)
- `ms-intereses` (`8093`)

No utiliza `ms-transacciones`, debido a que las operaciones implementadas para
este canal no requieren consultar el listado general de transacciones
procesadas.

### 9.2 Endpoints

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/atm/cuentas/{cuentaId}/movimientos` | Obtiene los movimientos de una cuenta adaptados al canal ATM. |
| GET | `/api/atm/cuentas/{cuentaId}/resumen` | Obtiene un resumen de una cuenta combinando información de movimientos e intereses procesados. |

### 9.3 Adaptación de movimientos

El endpoint:

    GET /api/atm/cuentas/{cuentaId}/movimientos

consume información desde `ms-cuentas`.

El BFF transforma los objetos recibidos para utilizar un DTO específico del
canal ATM.

La respuesta ATM conserva:

- Fecha.
- Tipo de transacción.
- Monto.

Se omiten campos que no son necesarios para esta representación, como el
identificador de cuenta y la descripción del movimiento.

### 9.4 Composición del resumen

El endpoint:

    GET /api/atm/cuentas/{cuentaId}/resumen

combina información proveniente de dos microservicios:

    ms-cuentas
         |
         | movimientos
         v
       BFF ATM
         ^
         | intereses procesados
         |
    ms-intereses

El BFF recibe ambas respuestas y construye un único objeto de respuesta:

    CuentaResumenAtmDTO

Este objeto contiene:

- `cuentaId`
- `movimientos`
- `interesesProcesados`

Los movimientos son transformados a `MovimientoAtmDTO` y los datos de
intereses son transformados a `InteresAtmDTO`.

### 9.5 Optimización del resumen

Para reducir el tamaño de la respuesta, el BFF ATM aplica transformaciones
sobre la información recibida.

En los movimientos, el resumen limita la respuesta a los últimos 5 registros
considerando el orden entregado por el microservicio.

En los intereses procesados, se filtran aquellos registros cuyo
`interesCalculado` es nulo o igual a cero.

Como resultado, durante las pruebas se obtuvo:

| Estado | Movimientos | Intereses | Tamaño aproximado |
|---|---:|---:|---:|
| Antes de la optimización | 46 | 17 | 4.9 KB |
| Después de la optimización | 5 | 6 | 1.17 KB |

La respuesta pasó de aproximadamente 4.9 KB a 1.17 KB, representando una
reducción aproximada del 76 % en el tamaño de la respuesta.

Esta optimización permite que el canal ATM reciba una cantidad de información
menor y más adecuada para el objetivo del endpoint.

### 9.6 Estructura

    bff-atm
    └── src/main/java/com/bankxyz/bff_atm
        ├── client
        │   ├── CuentaClient
        │   └── InteresClient
        ├── controller
        │   └── AtmController
        ├── dto
        │   ├── CuentaResumenAtmDTO
        │   ├── InteresAtmDTO
        │   ├── InteresResponseDTO
        │   ├── MovimientoAtmDTO
        │   └── MovimientoCuentaResponseDTO
        └── service
            └── AtmService

### 9.7 Responsabilidad de las capas

**Controller**

Recibe las solicitudes HTTP dirigidas al canal ATM y expone los endpoints
correspondientes.

**Service**

Contiene la lógica de composición, transformación y optimización de las
respuestas.

**Client**

Realiza las llamadas HTTP hacia `ms-cuentas` y `ms-intereses`.

**DTO**

Define estructuras específicas para el canal ATM y permite controlar qué
información se entrega al cliente.

Esta separación mantiene independiente la implementación del canal ATM y
permite adaptar las respuestas sin modificar los microservicios Backend.

## 10. Transformación y adaptación de respuestas

Una de las funciones principales de los BFF implementados es adaptar la
información proporcionada por los microservicios a las necesidades
particulares de cada canal.

Los microservicios entregan información asociada a las tablas del sistema,
mientras que cada BFF utiliza DTOs propios para controlar la estructura final
de las respuestas.

De esta manera, los clientes no necesitan conocer la estructura interna de
los microservicios.

### 10.1 Adaptación para Web

El canal Web utiliza respuestas con mayor nivel de detalle.

Por ejemplo, la información de una cuenta puede integrar información
proveniente de `ms-cuentas` y `ms-intereses`.

El BFF Web construye una respuesta mediante `CuentaWebDTO`, incorporando
información de la cuenta, intereses procesados y movimientos.

Los movimientos incluyen:

- Fecha.
- Tipo de transacción.
- Monto.
- Descripción.

Esto permite entregar una representación más completa para el canal Web.

### 10.2 Adaptación para Mobile

El canal Mobile utiliza estructuras más reducidas.

Un ejemplo corresponde a la transformación de una transacción.

La información recibida desde el microservicio contiene:

    transaccionId
    fecha
    monto
    tipo
    esAnomalia
    motivoAnomalia

El BFF Mobile transforma esta información para entregar:

    id
    monto
    tipo

Esta transformación evita enviar información que no es necesaria para esa
representación Mobile.

También se reduce la información entregada en las consultas de cuentas y
movimientos.

### 10.3 Adaptación para ATM

El canal ATM utiliza DTOs específicos para entregar información resumida.

En los movimientos se mantienen únicamente:

- Fecha.
- Tipo de transacción.
- Monto.

Además, el endpoint de resumen combina información de `ms-cuentas` y
`ms-intereses`.

El BFF ATM limita la cantidad de movimientos incluidos en el resumen y
filtra registros de intereses cuyo interés calculado sea nulo o igual a cero.

El resultado es una respuesta más pequeña y orientada a las necesidades del
canal ATM.

### 10.4 Comparación entre canales

Los tres BFF reciben información desde los microservicios, pero no entregan
necesariamente la misma estructura.

| Característica | Web | Mobile | ATM |
|---|---|---|---|
| BFF independiente | Sí | Sí | Sí |
| DTOs específicos | Sí | Sí | Sí |
| Transformación de datos | Sí | Sí | Sí |
| Composición de servicios | Sí | Sí | Sí, en el resumen |
| Reducción de información | Sí | Sí | Sí |
| Respuestas orientadas al canal | Sí | Sí | Sí |

La diferencia entre las respuestas demuestra la aplicación del patrón BFF:
cada backend adapta la información de acuerdo con las necesidades del cliente
que consume el servicio.

## 11. Organización del código

La solución se encuentra organizada en proyectos independientes para separar
las responsabilidades de procesamiento, acceso a datos, exposición de
servicios y adaptación de respuestas.

La estructura general del proyecto es:

    Sumativa S5/
    ├── Exp1_S3-main/
    ├── ms-transacciones/
    ├── ms-cuentas/
    ├── ms-intereses/
    ├── bff-web/
    ├── bff-mobile/
    └── bff-atm/

### 11.1 Proyecto de procesamiento

`Exp1_S3-main` corresponde al proyecto desarrollado durante la etapa anterior.

Su función es procesar los archivos CSV mediante Spring Batch y almacenar los
resultados en PostgreSQL.

Este proyecto se mantiene separado de los microservicios y BFF desarrollados
para esta etapa.

### 11.2 Estructura de los microservicios

Los microservicios siguen una estructura basada principalmente en tres capas:

    microservicio/
    └── src/main/java/
        └── paquete/
            ├── controller/
            ├── model/
            └── repository/

**Controller**

Expone los endpoints REST que pueden ser consumidos por los BFF.

**Repository**

Contiene las consultas utilizadas para obtener la información desde
PostgreSQL.

**Model**

Representa los datos que maneja cada microservicio.

Cada microservicio mantiene su responsabilidad específica y no contiene la
lógica particular de presentación de los canales Web, Mobile o ATM.

### 11.3 Estructura de los BFF

Los tres BFF utilizan una estructura modular:

    bff/
    └── src/main/java/
        └── paquete/
            ├── client/
            ├── controller/
            ├── dto/
            └── service/

**Client**

Contiene los componentes encargados de realizar las llamadas HTTP hacia los
microservicios Backend.

**Controller**

Expone los endpoints específicos del canal correspondiente.

**Service**

Contiene la lógica de composición, transformación y adaptación de las
respuestas.

**DTO**

Define las estructuras de datos utilizadas para entregar las respuestas al
cliente.

### 11.4 Separación de responsabilidades

La organización permite separar claramente las responsabilidades:

    PostgreSQL
        ↑
    Repository
        ↑
    Microservicio
        ↑
    Client
        ↑
    Service
        ↑
    Controller
        ↑
    Cliente

Esta separación evita concentrar toda la lógica en un único proyecto y
permite modificar la representación de un canal sin tener que modificar los
otros BFF.

Por ejemplo, una transformación realizada específicamente para Mobile se
mantiene dentro de `bff-mobile` y no afecta la implementación de `bff-web` o
`bff-atm`.

### 11.5 Independencia de los BFF

Cada canal dispone de su propio proyecto, puerto, Controller, Service, Client
y DTOs.

Esto permite que las necesidades específicas de cada frontend puedan
evolucionar de manera independiente.

La separación también facilita agregar nuevas transformaciones o endpoints a
un canal sin alterar directamente los demás canales.


## 12. Tecnologías utilizadas

El proyecto utiliza las siguientes tecnologías:

| Tecnología | Uso |
|---|---|
| Java 21 | Lenguaje de programación utilizado en los proyectos. |
| Spring Boot 4.0.8 | Framework utilizado para desarrollar los microservicios y BFF. |
| Spring Batch | Procesamiento de los archivos CSV desarrollado en la etapa anterior. |
| Spring Web | Creación de los endpoints REST y comunicación HTTP entre componentes. |
| Spring JDBC | Acceso a PostgreSQL desde los microservicios y proyecto de procesamiento. |
| PostgreSQL | Base de datos utilizada para almacenar la información procesada. |
| Maven | Gestión de dependencias, compilación y ejecución de los proyectos. |
| Postman | Pruebas de los endpoints y verificación de las respuestas. |

---

## 13. Puertos de las aplicaciones

Para permitir la ejecución simultánea de los diferentes componentes, cada
aplicación utiliza un puerto independiente.

| Aplicación | Puerto | Función |
|---|---:|---|
| `Exp1_S3-main` | `8080` | Procesamiento mediante Spring Batch. |
| `bff-web` | `8081` | Backend específico para Web. |
| `bff-mobile` | `8082` | Backend específico para Mobile. |
| `bff-atm` | `8083` | Backend específico para ATM. |
| `ms-transacciones` | `8091` | Microservicio de transacciones. |
| `ms-cuentas` | `8092` | Microservicio de movimientos de cuentas. |
| `ms-intereses` | `8093` | Microservicio de intereses procesados. |

Los puertos permiten que los BFF y microservicios se ejecuten
simultáneamente y se comuniquen mediante solicitudes HTTP.

### 13.1 Comunicación entre aplicaciones

Las principales comunicaciones utilizadas son:

    BFF Web :8081
        ├──→ ms-transacciones :8091
        ├──→ ms-cuentas :8092
        └──→ ms-intereses :8093

    BFF Mobile :8082
        ├──→ ms-transacciones :8091
        ├──→ ms-cuentas :8092
        └──→ ms-intereses :8093

    BFF ATM :8083
        ├──→ ms-cuentas :8092
        └──→ ms-intereses :8093

Los BFF realizan estas comunicaciones mediante HTTP y reciben las respuestas
de los microservicios para posteriormente transformarlas o combinarlas según
las necesidades de cada canal.


## 14. Requisitos y ejecución

### 14.1 Requisitos

Para ejecutar el proyecto se requiere:

- Java JDK 21.
- Maven, o utilizar el Maven Wrapper incluido en los proyectos.
- PostgreSQL.
- Una base de datos PostgreSQL configurada para el proyecto.
- Postman para realizar las pruebas de los endpoints.

La base de datos utilizada durante el desarrollo se denomina:

    bank_batch

La configuración de conexión a PostgreSQL se encuentra definida en el
archivo de configuración correspondiente al proyecto de procesamiento.

No se deben incluir credenciales reales de la base de datos dentro del
README.

---

### 14.2 Orden de ejecución

La solución está compuesta por varios proyectos independientes. Para
realizar las pruebas de la arquitectura completa se recomienda iniciar los
componentes en el siguiente orden:

1. PostgreSQL.
2. Proyecto `Exp1_S3-main`.
3. `ms-transacciones`.
4. `ms-cuentas`.
5. `ms-intereses`.
6. `bff-web`.
7. `bff-mobile`.
8. `bff-atm`.

Los microservicios deben estar disponibles antes de realizar solicitudes
desde los BFF, ya que estos dependen de sus endpoints HTTP.

---

### 14.3 Ejecución de los microservicios

Cada microservicio puede ejecutarse utilizando el Maven Wrapper incluido en
su proyecto.

Desde la carpeta correspondiente:

    .\mvnw.cmd spring-boot:run

Por ejemplo:

    cd ms-transacciones
    .\mvnw.cmd spring-boot:run

El mismo procedimiento se utiliza para:

    ms-cuentas
    ms-intereses

Cada aplicación debe iniciarse en su puerto correspondiente:

    ms-transacciones → 8091
    ms-cuentas       → 8092
    ms-intereses     → 8093

---

### 14.4 Ejecución de los BFF

Cada BFF se ejecuta de manera independiente.

Para BFF Web:

    cd bff-web
    .\mvnw.cmd spring-boot:run

Para BFF Mobile:

    cd bff-mobile
    .\mvnw.cmd spring-boot:run

Para BFF ATM:

    cd bff-atm
    .\mvnw.cmd spring-boot:run

Los BFF utilizan los siguientes puertos:

    bff-web     → 8081
    bff-mobile  → 8082
    bff-atm     → 8083

---

### 14.5 Ejecución del proyecto de procesamiento

El proyecto `Exp1_S3-main` corresponde a la etapa anterior y es responsable
del procesamiento de los archivos mediante Spring Batch.

Su ejecución permite generar los datos que posteriormente son utilizados por
los microservicios.

El proyecto utiliza PostgreSQL como destino de los datos procesados.

Las principales tablas generadas y utilizadas por la solución son:

    transacciones_procesadas
    intereses_procesados
    estados_cuenta

Una vez que los datos se encuentran disponibles en PostgreSQL, los
microservicios pueden exponerlos mediante sus respectivos endpoints.

---

### 14.6 Flujo de ejecución completo

El flujo de ejecución de la solución es:

    Archivos CSV
         |
         v
    Spring Batch
         |
         v
    PostgreSQL
         |
         v
    Microservicios
         |
         v
    BFF
         |
         v
    Cliente Web / Mobile / ATM

Los microservicios proporcionan los datos y los BFF realizan la adaptación
necesaria antes de entregar las respuestas a cada canal.

## 15. Pruebas de los endpoints

Las pruebas de la solución se realizaron mediante Postman, verificando que
los BFF pudieran comunicarse correctamente con los microservicios y que las
respuestas fueran adaptadas según el canal correspondiente.

### 15.1 Pruebas del BFF Web

#### Obtener transacciones

    GET http://localhost:8081/api/web/transacciones

Este endpoint permite obtener las transacciones procesadas y entregadas al
canal Web.

#### Obtener información de una cuenta

    GET http://localhost:8081/api/web/cuentas/101

Este endpoint combina información asociada a la cuenta y entrega una
respuesta con mayor nivel de detalle para el canal Web.

#### Obtener movimientos

    GET http://localhost:8081/api/web/cuentas/101/movimientos

Este endpoint obtiene los movimientos asociados a la cuenta seleccionada.

---

### 15.2 Pruebas del BFF Mobile

#### Obtener transacciones

    GET http://localhost:8082/api/mobile/transacciones

El endpoint entrega las transacciones adaptadas al formato utilizado por
Mobile.

#### Obtener información de una cuenta

    GET http://localhost:8082/api/mobile/cuentas/101

El endpoint entrega una respuesta reducida respecto de la utilizada por el
canal Web.

#### Obtener movimientos

    GET http://localhost:8082/api/mobile/cuentas/101/movimientos

El endpoint entrega los movimientos utilizando el formato específico del
canal Mobile.

---

### 15.3 Pruebas del BFF ATM

#### Obtener movimientos

    GET http://localhost:8083/api/atm/cuentas/101/movimientos

El endpoint entrega los movimientos de la cuenta utilizando una estructura
reducida para el canal ATM.

#### Obtener resumen de cuenta

    GET http://localhost:8083/api/atm/cuentas/101/resumen

Este endpoint combina información proveniente de `ms-cuentas` y
`ms-intereses`.

La respuesta contiene:

- Identificador de cuenta.
- Movimientos seleccionados.
- Intereses procesados seleccionados.

---

### 15.4 Resultado de las pruebas

Las pruebas permitieron verificar:

- Disponibilidad de los tres BFF.
- Comunicación entre los BFF y los microservicios.
- Obtención correcta de información desde PostgreSQL a través de los
  microservicios.
- Transformación de respuestas según el canal.
- Reducción de información en los canales Mobile y ATM.
- Composición de información proveniente de múltiples microservicios.
- Funcionamiento de los endpoints definidos para cada canal.

Las pruebas fueron realizadas utilizando la cuenta `101` como referencia
para las operaciones relacionadas con cuentas y movimientos.

## 16. Evidencia de optimización

La implementación de los BFF permite adaptar y reducir las respuestas
entregadas a cada canal.

Para verificar esta característica se realizaron pruebas utilizando Postman,
comparando el tamaño y contenido de las respuestas obtenidas desde los
distintos BFF.

### 16.1 Comparación de transacciones

Se comparó el endpoint de transacciones del canal Web con el correspondiente
al canal Mobile.

| Canal | Endpoint | Tamaño de respuesta |
|---|---|---:|
| Web | `/api/web/transacciones` | 131.77 KB |
| Mobile | `/api/mobile/transacciones` | 42.18 KB |

La respuesta Mobile presenta una reducción aproximada del 68 % respecto de
la respuesta Web utilizada como referencia.

Además de la diferencia de tamaño, ambos canales utilizan estructuras de
respuesta diferentes.

Por ejemplo, una transacción puede ser entregada por Web con información
como:

    transaccionId
    fecha
    monto
    tipo
    esAnomalia
    motivoAnomalia

Mientras que Mobile puede reducir esta información a:

    id
    monto
    tipo

Esto demuestra que el BFF Mobile no actúa solamente como intermediario, sino
que transforma la información recibida desde el microservicio.

### 16.2 Comparación de información de cuentas

También se compararon las respuestas correspondientes a la cuenta `101`.

| Canal | Endpoint | Tamaño de respuesta |
|---|---|---:|
| Web | `/api/web/cuentas/101` | 4.38 KB |
| Mobile | `/api/mobile/cuentas/101` | 257 B |
| ATM | `/api/atm/cuentas/101/resumen` | 1.17 KB |

Las diferencias se deben a que cada BFF entrega una estructura adaptada a
las necesidades de su respectivo canal.

El BFF Web entrega una respuesta más detallada, mientras que Mobile utiliza
una estructura considerablemente más reducida.

El BFF ATM genera una respuesta resumida mediante la composición de
información proveniente de diferentes microservicios.

### 16.3 Optimización del resumen ATM

Para comprobar la optimización realizada en el BFF ATM se comparó la
respuesta antes y después de aplicar las transformaciones implementadas.

Antes de la optimización, el resumen contenía aproximadamente:

- 46 movimientos.
- 17 registros de intereses.
- 4.9 KB de información.

Después de aplicar las transformaciones:

- 5 movimientos.
- 6 registros de intereses.
- 1.17 KB de información.

La reducción del tamaño fue aproximadamente del 76 %.

Esta reducción se obtiene principalmente mediante:

- Limitación de los movimientos incluidos en el resumen.
- Eliminación de información de campos que no son necesarios para el canal.
- Filtrado de registros de intereses cuyo interés calculado es nulo o igual
  a cero.
- Composición de la información necesaria en un único DTO específico para
  ATM.

### 16.4 Evidencia mediante Postman

Las pruebas realizadas mediante Postman permiten verificar tanto el
funcionamiento de los endpoints como las diferencias entre las respuestas
de cada canal.

Las capturas correspondientes a estas pruebas forman parte de la evidencia
de ejecución del proyecto y permiten comprobar:

- Disponibilidad de los tres BFF.
- Diferencias de tamaño entre respuestas.
- Transformación de estructuras.
- Reducción de información.
- Composición de información proveniente de múltiples microservicios.

## 17. Decisiones de diseño

Durante la implementación se tomaron decisiones orientadas a mantener la
separación de responsabilidades entre el backend real y los BFF, además de
adaptar las respuestas a las necesidades de cada canal.

### 17.1 Separación entre microservicios y BFF

Los BFF no realizan consultas directas a PostgreSQL.

El acceso a la base de datos se mantiene dentro de los microservicios, los
cuales exponen la información mediante endpoints REST.

Los BFF consumen estos endpoints y se encargan de la lógica específica de
cada canal.

Esta separación permite mantener independientes:

- Acceso a datos.
- Exposición de información.
- Lógica de adaptación de cada canal.

### 17.2 Un BFF independiente por canal

Se implementaron tres proyectos independientes:

- `bff-web`
- `bff-mobile`
- `bff-atm`

Esta decisión permite que cada canal tenga sus propios Controllers, Services,
Clients y DTOs.

De esta manera, una modificación realizada para un canal no requiere
modificar directamente la implementación de los demás.

### 17.3 Uso de DTOs específicos

Cada BFF utiliza DTOs propios para controlar la información entregada al
cliente.

Esto permite evitar que las estructuras internas utilizadas por los
microservicios sean expuestas directamente a los consumidores.

Los DTOs también permiten reducir campos cuando un canal no necesita la
información completa.

### 17.4 Composición de información

Los BFF pueden consumir más de un microservicio cuando una respuesta requiere
información proveniente de diferentes fuentes.

Un ejemplo es el BFF ATM, cuyo endpoint de resumen combina información
proveniente de:

    ms-cuentas
          +
    ms-intereses
          |
          v
       BFF ATM
          |
          v
    respuesta resumida

El BFF recibe las respuestas de ambos servicios y construye una respuesta
única mediante `CuentaResumenAtmDTO`.

### 17.5 Optimización específica por canal

Las respuestas no se diseñaron para que los tres canales recibieran
exactamente la misma información.

Web utiliza respuestas con mayor nivel de detalle.

Mobile reduce la cantidad de información transferida cuando esta no es
necesaria.

ATM utiliza respuestas resumidas y aplica filtros y límites para disminuir
el volumen de información.

Esta diferencia permite que cada BFF cumpla su función como backend
específico del canal.

### 17.6 Decisión respecto a los datos de saldo

Durante las pruebas se identificó que los datos disponibles en las tablas
procesadas no permiten determinar de manera inequívoca un saldo disponible
actual para una cuenta.

Por este motivo, la implementación no realiza un cálculo de saldo disponible
inventado.

Los campos `saldoInicial` y `saldoFinal` utilizados en las respuestas
corresponden a información procesada por el sistema de intereses y se
documentan como tal.

El BFF ATM entrega movimientos e información de intereses procesados en su
resumen, sin presentar estos datos como un saldo disponible actual.

### 17.7 Independencia del proyecto de procesamiento

El proyecto `Exp1_S3-main` se mantiene separado de los microservicios y BFF.

Su responsabilidad corresponde al procesamiento de los archivos CSV mediante
Spring Batch y al almacenamiento de los resultados en PostgreSQL.

Los microservicios utilizan posteriormente estos datos para exponerlos a los
BFF.

Esta separación permite mantener la continuidad entre las etapas del
proyecto sin mezclar la lógica de procesamiento Batch con la lógica de
consumo y adaptación propia de los BFF.

## 18. Estructura general del proyecto

La solución completa se organiza en proyectos independientes, manteniendo
separadas las responsabilidades de procesamiento, acceso a datos y adaptación
para cada canal.

La estructura general es:

    Sumativa S5/
    │
    ├── Exp1_S3-main/
    │   └── Procesamiento mediante Spring Batch
    │
    ├── ms-transacciones/
    │   └── Microservicio de transacciones
    │
    ├── ms-cuentas/
    │   └── Microservicio de movimientos de cuentas
    │
    ├── ms-intereses/
    │   └── Microservicio de intereses procesados
    │
    ├── bff-web/
    │   └── Backend for Frontend para Web
    │
    ├── bff-mobile/
    │   └── Backend for Frontend para Mobile
    │
    └── bff-atm/
        └── Backend for Frontend para ATM

### 18.1 Flujo de responsabilidades

Cada componente cumple una responsabilidad específica dentro de la
arquitectura:

    CSV
     ↓
    Spring Batch
     ↓
    PostgreSQL
     ↓
    Microservicios Backend
     ↓
    BFF específicos por canal
     ↓
    Clientes Web / Mobile / ATM

El procesamiento inicial genera la información que posteriormente es
consultada por los microservicios.

Los microservicios exponen los datos mediante APIs REST.

Los BFF consumen estas APIs y aplican la lógica específica de cada canal,
incluyendo transformación, composición y optimización de respuestas.

### 18.2 Independencia de los canales

La implementación mantiene tres BFF independientes:

    bff-web
    bff-mobile
    bff-atm

Cada uno posee sus propios componentes internos y puede evolucionar de manera
independiente.

Esta estructura permite agregar o modificar funcionalidades específicas de
un canal sin alterar directamente la lógica de los demás.

## 19. Conclusión

La implementación permitió incorporar el patrón Backend for Frontend (BFF)
sobre la solución desarrollada previamente con Spring Batch y PostgreSQL.

Se implementaron tres BFF independientes para los canales Web, Mobile y ATM,
cada uno con sus propios Controllers, Services, Clients y DTOs.

Los BFF consumen información desde los microservicios Backend mediante HTTP,
permitiendo separar el acceso a los datos de la lógica específica de cada
canal.

Además, se implementaron transformaciones, composición de información y
optimización de respuestas. Esto permitió entregar diferentes estructuras de
datos según las necesidades de Web, Mobile y ATM.

Las pruebas realizadas mediante Postman permitieron verificar el
funcionamiento de los endpoints, la comunicación entre los componentes y la
reducción del tamaño de determinadas respuestas.

La arquitectura resultante mantiene una separación clara entre el
procesamiento de datos, los microservicios que exponen la información y los
BFF encargados de adaptarla para cada cliente.