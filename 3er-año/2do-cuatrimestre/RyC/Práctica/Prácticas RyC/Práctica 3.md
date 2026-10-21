# Práctica 3 - Capa de Aplicación
## DNS (Domain Name Server)

**Introducción**

---
### 1. Investigue y describa cómo funciona el DNS. ¿Cuál es su objetivo?

El objetivo de DNS es traducir los identificadores de hosts de lenguaje natural (direcciones URL) a direcciones IP.
Para localizar otros hosts se debe conocer su dirección IP o el nombre que lo identifique. Al conocer su nombre en lenguaje natural, DNS se encarga de encontrar la IP correspondiente a ese hostname. Se debe usar la dirección IP para localizar a otro host porque los routers trabajan con el protocolo IP, mediante direcciones con estructura jerárquica de 4 bytes.

---
### 2. ¿Qué es un root server? ¿Qué es un generic top-level domain (gTLD)?

Un root server es el más alto de la jerarquía de servidores DNS. Es el primero que contacta el cliente DNS al hacer una query para obtener la dirección IP de un hostname. Son 13, nombrados de la A a la M, aunque en realidad cada uno es una red de servidores replicados, por lo que son muchos más. Luego de esa consulta, el root server le envía al cliente DNS el TLD al que le debe por el hostname requerido.
Los gTLD son los servidores responsables de los *top-level domains* como por ejemplo *.com* (comercial), *.net*, *.edu*, *.gov*, etc. También existen los ccTLD, que son responsables de los dominios de alto nivel que referencian a países, como .ar, .br, .fr, .us, .es, entre otros.

---
### 3. ¿Qué es una respuesta del tipo autoritativa?

Una respuesta de tipo autoritativa ocurre cuando la consulta de DNS se realiza a un servidor y este resulta ser el que tiene autoridad sobre la dirección solicitada. El servidor responde buscando en su base de datos de nombres para concretar la respuesta.

---
### 4. ¿Qué diferencia una consulta DNS recursiva de una iterativa?

El resolver delega, por completo, la responsabilidad en el Servidor Local y éste se debe encargar de resolver la consulta. Esto es lo que se llama una Consulta Recursiva. Sólo los servidores locales deberı́an admitir consultas recursivas desde los equipos de su misma red. Los ROOT Name Servers no deberı́an admitir prácticamente consultas recursivas.
El Servidor Local, una vez que tiene la consulta y se ha fijado que no es por un nombre local
ni está en su caché, deberá intentar resolverla externamente. Podrá intentar resolverlo de forma Recursiva, preguntando a otro servidor de nombres y delegando la resolución en éste. Como, en general, las consultas Recursiva están sólo habilitadas de forma local, deberá resolverla con una Consulta Iterativa encargándose el mismo.

---
### 5. ¿Qué es el resolver?

El funcionamiento del DNS se realiza en un esquema cliente/servidor, siendo el cliente cualquier aplicación que requiera la resolución de nombres. El código (instrucciones de máquina) del cliente se lo agrupa en un módulo llamado Resolver.
El Resolver es un agente encargado de resolver los nombres a solicitud del cliente, por ejemplo: un servidor web, el cliente telnet, un navegador web, un servidor de mail, etc. Este agente, generalmente, no se implementa como un servicio activo, sino como un conjunto de rutinas encapsuladas en una biblioteca de funciones que se link-edita conjuntamente con la aplicación. En el caso de sistemas Unix, el resolver es un conjunto de funciones incluidas
en la C library (libc).

---
### 6. Describa para qué se utilizan los siguientes tipos de registros de DNS:
- **a. `A`**: son registros que mapean de un nombre de domino a una dirección IP. Son los más comunes. Pueden existir varios registros (A) con el mismo nombre, por ejemplo, para realizar balance de carga de un servidor muy accedido. Para aprovechar esto, el servidor de DNS deberı́a responder con una lista de direcciones IP, siempre alternando el resultado con algún criterio, por ejemplo de forma circular.
  
- **b. `MX`**: Son registros que indican, para un nombre de domino, cuáles son los servidores de mail SMTP encargados de recibir los mensajes para ese dominio. De esta forma, no es necesario especificar el servidor completo de mail donde se encuentra la casilla destino, alcanza con indicar, solamente, el dominio. El servidor de mail SMTP que envı́a el mensaje deberá consultar, vı́a el servicio de DNS, cuáles son los servidores SMTP receptores para el dominio dado. Se puede detallar una lista de servidores y asignarles prioridades. Los valores más bajos son las mejores prioridades. Ası́, al momento de hacerse el envı́o del mensaje, si el servidor primario no está activo se podrı́a recurrir a otro de menor prioridad para enviar el e-mail. Con la asignación de prioridades con igual valor se podrı́a lograr un balance de carga entre los distintos servidores SMTP.
  
- **c. `PTR`**: Estos son registros que mapean direcciones IP a nombres de dominio. Son el inverso de los registros (A), por esto, se los suele llama reversos. Trabajan en el dominio especial in-addr.arpa.
  
- **d. `AAAA`**: Como el A pero para IPv6.
  
- **e. `SRV`**: Se utiliza para definir un servidor que ofrece un servicio específico. Su función principal es indicar a los clientes cómo y dónde pueden conectarse para acceder a un servicio, como VoIP, videoconferencias, Microsoft Exchange, XMPP, entre otros. A diferencia de registros como A o MX, los registros SRV son especialmente útiles cuando un servicio necesita ser redirigido a múltiples servidores o cuando se requiere especificar un puerto diferente al predeterminado.
  
- **f. `NS`**: Los registros (NS) indican los servidores de nombre autoritativos para una zona o sub-dominio. A partir de esto, se puede lograr una delegación de sub-dominios. A diferencia que los registros (MX), estos no llevan asociado una prioridad, todos los servidores tienen la misma precedencia. Para lograr un mejor balance, al ir respondiendo se deberı́a ir rotando el orden con el que se entregan los servidores autoritativos para una zona. Al tener varios servidores para un mismo dominio no es necesario configurar a todos con los mismos datos. El software de DNS permite asignar roles de Servidor Primario y Servidor(es) Secundario(s). De esta forma, sólo se requiere configurar el primario y luego el secundario obtendrá una copia de la base de datos del servidor maestro/primario. Es importante que los servidores estén actualizados, por eso debe existir algún mecanismo para mantenerlos sincronizados. El Servidor Primario deberı́a avisar a todos los Servidores Secundarios cuando se realiza un cambio, ası́ estos re-copian la base de datos de nombres desde el servidor maestro. La comunicación entre servidores se realiza vı́a el mismo protocolo de DNS, con la diferencia que se hace sobre TCP en lugar de UDP, esto se debe a que, generalmente, los datos transmitidos ocupan más de 512 bytes (máximo para DNS sobre UDP). Esta operación se llama Transferencia de Zona o, en inglés, Zone Transfer.
  Se recomienda sobre una configuración de un servidor de DNS, en el cual se delegan las zonas, y las direcciones IP de los servidores delegados están en la zona delegada, agregar para cada registro (NS) un registro (A), indicando la dirección IP del servidor delegado. Esto se utiliza para agilizar las búsquedas y ahorrar una doble consulta. Estas entradas (A) se las conoce como GLUE RECORDS, ya que “pegan” un nombre de un servidor de nombres con su correspondiente dirección IP.
  
