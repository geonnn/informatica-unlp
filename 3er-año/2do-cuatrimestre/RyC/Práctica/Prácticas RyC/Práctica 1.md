### 1. ¿Qué es una red? ¿Cuál es el principal objetivo para construir una red?

Una red es una cadena de elementos intercomunicados. El objetivo es interrelacionar los elementos para que puedan intercambiar mensajes entre sí y/o transferir información.

---
### 2. ¿Qué es Internet? Describa los principales componentes que permiten su funcionamiento.

Internet es una red que interconecta un gran número de equipos ubicados físicamente alrededor de todo el mundo. Equipos como computadoras, teléfonos, notebooks, entre otros, se conocen como **hosts** o **end systems**. Estos end systems se interconectan mediante una red de **link communications** y **packet switches** como por ejemplo routers o link-layer switches.
Los end systems acceden a internet mediante un ISP (Internet Service Provider). Cada ISP es en sí mismo una red. Se dice que Internet es una **red de redes**.
Todos estos componentes utiilzan protocolos que controlan el envío y la recepción de información. Los dos más importantes son los protocolos TCP y el IP.

Otro enfoque para definir Internet es como una infraestructura que provee servicios para aplicaciones. Estas aplicaciones se conocen como **aplicaciones distribuidas** ya que involucran varios end systems que intercambian información entre sí.

---
### 3. ¿Qué son las RFCs?

Los RFCs (requests for comments) son documentos que desarrolla la IETF (Internet Engineering Task Force) para definir estándares del Internet, como por ejemplo los protocolos TCP, IP, HTTP, SMTP, entre otros. 

---
### 4. ¿Qué es un protocolo?

Un conjunto de reglas que forman un estándar de comunicación. Mediante protocolos los equipos pueden comunicarse independientemente de sus características propias, como por ejemplo, el SO.

> *A protocol defines the format and the order of messages exchanged between two or more communicating entities, as well as the actions taken on the transmission and/or receipt of a message or other event.*
---
### 5. ¿Por qué dos máquinas con distintos sistemas operativos pueden formar parte de una misma red?

Porque utilizan el mismo protocolo. Es decir, se establece un estándar de comunicación para que distintos dispositivos o equipos (que pueden tener distintas características, como p. ej. distinto SO) conectados en una misma red puedan transferir información entre sí exitosamente.

---
### 6. ¿Cuáles son las 2 categorías en las que pueden clasificarse a los sistemas finales o End Systems? Dé un ejemplo del rol de cada uno en alguna aplicación distribuida que corra sobre Internet.

**Servidor o cliente**.
Un **cliente** es el sistema que realiza peticiones, que solicita/consume/recibe información. Por ejemplo, una PC realizando una búsqueda en google.
Un **servidor** es el sistema que brinda/ofrece información en respuesta a peticiones de clientes. Por ejemplo, un servidor DNS, un servidor web, entre otros.

---
### 7. ¿Cuál es la diferencia entre una red conmutada de paquetes de una red conmutada de circuitos?

En una red **conmutada de paquetes (*packet-switched network*)**, las fuentes envían los paquetes sin reservar recursos, por lo que si estos no están disponibles se puede generar cierta demora en el envío y/o recepción de la información. 
En una red **conmutada de circuitos (*circuit-switched network*)**, los recursos se reservan por el tiempo necesario requerido antes de establecer la comunicación. Implica el proceso de la reserva previa de recursos, pero una vez que se quieran utilizar, estarán disponibles.

*Analogía restaurant por llegada (y que no admite reservas) vs. restaurant por reserva (y sólo reserva).*

---
### 8. Analice qué tipo de red es una red de telefonía y qué tipo de red es Internet.

Circuit-switched vs. packet-switched.

---
### 9. Describa brevemente las distintas alternativas que conoce para acceder a Internet en su hogar.

**DSL (digital subscriber line):** usa la infraestructura de la línea de teléfono. La misma compañía que da servicio de teléfono también será el ISP. El cable transporta información en tres canales (rangos de frecuencia) distintos:
- Canal de bajada de alta velocidad (50kHz a 1MHz)
- Canal de subida de media velocidad (4kHz a 50kHz)
- Canal de teléfono (0 a 4kHz)

