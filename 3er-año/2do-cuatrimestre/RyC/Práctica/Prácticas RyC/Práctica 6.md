# Práctica 6
# Capa de Transporte - Parte II

## 1. ¿Cuál es el puerto por defecto que se utiliza en los siguientes servicios?
- `Web`
- `SSH`
- `DNS`
- `Web Seguro`
- `POP3`
- `IMAP`
- `SMTP`

Investigue en qué lugar en Linux y en Windows está descrita la asociación utilizada por defecto para cada servicio.

---
### **1. Puertos por defecto para cada servicio**

| Servicio | Nombre del Protocolo | Protocolo de Transporte | Puerto por Defecto |
| :--- | :--- | :--- | :--- |
| **Web** | HTTP | TCP | **`80`** |
| **SSH** | SSH | TCP | **`22`** |
| **DNS** | DNS | UDP y TCP | **`53`** |
| **Web Seguro** | HTTPS | TCP | **`443`** |
| **POP3** | POP3 (sin SSL) | TCP | **`110`** *(995 con SSL/TLS)* |
| **IMAP** | IMAP (sin SSL) | TCP | **`143`** *(993 con SSL/TLS)* |
| **SMTP** | SMTP | TCP | **`25`** *(587 para submission)* |

*(Nota sobre DNS: Generalmente opera sobre **UDP 53** para consultas estándar de baja sobrecarga, pero utiliza **TCP 53** para respuestas mayores a 512 bytes, transferencias de zona AXFR o con extensiones DNSSEC).*

---
### **2. Ubicación del archivo de asociación de servicios por defecto**

Tanto en Linux como en Windows existe un archivo de texto plano denominado **`services`** que mapea nombres de servicios legibles para humanos con sus correspondientes números de puerto y protocolos de transporte de la IANA (*Internet Assigned Numbers Authority*):

* **En sistemas Linux / UNIX:**  
  * **Ruta:** **`/etc/services`**  
  * Se puede inspeccionar desde la terminal con comandos como `cat`, `less` o filtrando con `grep`:
    ```bash
    grep -E '(http|ssh|domain|smtp|pop3|imap)' /etc/services
    ```

* **En sistemas Windows:**  
  * **Ruta:** **`C:\Windows\System32\drivers\etc\services`**  
  * Es un archivo de texto sin extensión que mantiene exactamente el mismo formato estándar de asignación de puertos y alias.

---
## 2. Investigue qué es multicast. ¿Sobre cuál de los protocolos de capa de transporte funciona? ¿Se podría adaptar para que funcione sobre el otro protocolo de capa de transporte? ¿Por qué?

---
### **1. ¿Qué es Multicast?**

**Multicast (multidifusión)** es un método de transmisión en el cual un emisor envía un único paquete hacia un grupo específico de destinatarios interesados que se han unido a un grupo de multidifusión mediante una dirección IP dedicada (en IPv4 corresponden a la Clase D, rango `224.0.0.0/4`, y en IPv6 al prefijo `FF00::/8`).

* A diferencia de **Unicast** (comunicación uno a uno) y de **Broadcast** (envío indiscriminado a todos los hosts del enlace local), en multicast los routers de la red se encargan de replicar el paquete únicamente en aquellos enlaces donde existan miembros suscritos al grupo.

---
### **2. ¿Sobre cuál de los protocolos de capa de transporte funciona?**

Multicast funciona sobre **UDP (*User Datagram Protocol*)**.

* **UDP es un protocolo sin conexión (*connectionless*)** y orientado a mensajes/datagramas independientes. 
* El emisor simplemente empaqueta los datos con un puerto destino y los envía hacia la dirección IP de multicast sin necesidad de conocer cuántos receptores existen, quiénes son, ni tener que sincronizar estados con ellos.

---
### **3. ¿Se podría adaptar para que funcione sobre el otro protocolo (TCP)? ¿Por qué?**

**No es posible adaptar Multicast para que funcione directamente sobre TCP**. 

La arquitectura y los mecanismos fundamentales de TCP están estrictamente diseñados para una comunicación **punto a punto (*unicast*) entre exactamente dos extremos**, lo que entra en conflicto directo con la naturaleza multidifusión:

1. **Orientación a conexión y saludo de tres vías (*Three-Way Handshake*):**  
   TCP requiere inicializar y sincronizar estados (números de secuencia iniciales ISN, buffers, opciones) entre un único emisor y un único receptor. No es viable establecer un saludo de tres vías simultáneo con múltiples destinos desconocidos o dinámicos mediante un solo segmento SYN.
2. **Control de flujo y ventana de recepción (*rwnd*):**  
   TCP adapta el ritmo de transmisión al buffer disponible en el receptor mediante el campo *Window Size*. En un entorno multicast con decenas o cientos de receptores heterogéneos (algunos lentos y otros rápidos), no existiría un único tamaño de ventana aplicable al flujo sin degradar a todos a la velocidad del peor receptor.