- **g. `CNAME`**: Son registros que mapean de un nombre de dominio a otros nombres. Se los conoce como aliases, debido a que dado un nombre indican el nombre original. Esta funcionalidad podrı́a, también, resolverse con varios registros (A). El nombre, al que apunta, deberı́a ser el nombre original, conocido como canónico.
  
- **h. `SOA`**: Los registros (SOA) se crean por cada zona o sub-zona que brinda el servicio de DNS. En este registro se especifican los parámetros globales para todos los registros del dominio o zona. Sólo se admite un registro (SOA) por zona.
  
- **i. `TXT`**: Son registros que mapean de un nombre de dominio a información extra asociada con el equipo que tiene dicho nombre, por ejemplo pueden indicar finalidad, usuarios, etc. No son utilizados habitualmente. Se los puede ver en uso asociando una clave pública, utilizando por ejemplo IPSec con un esquema de Opportunistic Encryption.

---
### 7. En Internet, un dominio suele tener más de un servidor DNS, ¿por qué cree que esto es así?

**Disponibilidad, tolerancia a fallos (redundancia):** si el dominio se encuentra en solo servidor se cae, el dominio se vuelve inalcanzable por los usuarios. 
**Load balancing:** repartir la carga de trabajo ante muchas solicitudes.
**Reducción de latencia:** varios servidores en distintos lugares para que usuarios de todo el mundo no tengan tiempos de espera largos.

---
### 8. Cuando un dominio cuenta con más de un servidor, uno de ellos es el primario (o maestro) y todos los demás son secundarios (o esclavos). ¿Cuál es la razón de que sea así?

La razón principal radica en **facilitar la administración y garantizar la consistencia e integridad de la base de datos de la zona**:

1. **Punto único de administración y edición**:
	- En lugar de tener que ingresar y modificar los registros manualmente en cada uno de los servidores del dominio, **la configuración y las modificaciones de los datos se realizan únicamente en el servidor primario (maestro)**.
	- Esto evita errores humanos y discrepancias de información entre servidores.

2. **Replicación automática y consistencia (Transferencia de zona)**:
	- Los servidores secundarios (esclavos) obtienen automáticamente una réplica exacta de la base de datos de nombres desde el servidor maestro a través del mecanismo de **transferencia de zona** (_Zone Transfer_, comúnmente mediante consultas AXFR sobre TCP).
	- Al realizar un cambio en el archivo de zona del primario, se incrementa el número de serie del registro **SOA**. Mediante mensajes de notificación (`NOTIFY`), el primario avisa a los secundarios para que descarguen la nueva versión y se mantengan sincronizados.

3. **Distinción operativa vs. visibilidad externa**:
	- Para el resto de los clientes y servidores de Internet, **todos los servidores listados en los registros NS tienen la misma jerarquía** y responden de manera autoritativa para resolver consultas sobre el dominio.
	- La distinción entre primario y secundario es exclusivamente una **cuestión de implementación y gestión administrativa interna** del dominio.
---
### 9. Explique brevemente en qué consiste el mecanismo de transferencia de zona y cuál es su finalidad.

La **transferencia de zona** (_Zone Transfer_) es el procedimiento mediante el cual un servidor DNS secundario (o esclavo) solicita y descarga una copia completa o incremental de la base de datos de registros de una zona desde el servidor primario (maestro).

Sus aspectos técnicos fundamentales son:

- **Uso del protocolo de transporte TCP**: A diferencia de las consultas habituales de los clientes que viajan sobre UDP, la transferencia de zona se realiza sobre **TCP en el puerto 53**. Esto se debe a que el volumen de registros transmitidos suele superar con creces el límite estándar de 512 bytes de los mensajes DNS sobre UDP.
- **Tipos de transferencia**: Comúnmente se utiliza **AXFR** para transferir la base de datos completa de la zona, o bien **IXFR** para transferir únicamente las modificaciones de manera incremental.
- **Disparadores de sincronización**: El proceso puede iniciarse periódicamente según los tiempos fijados en el registro **SOA** (parámetros _Refresh_ y _Expiry_), o bien de forma automática cuando el servidor primario modifica la zona, incrementa el número de serie (_Serial_) y envía un mensaje **NOTIFY** a los secundarios para que inicien la copia.

¿Cuál es su finalidad?

- **Mantener la consistencia y actualización**: Garantiza que todos los servidores secundarios tengan exactamente la misma información que el servidor primario sin necesidad de cargar manualmente las configuraciones en cada máquina.
- **Tolerancia a fallos y alta disponibilidad**: Al replicar los registros en varios servidores autoritativos, el dominio continúa resolviendo nombres incluso si el servidor primario se cae o deja de responder.
- **Distribución de carga**: Permite que las consultas de resolución de nombres de Internet se repartan equitativamente entre todos los servidores de la zona sin degradar el rendimiento.
---
### 10. Imagine que usted es el administrador del dominio de DNS de la UNLP (`unlp.edu.ar`). A su vez, cada facultad de la UNLP cuenta con un administrador que gestiona su propio dominio (por ejemplo, en el caso de la Facultad de Informática se trata de `info.unlp.edu.ar`). Suponga que se crea una nueva facultad, Facultad de Redes, cuyo dominio será `redes.unlp.edu.ar`, y el administrador le indica que quiere poder manejar su propio dominio. ¿Qué debe hacer usted para que el administrador de la Facultad de Redes pueda gestionar el dominio de forma independiente? *(Pista: investigue en qué consiste la delegación de dominios)*. Indicar qué registros de DNS se deberían agregar.

#### 1. ¿Qué se debe hacer? (Delegación de dominios)

Como administrador del dominio padre (`unlp.edu.ar`), debe realizar una **delegación de zona o subdominio**.

La delegación es el mecanismo mediante el cual la autoridad y la responsabilidad administrativa sobre una rama del espacio de nombres se transfiere a otros servidores de nombres. A partir de esta configuración, el servidor de la UNLP deja de responder de forma autoritativa por las máquinas de `redes.unlp.edu.ar` y, en su lugar, delega la resolución a los servidores DNS propios definidos por la Facultad de Redes.

#### 2. ¿Qué registros de DNS se deben agregar en la zona `unlp.edu.ar`?

En el archivo de configuración de la zona padre (`unlp.edu.ar`) deben añadirse dos clases de registros:

1. **Registros NS (_Name Server_)**:
    - Definen cuáles son los servidores de nombres autoritativos encargados de resolver el subdominio `redes.unlp.edu.ar`.