**Cable (tv):** usa la infraestructura del cable de tv (coaxial). La misma compañía que da servicio de tv por cable será ISP. **¿Fibra óptica?**

**Satélite(?**

---
### 10. ¿Qué ventajas tiene una implementación basada en capas o niveles?

La implementación basada en capas permite modularizar la solución para desarrollar un sistema complejo. Una capa proporciona su servicio realizando ciertas acciones dentro de su dominio y usando los servicios de la capa inmediatamente inferior. De esta manera, mientras el servicio que una capa brinda sea funcional y correcto para el sistema, la implementación del mismo puede variar o ser modificada sin afectar a todo el sistema.

---
### 11. ¿Cómo se llama la PDU de cada una de las siguientes capas: Aplicación, Transporte, Red y Enlace?

**PDU:** Protocol data unit.

**Aplicación:** Mensaje (*message*).
**Transporte:** Segmento (o datagrama en UDP) (*segment*)
**Red:** Paquete (*datagram*)
**Enlace:** Trama (*frame*).

---
### 12. ¿Qué es la encapsulación? Si una capa realiza la encapsulación de datos, ¿qué capa del nodo receptor realizará el proceso inverso?

La encapsulación consiste en tomar la unidad de información de una capa superior y encapsularla añadiendo información (headers) que puede ser de utilidad para la capa homóloga del lado receptor. Esta última se encargará de realizar el proceso inverso y podría utilizar la información adicional para facilitar o completar ciertas tareas en función de proveer su servicio.

---
### 13. Describa cuáles son las funciones de cada una de las capas del stack TCP/IP o protocolo de Internet.

**cuando busco el modelo TCP/IP son 4 capas:
Application
Transport
Internet (equivalente a network layer)
Network access (equivalente link layer + physical layer)**

**En el libro habla del *Internet Protocol stack* y describe las 5 capas.**

**Application layer:** es donde residen los protocolos de aplicación como HTTP, SMTP, FTP, entre otros. Están presentes en los end systems y una aplicación intercambia paquetes de información con otra. Estos paquetes se conocen como **mensajes** en la capa de aplicación.

**Transport layer:** transporta los mensajes de la capa de aplicación entre los endpoints. Se pasa el paquete de información y la dirección de destino a la capa de red. En Internet existen dos protocolos de transporte: TCP y UDP. Se describen más adelante cuando se ve capa de transporte. En resumen: TCP es más "reliable" para establecer conexiones, porque se asegura de que la información llegue a destino correctamente y demás. En UDP sólo se envía la información y no se verifica su recepción, entonces es un protocolo más eficiente en el uso de recursos.
En la capa de transporte los paquetes se conocen como **segmentos**.

**Network layer:** provee el servicio de entregar el segmento a la capa de transporte del host destino. Acá los paquetes se conocen como **datagrams.** Utiliza el protocolo IP, que deben tener todos los elementos de Internet que tengan una capa de red.

**Link layer:** mueve el paquete de un nodo (host o router) al siguiente en la ruta. La capa de red "dibuja" la ruta y la capa de enlace ejecuta el camino. En cada nodo, la capa de red le entrega el datagram a la capa de enlace. La capa de enlace toma el paquete, conocido como **frame** en este caso, y lo transporta al nodo siguiente. Ya en el nuevo nodo, le envía el paquete (datagram) a la capa de red.

**Physical layer:** provee el servicio de mover cada bit de un frame de un nodo a otro. La forma en que se realiza depende del medio de transmisión físico utilizado, pero el servicio es el mismo, en cada caso se mueven bits de un nodo al siguiente.

---
### 14. Compare el modelo OSI con la implementación TCP/IP

El modelo OSI se compone de 7 capas, las 5 descritas en 13) y dos más entre Application y Transport: Presentation y Session. Estas dos capas en quedarían dentro de la capa de aplicación en el modelo TCP/IP, ya que los servicios que implementan estas capas, el modelo TCP/IP lo deja librado a que lo implementen las aplicaciones que intercambian información.

**Presentation** provee servicios que permite a las aplicaciones interpretar el significado de la información intercambiada. Compresión, encriptación y descripción de información, entre otros.
**Session** provee servicios para la delimitación y sincronización del intercambio de información, lo que puede incluir también los medios para crear checkpoints y un esquema de recuperación en caso de fallos.

