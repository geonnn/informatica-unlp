# Práctica 5
# Capa de Transporte - Parte I

## 1. ¿Cuál es la función de la capa de transporte?

La función primordial de la **capa de transporte** es proporcionar una **comunicación lógica entre procesos de aplicación** que se ejecutan en diferentes _hosts_ de la red.

Mientras que la capa de red (IP) se encarga de la comunicación lógica entre las máquinas (_host-a-host_), la capa de transporte extiende y amplía ese servicio llevando los mensajes directamente desde y hacia los procesos o _sockets_ específicos que corren en cada máquina.

Sus funciones clave son:

1. **Multiplexación y Desmultiplexación:**
    - **Multiplexación (en el emisor):** Recolecta los datos generados por múltiples _sockets_ de aplicación, les añade el encabezado de la capa de transporte (que incluye los números de puerto de origen y destino) y los entrega a la capa de red para su envío.
    - **Desmultiplexación (en el receptor):** Inspecciona los campos del encabezado (números de puerto e IPs) para entregar cada segmento o datagrama recibido al _socket_ o proceso correcto.
    
2. **Provisión de Servicios según el Protocolo Utilizado:**
    - **TCP (orientado a conexión):** Ofrece un servicio de transferencia de datos **confiable y en orden**. Para lograrlo, implementa mecanismos de **control de flujo** (evita saturar el _buffer_ del receptor), **control de congestión** (evita colapsar la red), verificación de integridad mediante _checksum_ y gestión explícita del establecimiento y cierre de la conexión.
    - **UDP (sin conexión):** Ofrece un servicio sin garantías (_best-effort_) de baja sobrecarga. No establece conexión ni ofrece garantías de entrega u ordenamiento, limitándose a extender la entrega IP con multiplexación/desmultiplexación por puertos y detección opcional/básica de errores vía _checksum_.

---
## 2. Describa la estructura del segmento TCP y UDP.

#### Estructura del datagrama / segmento UDP

UDP es un protocolo minimalista de baja sobrecarga (_overhead_). Su encabezado es **fijo de 8 bytes (64 bits)** y se compone de **4 campos de 16 bits (2 bytes)** cada uno:

```
 0                   16                  31 bits
+-------------------+-------------------+
|    Puerto Origen  |   Puerto Destino  |  (4 bytes)
+-------------------+-------------------+
|     Longitud      |     Checksum      |  (4 bytes)
+-------------------+-------------------+
|          Datos (Carga útil)           |
+---------------------------------------+
```

- **Puerto Origen (16 bits):** Identifica el puerto del proceso emisor. Es opcional en IPv4 (si no se utiliza, se coloca en 0).
- **Puerto Destino (16 bits):** Identifica el puerto del proceso receptor que debe atender la solicitud.
- **Longitud (_Length_, 16 bits):** Especifica el tamaño total del datagrama UDP en bytes (encabezado + datos). Su valor mínimo es 8 bytes (un segmento sin payload).
- **Checksum (16 bits):** Utilizado para la detección de errores de bit en el encabezado, la carga útil y la _pseudo-cabecera_ IP.

---
#### Estructura del segmento TCP

TCP es un protocolo orientado a conexión que ofrece control de flujo, control de congestión y entrega confiable. Su encabezado tiene un **tamaño base de 20 bytes (160 bits)**, que puede extenderse hasta 60 bytes si se incluyen opciones.

```
 0                   16                  31 bits
+-------------------+-------------------+
|    Puerto Origen  |   Puerto Destino  |  (4 bytes)
+---------------------------------------+
|          Número de Secuencia          |  (4 bytes)
+---------------------------------------+
|       Número de Reconocimiento (ACK)  |  (4 bytes)
+-------+-------+---+-------------------+
|Offset |Reserv.|Flg|   Ventana Recv    |  (4 bytes)
+-------+-------+---+-------------------+
|     Checksum      |  Puntero Urgente  |  (4 bytes)
+-------------------+-------------------+
|         Opciones (si las hay)         |  (Variable)
+---------------------------------------+
|          Datos (Carga útil)           |
+---------------------------------------+
```

- **Puerto Origen y Destino (16 bits c/u):** Identifican los puertos de los _sockets_ emisor y receptor.
- **Número de Secuencia (_Sequence Number_, 32 bits):** Indica el número asignado al primer byte de datos contenido en el segmento. Durante el inicio de la conexión (flag `SYN`), transporta el número de secuencia inicial (_ISN_).
- **Número de Reconocimiento (_Acknowledgment Number_, 32 bits):** Indica el número del **próximo byte que el receptor espera recibir** (reconocimiento acumulativo).
- **Longitud del encabezado / Offset (4 bits):** Especifica el tamaño del encabezado TCP expresado en palabras de 32 bits (por ejemplo, el valor `5` indica 5 * 4 = 20 bytes).
- **Reservado (3 a 6 bits):** bits reservados para uso futuro.
- **Banderas de Control (_Flags_, 6 a 9 bits):**
    - **`SYN`**: Inicia/establece la conexión y sincroniza los números de secuencia.
    - **`ACK`**: Indica que el campo _Acknowledgment Number_ es válido.
    - **`FIN`**: Solicita el cierre ordenado de la conexión.
    - **`RST`**: Reinicia abruptamente la conexión en caso de errores o rechazos.
    - **`PSH`**: Pide a la capa de transporte entregar los datos inmediatamente a la aplicación (_push_).
    - **`URG`**: Indica que el segmento contiene datos urgentes.
    - _(Opcionales/Modernos)_: `ECE` y `CWR` (notificación explícita de congestión ECN).
- **Tamaño de Ventana (_Window Size_, 16 bits):** Utilizado para el **control de flujo**; informa la cantidad de bytes que el receptor está dispuesto a aceptar en su buffer.
- **Checksum (16 bits):** Detección obligatoria de errores en la cabecera, los datos y la pseudo-cabecera IP.
- **Puntero a Datos Urgentes (_Urgent Pointer_, 16 bits):** Indica la posición del último byte de datos urgentes (solo si el flag `URG` está activo).
- **Opciones (_Options_, longitud variable, 0 a 40 bytes):** Permite negociar características avanzadas como el **MSS** (_Maximum Segment Size_), escala de ventana (_Window Scale_), **SACK** (_Selective ACK_) o marcas de tiempo (_Timestamps_).

---
## 3. ¿Cuál es el objetivo del uso de puertos en el modelo TCP/IP?

El objetivo principal del uso de **números de puerto** es posibilitar la **multiplexación y desmultiplexación** de tráfico en la capa de transporte, permitiendo que múltiples aplicaciones o procesos se comuniquen de manera simultánea e independiente dentro de un mismo host utilizando una única dirección IP.

Mientras que la capa de red (IP) se encarga de direccionar el paquete de una máquina a otra (_host-to-host_), los números de puerto extienden esa comunicación hasta el proceso específico (_process-to-process_), identificando la interfaz lógica o _socket_ asignado a cada aplicación.

---

#### **Funciones clave del uso de puertos:**