2. **Registros A / AAAA (_Glue Records_ o registros de pegamento)**:
    - Si los servidores DNS delegados se encuentran bajo el mismo subdominio que se está delegando (por ejemplo, `ns1.redes.unlp.edu.ar`), se produciría una dependencia circular (para saber quién resuelve el dominio se necesita la IP de un servidor cuyo nombre está dentro del propio dominio).
    - Para romper esta circularidad y evitar que la consulta falle, **es indispensable incluir en la zona padre registros A con la dirección IP de cada servidor delegado**.

#### Ejemplo de configuración en el archivo de zona de `unlp.edu.ar`:

```
; ## Delegación de la zona de la nueva facultad ##
redes.unlp.edu.ar.        IN  NS  ns1.redes.unlp.edu.ar.
redes.unlp.edu.ar.        IN  NS  ns2.redes.unlp.edu.ar.

; ## Glue Records (direcciones IP de los servidores delegados) ##
ns1.redes.unlp.edu.ar.    IN  A   163.10.5.1
ns2.redes.unlp.edu.ar.    IN  A   163.10.5.2
```
#### 3. Configuración complementaria en la Facultad de Redes

Para que la delegación sea totalmente operativa, el administrador de la nueva facultad debe configurar en sus servidores autoritativos (`ns1` y `ns2`) el archivo de la zona `redes.unlp.edu.ar`, definiendo su propio registro **SOA**, sus registros **NS** y los registros de los hosts y servicios de su unidad académica (servidores web, correo MX, etc.).

---
### 11. Responda y justifique los siguientes ejercicios.
- **a. En la VM, utilice el comando `dig` para obtener la dirección IP del host `www.redes.unlp.edu.ar` y responda:**
  
	```dig
	redes@debian:~$ dig www.redes.unlp.edu.ar
	
	; <<>> DiG 9.16.27-Debian <<>> www.redes.unlp.edu.ar
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12659
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
	
	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 1232
	; COOKIE: 1cb74d2e284e8a00010000006abacba18a5c76cc1785df84 (good)
	;; QUESTION SECTION:
	;www.redes.unlp.edu.ar.         IN      A
	
	;; ANSWER SECTION:
	www.redes.unlp.edu.ar.  300     IN      A       172.28.0.50
	
	;; Query time: 0 msec
	;; SERVER: 172.28.0.29#53(172.28.0.29)
	;; WHEN: Mon Sep 28 17:18:41 -03 2026
	;; MSG SIZE  rcvd: 94
	
	```
  
  - i. ¿La solicitud fue recursiva? ¿Y la respuesta? ¿Cómo lo sabe?
    La solicitud desea recursividad (flag `rd`) y la respuesta es recursiva (flag `ra`).
    
  - ii. ¿Puede indicar si se trata de una respuesta autoritativa? ¿Qué significa que lo sea?
    Una respuesta autoritativa, en este caso, representa que el servidor al que se le hace la consulta (`172.28.0.29`) tiene autoridad sobre el dominio consultado (`www.redes.unlp.edu.ar`). Se puede observar que la respuesta es autoritativa por la flag `aa` presente en la respuesta.
    
  - iii. ¿Cuál es la dirección IP del resolver utilizado? ¿Cómo lo sabe?
    `;; SERVER: 172.28.0.29#53(172.28.0.29)`

- **b. ¿Cuáles son los servidores de correo del dominio `redes.unlp.edu.ar`? ¿Por qué hay más de uno y qué significan los números que aparecen entre `MX` y el nombre? Si se quiere enviar un correo destinado a `redes.unlp.edu.ar`, ¿a qué servidor se le entregará? ¿En qué situación se le entregará al otro?**
	```
	redes@debian:~$ dig redes.unlp.edu.ar MX
	
	; <<>> DiG 9.16.27-Debian <<>> redes.unlp.edu.ar MX
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34901
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3
	
	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 1232
	; COOKIE: 984a377a526e9d3d010000006abad7e33af66fff4d8bc4c6 (good)
	;; QUESTION SECTION:
	;redes.unlp.edu.ar.             IN      MX
	
	;; ANSWER SECTION:
	redes.unlp.edu.ar.      86400   IN      MX      10 mail2.redes.unlp.edu.ar.
	redes.unlp.edu.ar.      86400   IN      MX      5 mail.redes.unlp.edu.ar.
	
	;; ADDITIONAL SECTION:
	mail.redes.unlp.edu.ar. 86400   IN      A       172.28.0.90
	mail2.redes.unlp.edu.ar. 86400  IN      A       172.28.0.91
	
	;; Query time: 0 msec
	;; SERVER: 172.28.0.29#53(172.28.0.29)
	;; WHEN: Mon Sep 28 18:10:59 -03 2026
	;; MSG SIZE  rcvd: 149
	
	```
	Los servidores de correo son `mail.redes.unlp.edu.ar.` y `mail2.redes.unlp.edu.ar.` Cualquier cliente siempre intentará entregar el mensaje al servidor con prioridad 5. En caso de que este no esté disponible o rechace la conexión SMTP por algún motivo, el servidor con prioridad 10 recibirá el mensaje.

- **c. ¿Cuáles son los servidores de DNS del dominio `redes.unlp.edu.ar`?**
	```
	redes@debian:~$ dig redes.unlp.edu.ar NS  
	  
	; <<>> DiG 9.16.27-Debian <<>> redes.unlp.edu.ar NS  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 16168  
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: 961a56b5408e8c93010000006ad3835a397384f5fdc816f6 (good)  
	;; QUESTION SECTION:  
	;redes.unlp.edu.ar.             IN      NS  
	  
	;; ANSWER SECTION:  
	redes.unlp.edu.ar.      86400   IN      NS      ns-sv-a.redes.unlp.edu.ar.  
	redes.unlp.edu.ar.      86400   IN      NS      ns-sv-b.redes.unlp.edu.ar.  
	  
	;; ADDITIONAL SECTION:  
	ns-sv-a.redes.unlp.edu.ar. 604800 IN    A       172.28.0.30  
	ns-sv-b.redes.unlp.edu.ar. 604800 IN    A       172.28.0.29  
	  
	;; Query time: 4 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 11:16:58 -03 2026  
	;; MSG SIZE  rcvd: 150
	```
	Los servidores DNS del dominio `redes.unlp.edu.ar` son `ns-sv-a.redes.unlp.edu.ar` y `ns-sv-b.redes.unlp.edu.ar`.

- **d. Repita la consulta anterior cuatro veces más. ¿Qué observa? ¿Puede explicar a qué se debe?**
  El orden en el que figuran los servidores en la `ANSWER SECTION` va rotando (en una respuesta aparece primero `ns-sv-a` y en la siguiente `ns-sv-b`). Se debe al mecanismo de **DNS Round-Robin**. Como la mayoría de los clientes utilizan la primera IP que reciben en la respuesta, el servidor rota el orden para balancear equitativamente el tráfico de consultas entre ambos servidores.