3. **Control de errores y explosión de reconocimientos (*ACK Implosion*):**  
   TCP garantiza entrega confiable mediante acuses de recibo (ACK) y retransmisiones acumulativas o selectivas. Si un único emisor transmitiera un segmento TCP a un grupo multicast, recibiría simultáneamente un aluvión de ACKs de todos los miembros del grupo (*ACK implosion*), lo que saturaría los buffers del emisor y los enlaces de red.
4. **Control de congestión:**  
   TCP estima el RTT y ajusta su ventana de congestión (*cwnd*) basándose en pérdidas de paquetes. Cada receptor en una red experimenta caminos, retardos y cuellos de botella diferentes, haciendo inviable determinar un único estado de congestión representativo.

*(Nota: En escenarios donde se requiere confiabilidad en multicast, esta se implementa habitualmente en la capa de aplicación o mediante protocolos especializados como RMTP o PGM, operando sobre UDP o directamente sobre la capa de red).*

---
## 3. Investigue cómo funciona el protocolo de aplicación FTP teniendo en cuenta las diferencias en su funcionamiento cuando se utiliza el modo activo y cuando se utiliza el modo pasivo. ¿En qué se diferencian estos tipos de comunicaciones del resto de los protocolos de aplicación vistos?

---
### **1. Funcionamiento General del Protocolo FTP**

El protocolo **FTP (*File Transfer Protocol*)** opera bajo un modelo **cliente/servidor** sobre el servicio confiable de **TCP**, pero a diferencia de la mayoría de los protocolos de aplicación, basa su arquitectura en **dos conexiones TCP independientes y simultáneas**:

1. **Conexión de Control (*Out-Of-Band Control*):**
   * El cliente inicia una conexión hacia el **puerto TCP 21** del servidor.
   * Se mantiene **abierta durante toda la sesión**.
   * Su propósito es cursar los comandos del usuario (autenticación con `USER`/`PASS`, navegación de directorios, etc.) y las respuestas numéricas del servidor, priorizando un **retardo mínimo** (*min delay*).
2. **Conexión de Datos:**
   * Se crea **bajo demanda y de forma efímera** para cada operación que implique transferencia de datos (subir un archivo con `STOR`, descargarlo con `RETR` o listar un directorio con `LIST`).
   * Una vez transmitido el archivo o listado, esta conexión de datos se cierra, mientras que la conexión de control sigue activa. Su objetivo es maximizar el rendimiento o ancho de banda (*max throughput*).

---
### **2. Diferencias: Modo Activo vs. Modo Pasivo**

La diferencia fundamental entre ambos modos radica en **quién toma la iniciativa para abrir la conexión TCP de datos** y qué puertos se utilizan:

```text
       MODO ACTIVO                                    MODO PASIVO
Cliente (My)          Servidor (Other)        Cliente (My)          Servidor (Other)
    |                     |                       |                     |
    | --- Control: 21 --> |                       | --- Control: 21 --> |
    |                     |                       |                     |
    | --- PORT IP:P_cli-> |                       | ----- PASV -------> |
    | <-- 200 OK -------- |                       | <-- 227 Ent PASV -- | (informa P_srv)
    |                     |                       |                     |
    | <-- Datos: P_cli -- | (desde puerto 20)     | --- Datos: P_srv -> | (cliente conecta)
    |     [Transf.]       |                       |     [Transf.]       |
```

#### **A. Modo Activo (*Active Mode* - tradicional)**
* **Cómo funciona:**
  1. El cliente se conecta al puerto 21 del servidor para la sesión de control.
  2. Al momento de transferir datos, el cliente abre un puerto local efímero (`P_cli > 1024`) y le envía al servidor el comando **`PORT h1,h2,h3,h4,p1,p2`** por el canal de control, informándole su dirección IP y el número de puerto donde esperará la conexión.
  3. El **servidor** toma la iniciativa activa e inicia una conexión TCP **desde su puerto 20 (*ftp-data*) hacia el puerto `P_cli` anunciado por el cliente**.
* **Desventajas:**
  * **Problemas con NAT y Firewalls del cliente:** Dado que es el servidor quien origina una conexión TCP entrante hacia un puerto alto del cliente, los cortafuegos (*firewalls*) hogareños/empresariales o los dispositivos NAT bloquean la conexión al considerarla tráfico no solicitado desde el exterior.

#### **B. Modo Pasivo (*Passive Mode* - modo moderno/recomendado)**
* **Cómo funciona:**
  1. El cliente envía por la conexión de control el comando **`PASV`**.
  2. El servidor abre un puerto efímero no privilegiado (`P_srv > 1024`) y responde con el código **`227 Entering Passive Mode (h1,h2,h3,h4,p1,p2)`**, indicándole al cliente la IP y el puerto en el que quedó escuchando.
  3. El **cliente** toma la iniciativa e **inicia la conexión TCP de datos** desde uno de sus puertos efímeros hacia el puerto `P_srv` abierto por el servidor.
* **Ventajas:**
  * Al ser ambas conexiones (control y datos) iniciadas de manera saliente por el cliente (*outbound*), no se ve afectado por el firewall o NAT del cliente.

---
### **3. ¿En qué se diferencia FTP del resto de los protocolos de aplicación vistos?**