1. **Desmultiplexación en la recepción:**
    - Al recibir un datagrama o segmento, la capa de transporte examina los puertos del encabezado para redirigir los datos al _socket_ o proceso correcto.
    - En **UDP**, la desmultiplexación básica se realiza verificando únicamente el **puerto de destino**.
    - En **TCP**, la identificación de la conexión se realiza mediante una **4-upla**: `(IP origen, puerto origen, IP destino, puerto destino)`. Esto permite que un servidor reciba múltiples conexiones simultáneas en un mismo puerto (por ejemplo, el puerto 80 en un servidor web) diferenciando cada cliente por su IP y puerto de origen.

2. **Multiplexación en la emisión:**    
    - Permite recolectar los datos generados por distintos procesos de aplicación, empaquetarlos agregando el número de puerto correspondiente en el encabezado y enviarlos a la capa de red para su transmisión.

3. **Dirección de retorno:**    
    - El campo **puerto de origen** proporciona la información requerida para que el receptor sepa a qué puerto cliente debe dirigir los mensajes de respuesta.

---
#### **Clasificación de puertos (Rangos IANA):**

- **Puertos bien conocidos (_Well-Known Ports_, 0 a 1023):** Asignados a servicios estándar y del sistema operativo (por ejemplo, HTTP en el 80, SSH en el 22, DNS en el 53 o SMTP en el 25).
- **Puertos registrados (_Registered Ports_, 1024 a 49151):** Asignados a aplicaciones y servicios específicos comercializados o desarrollados por terceros.
- **Puertos efímeros o dinámicos (_Dynamic / Private Ports_, 49152 a 65535):** Asignados de forma temporal y automática por el sistema operativo al cliente para identificar la conexión mientras dure la sesión.

---
## 4. Compare TCP y UDP en cuanto a:
- **a. Confiabilidad.**
- **b. Multiplexación.**
- **c. Orientado a la conexión.**
- **d. Controles de congestión.**
- **e. Utilización de puertos.**

| Criterio                       | TCP (_Transmission Control Protocol_)                                                      | UDP (_User Datagram Protocol_)                                                                 |
| :----------------------------- | :----------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- |
| **a. Confiabilidad**           | **Confiable**: garantiza entrega de datos en orden, sin pérdidas ni duplicados.            | **No confiable** (_best-effort_): los datos pueden perderse, duplicarse o llegar desordenados. |
| **b. Multiplexación**          | Desmultiplexación por **4-upla** (IP orig, puerto orig, IP dest, puerto dest).             | Desmultiplexación por **puerto destino** (IP dest, puerto dest).                               |
| **c. Orientado a la conexión** | **Sí**: requiere el saludo de tres vías (_three-way handshake_) previo a la transferencia. | **No** (_connectionless_): cada datagrama se envía de forma independiente y sin estado.        |
| **d. Control de congestión**   | **Sí**: implementa control de flujo y control de congestión de red.                        | **No**: carece de mecanismos de control de congestión o flujo.                                 |
| **e. Utilización de puertos**  | Identifica extremos de una conexión lógica y flujo continuo de bytes (_byte stream_).      | Identifica sockets para la entrega de mensajes/datagramas discretos.                           |

---
#### **a. Confiabilidad**

- **TCP:** Proporciona un servicio de transferencia de datos totalmente **confiable**. Utiliza números de secuencia, acuses de recibo (ACK), retransmisión por temporización (_timeouts_) o ACKs duplicados, y verificación obligatoria mediante _checksum_ para asegurar que los datos lleguen completos, en orden y sin errores al receptor.
- **UDP:** Es un protocolo **no confiable** que ofrece un servicio de "mejor esfuerzo" (_best-effort_). No realiza retransmisiones ni garantiza que los paquetes lleguen o mantengan el orden de emisión. El cálculo del _checksum_ es opcional en IPv4 pero obligatorio en IPv6.

#### **b. Multiplexación y Desmultiplexación**

- **TCP:** Para redirigir el segmento entrante al socket correcto, el receptor evalúa una **4-upla**: `(IP origen, puerto origen, IP destino, puerto destino)`. Esto permite a un servidor (por ejemplo, web) mantener múltiples conexiones abiertas simultáneamente en un mismo puerto de escucha.
- **UDP:** Realiza la desmultiplexación de forma más simple comprobando principalmente la combinación del **puerto destino** y la IP de destino. Datagramas provenientes de diferentes IPs u orígenes dirigidos al mismo puerto destino ingresan al mismo socket.

#### **c. Orientación a la Conexión**

- **TCP:** Es un protocolo **orientado a conexión**. Antes de transmitir datos de aplicación, requiere inicializar los estados en ambos extremos mediante el intercambio de control conocido como **saludo de tres vías** (_three-way handshake_), así como un procedimiento explícito para el cierre de la sesión.
- **UDP:** Es **sin conexión** (_connectionless_). No establece una sesión previa entre emisor y receptor ni mantiene estado de la comunicación en los hosts.

#### **d. Controles de Congestión y Flujo**

- **TCP:** Incluye mecanismos integrados de **control de flujo** (mediante la ventana de recepción para no saturar el buffer del host destino) y **control de congestión** (como _Slow Start_ y _AIMD_ para no sobrecargar los routers intermedios de la red).
- **UDP:** **No posee** ningúno de estos controles. Las aplicaciones que utilizan UDP pueden transmitir al ritmo que deseen sin restringirse por el estado de la red o del receptor.

#### **e. Utilización de Puertos**

- Ambos protocolos reservan **16 bits** en sus encabezados para especificar el puerto de origen y el puerto de destino (permitiendo valores del 0 al 65535).
- **TCP** emplea los puertos para vincular sockets que gestionan una corriente o **flujo continuo de bytes** (_byte stream_) asociado a una conexión específica.
- **UDP** utiliza los puertos para direccionar **datagramas o mensajes discretos e independientes** (_message-based_).

---
## 5. La PDU de la capa de transporte es el segmento. Sin embargo, en algunos contextos suele utilizarse el término datagrama. Indique cuándo.

El término **datagrama** se utiliza en la capa de transporte principalmente cuando se hace referencia a la **PDU del protocolo UDP** (_User Datagram Protocol_).

Los contextos específicos en los que se utiliza cada denominación son los siguientes:

1. **En la PDU de UDP (_Datagrama de usuario_):**
    - En la literatura técnica estándar de Internet (como los RFCs), la PDU de **TCP** se denomina formalmente **segmento**, mientras que la unidad de datos enviada o recibida por **UDP** se denomina habitualmente **datagrama** (o _datagrama UDP_) debido a que transporta mensajes discretos e independientes sin conexión.
    - Por una cuestión de coherencia jerárquica con la capa de transporte, suele aceptarse el término **segmento UDP**, pero el uso de **datagrama UDP** es muy frecuente.
    
2. **En la capa de red (IP):**
    - El término **datagrama** es la denominación estándar de la **PDU de la capa de red** (datagrama IP o paquete de red), la cual se encarga del servicio _best-effort_ y encapsula internamente al segmento o datagrama de transporte.

---
## 6. Describa el saludo de tres vías de TCP. ¿UDP tiene esta característica?

### **Descripción del saludo de tres vías de TCP (_Three-Way Handshake_)**

El **saludo de tres vías** es el mecanismo mediante el cual dos extremos inicializan los estados de una conexión TCP, sincronizan sus números de secuencia iniciales (**ISN**) y reservan los buffers y recursos necesarios antes de comenzar la transferencia de datos:

```
Cliente TCP                               Servidor TCP
 (Activo)                                   (Pasivo)
    |                                          |  LISTEN
    | --------- 1. SYN (ISN = X) ------------> |
    |           (Estado: SYN_SENT)             |  SYN_RCVD
    |                                          |
    | <------- 2. SYN + ACK (ISN = Y, -------- |
    |                        ACK = X + 1)      |
    |  (Estado: ESTABLISHED)                   |
    |                                          |
    | --------- 3. ACK (ACK = Y + 1) --------> |
    |                                          |  ESTABLISHED
    v                                          v
      [ Conexión establecida: inicio de intercambio de datos ]
```

- **Paso 1 (Cliente --> Servidor):**
    - El cliente realiza una apertura activa (_active open_) enviando un segmento de control con el **flag `SYN = 1`**.
    - En este segmento no viajan datos de aplicación y se define el número de secuencia inicial del cliente: **`Seq = X` (ISN)**.
    - El cliente pasa al estado **`SYN_SENT`**.

- **Paso 2 (Servidor --> Cliente):**
    - El servidor (que se encontraba a la espera en estado **`LISTEN`**) acepta la solicitud.
    - Responde con un segmento que tiene activos los flags **`SYN = 1`** y **`ACK = 1`**.
    - Establece su propio número de secuencia inicial: **`Seq = Y` (ISN)**, y confirma la recepción del `SYN` del cliente mediante **`ACK = X + 1`**.
    - El servidor pasa al estado **`SYN_RCVD`**.

- **Paso 3 (Cliente --> Servidor):**
    - El cliente recibe el `SYN+ACK`, pasa al estado **`ESTABLISHED`** y envía la confirmación final con el **flag `ACK = 1`**.
    - Asigna **`Seq = X + 1`** y **`ACK = Y + 1`**.
    - Al recibir este segmento, el servidor pasa también al estado **`ESTABLISHED`**.
    - _(Nota: A partir de este tercer segmento, el protocolo ya permite transportar datos de aplicación)_.

---
### **¿UDP tiene esta característica?**

**No, UDP no posee saludo de tres vías ni ningún mecanismo de establecimiento de conexión**.

- **Es un protocolo sin conexión (_connectionless_)**: No existe una fase previa de negociación entre emisor y receptor.
- Los datagramas UDP se transmiten de manera inmediata hacia la red sin sincronizar previamente números de secuencia, sin reservar buffers y sin verificar si el extremo receptor se encuentra escuchando o preparado para recibirlos.

---
## 7. Investigue qué es el ISN (Initial Sequence Number). Relaciónelo con el saludo de tres vías.

### **1. ¿Qué es el ISN (_Initial Sequence Number_)?**

El **ISN** es el **número de secuencia inicial** de 32 bits que elige cada extremo de una comunicación TCP al comenzar una nueva conexión.

Dado que TCP trata los datos como un flujo continuo de bytes (_stream of bytes_), cada byte transmitido tiene asignado un número de secuencia propio. El ISN define el punto de partida numérico para dicho flujo en cada sentido de la comunicación.

**¿Por qué no se inicia siempre en 0?**

1. **Confusión de segmentos rezagados de conexiones previas:** En una red IP, datagramas pertenecientes a una conexión antigua (entre la misma combinación de IP y puertos) pueden quedar demorados en los routers y llegar más tarde. Si cada conexión arrancara en 0, un segmento rezagado podría coincidir numéricamente con un byte de la nueva conexión y ser aceptado erróneamente como un dato válido.
2. **Seguridad contra ataques de suplantación (_TCP Spoofing_):** Si el número inicial fuera predecible o siempre igual, un atacante externo podría falsificar la dirección IP de origen, adivinar los números de secuencia y forzar la inyección de segmentos válidos o secuestrar sesiones (_session hijacking_). Por este motivo, los sistemas operativos modernos seleccionan el ISN de forma pseudoaleatoria y variable en el tiempo.

---
### **2. Relación del ISN con el Saludo de Tres Vías (_Three-Way Handshake_)**

Durante el saludo de tres vías, los dos extremos no solo acuerdan abrir la conexión, sino que **se informan y sincronizan mutuamente sus respectivos ISN** de forma independiente:

```
Cliente TCP                                             Servidor TCP
    |                                                        |
    | ------- 1. SYN (Seq = client_isn) -------------------> |  (Informa su ISN)
    |                                                        |
    | <------ 2. SYN+ACK (Seq = server_isn, ---------------- |  (Informa su ISN y
    |                     Ack = client_isn + 1)              |   confirma el del cliente)
    |                                                        |
    | ------- 3. ACK (Ack = server_isn + 1) ---------------> |  (Confirma el del servidor)
    v                                                        v
```

1. **Paso 1 (SYN del Cliente):** El cliente selecciona su propio número inicial (`client_isn`) y lo transmite en el campo _Sequence Number_ con el flag `SYN = 1`.
2. **Paso 2 (SYN+ACK del Servidor):**
    - El servidor selecciona su propio número inicial (`server_isn`) y lo incluye en el campo _Sequence Number_ con el flag `SYN = 1`.
    - Al mismo tiempo, acusa recibo del ISN del cliente estableciendo en el campo _Acknowledgment Number_ el valor **`client_isn + 1`**.
    - _(Nota: Aunque el segmento `SYN` no transporta datos de aplicación, consume lógicamente 1 número de secuencia para posibilitar su confirmación inequívoca)_.
3. **Paso 3 (ACK final del Cliente):** El cliente confirma la recepción del ISN del servidor enviando un segmento con el campo _Acknowledgment Number_ configurado en **`server_isn + 1`**.

A partir de este intercambio, ambos equipos quedan perfectamente sincronizados respecto a qué número de byte esperar en cada dirección a lo largo de toda la sesión.

---
## 8. Investigue qué es el MSS. ¿Cuándo y cómo se negocia?

### **1. ¿Qué es el MSS (_Maximum Segment Size_)?**

El **MSS** es la **cantidad máxima de datos de la capa de aplicación (carga útil o _payload_)** que un extremo de una conexión TCP está dispuesto a recibir dentro de un único segmento.

- **Diferencia clave con la MTU:**
    - La **MTU** (_Maximum Transmission Unit_) es el tamaño máximo de la trama que puede transportar el protocolo de la capa de enlace (por ejemplo, 1500 bytes en Ethernet).
    - El **MSS cuenta únicamente los datos útiles de aplicación**, es decir, no incluye los encabezados de red ni de transporte.
    - Su valor se calcula normalmente a partir de la MTU del enlace local restando la longitud de los encabezados fijos de IP y TCP: \[\text{MSS} = \text{MTU} - \text{Longitud Header IP (20 bytes)} - \text{Longitud Header TCP (20 bytes)}\] Para un enlace estándar Ethernet (MTU = 1500 bytes), el valor típico de MSS es: \[\text{MSS} = 1500 - 40 = 1460 \text{ bytes}\]

---
### **2. ¿Cuándo se negocia?**

El valor del MSS se negocia **únicamente durante el establecimiento de la conexión**, es decir, dentro del **saludo de tres vías (_three-way handshake_)**:

- En el primer segmento (**`SYN`**) enviado por el cliente.
- En el segundo segmento (**`SYN+ACK`**) enviado por el servidor.