- **e. Observe la información que obtuvo al consultar por los servidores de DNS del dominio. En base a la salida, ¿es posible indicar cuál de ellos es el primario?**
  No. Los registros NS no incluyen prioridades ni ponderaciones (a diferencia de los registros MX). Para los clientes, todos los servidores listados en NS tienen exactamente la misma jerarquía.
  
- **f. Consulte por el registro `SOA` del dominio y responda.**
	```
	redes@debian:~$ dig redes.unlp.edu.ar SOA  
	  
	; <<>> DiG 9.16.27-Debian <<>> redes.unlp.edu.ar SOA  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50539  
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: ef1de99afc43ea67010000006ad384813482000294bacc81 (good)  
	;; QUESTION SECTION:  
	;redes.unlp.edu.ar.             IN      SOA  
	  
	;; ANSWER SECTION:  
	redes.unlp.edu.ar.      86400   IN      SOA     ns-sv-b.redes.unlp.edu.ar. root.redes.unlp.edu.ar. 2020031700 604800 86400 2419200 86400  
	  
	;; Query time: 4 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 11:21:53 -03 2026  
	;; MSG SIZE  rcvd: 123
	```
  - i. ¿Puede ahora determinar cuál es el servidor de DNS primario?
    Sí. El primer nombre de dominio que aparece en los datos del SOA (campo MNAME) indica cuál es el servidor primario. El servidor primario es `ns-sv-b.redes.unlp.edu.ar`.
    
  - ii. ¿Cuál es el número de serie, qué convención sigue y en qué casos es importante actualizarlo?
    El número de serie es 2020031700. Tiene formato YYYYMMDDSS. Indica que el archivo de la zona fue editado por última vez el 17 de marzo de 2020 y está en su versión 00. Si hubiera sido editado otra vez en el mismo día, quedaría en versión 01. Así sucesivamente hasta 99 (por lo general, entiendo que nunca se llegaría a realizar más de 100 modificaciones en el archivo de zona en un mismo día, pero no sé qué pasaría si se diera ese caso).
    
  - iii. ¿Qué valor tiene el segundo campo del registro? Investigue para qué se usa y cómo se interpreta el valor.
    El valor `root.redes.unlp.edu.ar` representa la dirección de correo electrónico del responsable técnico de la zona. El primer punto reemplaza al símbolo `@`, dando como resultado `root@redes.unlp.edu.ar`.
    
  - iv. ¿Qué valor tiene el TTL de caché negativa y qué significa?
    El TTL de caché negativa es el último valor que aparece en el registro SOA. Es `86400` y corresponde a un tiempo en segundos. Determina cuánto tiempo los resolvers pueden guardar en su memoria caché una respuesta negativa (un error `NXDOMAIN` al consultar por un registro que no existe en el dominio) antes de tener que volver a consultar al servidor autoritativo.

- **g. Indique qué valor tiene el registro `TXT` para el nombre `saludo.redes.unlp.edu.ar`. Investigue para qué es usado este registro.**
	```
	redes@debian:~$ dig saludo.redes.unlp.edu.ar TXT
	
	; <<>> DiG 9.16.27-Debian <<>> saludo.redes.unlp.edu.ar TXT
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13822
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
	
	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 1232
	; COOKIE: bd6bb8902586bfc3010000006ad387f8892a263ebad71312 (good)
	;; QUESTION SECTION:
	;saludo.redes.unlp.edu.ar.      IN      TXT
	
	;; ANSWER SECTION:
	saludo.redes.unlp.edu.ar. 86400 IN      TXT     "HOLA"
	
	;; Query time: 4 msec
	;; SERVER: 172.28.0.29#53(172.28.0.29)
	;; WHEN: Sat Oct 17 11:36:40 -03 2026
	;; MSG SIZE  rcvd: 98
	```
	Este registro permite almacenar texto libre a un nombre de dominio. Generalmente es utilizado para asociar información adicional legible por personas.
	Algunas de sus aplicaciones son:
	* **Seguridad y autenticación en correo electrónico**: Es su aplicación técnica más importante. Se utilizan para publicar políticas como:
	* **SPF (** **Sender Policy Framework** **)**: Declara qué direcciones IP tienen permitido enviar correos en nombre del dominio.
	* **DKIM (** **DomainKeys Identified Mail** **)**: Publica claves públicas para verificar la firma digital del correo.
	* **DMARC**: Indica a los servidores receptores qué hacer si un mensaje falla las comprobaciones de SPF o DKIM.
	* **Verificación de propiedad de dominios**: Diversos servicios web y proveedores de certificados SSL/TLS piden agregar un código único en un registro TXT para confirmar que tenés control administrativo sobre la zona.
	
- **h. Utilizando `dig`, solicite la transferencia de zona de `redes.unlp.edu.ar`, analice la salida y responda.**
	```
	redes@debian:~$ dig redes.unlp.edu.ar AXFR  
	  
	; <<>> DiG 9.16.27-Debian <<>> redes.unlp.edu.ar AXFR  
	;; global options: +cmd  
	redes.unlp.edu.ar.      86400   IN      SOA     ns-sv-b.redes.unlp.edu.ar. root.redes.unlp.edu.ar. 2020031700 604800 86400 2419200 86400  
	redes.unlp.edu.ar.      86400   IN      NS      ns-sv-a.redes.unlp.edu.ar.  
	redes.unlp.edu.ar.      86400   IN      NS      ns-sv-b.redes.unlp.edu.ar.  
	redes.unlp.edu.ar.      86400   IN      MX      5 mail.redes.unlp.edu.ar.  
	redes.unlp.edu.ar.      86400   IN      MX      10 mail2.redes.unlp.edu.ar.  
	ftp.redes.unlp.edu.ar.  86400   IN      CNAME   www.redes.unlp.edu.ar.  
	mail.redes.unlp.edu.ar. 86400   IN      A       172.28.0.90  
	mail2.redes.unlp.edu.ar. 86400  IN      A       172.28.0.91  
	ns-sv-a.redes.unlp.edu.ar. 604800 IN    A       172.28.0.30  
	ns-sv-b.redes.unlp.edu.ar. 604800 IN    A       172.28.0.29  
	practica.redes.unlp.edu.ar. 86400 IN    NS      ns1.practica.redes.unlp.edu.ar.  
	practica.redes.unlp.edu.ar. 86400 IN    NS      ns2.practica.redes.unlp.edu.ar.  
	ns1.practica.redes.unlp.edu.ar. 86400 IN A      172.28.0.120  
	ns2.practica.redes.unlp.edu.ar. 86400 IN A      172.28.0.121  
	saludo.redes.unlp.edu.ar. 86400 IN      TXT     "HOLA"  
	www.redes.unlp.edu.ar.  300     IN      A       172.28.0.50  
	redes.unlp.edu.ar.      86400   IN      SOA     ns-sv-b.redes.unlp.edu.ar. root.redes.unlp.edu.ar. 2020031700 604800 86400 2419200 86400  
	;; Query time: 0 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 11:40:46 -03 2026  
	;; XFR size: 17 records (messages 1, bytes 441)
	```
  - i. ¿Qué significan los números que aparecen antes de la palabra `IN`? ¿Cuál es su finalidad?
    Representan el **TTL (*Time to Live*)** de cada registro individual expresado en **segundos**. Por ejemplo, `86400` equivale a 24 horas (1 día), `604800` a 7 días, y `300` (en el registro A de `www`) a 5 minutos. La finalidad del TTL es indicar a los clientes y _resolvers_ intermedios durante cuánto tiempo pueden mantener en su memoria caché ese registro específico antes de descartarlo y tener que volver a consultar al servidor autoritativo.
	  
  - ii. ¿Cuántos registros `NS` observa? Compare la respuesta con los servidores de DNS del dominio `redes.unlp.edu.ar` que dio anteriormente. ¿Puede explicar a qué se debe la diferencia y qué significa?
    * **Registros NS en la salida:** Se observan **4 registros NS** en total:
		1. Dos para el dominio principal: `ns-sv-a.redes.unlp.edu.ar` y `ns-sv-b.redes.unlp.edu.ar`.
		2. Dos para la subzona delegada: `ns1.practica.redes.unlp.edu.ar` y `ns2.practica.redes.unlp.edu.ar`.
	* **Explicación de la diferencia:**
		* Al consultar específicamente por `dig redes.unlp.edu.ar NS` (inciso c), el servidor devolvió únicamente los **2 servidores autoritativos** que responden por esa zona.
		* Al solicitar la transferencia de zona AXFR, el servidor entrega **la totalidad del archivo de zona**, entonces también muestra la **delegación de la subzona** **practica.redes.unlp.edu.ar**, incluyendo sus registros NS y sus correspondientes registros de pegamento (*Glue Records* A `172.28.0.120` y `172.28.0.121`).