1. **Uso de múltiples conexiones TCP separadas (*Control fuera de banda / Out-of-band*):**  
   Protocolos como HTTP, SMTP, DNS, SSH o POP3/IMAP canalizan tanto las solicitudes de control/comandos como el transporte de la información útil a través de una **única conexión TCP (en banda o *in-band*)**. En cambio, FTP separa tajantemente los comandos de control del flujo de datos en dos conexiones TCP distintas.
2. **Ciclo de vida efímero para los datos:**  
   La conexión de control es persistente, pero la conexión de datos se establece y se destruye por cada archivo o lista de directorio que se transmite.
3. **Inversión de roles en la apertura de transporte (en Modo Activo):**  
   En todos los demás protocolos cliente/servidor, es siempre el cliente quien realiza la apertura activa hacia el puerto bien conocido del servidor. En el modo activo de FTP, **el servidor actúa como iniciador activo de una conexión TCP hacia el cliente**.
4. **Negociación de representación y estructura de datos (Capa de Presentación):**  
   FTP incorpora mecanismos explícitos para definir cómo interpretar y formatear los datos transferidos según el sistema operativo (comandos `TYPE` para **ASCII**, **EBCDIC** o **IMAGE/Binario**, y `STRU` o `MODE`), resolviendo problemas de heterogeneidad entre plataformas que otros protocolos delegan a estándares externos como MIME.

---
## 4. Suponiendo Selective Repeat, tamaño de ventana 4 y sabiendo que `E` indica que el mensaje llegó con errores, indique en el siguiente gráfico la numeración de los ACK que el host B envía al Host A.

![[Pasted image 20261103201610.png]]

**Diagrama (Host A ↔ Host B):**
- Host A envía los segmentos `0, 1, 2, 3, 4, 5` hacia Host B.
- El segmento `2` llega a Host B con errores (marcado `E`).
- Host B devuelve los ACK correspondientes a Host A a medida que recibe los segmentos.
- Al vencer el *Timeout* del segmento `2`, Host A lo retransmite y Host B responde con el ACK correspondiente.

---
### **1. Principio de funcionamiento en Selective Repeat (SR)**

A diferencia de *Go-Back-N* (donde los ACKs son acumulativos y se descartan los paquetes fuera de orden), en **Selective Repeat (SR)**:
* **El receptor confirma individualmente cada paquete recibido correctamente** mediante un **ACK explícito** con el número de secuencia de ese paquete en particular.
* **Paquetes con error o corrompidos (`E`):** Al no superar la comprobación de checksum o estar corrompidos, el receptor **no genera ACK** para ese paquete (o lo descarta).
* **Paquetes fuera de orden:** Si un paquete correcto llega fuera de orden pero cae dentro del rango de la ventana del receptor (`[rcv_base, rcv_base + N - 1]`), el receptor **lo almacena en su buffer local (*buffering*) y envía inmediatamente el ACK correspondiente a ese paquete**.

---
### **2. Análisis paso a paso del gráfico**

El Host A (emisor) tiene una ventana de tamaño N = 4 e inicia transmitiendo los primeros 4 paquetes (del 0 al 3):

1. **Host A envía el mensaje `0`:**
   * Llega correctamente al Host B.
   * **Host B responde:** **`ACK 0`** (avanza su base a 1 y entrega el paquete 0 a la aplicación).
   * Al llegar el `ACK 0` al Host A, este avanza su ventana y transmite el **mensaje `4`**.

2. **Host A envía el mensaje `1`:**
   * Llega correctamente al Host B.
   * **Host B responde:** **`ACK 1`** (avanza su base a 2 y entrega el paquete 1 a la aplicación).
   * Al llegar el `ACK 1` al Host A, este avanza su ventana y transmite el **mensaje `5`**.

3. **Host A envía el mensaje `2`:**
   * Llega con error al Host B (**marcado con `E`** en el gráfico).
   * **Host B:** Al estar corrupto/dañado, **no envía ACK** para el paquete 2. La base de la ventana de recepción se queda retenida en `2`.

4. **Host A envía el mensaje `3`:**
   * Llega correctamente al Host B. Como el paquete 2 no llegó bien, el mensaje 3 está **fuera de orden**.
   * **Host B:** Lo retiene en buffer (esperando a que se recupere el 2) y **responde con:** **`ACK 3`**.

5. **Host A envía el mensaje `4`:**
   * Llega correctamente al Host B (también fuera de orden).
   * **Host B:** Lo retiene en buffer y **responde con:** **`ACK 4`**.

6. **Host A envía el mensaje `5`:**
   * Llega correctamente al Host B (fuera de orden).
   * **Host B:** Lo retiene en buffer y **responde con:** **`ACK 5`**.

7. **Vence el temporizador en Host A (`Timeout 2`):**
   * El emisor nunca recibió el ACK del paquete 2 y expira su temporizador individual.
   * En Selective Repeat, el Host A **retransmite únicamente el paquete 2**.
   * Llega la retransmisión del mensaje 2 al Host B.
   * **Host B responde con:** **`ACK 2`**.
   * Al recibir el paquete 2, el receptor completa la secuencia de los paquetes que tenía almacenados en el buffer (2, 3, 4 y 5), los entrega todos juntos a la capa superior y desliza su ventana.