Una vez establecida la sesión, el valor del MSS queda fijado y ya no se transmite ni se renegocia en los segmentos posteriores de transferencia de datos.

---
### **3. ¿Cómo se negocia?**

1. **Uso del campo _Options_:** Cada _host_ anuncia el tamaño de segmento máximo que puede recibir incluyéndolo en el campo de **Opciones de longitud variable** de la cabecera TCP (`Option Kind = 2`, longitud de 4 bytes).
2. **Anuncio independiente y asimétrico:**
    - El cliente informa su MSS máximo soportado en el paquete `SYN`.
    - El servidor informa su propio MSS en la respuesta `SYN+ACK`.
    - Los valores pueden ser asimétricos si cada extremo posee interfaces con MTUs distintas.
3. **Determinación del tamaño de segmento efectivo:**
    - Cada emisor se compromete a no enviar segmentos de datos cuyo tamaño supere el MSS anunciado por el receptor remoto.
    - De este modo, el tamaño máximo de datos que se transmitirá en la conexión queda limitado por el **mínimo entre ambos MSS anunciados** (o ajustado según los mecanismos de descubrimiento de MTU del camino, _Path MTU Discovery_). Si un extremo no envía la opción MSS en su segmento SYN, se asume el valor por defecto estándar de 536 bytes.

---
## 9. Utilice el comando `ss` (reemplazo de `netstat`) para obtener la siguiente información de su PC:
- **a. Para listar las comunicaciones TCP establecidas.**
- **b. Para listar las comunicaciones UDP establecidas.**
- **c. Obtener sólo los servicios TCP que están esperando comunicaciones.**
- **d. Obtener sólo los servicios UDP que están esperando comunicaciones.**
- **e. Repetir los anteriores para visualizar el proceso del sistema asociado a la conexión.**
- **f. Obtenga la misma información planteada en los ítems anteriores usando el comando `netstat`.**

#### **a. Para listar las comunicaciones TCP establecidas**
Por defecto, al ejecutar `ss` sin flags de filtrado de estado, solo se muestran las conexiones no escuchantes (establecidas o conectadas). Indicamos explícitamente TCP con `-t`:
* **Comando `ss`:**
  ```bash
  ss -t
  ```
  *(o filtrando explícitamente el estado: `ss -t state established`)*.

---
#### **b. Para listar las comunicaciones UDP establecidas**
En UDP, al ser un protocolo sin conexión (*connectionless*), los sockets conectados son aquellos que han asociado una dirección/puerto remoto (por ejemplo, mediante la llamada al sistema `connect`):
* **Comando `ss`:**
  ```bash
  ss -u
  ```
  *(o filtrando explícitamente: `ss -u state established`)*.

---
#### **c. Obtener sólo los servicios TCP que están esperando comunicaciones**
Para filtrar los sockets TCP en estado pasivo o de escucha (**LISTEN**), se combina la opción de TCP (`-t`) con la opción de escucha (`-l`):
* **Comando `ss`:**
  ```bash
  ss -tl
  ```
  *(o bien: `ss -t state listening`)*.

---
#### **d. Obtener sólo los servicios UDP que están esperando comunicaciones**
Los sockets de servicios UDP a la espera de datagramas entrantes no se encuentran conectados a un par específico:
* **Comando `ss`:**
  ```bash
  ss -ul
  ```

---
#### **e. Repetir los anteriores para visualizar el proceso del sistema asociado a la conexión**
Para mostrar el proceso, PID y nombre del programa asociado al socket, se agrega la opción **`-p`** (*processes*). *(Nota: habitualmente requiere permisos de superusuario `sudo` para ver procesos de otros usuarios/servicios)*:
* **TCP establecidas con proceso:**
  ```bash
  sudo ss -tp
  ```
* **UDP establecidas con proceso:**
  ```bash
  sudo ss -up
  ```
* **Servicios TCP en escucha con proceso:**
  ```bash
  sudo ss -tlp
  ```
* **Servicios UDP en escucha con proceso:**
  ```bash
  sudo ss -ulp
  ```

*(Parámetro adicional útil: se suele sumar **`-n`** para ver los puertos numéricamente en lugar de traducirlos por su nombre de servicio).*

---
#### **f. Obtenga la misma información planteada en los ítems anteriores usando el comando `netstat`**
La herramienta clásica **`netstat`** utiliza modificadores equivalentes: `-t` (TCP), `-u` (UDP), `-l` (listening), `-p` (procesos/programas) y `-n` (numérico):

* **Comunicaciones TCP establecidas:**
  ```bash
  netstat -t
  ```
* **Comunicaciones UDP establecidas:**
  ```bash
  netstat -u
  ```
* **Servicios TCP esperando comunicaciones (LISTEN):**
  ```bash
  netstat -tl
  ```
* **Servicios UDP esperando comunicaciones:**
  ```bash
  netstat -ul
  ```
* **Visualizando el proceso asociado (agregando `-p`):**
  ```bash
  sudo netstat -tp    # TCP establecidas con PID/Nombre
  sudo netstat -up    # UDP establecidas con PID/Nombre
  sudo netstat -tlp   # TCP en escucha con PID/Nombre
  sudo netstat -ulp   # UDP en escucha con PID/Nombre
  ```

---
### 10. ¿Qué sucede si llega un segmento TCP con el flag `SYN` activo a un host que no tiene ningún proceso esperando en el puerto destino de dicho segmento (es decir, el puerto destino no está en estado `LISTEN`)?
- **a. Utilice `hping3` para enviar paquetes TCP al puerto destino 22 de la máquina virtual con el flag `SYN` activado.**
- **b. Utilice `hping3` para enviar paquetes TCP al puerto destino 40 de la máquina virtual con el flag `SYN` activado.**
- **c. ¿Qué diferencias nota en las respuestas obtenidas en los dos casos anteriores? ¿Puede explicar a qué se debe?** *(Ayuda: utilice el comando `ss` visto anteriormente)*.

Cuando un segmento TCP con el flag **`SYN`** activo llega a un host de destino y **no existe ningún proceso escuchando** en ese puerto (puerto cerrado, sin socket en estado `LISTEN`), la pila de red del sistema operativo receptor **rechaza la conexión enviando de vuelta un segmento TCP con los flags `RST` y `ACK` activados (`flags=RA`)**.

El flag `RST` (_Reset_) indica al emisor que la conexión no puede establecerse o es rechazada de forma inmediata.

---
### **Desarrollo de los incisos**

#### **a. Envío con `hping3` al puerto 22 (puerto abierto / SSH)**

El puerto 22 suele estar abierto por el servicio de SSH. Para enviar paquetes con el flag SYN activo:

```bash
sudo hping3 -S -p 22 -c 2 <IP_VM>
```

- **Respuesta obtenida:**  
    El host remoto responde con paquetes que contienen las banderas **`flags=SA` (`SYN + ACK`)**.

- **Significado:** El puerto está en estado **`LISTEN`**; el servidor acepta el inicio del saludo de tres vías (_three-way handshake_) y responde con su propio `SYN` y la confirmación del `SYN` del cliente.

---

#### **b. Envío con `hping3` al puerto 40 (puerto cerrado)**