- **i. Consulte por el registro `A` de `www.redes.unlp.edu.ar` y luego por el registro `A` de `www.practica.redes.unlp.edu.ar`. Observe los TTL de ambos. Repita la operación y compare el valor de los TTL de cada uno respecto de la respuesta anterior. ¿Puede explicar qué está ocurriendo?** *(Pista: observar los flags será de ayuda)*
	```
	redes@debian:~$ dig www.redes.unlp.edu.ar  
	  
	; <<>> DiG 9.16.27-Debian <<>> www.redes.unlp.edu.ar  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 26705  
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: c89f283b16c55ddb010000006ad38e04a1dab3a60fd2a7c5 (good)  
	;; QUESTION SECTION:  
	;www.redes.unlp.edu.ar.         IN      A  
	  
	;; ANSWER SECTION:  
	www.redes.unlp.edu.ar.  300     IN      A       172.28.0.50  
	  
	;; Query time: 4 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 12:02:28 -03 2026  
	;; MSG SIZE  rcvd: 94  
	  
	redes@debian:~$ dig www.practica.redes.unlp.edu.ar  
	  
	; <<>> DiG 9.16.27-Debian <<>> www.practica.redes.unlp.edu.ar  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47763  
	;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: 071c99b0f1d92e7e010000006ad38e0dc97cacdd0d4b0fba (good)  
	;; QUESTION SECTION:  
	;www.practica.redes.unlp.edu.ar.        IN      A  
	  
	;; ANSWER SECTION:  
	www.practica.redes.unlp.edu.ar. 60 IN   A       172.28.0.10  
	  
	;; Query time: 2441 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 12:02:37 -03 2026  
	;; MSG SIZE  rcvd: 103  
	  
	redes@debian:~$ dig www.redes.unlp.edu.ar  
	  
	; <<>> DiG 9.16.27-Debian <<>> www.redes.unlp.edu.ar  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17568  
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: 259e550f4f7f06c0010000006ad38e139aa040d9dca423de (good)  
	;; QUESTION SECTION:  
	;www.redes.unlp.edu.ar.         IN      A  
	  
	;; ANSWER SECTION:  
	www.redes.unlp.edu.ar.  300     IN      A       172.28.0.50  
	  
	;; Query time: 4 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 12:02:43 -03 2026  
	;; MSG SIZE  rcvd: 94  
	  
	redes@debian:~$ dig www.practica.redes.unlp.edu.ar  
	  
	; <<>> DiG 9.16.27-Debian <<>> www.practica.redes.unlp.edu.ar  
	;; global options: +cmd  
	;; Got answer:  
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 3101  
	;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  
	  
	;; OPT PSEUDOSECTION:  
	; EDNS: version: 0, flags:; udp: 1232  
	; COOKIE: eb4993dd413d8397010000006ad38e150b6d52e52a48d1eb (good)  
	;; QUESTION SECTION:  
	;www.practica.redes.unlp.edu.ar.        IN      A  
	  
	;; ANSWER SECTION:  
	www.practica.redes.unlp.edu.ar. 52 IN   A       172.28.0.10  
	  
	;; Query time: 4 msec  
	;; SERVER: 172.28.0.29#53(172.28.0.29)  
	;; WHEN: Sat Oct 17 12:02:45 -03 2026  
	;; MSG SIZE  rcvd: 103
	```
  Para `www.redes.unlp.edu.ar` (Dominio propio):
	- **Línea de banderas:** `flags: qr aa rd ra` (**Tiene la bandera** **aa**).
	* **TTL y tiempo de respuesta:**
	  * 1.ª consulta: TTL = **300**, tiempo = **4 msec**.
	  * 2.ª consulta: TTL = **300**, tiempo = **4 msec**.
	* **Explicación:** Dado que el servidor `172.28.0.29` es **autoritativo** para el dominio `redes.unlp.edu.ar`, no consulta ni guarda esta respuesta en una caché temporal con cuenta regresiva. Cada vez que le preguntás, entrega la información directamente desde su archivo de zona con su **TTL estático de 300 segundos**.
	  
  Para `www.practica.redes.unlp.edu.ar` (Subdominio delegado):
	- **Línea de banderas:** `flags: qr rd ra` (**NO tiene la bandera** **aa**).
	- **Análisis de la 1.ª consulta:**
	    - **Query time: 2441 msec**: Como `172.28.0.29` no es autoritativo sobre la subzona `practica`, tuvo que realizar una resolución recursiva consultando a los servidores delegados (`172.28.0.120` / `121`). De ahí la demora de más de 2 segundos.
	    - **TTL: 60**: Obtuvo el registro con un TTL inicial de 60 segundos y **lo guardó en su caché local**.
	- **Análisis de la 2.ª consulta (realizada 8 segundos después, entre 12:02:37 y 12:02:45):**
	    - **Query time: 4 msec**: Respondió casi instantáneamente porque sacó la respuesta directamente de su **memoria caché**.
	    - **TTL: 52**: El TTL se descontó en **8 segundos** (60 − 8 = 52). El resolver descuenta el tiempo transcurrido en cuenta regresiva para no entregar datos expirados en futuras consultas.