### **Resumen de las flechas de respuesta (de arriba hacia abajo en el diagrama):**

* 1ª flecha roja (respuesta al mensaje 0): **`ACK 0`**
* 2ª flecha roja (respuesta al mensaje 1): **`ACK 1`**
* *(Mensaje 2 llega con error `E` --> no genera respuesta)*
* 3ª flecha roja (respuesta al mensaje 3): **`ACK 3`**
* 4ª flecha roja (respuesta al mensaje 4): **`ACK 4`**
* 5ª flecha roja (respuesta al mensaje 5): **`ACK 5`**
* 6ª flecha roja (respuesta a la retransmisión tras `Timeout 2`): **`ACK 2`**

---
## 5. ¿Qué restricción existe sobre el tamaño de ventanas en el protocolo Selective Repeat?

---
### **1. La Restricción Fundamental**

En el protocolo **Selective Repeat (SR)**, el tamaño de la ventana ($W$ o $N$) debe ser **menor o igual a la mitad del espacio de números de secuencia disponibles**:

$\mathbf{W \le \frac{M}{2}}$

Donde:
* **$W$** es el tamaño de la ventana (tanto del emisor como del receptor).
* **$M$** es la cantidad total de números de secuencia distintos en el espacio modular. Si se emplean **$k$ bits** para codificar el número de secuencia en la cabecera, entonces $M = 2^k$, quedando la restricción formulada como:

$\mathbf{W \le 2^{k-1}} \quad \Longleftrightarrow \quad \mathbf{M \ge 2W}$

---
### **2. ¿Por qué existe esta restricción? (El Dilema del Receptor)**

A diferencia de *Go-Back-N* —donde el receptor solo acepta un único paquete estrictamente en orden $W_{rx} = 1$ y la restricción es simplemente $W \le M - 1$—, en **Selective Repeat el receptor tiene su propia ventana de recepción de tamaño $W$** y almacena paquetes recibidos fuera de orden.

Dado que existe un canal de comunicación con retardo y posibles pérdidas entre ambos extremos, **las ventanas del emisor y del receptor no avanzan sincronizadas en el mismo instante exacto**. 

Si la ventana fuera mayor a la mitad del espacio $W > \frac{M}{2}$, se produce una **ambigüedad catastrófica en el receptor**, donde este es incapaz de distinguir si un paquete entrante es una **retransmisión de un paquete viejo (duplicado)** o si es un **paquete completamente nuevo**.

---
### **3. Ejemplo del problema cuando no se cumple la regla $W > M/2$**

Supongamos un espacio de números de secuencia con **$k = 2$ bits** $M = 2^2 = 4$ números: **`0, 1, 2, 3`**) y elegimos un tamaño de ventana **$W = 3$** (notar que $3 > 4/2 = 2$, violando la restricción):

#### **Escenario A: Pérdida de todas las confirmaciones (ACKs)**
1. El emisor transmite los paquetes **`0`**, **`1`** y **`2`**.
2. El receptor los recibe correctamente, entrega los datos a la capa superior, envía los acuses de recibo **`ACK 0`**, **`ACK 1`**, **`ACK 2`** y desliza su ventana de recepción.
3. Supongamos que **todos los ACKs se pierden en la red**.
4. En el emisor expira el temporizador para el paquete **`0`** (*timeout*) y lo retransmite: envía nuevamente el paquete con número de secuencia **`0`**.
5. **El receptor recibe el paquete `0`**: Al mirar su ventana activa, ve que el `0` está contenido en ella y **lo acepta erróneamente como un dato nuevo**, cuando en realidad era un duplicado del primer paquete.

#### **Escenario B: Transmisión normal con avance de ventana**
1. El emisor transmite los paquetes **`0`**, **`1`** y **`2`**.
2. El receptor los recibe y envía sus ACKs.
3. Esta vez, **todos los ACKs llegan exitosamente al emisor**.
4. El emisor desliza su ventana y transmite los siguientes paquetes nuevos: **`3`**, **`0`** y **`1`**.
5. Supongamos que el paquete **`3`** se pierde en el camino pero el paquete nuevo con secuencia **`0`** llega correctamente al receptor.
6. **El receptor recibe el paquete `0`**: Está dentro de su ventana y lo acepta como dato nuevo correcto.

> **Conclusión:** Desde el punto de vista del receptor, los dos escenarios son indistinguibles. Para evitar que la ventana vieja del emisor se solape modularmente con la nueva ventana del receptor, es obligatorio que **el tamaño de la ventana nunca supere la mitad del espacio de numeración**.

---
## 6. De acuerdo a la captura TCP de la siguiente figura, indique los valores de los campos borroneados.

![[Pasted image 20261103201725.png|1050]]