El puerto 40 es un puerto reservado/no utilizado comúnmente donde no corre ningún servicio en la máquina virtual:

```bash
sudo hping3 -S -p 40 -c 2 <IP_VM>
```

- **Respuesta obtenida:**  
    El host responde con paquetes que contienen las banderas **`flags=RA` (`RST + ACK`)**.

- **Significado:** Como ningún proceso tiene abierto el socket en modo pasivo en ese puerto, el kernel genera un segmento de **reseteo (`RST`)** para abortar el intento de conexión.

---

#### **c. Diferencias y explicación**

- **Diferencia observada:**
    - En el puerto **22**, se recibe **`flags=SA` (`SYN, ACK`)**.
    - En el puerto **40**, se recibe **`flags=RA` (`RST, ACK`)**.
- **Explicación con `ss`:**  
    Al ejecutar en la máquina virtual:
	```bash
	ss -tlpn
	```
    Se puede constatar que:
    - El puerto **22** figura en la columna _State_ como **`LISTEN`** (asociado al demonio `sshd`).
    - El puerto **40** **no aparece en la lista de sockets en escucha**.

Por lo tanto, la pila TCP del sistema operativo destino sabe si debe continuar el saludo de tres vías o resetear la conexión analizando si existe o no una entrada en su tabla de sockets en estado `LISTEN` para ese puerto.

---
## 11. ¿Qué sucede si llega un datagrama UDP a un host que no tiene ningún proceso esperando en el puerto destino de dicho datagrama (es decir, que dicho puerto no está en estado `LISTEN`)?
- **a. Utilice `hping3` para enviar datagramas UDP al puerto destino 5353 de la máquina virtual.**
- **b. Utilice `hping3` para enviar datagramas UDP al puerto destino 40 de la máquina virtual.**
- **c. ¿Qué diferencias nota en las respuestas obtenidas en los dos casos anteriores? ¿Puede explicar a qué se debe?** *(Ayuda: utilice el comando `ss` visto anteriormente)*.

Cuando un datagrama UDP llega a un host de destino y **no existe ningún socket o proceso escuchando** en ese puerto de destino, la capa de transporte no puede entregar los datos. 

Como UDP no es un protocolo orientado a conexión y no maneja mensajes de señalización propios (a diferencia de TCP, que envía un `RST`), el sistema operativo recurre a la capa de red y **genera un mensaje de control ICMP de error: *Destination Unreachable (Port Unreachable)***, correspondiente a **ICMP Tipo 3, Código 3**.

---
#### **a. Envío con `hping3` al puerto 5353 (puerto abierto / mDNS)**
El puerto 5353/UDP suele estar abierto en la máquina virtual por el servicio de resolución multicast mDNS (como el demonio `avahi-daemon`).
Para enviar datagramas UDP con `hping3` se utiliza la opción **`--udp`** (o **`-2`**):
```bash
sudo hping3 --udp -p 5353 -c 2 <IP_VM>
```
* **Respuesta obtenida:**  
  * En la consola de `hping3` habitualmente **no se recibe ninguna respuesta** (100% packet loss) o el servicio de aplicación responde según su implementación.
* **Explicación:**  
  * Al haber un proceso escuchando en el puerto 5353, el kernel entrega el datagrama al socket correspondiente. No se genera ningún error a nivel de red/transporte.

---
#### **b. Envío con `hping3` al puerto 40 (puerto cerrado)**
En la máquina virtual no corre ningún servicio en el puerto 40/UDP.
```bash
sudo hping3 --udp -p 40 -c 2 <IP_VM>
```
* **Respuesta obtenida:**  
  * El host receptor responde con un paquete **ICMP Port Unreachable**.
  * En la consola de `hping3` se visualizará una respuesta del tipo:
    ```text
    ICMP Port Unreachable from ip=127.0.0.1 name=localhost
    status=0 port=1402 seq=0
    ```

---
#### **c. Diferencias y explicación con `ss`**

* **Diferencia observada:**  
  * Al enviar al puerto **5353**, el datagrama es absorbido por el proceso y no se genera mensaje de error.  
  * Al enviar al puerto **40**, se recibe un mensaje de error **ICMP (Tipo 3, Código 3: *Port Unreachable*)**.

* **Comprobación con `ss`:**  
  Si se listan los servicios UDP a la espera en la máquina virtual ejecutando:
  ```bash
  ss -ulnp
  ```
  Se observa que:
  * El puerto **5353** aparece en la lista de sockets UDP abiertos (asociado a `avahi-daemon`).
  * El puerto **40** **no figura en la lista** de sockets del sistema.

Al llegar el datagrama UDP dirigido al puerto 40 y no encontrar ningún socket que coincida con ese puerto destino, la pila IP/UDP descarta el datagrama y el módulo ICMP del kernel emite la notificación de puerto inalcanzable de regreso al emisor.

---
## 12. Investigue los distintos tipos de estado que puede tener una conexión TCP. *(Ver [TCP/IP State Transition Diagram](https://users.cs.northwestern.edu/~agupta/cs340/project2/TCPIP_State_Transition_Diagram.pdf))*

En el protocolo **TCP**, los dos extremos mantienen una **máquina de estados finitos (FSM)** para gestionar el ciclo de vida completo de la conexión: **establecimiento**, **transferencia de datos** y **cierre**.

---
### **1. Estados de Inicialización y Apertura (*Three-Way Handshake*)**

* **`CLOSED`**: Estado ficticio/inicial que indica que **no hay conexión activa ni socket abierto**.
* **`LISTEN`**: El servidor realiza una apertura pasiva (*passive open*) mediante llamadas al sistema como `listen()` y queda a la espera de peticiones de conexión entrantes en un puerto específico.
* **`SYN_SENT`**: El cliente realiza una apertura activa (*active open*), envía un segmento con el flag **`SYN`** y su ISN, y espera la respuesta del servidor.
* **`SYN_RCVD` (o `SYN_RECEIVED`)**: El servidor recibió el `SYN` del cliente, reservó recursos, respondió con un segmento **`SYN + ACK`** y queda a la espera del `ACK` final del cliente.
* **`ESTABLISHED`**: La conexión quedó establecida con éxito en ambos extremos. Es el estado operativo principal donde se produce la **transferencia bidireccional de datos de aplicación**.

---
### **2. Estados durante el Cierre de la Conexión (*Teardown*)**

Como TCP es *full-duplex*, cada sentido de la conexión debe cerrarse de forma independiente mediante el intercambio de segmentos **`FIN`** y **`ACK`**. La transición de estados depende de si el host inicia el cierre (cierre activo) o si responde al cierre del otro extremo (cierre pasivo):