- **j. Consulte por el registro `A` de `www.practica2.redes.unlp.edu.ar`. ¿Obtuvo alguna respuesta? Investigue sobre los códigos de respuesta de DNS. ¿Para qué son utilizados los mensajes `NXDOMAIN` y `NOERROR`?**
	```
	redes@debian:~$ dig www.practica2.redes.unlp.edu.ar
	
	; <<>> DiG 9.16.27-Debian <<>> www.practica2.redes.unlp.edu.ar
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 54973
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1
	
	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 1232
	; COOKIE: d250b932a4a4febe010000006ad39031d45efd2ed3b5ae95 (good)
	;; QUESTION SECTION:
	;www.practica2.redes.unlp.edu.ar. IN    A
	
	;; AUTHORITY SECTION:
	redes.unlp.edu.ar.      86400   IN      SOA     ns-sv-b.redes.unlp.edu.ar. root.redes.unlp.edu.ar. 2020031700 604800 86400 2419200 86400
	
	;; Query time: 4 msec
	;; SERVER: 172.28.0.29#53(172.28.0.29)
	;; WHEN: Sat Oct 17 12:11:45 -03 2026
	;; MSG SIZE  rcvd: 154
	```
	**Análisis de la respuesta obtenida**
	- **status: NXDOMAIN** **(Non-Existent Domain):** El servidor informa oficialmente que el FQDN consultado (`www.practica2.redes.unlp.edu.ar`) **no existe** dentro de la zona.
	- **Respuesta autoritativa (`flags: qr aa rd ra`):** Al contar con el flag **aa**, es el propio servidor autoritativo de `redes.unlp.edu.ar` el que confirma la inexistencia del registro de manera definitiva y no una caché intermedia.
	- **Sección** **AUTHORITY SECTION:** Devuelve el registro **SOA** del dominio. Esto se utiliza para la **caché negativa**: le indica a los _resolvers_ intermedios durante cuánto tiempo (según el último número del SOA, 86400 segundos) pueden recordar que este nombre no existe sin tener que volver a preguntarle al servidor autoritativo.
	
	**¿Para qué se utilizan los códigos NXDOMAIN y NOERROR?**
	Los códigos de estado (_RCODE_) en las cabeceras de respuesta DNS indican el resultado de la consulta:
	- **NXDOMAIN (Non-Existent Domain):**
	    - **Significado:** Indica que el nombre de dominio consultado **no existe en absoluto** dentro del espacio de nombres.
	    - **Ejemplo:** La consulta sobre `www.practica2.redes.unlp.edu.ar`.
	- **NOERROR (No Error):**
	    - **Significado:** Indica que la consulta fue **procesada con éxito y sin errores a nivel de protocolo**.
	    - **Casos posibles:**
	        1. **Con datos (ANSWER > 0):** El nombre existe y posee registros del tipo solicitado (por ejemplo, consultar `A` y recibir las IPs).
	        2. **Sin datos (NODATA / ANSWER: 0):** El nombre de dominio **sí existe**, pero **no posee registros del tipo específico que se consultó**. Por ejemplo, si un host solo tiene una dirección IPv4 (registro `A`), al consultar por su dirección IPv6 (registro `AAAA`), el servidor responderá con `NOERROR` pero con `ANSWER: 0`.
---
### 12. Investigue los comandos `nslookup` y `host`. ¿Para qué sirven? Intente con ambos comandos obtener:
- Dirección IP de `www.redes.unlp.edu.ar`.
	```
	redes@debian:~$ host www.redes.unlp.edu.ar
	www.redes.unlp.edu.ar has address 172.28.0.50
	```
- Servidores de correo del dominio `redes.unlp.edu.ar`.
	```
	redes@debian:~$ host -t MX redes.unlp.edu.ar  
	redes.unlp.edu.ar mail is handled by 5 mail.redes.unlp.edu.ar.  
	redes.unlp.edu.ar mail is handled by 10 mail2.redes.unlp.edu.ar.
	```
- Servidores de DNS del dominio `redes.unlp.edu.ar`.
	```
	redes@debian:~$ host -t NS redes.unlp.edu.ar
	redes.unlp.edu.ar name server ns-sv-a.redes.unlp.edu.ar.
	redes.unlp.edu.ar name server ns-sv-b.redes.unlp.edu.ar.
	```
	
	```
	redes@debian:~$ nslookup -type=NS redes.unlp.edu.ar
	Server:         172.28.0.29
	Address:        172.28.0.29#53
	
	redes.unlp.edu.ar       nameserver = ns-sv-b.redes.unlp.edu.ar.
	redes.unlp.edu.ar       nameserver = ns-sv-a.redes.unlp.edu.ar.
	```
- **host**: Es una herramienta de línea de comandos diseñada para realizar búsquedas rápidas de nombres de dominio a direcciones IP (y viceversa), o consultar tipos específicos de registros DNS con una salida limpia y estructurada.
- **nslookup**: Es una utilidad clásica de diagnóstico de red que permite consultar servidores DNS para verificar registros. Puede utilizarse en **modo no interactivo** (pasando los argumentos en una sola línea) o en **modo interactivo** (abriendo una consola propia para cambiar tipos de consulta o servidores de forma dinámica).

---
### 13. ¿Qué función cumple en Linux/Unix el archivo `/etc/hosts` o en Windows el archivo `\WINDOWS\system32\drivers\etc\hosts`?

El archivo `hosts` es un archivo de texto plano que funciona como una tabla estática local para mapear direcciones IP a nombres de host.

- **Resolución de nombres local prioritaria**:
	- Cuando una aplicación requiere resolver un nombre de dominio (por ejemplo, mediante llamadas a funciones de biblioteca del _resolver_ como `gethostbyname` en `libc`), el sistema operativo consulta habitualmente este archivo estático local antes de enviar una consulta de red a los servidores DNS configurados.
- **Asignación de la interfaz de loopback**:
	- Asocia la dirección IP interna `127.0.0.1` al nombre estándar `localhost` y a otros alias del equipo local.
- **Entorno de desarrollo y servidores virtuales**:
	- Permite asociar nombres de dominio de prueba (por ejemplo, asociar `www` o `www2` a `127.0.0.1`) para probar aplicaciones web y _Virtual Hosts_ localmente sin necesidad de configurar ni depender de un servidor DNS.
- **Sobrescritura local de registros de red**:
	- Permite forzar a que un equipo resuelva un dominio hacia una IP específica seleccionada por el administrador, ignorando la respuesta del sistema DNS de la red o de Internet.
---
### 14. Abra el programa Wireshark para comenzar a capturar el tráfico de red en la interfaz con IP `172.28.0.1`. Una vez abierto realice una consulta DNS con el comando `dig` para averiguar el registro `MX` de `redes.unlp.edu.ar` y luego, otra para averiguar los registros `NS` correspondientes al dominio `redes.unlp.edu.ar`. Analice la información proporcionada por `dig` y compárelo con la captura.

