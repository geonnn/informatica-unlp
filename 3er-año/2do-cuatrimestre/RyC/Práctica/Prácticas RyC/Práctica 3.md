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

---
### 8. Cuando un dominio cuenta con más de un servidor, uno de ellos es el primario (o maestro) y todos los demás son secundarios (o esclavos). ¿Cuál es la razón de que sea así?

---
### 9. Explique brevemente en qué consiste el mecanismo de transferencia de zona y cuál es su finalidad.

---
### 10. Imagine que usted es el administrador del dominio de DNS de la UNLP (`unlp.edu.ar`). A su vez, cada facultad de la UNLP cuenta con un administrador que gestiona su propio dominio (por ejemplo, en el caso de la Facultad de Informática se trata de `info.unlp.edu.ar`). Suponga que se crea una nueva facultad, Facultad de Redes, cuyo dominio será `redes.unlp.edu.ar`, y el administrador le indica que quiere poder manejar su propio dominio. ¿Qué debe hacer usted para que el administrador de la Facultad de Redes pueda gestionar el dominio de forma independiente? *(Pista: investigue en qué consiste la delegación de dominios)*. Indicar qué registros de DNS se deberían agregar.

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
Los servidores de correo son `mail.redes.unlp.edu.ar.` y `mail2.redes.unlp.edu.ar.` Primero se intentará usar el servidor con prioridad 5. En caso de que este no esté disponible, se usa el servidor con prioridad 10.

- **c. ¿Cuáles son los servidores de DNS del dominio `redes.unlp.edu.ar`?**

- **d. Repita la consulta anterior cuatro veces más. ¿Qué observa? ¿Puede explicar a qué se debe?**

- **e. Observe la información que obtuvo al consultar por los servidores de DNS del dominio. En base a la salida, ¿es posible indicar cuál de ellos es el primario?**

- **f. Consulte por el registro `SOA` del dominio y responda.**
  - i. ¿Puede ahora determinar cuál es el servidor de DNS primario?
  - ii. ¿Cuál es el número de serie, qué convención sigue y en qué casos es importante actualizarlo?
  - iii. ¿Qué valor tiene el segundo campo del registro? Investigue para qué se usa y cómo se interpreta el valor.
  - iv. ¿Qué valor tiene el TTL de caché negativa y qué significa?

- **g. Indique qué valor tiene el registro `TXT` para el nombre `saludo.redes.unlp.edu.ar`. Investigue para qué es usado este registro.**

- **h. Utilizando `dig`, solicite la transferencia de zona de `redes.unlp.edu.ar`, analice la salida y responda.**
  - i. ¿Qué significan los números que aparecen antes de la palabra `IN`? ¿Cuál es su finalidad?
  - ii. ¿Cuántos registros `NS` observa? Compare la respuesta con los servidores de DNS del dominio `redes.unlp.edu.ar` que dio anteriormente. ¿Puede explicar a qué se debe la diferencia y qué significa?

- **i. Consulte por el registro `A` de `www.redes.unlp.edu.ar` y luego por el registro `A` de `www.practica.redes.unlp.edu.ar`. Observe los TTL de ambos. Repita la operación y compare el valor de los TTL de cada uno respecto de la respuesta anterior. ¿Puede explicar qué está ocurriendo?** *(Pista: observar los flags será de ayuda)*

- **j. Consulte por el registro `A` de `www.practica2.redes.unlp.edu.ar`. ¿Obtuvo alguna respuesta? Investigue sobre los códigos de respuesta de DNS. ¿Para qué son utilizados los mensajes `NXDOMAIN` y `NOERROR`?**

---
### 12. Investigue los comandos `nslookup` y `host`. ¿Para qué sirven? Intente con ambos comandos obtener:
- Dirección IP de `www.redes.unlp.edu.ar`.
- Servidores de correo del dominio `redes.unlp.edu.ar`.
- Servidores de DNS del dominio `redes.unlp.edu.ar`.

---
### 13. ¿Qué función cumple en Linux/Unix el archivo `/etc/hosts` o en Windows el archivo `\WINDOWS\system32\drivers\etc\hosts`?

---
### 14. Abra el programa Wireshark para comenzar a capturar el tráfico de red en la interfaz con IP `172.28.0.1`. Una vez abierto realice una consulta DNS con el comando `dig` para averiguar el registro `MX` de `redes.unlp.edu.ar` y luego, otra para averiguar los registros `NS` correspondientes al dominio `redes.unlp.edu.ar`. Analice la información proporcionada por `dig` y compárelo con la captura.

---
### 15. Dada la siguiente situación: "Una PC en una red determinada, con acceso a Internet, utiliza los servicios de DNS de un servidor de la red". Analice:
- **a. ¿Qué tipo de consultas (iterativas o recursivas) realiza la PC a su servidor de DNS?**
- **b. ¿Qué tipo de consultas (iterativas o recursivas) realiza el servidor de DNS para resolver requerimientos de usuario como el anterior? ¿A quién le realiza estas consultas?**

---
### 16. Relacione DNS con HTTP. ¿Se puede navegar si no hay servicio de DNS?

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
- **b. ¿Dónde es recursiva la consulta? ¿Y dónde iterativa?**

---
### 18. ¿A quién debería consultar para que la respuesta sobre `www.google.com` sea autoritativa?

---
### 19. ¿Qué sucede si al servidor elegido en el paso anterior se lo consulta por `www.info.unlp.edu.ar`? ¿Y si la consulta es al servidor `8.8.8.8`?

---
**Ejercicio de parcial**

---
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