#### **A. Cierre Activo (*Active Close* — quien envía el primer `FIN`):**
* **`FIN_WAIT_1`**: La aplicación local invoca `close()`. El host envía un segmento de control **`FIN`** y espera la confirmación (`ACK`) del remoto o un `FIN` simultáneo.
* **`FIN_WAIT_2`**: El host recibió el `ACK` a su propio `FIN`. Su canal de salida está cerrado, pero su canal de entrada sigue abierto a la espera de que el extremo remoto envíe su propio segmento `FIN`.
* **`CLOSING`**: Ocurre en un **cierre simultáneo**. Ambos extremos enviaron un segmento `FIN` antes de recibir el `ACK` del otro. Al recibir el `FIN` ajeno, envían `ACK` y pasan a `CLOSING` a la espera del `ACK` a su propio `FIN`.
* **`TIME_WAIT`**: El host recibió el `FIN` del remoto y envió el último `ACK`. Permanece en este estado durante un tiempo establecido (habitualmente **`2MSL`**, *Maximum Segment Lifetime*, entre 1 y 2 minutos) antes de pasar a `CLOSED`:
  1. Para asegurar que el `ACK` final haya llegado al destino (si se pierde, el remoto retransmitirá su `FIN` y podrá volver a confirmarse sin error).
  2. Para permitir que cualquier segmento rezagado de esta conexión expire en la red y no interfiera con una futura conexión que reutilice la misma 4-upla `(IP:puerto)`.

#### **B. Cierre Pasivo (*Passive Close* — quien recibe el primer `FIN`):**
* **`CLOSE_WAIT`**: El host recibió el primer segmento `FIN`, envió el `ACK` de respuesta y notifica el fin de archivo (`EOF`) a la aplicación local. Permanece en este estado todo el tiempo necesario mientras la aplicación local termina de transmitir los datos pendientes.
* **`LAST_ACK`**: La aplicación local finalmente ejecuta `close()`. El host transmite su propio segmento `FIN` y queda a la espera del último `ACK` de confirmación. Una vez recibido, la conexión pasa a **`CLOSED`**.

---
### **Resumen del Diagrama de Transición**

| Etapa             | Extremo Activo (Cliente típico)                                          | Extremo Pasivo (Servidor típico)                        |
| :---------------- | :----------------------------------------------------------------------- | :------------------------------------------------------ |
| **Apertura**      | `CLOSED` -> `SYN_SENT` -> `ESTABLISHED`                                  | `CLOSED` -> `LISTEN` -> `SYN_RCVD` -> `ESTABLISHED`     |
| **Transferencia** | `ESTABLISHED`                                                            | `ESTABLISHED`                                           |
| **Cierre**        | `ESTABLISHED` -> `FIN_WAIT_1` -> `FIN_WAIT_2` -> `TIME_WAIT` -> `CLOSED` | `ESTABLISHED` -> `CLOSE_WAIT` -> `LAST_ACK` -> `CLOSED` |
![[Pasted image 20261103110845.png|509]]

![[Pasted image 20261103192403.png|504]]

---
## 13. Dada la siguiente salida del comando `ss`, responda:

```
Netid  State       Recv-Q  Send-Q  Local Address:Port    Peer Address:Port    Process
tcp    LISTEN      0       128     *:22                  *:*                  users:(("sshd",pid=468,fd=29))
tcp    LISTEN      0       128     *:80                  *:*                  users:(("apache2",pid=991,fd=95))
udp    LISTEN      0       128     163.10.5.222:53       *:*                  users:(("named",pid=452,fd=10))
tcp    ESTAB       0       0       163.10.5.222:59736    64.233.163.120:443   users:(("x-www-browser",pid=1079,fd=51))
tcp    CLOSE-WAIT  0       0       163.10.5.222:41654    200.115.89.30:443    users:(("x-www-browser",pid=1079,fd=50))
tcp    ESTAB       0       0       163.10.5.222:59737    64.233.163.120:443   users:(("x-www-browser",pid=1079,fd=55))
tcp    ESTAB       0       0       163.10.5.222:33583    200.115.89.15:443    users:(("x-www-browser",pid=1079,fd=53))
tcp    ESTAB       0       0       163.10.5.222:45293    64.233.190.99:443    users:(("x-www-browser",pid=1079,fd=59))
tcp    LISTEN      0       128     *:25                  *:*                  users:(("postfix",pid=627,fd=3))
tcp    ESTAB       0       0       127.0.0.1:22          127.0.0.1:41220      users:(("sshd",pid=1418,fd=3),("sshd",pid=1416,fd=3))
tcp    ESTAB       0       0       163.10.5.222:52952    64.233.190.94:443    users:(("x-www-browser",pid=1079,fd=29))
tcp    TIME-WAIT   0       0       163.10.5.222:36676    54.149.207.17:443    users:(("x-www-browser",pid=1079,fd=3))
tcp    ESTAB       0       0       163.10.5.222:52960    64.233.190.94:443    users:(("x-www-browser",pid=1079,fd=67))
tcp    ESTAB       0       0       163.10.5.222:50521    200.115.89.57:443    users:(("x-www-browser",pid=1079,fd=69))
tcp    SYN-SENT    0       0       163.10.5.222:52132    43.232.2.2:9500      users:(("x-www-browser",pid=1079,fd=70))
tcp    ESTAB       0       0       127.0.0.1:41220       127.0.0.1:22         users:(("ssh",pid=1415,fd=3))
udp    LISTEN      0       128     127.0.0.1:53          *:*                  users:(("named",pid=452,fd=9))
```

- **a. ¿Cuántas conexiones hay establecidas?**
- **b. ¿Cuántos puertos hay abiertos a la espera de posibles nuevas conexiones?**
- **c. El cliente y el servidor de las comunicaciones HTTPS (puerto 443), ¿residen en la misma máquina?**
- **d. El cliente y el servidor de la comunicación SSH (puerto 22), ¿residen en la misma máquina?**
- **e. Liste los nombres de todos los procesos asociados con cada comunicación. Indique para cada uno si se trata de un proceso cliente o uno servidor.**
- **f. ¿Cuáles conexiones tuvieron el cierre iniciado por el host local y cuáles por el remoto?**
- **g. ¿Cuántas conexiones están aún pendientes por establecerse?**

---

### **a. ¿Cuántas conexiones hay establecidas?**

En la salida del comando figuran **9 entradas/sockets en estado `ESTAB`**:
1. `163.10.5.222:59736` --> `64.233.163.120:443`
2. `163.10.5.222:59737` --> `64.233.163.120:443`
3. `163.10.5.222:33583` --> `200.115.89.15:443`
4. `163.10.5.222:45293` --> `64.233.190.99:443`
5. `127.0.0.1:22` <--> `127.0.0.1:41220` (extremo servidor SSH)
6. `163.10.5.222:52952` --> `64.233.190.94:443`
7. `163.10.5.222:52960` --> `64.233.190.94:443`
8. `163.10.5.222:50521` --> `200.115.89.57:443`
9. `127.0.0.1:41220` <--> `127.0.0.1:22` (extremo cliente SSH)

**Interpretación:**  
Hay **9 sockets en estado `ESTAB`**, pero corresponden a **8 conexiones establecidas distintas**. Esto se debe a que la comunicación SSH se produce localmente a través de la interfaz de *loopback* (`127.0.0.1`), por lo que `ss` muestra ambos extremos (cliente y servidor) en la misma máquina para esa única conexión.

---
### **b. ¿Cuántos puertos hay abiertos a la espera de posibles nuevas conexiones?**

En estado **`LISTEN`** se identifican **4 puertos lógicos distintos**:
* **Puertos TCP en escucha (3):**
  * Puerto **22** (`*:22`, servicio SSH).
  * Puerto **80** (`*:80`, servicio web HTTP).
  * Puerto **25** (`*:25`, servicio de correo SMTP).