---
### 15. Dada la siguiente situación: "Una PC en una red determinada, con acceso a Internet, utiliza los servicios de DNS de un servidor de la red". Analice:
- **a. ¿Qué tipo de consultas (iterativas o recursivas) realiza la PC a su servidor de DNS?**
	- **Consulta Recursiva**: La PC (mediante la rutina cliente o _stub resolver_) realiza una consulta **recursiva** a su servidor DNS local.
	- **Explicación**: El cliente le traslada **por completo la responsabilidad** de la resolución al servidor DNS local. Le solicita el registro deseado esperando una respuesta final definitiva (la dirección IP requerida o el error `NXDOMAIN` si no existe). La PC no interviene en la búsqueda externa ni contacta a otros servidores.

- **b. ¿Qué tipo de consultas (iterativas o recursivas) realiza el servidor de DNS para resolver requerimientos de usuario como el anterior? ¿A quién le realiza estas consultas?**
	- **Tipo de consultas**: El servidor DNS local realiza consultas **iterativas** hacia el exterior para resolver la solicitud del usuario (siempre que la respuesta no se encuentre ya almacenada en su memoria caché).
	- **¿A quién se las realiza? (Cadena de resolución)**:
	    1. **A los Servidores Raíz (Root Name Servers)**: Realiza la primera consulta iterativa a un servidor raíz. Este le responde con una referencia (_referral_) entregando la lista de los servidores autoritativos para el TLD correspondiente (por ejemplo, los servidores de `.ar` o `.edu.ar`).
	    2. **A los Servidores TLD (Top-Level Domain)**: Le consulta iterativamente a uno de los servidores TLD obtenidos en el paso anterior. Este le devuelve la lista de servidores autoritativos para el dominio de segundo nivel (por ejemplo, `unlp.edu.ar`).
	    3. **A los Servidores Autoritativos de la Zona**: Por último, consulta directamente al servidor autoritativo del dominio destino. Al alojar la base de datos oficial, este servidor le entrega la dirección IP definitiva solicitada.
Una vez recibida la dirección IP, el servidor DNS local **almacena la entrada en su memoria caché** para atender futuras consultas idénticas y le envía la respuesta final a la PC cliente.

---
### 16. Relacione DNS con HTTP. ¿Se puede navegar si no hay servicio de DNS?

**HTTP** y **DNS** son dos protocolos de la capa de aplicación que colaboran de manera estrecha y secuencial para posibilitar la navegación web:

1. **Extracción del nombre de host**: Cuando se ingresa una URL en la barra de direcciones del navegador (por ejemplo `http://www.unlp.edu.ar/index.html`), el navegador web analiza la dirección y extrae el nombre de host o FQDN (`www.unlp.edu.ar`).
2. **Traducción requerida antes del transporte**: Para establecer la conexión **TCP** subyacente hacia el puerto 80 (HTTP) o 443 (HTTPS), la pila de red necesita conocer obligatoriamente la dirección IP numérica del destino. Como la URL contiene un nombre de dominio, el navegador consulta previamente al servicio de **DNS** para resolver ese nombre en una dirección IP (mediante registros A o AAAA).
3. **Petición HTTP**: Una vez que el servicio DNS devuelve la IP correspondiente, el equipo cliente ejecuta el saludo de tres vías (_three-way handshake_) de TCP hacia esa dirección IP y, posteriormente, envía la solicitud `HTTP GET` para descargar el recurso.

**¿Se puede navegar si no hay servicio de DNS?

**Sí, es técnicamente posible**, pero de forma muy restringida y recurriendo a alternativas locales o directas:

- **Acceso por dirección IP directa**: Si el usuario conoce la IP del servidor web (por ejemplo, escribiendo `http://163.10.0.50` en la barra del navegador), el sistema establece la conexión TCP de inmediato hacia la IP de destino sin emitir ninguna consulta DNS a la red.
- **Resolución mediante tabla local (** **/etc/hosts** **)**: Si la correspondencia entre el nombre de dominio y su IP se encuentra declarada localmente en el archivo `/etc/hosts` (en Linux/Unix) o `\WINDOWS\system32\drivers\etc\hosts` (en Windows), la resolución la efectúa el propio sistema operativo sin requerir que la infraestructura de servidores DNS esté operativa.

**Complicaciones de navegar sin DNS en la red actual**
Aunque la conexión sea viable mediante las alternativas mencionadas, prescindir del servicio DNS presenta serios problemas en la práctica:

- **Hospedaje virtual basado en nombres (** **Name-based Virtual Hosts** **)**: En servidores web modernos (como Apache o NGINX), una única IP suele compartir cientos de sitios web distintos. El servidor sabe qué sitio entregar leyendo la cabecera `Host:` del protocolo HTTP. Si se ingresa mediante la IP directa, el servidor no podrá determinar a qué dominio se desea ingresar y devolverá la página genérica predeterminada.
- **Validación de certificados de seguridad (HTTPS)**: Los certificados SSL/TLS se emiten para nombres de dominio específicos, por lo que navegar ingresando la IP generará advertencias de seguridad y bloqueos en los navegadores.
- **Carga de componentes secundarios**: Las páginas web enlazan imágenes, hojas de estilo CSS o scripts alojados en dominios de terceros. Aunque la página inicial cargue por IP, todos los elementos vinculados a nombres de dominio no podrán descargarse si no hay DNS.

---
### 17. Observar el siguiente gráfico y contestar:

**Diagrama de red:**
- **Red A:** `PC-A` (`192.168.10.5`) y `DNS Server` (`192.168.10.2`), ambos conectados mediante `eth0` a un switch (`Sw2`), que a su vez se conecta a `Router A` (`192.168.10.1`) por `eth0`.
- `Router A` conecta la Red A hacia Internet.
- **A. Root-Server:** `205.10.100.10` (aparece duplicado/redundante en el gráfico).
- **Dominio `.ar`:** servidor `a.dns.ar` — `200.108.145.50`.
- **Dominio `edu.ar`:** servidor `ns1.riu.edu.ar` — `170.210.0.18`.
- **Dominio `unlp.edu.ar`:** servidor `unlp.unlp.edu.ar` — `163.10.0.67`.
- **Host `www.unlp.edu.ar`:** `163.10.0.54`.

- **a. Si la PC-A, que usa como servidor de DNS a "DNS Server", desea obtener la IP de `www.unlp.edu.ar`, cuáles serían, y en qué orden, los pasos que se ejecutarán para obtener la respuesta.**

**a. Pasos y orden de ejecución para obtener la IP de** **www.unlp.edu.ar**

1. **PC-A** $\rightarrow$ **DNS Server** (192.168.10.2):
	- La **PC-A** envía una solicitud **recursiva** a su servidor DNS local pidiendo la dirección IP de `www.unlp.edu.ar`.