```
No.  Time       Source         Destination    Protocol  Length  Info
1    0.000000   172.20.1.1     172.20.1.100   TCP       74      41749 > vce [____] Seq=____ Win=5840 Len=0 MSS=1460 SACK_PERM=1 TSval=270132 TSecr=0
2    0.001264   172.20.1.100   172.20.1.1     TCP       74      vce > 41749 [SYN, ACK] Seq=1047471501 Ack=3933822138 Win=5792 Len=0 MSS=1460 SACK_PERM=1 ...
3    0.001341   ____           ____           TCP       66      ____ > ____ [____] Seq=____ Ack=____ Win=5888 Len=0 TSval=270132 TSecr=1877442...

Internet Protocol Version 4, Src: 172.20.1.100 (172.20.1.100), Dst: 172.20.1.1 (172.20.1.1)
Transmission Control Protocol, Src Port: vce (11111), Dst Port: 41749 (41749), Seq: 1047471501, Ack: 3933822138, Len: 0
    Source port: vce (11111)
    Destination port: 41749 (41749)
    [Stream index: 0]
    Sequence number: 1047471501
    Acknowledgement number: 3933822138
    Header length: 40 bytes
    Flags: 0x012 (SYN, ACK)
        000. .... = Reserved: Not set
        ...0 .... = Nonce: Not set
        .... 0... = Congestion Window Reduced (CWR): Not set
        .... .0.. = ECN-Echo: Not set
        .... ..0. = Urgent: Not set
        .... ...1 = Acknowledgment: Set
        .... .... 0... = Push: Not set
        .... .... .0.. = Reset: Not set
        .... .... ..1. = Syn: Set
        .... .... ...0 = Fin: Not set
    Window size value: 5792
    [Calculated window size: 5792]
    Checksum: 0x9803 [validation disabled]
```

---
### **1. Análisis de la captura Wireshark**

La captura muestra el establecimiento de una conexión TCP mediante el **saludo de tres vías (*three-way handshake*)** entre el host cliente `172.20.1.1` (puerto efímero `41749`) y el servidor `172.20.1.100` (puerto `11111`, asociado al servicio denominado `vce`):

* **Paquete 1 (Cliente --> Servidor):**  
  `172.20.1.1 -> 172.20.1.100 | TCP | 41749 > vce [____] Seq=____ Win=5840 Len=0 MSS=1460 ...`
* **Paquete 2 (Servidor --> Cliente):**  
  `172.20.1.100 -> 172.20.1.1 | TCP | vce > 41749 [SYN, ACK] Seq=1047471501 Ack=3933822138 Win=5792 Len=0 MSS=1460 ...`  
  *El detalle del panel inferior de Wireshark corresponde a este paquete 2, donde se lee:*  
  * **Sequence number:** `1047471501` $ISN_{servidor}$.
  * **Acknowledgement number:** `3933822138`.
  * **Flags:** `0x012 (SYN, ACK)`.
* **Paquete 3 (Cliente --> Servidor):**  
  `172.20.1.1 -> 172.20.1.100 | TCP | 66 41749 > vce [____] Seq=____ Ack=____ Win=5888 Len=0 ...`

---
### **2. Deducción de los campos borroneados**

#### **En el Paquete 1:**
1. **Flags:** **`[SYN]`**  
   * **Justificación:** Es el primer segmento del saludo de tres vías iniciado activamente por el cliente para solicitar la apertura de la conexión y sincronizar los números de secuencia.
1. **`Seq` (Número de secuencia inicial del cliente - $ISN_{cliente}$):** **`3933822137`**  
   * **Justificación:** En el segundo paquete, el servidor acusa recibo del `SYN` del cliente enviando `Ack = 3933822138`. Como un paquete con flag `SYN` activo consume conceptualmente 1 número de secuencia $Ack = Seq_{SYN} + 1$, el valor de secuencia emitido en el paquete 1 fue:  
     $\text{Seq}_1 = 3933822138 - 1 = \mathbf{3933822137}$

---
#### **En el Paquete 3:**
3. **Puertos origen y destino:** **`41749 > vce`** (o `41749 > 11111`)  
   * **Justificación:** El tercer segmento es emitido por el cliente (`172.20.1.1:41749`) hacia el servidor (`172.20.1.100:11111`), completando la confirmación de la conexión.
4. **Flags:** **`[ACK]`**  
   * **Justificación:** Es el segmento final del *handshake*, donde el cliente confirma la recepción del `SYN+ACK` del servidor.
5. **`Seq`:** **`3933822138`**  
   * **Justificación:** El cliente envió inicialmente su $ISN = 3933822137$ en el paquete 1. Como el `SYN` consumió 1 byte de secuencia, el siguiente byte a transmitir por el cliente corresponde al número `3933822138`.
3. **`Ack`:** **`1047471502`**  
   * **Justificación:** El servidor anunció su propio número de secuencia inicial en el paquete 2 con `Seq = 1047471501` y el flag `SYN` seteado. El cliente debe acusar recibo de ese `SYN` confirmando $Ack = \text{Seq}_{servidor} + 1$:  
     $\text{Ack}_3 = 1047471501 + 1 = \mathbf{1047471502}$

---
### **Resumen final de valores borroneados:**

* **Paquete 1:**
  * **Flags:** `SYN`
  * **Seq:** `3933822137`
* **Paquete 3:**
  * **Puertos:** `41749 > vce` (o `41749 > 11111`)
  * **Flags:** `ACK`
  * **Seq:** `3933822138`
  * **Ack:** `1047471502`