* **Puertos UDP en escucha (1):**
  * Puerto **53** (servicio DNS, presente en las interfaces `163.10.5.222:53` y `127.0.0.1:53`).

#### CONSULTAR
*(Nota: si se contabilizan los sockets/entradas en escucha, son 5 en total debido a que el puerto 53 UDP está abierto en dos interfaces locales de forma independiente)*.

---
### **c. El cliente y el servidor de las comunicaciones HTTPS (puerto 443), ¿residen en la misma máquina?**

**No**.  
* La dirección y puerto locales corresponden a la máquina local (`163.10.5.222`) utilizando puertos efímeros dinámicos (59736, 41654, 33583, etc.) mediante el proceso cliente **`x-www-browser`**.
* Las direcciones remotas (*Peer Address:Port*) son IPs públicas externas a la red local (como `64.233.163.120`, `200.115.89.15`, etc.) en el puerto de servicio **443**.

---
### **d. El cliente y el servidor de la comunicación SSH (puerto 22), ¿residen en la misma máquina?**

**Sí**.  
La comunicación se realiza íntegramente sobre la dirección de *loopback* (`127.0.0.1`):
* El servidor **`sshd`** escucha y atiende en `127.0.0.1:22`.
* El cliente **`ssh`** originó la conexión desde la misma máquina utilizando el puerto efímero `127.0.0.1:41220`.

---
### **e. Procesos asociados con cada comunicación y su rol**

| Proceso             | Rol          | Función / Justificación                                                            |
| :------------------ | :----------- | :--------------------------------------------------------------------------------- |
| **`sshd`**          | **Servidor** | Demonio de Secure Shell que escucha peticiones en el puerto 22 y atiende sesiones. |
| **`apache2`**       | **Servidor** | Servidor web HTTP en escucha en el puerto 80.                                      |
| **`named`**         | **Servidor** | Servidor de nombres de dominio (DNS / BIND) en el puerto 53 UDP.                   |
| **`postfix`**       | **Servidor** | Agente de transporte de correo (MTA) en escucha en el puerto 25 TCP.               |
| **`x-www-browser`** | **Cliente**  | Navegador web que inicia conexiones salientes hacia servidores web remotos.        |
| **`ssh`**           | **Cliente**  | Aplicación cliente de terminal remota conectada a `127.0.0.1:22`.                  |

---
### **f. ¿Cuáles conexiones tuvieron el cierre iniciado por el host local y cuáles por el remoto?**

* **Cierre iniciado por el host remoto (Cierre Pasivo):**
  * `163.10.5.222:41654` <--> `200.115.89.30:443` en estado **`CLOSE-WAIT`**.
  * *Justificación:* El extremo remoto envió el primer segmento `FIN`. La máquina local respondió con `ACK` y pasó al estado `CLOSE_WAIT` a la espera de que el proceso local (`x-www-browser`) cierre su socket.

* **Cierre iniciado por el host local (Cierre Activo):**
  * `163.10.5.222:36676` <--> `54.149.207.17:443` en estado **`TIME-WAIT`**.
  * *Justificación:* El host local fue quien inició el cierre enviando el primer segmento `FIN`. Tras completarse el intercambio de confirmaciones, el host local ingresó en la espera temporizada de `TIME_WAIT` (2MSL).

---
### **g. ¿Cuántas conexiones están aún pendientes por establecerse?**

Hay **1 conexión pendiente** de establecerse:
* `163.10.5.222:52132` --> `43.232.2.2:9500` en estado **`SYN-SENT`**.
* El cliente local envió el segmento `SYN` inicial y se encuentra a la espera del segmento `SYN+ACK` por parte del servidor para completar el saludo de tres vías.

---
## 14. Dadas las salidas de los siguientes comandos ejecutados en el cliente y el servidor, responder:

```
servidor# ss -natu | grep 110
tcp  LISTEN     0  0  *:110              *:*
tcp  SYN-RECV   0  0  157.0.0.1:110      157.0.11.1:52843

cliente# ss -natu | grep 110
tcp  SYN-SENT   0  1  157.0.11.1:52843   157.0.0.1:110
```

- **a. ¿Qué segmentos llegaron y cuáles se están perdiendo en la red?**
- **b. ¿A qué protocolo de capa de aplicación y de transporte se está intentando conectar el cliente?**
- **c. ¿Qué flags tendría seteado el segmento perdido?**

---
### **a. ¿Qué segmentos llegaron y cuáles se están perdiendo en la red?**

- **Segmentos que llegaron:**
    - **Llegó el segmento `SYN`** enviado por el cliente hacia el servidor.
        - _Justificación:_ El servidor pasó del estado `LISTEN` al estado **`SYN-RECV`**. Esto solo ocurre cuando recibe de forma efectiva el primer segmento `SYN` con el número de secuencia inicial (_ISN_) del cliente.

- **Segmentos que se están perdiendo:**
    - **Se está perdiendo el segmento de respuesta `SYN + ACK`** enviado por el servidor hacia el cliente.
        - _Justificación:_ El cliente permanece en estado **`SYN-SENT`**. Si hubiera recibido el `SYN + ACK` proveniente del servidor, habría transitado de inmediato al estado `ESTABLISHED` y enviado el `ACK` final. Al encontrarse todavía en `SYN-SENT` (con `Send-Q = 1`), el cliente sigue esperando la respuesta del servidor o preparándose para retransmitir su `SYN`.

---
### **b. ¿A qué protocolo de capa de aplicación y de transporte se está intentando conectar el cliente?**

- **Capa de Transporte:** **TCP** (_Transmission Control Protocol_).
    - En la salida de `ss` se visualiza el identificador de protocolo **`tcp`** y los estados corresponden a su máquina de estados finitos (`SYN-SENT`, `SYN-RECV`).

- **Capa de Aplicación:** **POP3** (_Post Office Protocol v3_).
    - El puerto destino al cual se conecta es el puerto **110**, asignado por defecto al servicio de recuperación de correo electrónico POP3.

---
### **c. ¿Qué flags tendría seteado el segmento perdido?**

El segmento perdido es el segundo paso del saludo de tres vías (_three-way handshake_) enviado por el servidor. Por lo tanto, tendría seteados los siguientes flags en su cabecera TCP:

- **`SYN`** (Synchronization).
- **`ACK`** (Acknowledgment).

_(Es el paquete **`SYN + ACK`**, con los bits correspondientes en 1)_.

---
## 15. Use CORE para armar una topología como la siguiente, sobre la cual deberá realizar:

![[Pasted image 20261103092845.png|330]]

**Topología:**
- **Servidor:** `10.0.0.20/24` / `2001:0:20/64`
- **cliente 1:** `10.0.0.21/24` / `2001:0:21/64`
- Ambos conectados mediante un switch (`n2`).