2. **DNS Server** $\rightarrow$ A.Root-Server (205.10.100.10):
    - Al no tener la respuesta almacenada en caché, el servidor local consulta de forma **iterativa** a un servidor raíz (`A.Root-Server`)1more_horiz.
    - El `A.Root-Server` responde con una referencia (_referral_) hacia los servidores del TLD `.ar` (`a.dns.ar`, IP `200.108.145.50`).
3. **DNS Server** $\rightarrow$ a.dns.ar (200.108.145.50):
    - El servidor local consulta **iterativamente** al servidor de `.ar` (`a.dns.ar`).
    - Este le devuelve la referencia de los servidores encargados del subdominio `edu.ar` (`ns1.riu.edu.ar`, IP `170.210.0.18`).
4. **DNS Server** $\rightarrow$ ns1.riu.edu.ar (170.210.0.18):
    - El servidor local consulta **iterativamente** al servidor de `edu.ar` (`ns1.riu.edu.ar`).
    - Este responde con la referencia del servidor autoritativo de la UNLP (`unlp.unlp.edu.ar`, IP `163.10.0.67`).
5. **DNS Server** $\rightarrow$ unlp.unlp.edu.ar (163.10.0.67):
    - El servidor local realiza la consulta **iterativa** al servidor autoritativo de la zona `unlp.edu.ar` (`unlp.unlp.edu.ar`).
    - Dado que aloja la base de datos oficial, responde con el registro A definitivo: la dirección IP **163.10.0.54** correspondiente a `www.unlp.edu.ar`.
6. **DNS Server** $\rightarrow$ **PC-A**:
    - El servidor DNS local almacena el resultado en su memoria caché y le entrega la dirección IP **163.10.0.54** a la **PC-A**.

**b. ¿Dónde es recursiva la consulta? ¿Y dónde iterativa?**

- **Consulta Recursiva**:
    - Se realiza únicamente entre la **PC-A** y su **DNS Server local** (`192.168.10.2`). La PC-A le traslada la responsabilidad total del proceso y espera la respuesta final.
- **Consultas Iterativas**:
    - Se realizan entre el **DNS Server local** y cada uno de los servidores de la jerarquía DNS pública:
        1. `DNS Server` $\leftrightarrow$ `A.Root-Server` (`205.10.100.10`)
        2. `DNS Server` $\leftrightarrow$ `a.dns.ar` (`200.108.145.50`)
        3. `DNS Server` $\leftrightarrow$ `ns1.riu.edu.ar` (`170.210.0.18`)
        4. `DNS Server` $\leftrightarrow$ `unlp.unlp.edu.ar` (`163.10.0.67`)

---
### 18. ¿A quién debería consultar para que la respuesta sobre `www.google.com` sea autoritativa?

A cualquiera de los servidores autoritativos del dominio `google.com`.
`dig google.com NS`: devuelve `ns1.google.com (216.239.32.10)`, entre otros NS.
`dig www.google.com @216.239.32.10`: respuesta autoritativa.

---
### 19. ¿Qué sucede si al servidor elegido en el paso anterior se lo consulta por `www.info.unlp.edu.ar`? ¿Y si la consulta es al servidor `8.8.8.8`?

- **Resultado:** El servidor **no resolverá la dirección IP** y devolverá un error o advertencia (generalmente con estado `REFUSED` o `ANSWER: 0` junto a la leyenda _"recursion requested but not available"_).
- **Explicación:** **ns1.google.com** **es un servidor puramente autoritativo** para la zona de Google. Los servidores autoritativos públicos tienen la **recursión deshabilitada** para clientes externos; solo responden por los dominios que alojan en su propia base de datos. Al no ser autoritativo sobre `unlp.edu.ar` y no aceptar peticiones recursivas, se niega a salir a buscar la respuesta por la jerarquía de Internet.


**¿Y si la consulta se realiza al servidor 8.8.8.8?**

- **Resultado:** Responderá con éxito (**status: NOERROR**) entregando la **dirección IP** de `www.info.unlp.edu.ar`.
- **Características de la respuesta:**
    - **Respuesta NO autoritativa:** No contendrá la bandera **aa** **(*Authoritative Answer*)**, ya que `8.8.8.8` no es el dueño oficial de la zona de la UNLP.
    - **Recursión disponible:** Contendrá la bandera **ra** **(*Recursion Available*)** activada.
	- **Explicación:** **8.8.8.8** **es un resolver recursivo público** de Google45. Su función principal es recibir peticiones de clientes y, si no tiene la respuesta en su memoria caché, realizar todo el recorrido iterativo a través de la jerarquía global de DNS (servidores raíz $\rightarrow$ `.ar` $\rightarrow$ `edu.ar` $\rightarrow$ `unlp.edu.ar` $\rightarrow$ `info.unlp.edu.ar`) hasta obtener la IP y enviársela al usuario.
---
## Ejercicio de parcial
### 20. En base a la siguiente salida de `dig`, conteste las consignas. Justifique en todos los casos.

```
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 4, ADDITIONAL: 4

;; QUESTION SECTION:
;ejemplo.com.                    IN      __ MX

;; ANSWER SECTION:
ejemplo.com.            1634     IN      __ MX    10  srv01.ejemplo.com.    (1)
ejemplo.com.            1634     IN      __ MX    5  srv00.ejemplo.com.    (2)

;; AUTHORITY SECTION:
ejemplo.com.           92354     IN      __ NS   ss00.ejemplo.com.
ejemplo.com.           92354     IN      __ NS   ss02.ejemplo.com.
ejemplo.com.           92354     IN      __ NS   ss01.ejemplo.com.
ejemplo.com.           92354     IN      __ NS   ss03.ejemplo.com.

;; ADDITIONAL SECTION:
srv01.ejemplo.com.        272    IN      __ A   64.233.186.26
srv01.ejemplo.com.        240    IN      __ AAAA   2800:3f0:4003:c00::1a
srv00.ejemplo.com.        272    IN      __ A   74.125.133.26
srv00.ejemplo.com.        240    IN      __ AAAA   2a00:1450:400c:c07::1b
```

- **a. Complete las líneas donde aparece `__` con el registro correcto.**
- **b. ¿Es una respuesta autoritativa? En caso de no serlo, ¿a qué servidor le preguntaría para obtener una respuesta autoritativa?**
  No es autoritativa. 
  
- **c. ¿La consulta fue recursiva? ¿Y la respuesta?**
  Aparece la flag `rd`, representando que la consulta desea recursividad en la respuesta. Luego aparece la flag `ra`, que indica que la respuesta fue recursiva.

- **d. ¿Qué representan los valores 10 y 5 en las líneas (1) y (2)?**
  La prioridad de los servidores de mail. Mientras más bajo el número mayor es la prioridad del servidor. Primero se intentará utilizar el de mayor prioridad y en caso de no ser posible, se intenta con los siguientes.