---
## 7. Dada la sesión TCP de la figura, completar los valores marcados con un signo de interrogación.

![[Pasted image 20261103201756.png]]

| Time   | `10.0.0.10` (54762) ↔ `10.0.1.10` (10000) | Comment                  |
| ------ | ----------------------------------------- | ------------------------ |
| 1.360  | `SYN` →                                   | Seq = 0                  |
| 1.360  | ← `SYN, ACK`                              | Seq = 0, Ack = 1         |
| 1.360  | `ACK` →                                   | Seq = **1**, Ack = **1** |
| 3.581  | `PSH, ACK` - Len:7 →                      | Seq = 1, Ack = 1         |
| 3.581  | ← `ACK`                                   | Seq = 1, Ack = **8**     |
| 8.796  | `PSH, ACK` - Len:9 →                      | Seq = 8, Ack = 1         |
| 8.797  | ← `ACK`                                   | Seq = 1, Ack = **17**    |
| 14.382 | `PSH, ACK` - Len:5 →                      | Seq = 17, Ack = 1        |
| 14.382 | ← `ACK`                                   | Seq = 1, Ack = **22**    |
| 15.190 | `FIN, ACK` →                              | Seq = **22**, Ack = 1    |
| 15.190 | ← `FIN, ACK`                              | Seq = 1, Ack = **23**    |
| 15.190 | `ACK` →                                   | Seq = **23**, Ack = 2    |

### **1. Análisis de la Sesión TCP y Reglas de Numeración**

La captura muestra una comunicación TCP completa entre el **Cliente** (`10.0.0.10:54762`) y el **Servidor** (`10.0.1.10:10000`):
* **Saludo de tres vías (*Handshake*):**
  * Los números de secuencia relativos iniciales son $ISN_{cliente} = 0$ e $ISN_{servidor} = 0$.
  * Los flags `SYN` y `FIN` no transportan datos de aplicación, pero **consumen lógicamente 1 número de secuencia**.
* **Transferencia de datos:**
  * En cada segmento de datos, el emisor transmite desde el byte indicado en su campo `Seq`.
  * Si un segmento transporta `Len = L` bytes, el siguiente número de secuencia será $\text{Seq} + L$.
  * El receptor responde con un `Ack` acumulativo indicando el **próximo byte que espera recibir**: $\text{Ack} = \text{Seq} + \text{Len}$.

---
### **2. Deducción fila por fila de los valores con `?`**

1. **Fila 3 (Tiempo `1.360`): `Cliente -> Servidor` | `ACK`**
   * **`Seq = 1`**: El cliente envió `Seq = 0` en el `SYN`. Al consumir 1 número de secuencia, su siguiente byte es el `1`.
   * **`Ack = 1`**: Confirma el `SYN, ACK` del servidor (que tenía `Seq = 0`), esperando su byte `0 + 1 = 1`.
   * *(Valores:* **`Seq = 1, Ack = 1`**)*.

2. **Fila 5 (Tiempo `3.581`): `Servidor -> Cliente` | `ACK`**
   * El cliente acaba de enviar un segmento con `Seq = 1` y longitud `Len: 7`.
   * El servidor acusa recibo de los 7 bytes recibidos esperando el siguiente byte: $1 + 7 = 8$.
   * *(Valor:* **`Ack = 8`**)*.

3. **Fila 7 (Tiempo `8.797`): `Servidor -> Cliente` | `ACK`**
   * El cliente envió un segmento con `Seq = 8` y longitud `Len: 9`.
   * El servidor acusa recibo esperando el byte: $8 + 9 = 17$.
   * *(Valor:* **`Ack = 17`**)*.

4. **Fila 9 (Tiempo `14.382`): `Servidor -> Cliente` | `ACK`**
   * El cliente envió un segmento con `Seq = 17` y longitud `Len: 5`.
   * El servidor acusa recibo esperando el byte: $17 + 5 = 22$.
   * *(Valor:* **`Ack = 22`**)*.

5. **Fila 10 (Tiempo `15.190`): `Cliente -> Servidor` | `FIN, ACK`**
   * El cliente inicia el cierre activo. Como el último paquete de datos terminó en el byte 21 ($17 + 5 - 1$), el número de secuencia de este segmento es **`Seq = 22`**.
   * *(Valor:* **`Seq = 22`**)*.

6. **Fila 11 (Tiempo `15.190`): `Servidor -> Cliente` | `FIN, ACK`**
   * El servidor confirma el `FIN` del cliente. Dado que el `FIN` consume 1 unidad de secuencia, el servidor debe acusar recibo de $22 + 1 = 23$.
   * *(Valor:* **`Ack = 23`**)*.

7. **Fila 12 (Tiempo `15.190`): `Cliente -> Servidor` | `ACK`**
   * El cliente envía la confirmación final del cierre.
   * Su número de secuencia es **`Seq = 23`** (tras haber consumido 1 con su propio `FIN` que tenía `Seq = 22`).
   * Confirma el `FIN` del servidor (que tenía `Seq = 1`), por lo que su acuse de recibo es `Ack = 1 + 1 = 2` (tal como figura en el gráfico).
   * *(Valor:* **`Seq = 23`**)*.