- **a. En ambos equipos inspeccionar el estado de las conexiones y mantener abiertas ambas ventanas con el comando corriendo para poder visualizar los cambios a medida que se realiza el ejercicio.** *(Ayuda: `watch -n1 'ss -nat'`)*.
- **b. En Servidor, utilice la herramienta `ncat` para levantar un servicio que escuche en el puerto `8001/TCP`. Utilice la opción `-k` para que el servicio sea persistente. Verifique el estado de las conexiones.**
- **c. Desde CLIENTE1 conectarse a dicho servicio utilizando también la herramienta `ncat`. Inspeccione el estado de las conexiones.**
- **d. Iniciar otra conexión desde CLIENTE1 de la misma manera que la anterior y verificar el estado de las conexiones. ¿De qué manera puede identificar cada conexión?**
- **e. En base a lo observado en el ítem anterior, ¿es posible iniciar más de una conexión desde el cliente al servidor en el mismo puerto destino? ¿Por qué? ¿Cómo se garantiza que los datos de una conexión no se mezclarán con los de la otra?**
- **f. Analice en el tráfico de red, los flags de los segmentos TCP que ocurren cuando:**
  - i. Cierra la última conexión establecida desde CLIENTE1. Evalúe los estados de las conexiones en ambos equipos.
  - ii. Corta el servicio de `ncat` en el servidor (`Ctrl+C`). Evalúe los estados de las conexiones en ambos equipos.
  - iii. Cierra la conexión en el cliente. Evalúe nuevamente los estados de las conexiones.

### **a. Monitoreo de conexiones en tiempo real**
En sendas terminales de ambos equipos se ejecuta:
```bash
watch -n1 'ss -nat'
```
Esto actualiza cada 1 segundo la lista de sockets TCP numéricos para observar en vivo las transiciones de estado.

---
### **b. Levantar el servicio en el Servidor**
En la terminal del **Servidor** se inicia el servicio con persistencia (`-k`) en el puerto 8001/TCP:
```bash
ncat -lk 8001
```
* **Estado observado:**
  * **Servidor:** Aparece un socket TCP en estado **`LISTEN`** en la dirección local `*:8001` (o `0.0.0.0:8001`) esperando conexiones entrantes.
  * **Cliente 1:** No muestra actividad ni registros asociados al puerto 8001.

---
### **c. Conexión desde CLIENTE 1**
Desde una terminal en **CLIENTE 1** se establece la primera conexión:
```bash
ncat 10.0.0.20 8001
```
* **Estados observados tras el saludo de 3 vías (*three-way handshake*):**
  * **Cliente 1:** Pasa a **`ESTABLISHED`** con una entrada del estilo `10.0.0.21:<puerto_efimero_1> -> 10.0.0.20:8001`.
  * **Servidor:** 
    1. Mantiene el socket original en estado **`LISTEN`** en el puerto `*:8001` gracias al parámetro `-k`.
    2. Crea un nuevo socket en estado **`ESTABLISHED`**: `10.0.0.20:8001 -> 10.0.0.21:<puerto_efimero_1>`.

---
### **d. Iniciar una segunda conexión desde CLIENTE 1 y su identificación**
En otra terminal de **CLIENTE 1**, se ejecuta nuevamente:
```bash
ncat 10.0.0.20 8001
```
* **Estados observados:**
  * En ambos equipos se visualizan **dos conexiones en estado `ESTABLISHED`** hacia el puerto de destino 8001.
* **¿De qué manera puede identificar cada conexión?**
  * Cada conexión se diferencia de forma inequívoca por su **puerto de origen en el cliente**. El sistema operativo asigna dinámicamente un puerto efímero diferente a cada proceso cliente (por ejemplo, `54120` para la primera y `54122` para la segunda).

---
### **e. Múltiples conexiones al mismo puerto destino**
* **¿Es posible iniciar más de una conexión desde el cliente al servidor en el mismo puerto destino? ¿Por qué?**
  * **Sí, es perfectamente posible**. TCP no identifica una conexión únicamente por el puerto de destino del servidor, sino por la **4-upla (o socket pair)**:
    `IP Origen, Puerto Origen, IP Destino, Puerto Destino`
  * Mientras al menos uno de esos cuatro valores sea distinto, las conexiones son entidades lógicas totalmente separadas.
* **¿Cómo se garantiza que los datos no se mezclarán?**
  * Gracias al mecanismo de **desmultiplexación orientada a conexión** de TCP: al llegar un segmento, la pila TCP compara los cuatro campos de la cabecera IP y TCP con su tabla interna de conexiones activas y entrega el *payload* exclusivamente al buffer del socket correspondiente a esa 4-upla exacta.

---
### **f. Análisis de tráfico y banderas (flags) en los cierres de conexión**

#### **i. Cierre de la última conexión desde CLIENTE 1 (Ctrl+C en el cliente)**
* **Flags en el tráfico de red:**
  1. `Cliente 1 -> Servidor`: Segmento con bandera **`[F.]` (`FIN + ACK`)** (cierre activo del cliente).
  2. `Servidor -> Cliente 1`: Segmento con bandera **`[.]` (`ACK`)** confirmando el FIN recibido.
  3. `Servidor -> Cliente 1`: Segmento con bandera **`[F.]` (`FIN + ACK`)** (cierre pasivo completado por el servidor).
  4. `Cliente 1 -> Servidor`: Segmento con bandera **`[.]` (`ACK`)** final.
* **Estados en ambos equipos:**
  * **Cliente 1 (Cierre Activo):** Pasa por `FIN_WAIT_1` -> `FIN_WAIT_2` y finalmente queda en **`TIME_WAIT`** (durante 2MSL para garantizar la entrega del último ACK y absorber segmentos rezagados).
  * **Servidor (Cierre Pasivo):** Pasa temporalmente por `CLOSE_WAIT` -> `LAST_ACK` hasta recibir el ACK final y transita a **`CLOSED`** (la conexión desaparece de `ss`).
  * *(Nota: La primera conexión sigue en `ESTABLISHED` y el servidor sigue en `LISTEN`)*.

#### **ii. Corte del servicio `ncat` en el Servidor (Ctrl+C en el proceso servidor)**
* **Flags en el tráfico de red:**
  * El servidor mata el proceso de escucha y cierra activamente la conexión restante enviando un segmento **`[F.]` (`FIN + ACK`)** hacia el cliente.
  * El cliente responde con un segmento **`[.]` (`ACK`)**.
* **Estados en ambos equipos:**
  * **Servidor:** Desaparece el estado `LISTEN` (el servicio se detuvo). Para la conexión establecida que cerró, envía el `FIN`, recibe el `ACK` y queda en **`FIN_WAIT_2`** a la espera de que el cliente finalice.
  * **Cliente 1:** La capa de transporte de Cliente 1 acusa recibo del FIN y pasa a estado **`CLOSE_WAIT`**. La aplicación en el cliente queda notificada de un fin de archivo (`EOF`), pero el socket sigue abierto localmente hasta que el usuario termine el proceso en el cliente.

#### **iii. Cierre de la conexión en el cliente (Ctrl+C en CLIENTE 1)**
* **Flags en el tráfico de red:**
  * Al cerrarse la aplicación en el cliente, este transmite su propio segmento de fin: **`[F.]` (`FIN + ACK`)**.
  * El servidor responde con el **`[.]` (`ACK`)** de confirmación final.
* **Estados en ambos equipos:**
  * **Servidor (Cierre Activo previo):** Recibe el `FIN`, envía el `ACK` final y entra en estado **`TIME_WAIT`** durante el temporizador `2MSL`.
  * **Cliente 1:** Pasa brevemente por `LAST_ACK`, recibe la confirmación y pasa inmediatamente a **`CLOSED`** (desaparece de la salida de `ss`).