---
## 8. ¿Qué es el RTT y cómo se calcula? Investigue la opción TCP timestamp y los campos `TSval` y `TSecr`.

---
### **1. ¿Qué es el RTT (*Round Trip Time*) y cómo se calcula?**

El **RTT** (*Round Trip Time* o tiempo de ida y vuelta) es el **intervalo de tiempo que transcurre desde que un emisor transmite un segmento de datos hasta que recibe el acuse de recibo (ACK) correspondiente** emitido por el receptor. Es un parámetro fundamental para que TCP pueda fijar dinámicamente el temporizador de retransmisión (**RTO** - *Retransmission Timeout*).

#### **Cálculo de la estimación de RTT y del Timeout (RFC 6298):**
Dado que el RTT medido para cada paquete individual (**`SampleRTT`**) fluctúa continuamente debido a las colas y retardos variables en los routers de la red, TCP no utiliza una muestra aislada directamente, sino un promedio suavizado mediante una **media móvil ponderada exponencial** (*EWMA*):

1. **Estimación media del RTT (`EstimatedRTT` o `SRTT`):**
   $\text{EstimatedRTT} = (1 - \alpha) \cdot \text{EstimatedRTT} + \alpha \cdot \text{SampleRTT}$
   *(El estándar recomienda fijar el factor de peso en $\alpha = 0.125 = 1/8$)*.

2. **Desviación o variabilidad del RTT (`DevRTT`):**
   Mide cuánto se desvía el `SampleRTT` respecto del promedio estimado:
   $\text{DevRTT} = (1 - \beta) \cdot \text{DevRTT} + \beta \cdot |\text{SampleRTT} - \text{EstimatedRTT}|$
   *(Típicamente con $\beta = 0.25 = 1/4$)*.

3. **Cálculo del intervalo de temporización (**`TimeoutInterval`** o **`RTO`**):**
   Se añade un margen de seguridad proporcional a la dispersión de las medidas:
   $\text{TimeoutInterval (RTO)} = \text{EstimatedRTT} + 4 \cdot \text{DevRTT}$

---
### **2. La opción TCP Timestamps (RFC 1323 / RFC 7323)**

Tradicionalmente, medir el RTT mediante temporizadores locales presentaba problemas importantes. Según el **Algoritmo de Karn**, si un segmento es retransmitido, el emisor no puede determinar si el ACK recibido corresponde al paquete original o a la retransmisión, por lo que las muestras de paquetes retransmitidos deben ignorarse. 

Para solucionar esto de forma precisa y eficiente sin requerir temporizadores por cada paquete, se introdujo en el campo de opciones de la cabecera TCP la **opción Timestamps** (`Option Kind = 8`, longitud de 10 bytes).

Esta opción introduce dos campos de 32 bits en el encabezado:

* **`TSval` (*Timestamp Value*):** 
  * Es el valor de la marca de tiempo generada por el reloj local del emisor en el instante exacto en que despacha el segmento.
* **`TSecr` (*Timestamp Echo Reply*):** 
  * Es el "eco" de la última marca de tiempo recibida del otro extremo. Cuando el receptor genera un ACK, copia el valor del `TSval` que recibió en el paquete de datos dentro de su propio campo `TSecr`.

---
### **3. Funcionamiento de `TSval` y `TSecr` en la medición de RTT (RTTM)**

El mecanismo de cálculo opera de manera simétrica y continua entre ambos hosts:

```text
Host A (Reloj A = 100)                             Host B (Reloj B = 450)
   |                                                        |
   | --- Segmento datos: [TSval=100, TSecr=0] ------------> | (B registra TSval=100)
   |                                                        |
   | <--- Segmento ACK: [TSval=465, TSecr=100] ------------ | (B devuelve como eco el 100)
   |
(Al recibir el ACK en tiempo Reloj A = 120):
 RTT = Reloj_Actual - TSecr = 120 - 100 = 20 ms
```

1. El emisor envía un segmento y coloca su tiempo actual en **`TSval`** (por ejemplo, `100`).
2. El receptor recibe el paquete y, al confeccionar la respuesta/ACK, asigna **`TSecr = 100`** mientras coloca su propia hora local en `TSval` (por ejemplo, `465`).
3. Cuando el emisor original recibe ese ACK, simplemente resta:
   $\mathbf{\text{RTT} = \text{Tiempo\_Actual\_Local} - \text{TSecr}}$
4. **Ventajas:**
   * **No requiere sincronización de relojes:** El emisor solo resta su propio reloj local contra el valor devuelto.
   * **Elimina la ambigüedad de Karn:** Cada retransmisión lleva un `TSval` diferente, permitiendo correlacionar exactamente qué ACK responde a cuál segmento sin confusiones.
   * **Protección contra solapamiento de números de secuencia (PAWS - *Protection Against Wrapped Sequences*):** En redes de alta velocidad (alto ancho de banda) donde los números de secuencia de 32 bits pueden dar la vuelta rápidamente (*wrap-around*), los timestamps permiten descartar segmentos viejos rezagados que compartan el mismo rango de secuencia.

---
## 9. Para la captura *tcp-captura.pcap*, responder las siguientes preguntas.
- **a. ¿Cuántos intentos de conexiones TCP hay?**
- **b. ¿Cuáles son la fuente y el destino (IP:port) para c/u?**
- **c. ¿Cuántas conexiones TCP exitosas hay en la captura? ¿Cómo diferencia las exitosas de las que no lo son? ¿Cuáles flags encuentra en cada una?**
- **d. Dada la primera conexión exitosa, responder:**
  - i. ¿Quién inicia la conexión?
  - ii. ¿Quién es el servidor y quién el cliente?
  - iii. ¿En qué segmentos se ve el 3-way handshake?
  - iv. ¿Cuáles ISNs se intercambian?
  - v. ¿Cuál MSS se negoció?
  - vi. ¿Cuál de los dos hosts envía la mayor cantidad de datos (IP:port)?
- **e. Identificar el primer segmento de datos (origen, destino, tiempo, número de fila y número de secuencia TCP).**
  - i. ¿Cuántos datos lleva?
  - ii. ¿Cuándo es confirmado (tiempo, número de fila y número de secuencia TCP)?
  - iii. La confirmación, ¿qué cantidad de bytes confirma?
- **f. ¿Quién inicia el cierre de la conexión? ¿Qué flags se utilizan? ¿En cuáles segmentos se ve (tiempo, número de fila y número de secuencia TCP)?**

---
## 10. Responda las siguientes preguntas respecto del mecanismo de control de flujo.
- **a. ¿Quién lo activa? ¿De qué forma lo hace?**
- **b. ¿Qué problema resuelve?**
- **c. ¿Cuánto tiempo dura activo y qué situación lo desactiva?**

---
## 11. Responda las siguientes preguntas respecto del mecanismo de control de congestión.
- **a. ¿Quién activa el mecanismo de control de congestión? ¿Cuáles son los posibles disparadores?**
- **b. ¿Qué problema resuelve?**
- **c. Diferencie `slow start` de `congestion-avoidance`.**

---
## 12. Para la captura *udp-captura.pcap*, responder las siguientes preguntas.
- **a. ¿Cuántas comunicaciones (srcIP, srcPort, dstIP, dstPort) UDP hay en la captura?**
- **b. ¿Cómo se podrían identificar las exitosas de las que no lo son?**
- **c. ¿UDP puede utilizar el modelo cliente/servidor?**
- **d. ¿Qué servicios o aplicaciones suelen utilizar este protocolo? ¿Qué requerimientos tienen?**
- **e. ¿Qué hace el protocolo UDP en relación al control de errores?**
- **f. Con respecto a los puertos vistos en las capturas, ¿observa algo particular que lo diferencie de TCP?**
- **g. Dada la primera comunicación en la cual se ven datos en ambos sentidos (identificar el primer datagrama):**
  - i. ¿Cuál es la dirección IP que envía el primer datagrama? ¿Desde cuál puerto?
  - ii. ¿Cuántos datos se envían en un sentido y en el otro?

---
## 13. Dada la salida que se muestra en la imagen, responda los ítems debajo.

```
Netid  State      Local Address:Port    Peer Address:Port       Process
udp    UNCONN     *:68                  *:*                     (("dhclient",671,5))
udp    UNCONN     *:123                 *:*                     (("ntpd",2138,16))
udp    UNCONN     :::123                :::*                    (("ntpd",2138,17))
tcp    LISTEN     *:80                  *:*                     (("nginx",23653,19),("nginx",23652,19))
tcp    LISTEN     *:22                  *:*                     (("sshd",1151,3))
tcp    LISTEN     127.0.0.1:25          *:*                     (("master",11457,12))
tcp    LISTEN     *:443                 *:*                     (("nginx",23653,20),("nginx",23652,20))
tcp    LISTEN     *:3306                *:*                     (("mysqld",4556,13))
tcp    ESTAB      127.0.0.1:3306        127.0.0.1:34338         (("mysqld",4556,14))
tcp    TIME-WAIT  10.100.25.135:443     43.226.162.110:29148
tcp    ESTAB      127.0.0.1:48717       127.0.0.1:3306          (("mysqld",4556,17))
tcp    ESTAB      127.0.0.1:3306        127.0.0.1:48717         (("ruby",28615,10))
tcp    ESTAB      127.0.0.1:34338       127.0.0.1:3306          (("ruby",28610,9))
tcp    ESTAB      10.100.25.135:22      200.100.120.210:61576   (("sshd",13756,3),("sshd",13654,3))
tcp    LISTEN     :::22                 :::*                    (("sshd",1151,4))
tcp    LISTEN     :1:25                 :::*                    (("master",11457,13))
```

- Suponga que ejecuta los siguientes comandos desde un host con la IP `10.100.25.90`. Responda qué devuelve la ejecución de los siguientes comandos y, en caso que corresponda, especifique los flags.
  - a. `hping3 -p 3306 --udp 10.100.25.135`
  - b. `hping3 -S -p 25 10.100.25.135`
  - c. `hping3 -S -p 22 10.100.25.135`
  - d. `hping3 -S -p 110 10.100.25.135`

- ¿Cuántas conexiones distintas hay establecidas? Justifique.
