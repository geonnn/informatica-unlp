# Práctica 2 - Capa de Aplicación
## HTTP
**Requerimientos**
Para realizar esta práctica deberá descargar la máquina virtual provista por la cátedra. Puede ver la URL de descarga en el sitio de la cátedra en https://catedras.info.unlp.edu.ar/.
Una vez descargado el archivo, haciendo doble click en el mismo debería abrirse un cuadro de diálogo que permita configurar algunos parámetros del sistema. Se pueden aceptar los valores por defecto haciendo simplemente click en Importar.
Se recomienda hacer un snapshot de la VM antes de empezar a usarla, para poder volver atrás en caso de que algo deje de funcionar. Los datos de acceso a la máquina virtual son:
**Usuario:** redes
**Contraseña:** redes
Para acceso con permisos de administrador, usar el comando sudo
**Aclaración:** el dominio redes.unlp.edu.ar solo existe dentro de la VM provista por la cátedra, no es válido en Internet, lo que implica que todos los ejercicios de esta práctica y las siguientes en las que se utilice dicho dominio solo podrán ser resueltos dentro dicha VM.

---
### 1. ¿Cuál es la función de la capa de aplicación?

En la capa de aplicación residen los protocolos para establecer la comunicación entre procesos de diferentes hosts. Estos protocolos definen cómo se comunican entre sí los procesos definiendo: tipo de mensajes intercambiados, sintaxis y semántica de los mensajes y reglas para determinar cómo y cuando un proceso envía y responde mensajes. 

---
### 2. Si dos procesos deben comunicarse:
- **a.​ ¿Cómo podrían hacerlo si están en diferentes máquinas?**
  Dos procesos pueden comunicarse utilizando protocolos establecidos en la capa de aplicación: HTTP, HTTPS, FTP, SMTP, etc.
 
- **b.​ Y si están en la misma máquina, ¿qué alternativas existen?**
  En la misma máquina un proceso se comunica con otro mediante recursos administrados por el sistema operativo, por ejemplo la memoria.
  
---
### 3. Explique brevemente cómo es el modelo Cliente/Servidor. Dé un ejemplo de un sistema Cliente/Servidor en la “vida cotidiana” y un ejemplo de un sistema informático que siga el modelo Cliente/Servidor. ¿Conoce algún otro modelo de comunicación?

El modelo cliente/servidor puede verse como una persona que va a comer a un restaurante. La persona (cliente) realiza un requerimiento, por ejemplo una milanesa con papas y el restaurante (servidor) responde a esta solicitud según la situación.
En informática visitar una página web se considera un sistema cliente/servidor.
Otro modelo puede ser productor/consumidor.

---
### 4. Describa la funcionalidad de la entidad genérica “Agente de usuario” o “User agent”.

Es una cabecera. Permite especificar en un requerimiento qué software, versión y/o sistema operativo utiliza el cliente.

---
### 5. ¿Qué son y en qué se diferencian HTML y HTTP?

**HTML** (*Hypertext Markup Language*) es un estándar de formato de archivo en texto ASCII que los navegadores comprenden e interpretan para retornar los contenidos de una aplicación web estructurados de una determinada forma.
**HTTP** (*Hypertext Transfer Protocol*) es un protocolo de transferencia de archivos que define el formato y la secuencia de mensajes necesarios para comunicar al cliente y al servidor.
No son "comparables", son cosas distintas con objetivos diferentes. Por ejemplo, los navegadores pueden utilizar el protocolo HTTP para solicitar archivos HTML a un servidor web. Este último, utilizando nuevamente el protocolo HTTP y suponiendo un resultado favorable, envía una respuesta al cliente con el archivo HTML solicitado por el navegador incluido en el cuerpo de la misma. Finalmente el navegador recibe el HTML y lo muestra en pantalla para mostrarle los contenidos al usuario.

---
### 6. HTTP tiene definido un formato de mensaje para los requerimientos y las respuestas. (Ayuda: apartado “Formato de mensaje HTTP”, Kurose).
- **a.​ ¿Qué información de la capa de aplicación nos indica si un mensaje es de requerimiento o de respuesta para HTTP? ¿Cómo está compuesta dicha información? ¿Para qué sirven las cabeceras?**
  La primera línea es la línea de requerimiento o línea de respuesta, según el mensaje sea requerimiento o respuesta, respectivamente.
  En el caso de un requerimiento, la línea de requerimiento, se compone:
  ```
  <Método> <Recurso> <Versión de HTTP>
  ```
  La línea de respuesta, se compone:
  ```
  <Versión de HTTP> <Código de estado> <Frase relacionada al código de estado>
  ```
Las cabeceras son parámetros adicionales para un mensaje HTTP. Sirven para indicar información adicional que puede ser de utilidad para el receptor del mensaje.

- **b.​ ¿Cuál es su formato? (Ayuda: https://developer.mozilla.org/es/docs/Web/HTTP/Headers)**
  Formato de un requerimiento:
```
<Método> <Recurso> <Versión de HTTP>
<Headers>
<Cuerpo del mensaje>
```
Formato de una respuesta:
```
<Versión de HTTP> <Código de estado> <Frase>
<Headers>
<Cuerpo del mensaje>
```
  
- **c.​ Suponga que desea enviar un requerimiento con la versión de HTTP 1.1 desde curl/7.74.0 a un sitio de ejemplo como www.misitio.com para obtener el recurso /index.html. En base a lo indicado, ¿qué información debería enviarse mediante encabezados? Indique cómo quedaría el requerimiento.**
  ```
  GET /index.html HTTP/1.1
  Host: www.misitio.com
  User-Agent: curl/7.74.0
  Accept: */*
  ```
  
---
### 7. Utilizando la VM, abra una terminal e investigue sobre el comando curl. Analice para qué sirven los siguientes parámetros (-I, -H, -X, -s).

**curl:** herramienta para transferir información desde o hacia un servidor usando uno de los protocolos disponibles (HTTP, HTTPS, FTP, SMTP, etc.) (`man curl`). 

**-I:** sólo recupera los headers, no toda la información.
**-H:** para incluir headers extra junto con la información enviada.
**-X:** cambia el método a utilizar (`GET`, `POST`, `DELETE`, etc.). P. ej. `curl -X "DELETE" www...`
**-s:** silent. No muestra progreso o errores. De todas formas retorna la info. solicitada por curl.

---
### 8. Ejecute el comando curl sin ningún parámetro adicional y acceda a www.redes.unlp.edu.ar. Luego responda:
- **a.​ ¿Cuántos requerimientos realizó y qué recibió? Pruebe redirigiendo la salida (>) del comando curl a un archivo con extensión html y abrirlo con un navegador.**
  Realiza un solo requerimiento, `GET /`. Por esto, al abrir el archivo html no tiene estilos ni ningún archivo adicional, entonces sólo se ve el HTML plano.
  
- **b.​ ¿Cómo funcionan los atributos href de los tags link e img en html?**
  Son la URL a otro recurso. Cada recurso que aparezca con atributo href representa otro requerimiento. Puede implicar otra conexión si no se tiene conexión persistente en la comunicación o el recurso se encuentra en otro servidor. 

- **c.​ Para visualizar la página completa con imágenes como en un navegador, ¿alcanza con realizar un único requerimiento?**
  No, también se deben obtener todos los archivos de estilo y demás en otros requerimientos.
  
- **d.​ ¿Cuántos requerimientos serían necesarios para obtener una página que tiene dos CSS, dos Javascript y tres imágenes? Diferencie cómo funcionaría un navegador respecto al comando curl ejecutado previamente.**
  8\. Los 7 archivos mencionados y el html.
---
### 9. Ejecute a continuación los siguientes comandos:
```bash
curl -v -s www.redes.unlp.edu.ar > /dev/null
```
```bash
curl -I -v -s www.redes.unlp.edu.ar
```
- **a.​ ¿Qué diferencias nota entre cada uno?**
  El primero envía la salida a de la solicitud a `/dev/null`, entonces con `-v` sólo se muestran los headers de la request y la response.
```
redes@debian:~$ curl -v -s www.redes.unlp.edu.ar > /dev/null 
*   Trying 172.28.0.50:80...
* Connected to www.redes.unlp.edu.ar (172.28.0.50) port 80 (#0)
> GET / HTTP/1.1
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.74.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Mon, 31 Aug 2026 21:53:01 GMT
< Server: Apache/2.4.56 (Unix)
< Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
< ETag: "1322-5f7457bd64f80"
< Accept-Ranges: bytes
< Content-Length: 4898
< Content-Type: text/html
< 
{ [4898 bytes data]
* Connection #0 to host www.redes.unlp.edu.ar left intact
```
El segundo comando no necesita la redirección a `/dev/null` porque usa el parámetro `-I`, que sólo recupera los headers de la response, y no incluye el cuerpo.
```
redes@debian:~$ curl -I -v -s www.redes.unlp.edu.ar 
*   Trying 172.28.0.50:80...
* Connected to www.redes.unlp.edu.ar (172.28.0.50) port 80 (#0)
> HEAD / HTTP/1.1
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.74.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< Date: Mon, 31 Aug 2026 21:56:42 GMT
Date: Mon, 31 Aug 2026 21:56:42 GMT
< Server: Apache/2.4.56 (Unix)
Server: Apache/2.4.56 (Unix)
< Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
< ETag: "1322-5f7457bd64f80"
ETag: "1322-5f7457bd64f80"
< Accept-Ranges: bytes
Accept-Ranges: bytes
< Content-Length: 4898
Content-Length: 4898
< Content-Type: text/html
Content-Type: text/html

< 
* Connection #0 to host www.redes.unlp.edu.ar left intact
```
  
- **b. ¿Qué ocurre si en el primer comando se quita la redirección a /dev/null? ¿Por qué no es necesaria en el segundo comando?**
  Si no se redirecciona a `/dev/null` se muestra el cuerpo de la response, en este caso, el contenido del archivo html que construye la página. En el segundo comando no es necesario porque con el parámetro `-I` sólo se muestran los headers de la response (también de la request por `-v`).
  
- **c.​ ¿Cuántas cabeceras viajaron en el requerimiento? ¿Y en la respuesta?**
  3\. Lo primero que se ve indicado por ">" es la línea de requerimiento, Los ">" siguientes son las cabeceras.
  En la respuesta hay 7 cabeceras. Lo primero indicado por "<" es la línea de respuesta.
---
### 10. ¿Qué indica la cabecera Date?

La cabecera Date (presente en la response) indica la fecha y hora de la **response**.

---
### 11. En HTTP/1.0, ¿cómo sabe el cliente que ya recibió todo el objeto solicitado de manera completa? ¿Y en HTTP/1.1?

En HTTP/1.0 se recibe el objeto y se cierra la conexión.
En HTTP/1.1 se envía el header "Content-Length" que indica la longitud del objeto. Si el servidor no conoce la longitud del archivo envía el header "Transfer-Encoding: chunked" y el recurso se envía en bloques, cada uno precedido por su tamaño. El mensaje termina con un bloque de tamaño 0.

---
### 12. Investigue los distintos tipos de códigos de retorno de un servidor web y su significado. Considere que los mismos se clasifican en categorías (2XX, 3XX, 4XX, 5XX).

#### Categoría 2XX. Respuestas exitosas:
**200 OK:** La request fue exitosa. El resultado de la request depende del método utilizado. Por ejemplo, para `GET`, el recurso fue recuperado y su contenido incluido en el cuerpo del mensaje. Para `HEAD` lo mismo, pero con los headers. Para `PUT` o `POST`: "*El recurso que describe el resultado de la acción se transmite en el cuerpo del mensaje.*"
**201 Created:** Se creó un nuevo recurso como resultado. Respuesta típica de un `POST`, por ejemplo, un registro de usuario.
**202 Accepted**
**203 Non-Authoritative Information**
**204 No Content**
**205 Reset Content**

#### Categoría 3XX. Mensajes de redirección.
**301 Moved permanently:** La URL del recurso requerido cambió permanentemente. Se incluye la nueva URL en la response.
**302 Found:** Este código de respuesta significa que el recurso de la URI solicitada ha sido cambiado temporalmente. Nuevos cambios en la URI serán agregados en el futuro. Por lo tanto, la misma URI debe ser usada por el cliente en futuras solicitudes.
**304 Not Modified:** Este código de respuesta es usado para propósitos de caché. Le indica al cliente que la respuesta no ha sido modificada. Entonces, el cliente puede continuar usando la misma versión almacenada en su caché.
**307 Temporary Redirect:** El servidor envía esta respuesta para dirigir al cliente a obtener el recurso solicitado a otra URI con el mismo método que se usó la petición anterior. Tiene la misma semántica que el código de respuesta HTTP `302 Found`, con la excepción de que el agente usuario no debe cambiar el método HTTP usado: si un `POST` fue usado en la primera petición, otro `POST` debe ser usado en la segunda petición.
**308 Permanent Redirect:** Significa que el recurso ahora se encuentra permanentemente en otra URI, especificada por la respuesta de encabezado HTTP `Location:`. Tiene la misma semántica que el código de respuesta HTTP `301 Moved Permanently`, con la excepción de que el agente usuario no debe cambiar el método HTTP usado: si un `POST` fue usado en la primera petición, otro `POST` debe ser usado en la segunda petición.

#### Categoría 4XX. Error del cliente.
**400 Bad Request:** El servidor no pudo interpretar la request porque tiene una sintáxis inválida.
**401 Unauthorized:** Se debe autenticar para obtener el recurso requerido.
**403 Forbidden:** El cliente no posee los permisos necesarios para acceder al recurso requerido.
**404 Not Found:** El servidor no encontró el recurso solicitado.
**408 Request Timeout:** Esta respuesta es enviada en una conexión inactiva en algunos servidores, incluso sin alguna petición previa por el cliente. Significa que el servidor quiere desconectar esta conexión sin usar. Esta respuesta es muy usada desde algunos navegadores, como Chrome, Firefox 27+, o IE9, usa mecanismos de pre-conexión HTTP para acelerar la navegación. También hay que tener en cuenta que algunos servidores simplemente desconecta la conexión sin enviar este mensaje.
**409 Conflict:** Esta respuesta puede ser enviada cuando una petición tiene conflicto con el estado actual del servidor.
**429 Too Many Requests:** El usuario envío muchas requests en una determinada cantidad de tiempo.

#### Categoría 5XX. Error del servidor.
**500 Internal Server Error:** El servidor ha encontrado una situación que no sabe manejar. Este error es genérico, lo que indica que el servidor no puede encontrar un código de estado 5XX más apropiado para responder.
**501 Not Implemented:** El método de solicitud no es compatible con el servidor y no puede ser manejado. Los únicos métodos que los servidores son necesarios para soportar (y por lo tanto no deben devolver este código) son `GET` y `HEAD`.
**502 Bad Gateway:** Esta respuesta de error significa que el servidor, mientras trabajaba como una puerta de enlace para obtener una respuesta necesaria para manejar la solicitud, obtuvo una respuesta no válida.
**503 Service Unavailable:** El servidor no está listo para manejar la solicitud. Las causas comunes son un servidor que está caído para el mantenimiento o que está sobrecargado. Tenga en cuenta que junto con esta respuesta, se debe enviar una página fácil de usar que explique el problema. Esta respuesta debe utilizarse para condiciones temporales y Retry-AfterEl encabezado HTTP debería, si es posible, contener el tiempo estimado antes de la recuperación del servicio. El webmaster también debe tener cuidado con los encabezados relacionados con el almacenamiento en caché que se envían junto con esta respuesta, ya que estas respuestas de condición temporal generalmente no deben almacenarse en caché.
**504 Gateway Timeout:** Esta respuesta de error se da cuando el servidor actúa como una puerta de enlace y no puede obtener una respuesta en el tiempo.
**505 HTTP Version Not Supported:** La versión HTTP utilizada en la solicitud no es soportada por el servidor.
**506 Variant Also Negotiates:** El servidor tiene un error de configuración interna: durante la negociación de contenido, la variante elegida está configurada para participar en la propia negociación de contenido, lo que da como resultado referencias circulares al crear respuestas.
**507 Insufficient Storage:** El método no se pudo realizar en el recurso porque el servidor no puede almacenar la representación necesaria para completar con éxito la solicitud.
**508 Loop Detected:** El servidor detectó un bucle infinito mientras procesaba la solicitud.
**510 Not Extended:** La solicitud del cliente declara una extensión HTTP (RFC 2774) que debe usarse para procesar la solicitud, pero la extensión no es compatible.
**511 Network Authentication Required:** Indica que el cliente necesita autenticarse para obtener acceso a la red.

---
### 13. Utilizando curl, realice un requerimiento con el método HEAD al sitio www.redes.unlp.edu.ar e indique:
- **a. ¿Qué información brinda la primera línea de la respuesta?**
  La primera línea es la **línea de respuesta.** Muestra el protocolo y un código de estado.
  
- **b. ¿Cuántos encabezados muestra la respuesta?**
  7.
  
- **c. ¿Qué servidor web está sirviendo la página?**
  Server: Apache/2.4.56 (Unix)
  
- **d. ¿El acceso a la página solicitada fue exitoso o no?**
  Sí, el código de respuesta es 200 OK.
  
- **e. ¿Cuándo fue la última vez que se modificó la página?**
  Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
  
- **f. Solicite la página nuevamente con curl usando GET, pero esta vez indique que quiere obtenerla sólo si la misma fue modificada en una fecha posterior a la que efectivamente fue modificada. ¿Cómo lo hace? ¿Qué resultado obtuvo? ¿Puede explicar para qué sirve?**
```sh
redes@debian:~$ curl -vsH "If-Modified-Since: Sun, 19 Mar 2023 19:04:46 GMT" www.redes.unlp.edu.ar > /dev/null
*   Trying 172.28.0.50:80...
* Connected to www.redes.unlp.edu.ar (172.28.0.50) port 80 (#0)
> GET / HTTP/1.1
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.74.0
> Accept: */*
> If-Modified-Since: Sun, 19 Mar 2023 19:04:46 GMT
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 304 Not Modified
< Date: Tue, 01 Sep 2026 14:56:29 GMT
< Server: Apache/2.4.56 (Unix)
< Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
< ETag: "1322-5f7457bd64f80"
< Accept-Ranges: bytes
< 
* Connection #0 to host www.redes.unlp.edu.ar left intact
```
Con el parámetro `-H` se agregan headers a la request. El header "If-Modified-Since" hace que el recurso sólo se recupere si la fecha de modificación del mismo es posterior a la enviada como parámetro en el header.

---
### 14. Utilizando curl, acceda al sitio www.redes.unlp.edu.ar/restringido/index.php y siga las instrucciones y las pistas que vaya recibiendo hasta obtener la respuesta final. Será de utilidad para resolver este ejercicio poder analizar tanto el contenido de cada página como los encabezados.

✅

---
### 15. Utilizando la VM, realice las siguientes pruebas:
- **a.​ Ejecute el comando `curl www.redes.unlp.edu.ar/extras/prueba-http-1-0.txt` y copie la salida completa (incluyendo los dos saltos de línea del final).**
```
GET /http/HTTP-1.1/ HTTP/1.0
User-Agent: curl/7.38.0
Host: www.redes.unlp.edu.ar
Accept: */*




```

- **b.​ Desde la consola ejecute el comando telnet www.redes.unlp.edu.ar 80 y luego pegue el contenido que tiene almacenado en el portapapeles. ¿Qué ocurre luego de hacerlo?**
```
redes@debian:~$ telnet www.redes.unlp.edu.ar 80
Trying 172.28.0.50...
Connected to www.redes.unlp.edu.ar.
Escape character is '^]'.
GET /http/HTTP-1.1/ HTTP/1.0
User-Agent: curl/7.38.0
Host: www.redes.unlp.edu.ar
Accept: */*



HTTP/1.1 200 OK
Date: Tue, 01 Sep 2026 17:36:19 GMT
Server: Apache/2.4.56 (Unix)
Last-Modified: Sun, 19 Mar 2023 19:04:46 GMT
ETag: "760-5f7457bd64f80"
Accept-Ranges: bytes
Content-Length: 1888
Connection: close
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Protocolo HTTP: versiones</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="../../bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./bootstrap/js/html5shiv.js"></script>
    <![endif]-->
  </head>

  <body>


    <div id="wrap">
        
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="../../index.html"><i class="icon-home icon-white"></i></a>
          <a class="brand" href="https://catedras.info.unlp.edu.ar" target="_blank">Redes y Comunicaciones</a>
          <a class="brand" href="http://www.info.unlp.edu.ar" target="_blank">Facultad de Inform&aacute;tica</a>
          <a class="brand" href="http://www.unlp.edu.ar" target="_blank">UNLP</a>
        </div>
      </div>
    </div>

    <div class="container">
    <h1>Ejemplo del protocolo HTTP 1.1</h1>
    <p>
        Esta p&aacute;gina se visualiza utilizando HTTP 1.1. Utilizando el capturador de paquetes analice cuantos flujos utiliza el navegador para visualizar la p&aacute;gina con sus im&aacute;genes en contraposici&oacute;n con el protocolo HTTP/1.0.
    </p>
    </p>
    <h2>Imagen de ejemplo</h2>
    <img src="13532-tuxkiller03green.png" width="800px"/>
    </div> 
    
    
    </div>
    <div id="footer">
      <div class="container">
        <p class="muted credit">Redes y Comunicaciones</p>
      </div>
    </div>
  </body>
</html>
Connection closed by foreign host.
```

- **c.​ Repita el proceso anterior, pero copiando la salida del recurso /extras/prueba-http-1-1.txt. Verifique que debería poder pegar varias veces el mismo contenido sin tener que ejecutar el comando telnet nuevamente.**
  Esto ocurre porque el protocolo es HTTP1.1 y por defecto mantiene la conexión abierta.

---
### 16. En base a lo obtenido en el ejercicio anterior, responda:
- **a.​ ¿Qué está haciendo al ejecutar el comando telnet?**
  El comando telnet inicia la conexión hacia el puerto 80, luego se ejecuta la request al pegar la línea de requerimientos y los headers.

- **b.​ ¿Qué método HTTP utilizó? ¿Qué recurso solicitó?**
  En ambos casos se usa el método GET y se solicita el recurso `/http/HTTP-1.1/`.
  
- **c.​ ¿Qué diferencias notó entre los dos casos? ¿Puede explicar por qué?**
  En el caso del protocolo HTTP1.0 la conexión no se mantiene abierta y finaliza al recibir la response del servidor.
  En el protocolo HTTP1.1, por defecto la conexión se mantiene abierta, entonces se pueden realizar varios requerimientos sin que finalice la conexión.
  
- **d.​ ¿Cuál de los dos casos le parece más eficiente? Piense en el ejercicio donde analizó la cantidad de requerimientos necesarios para obtener una página con estilos, javascripts e imágenes. El caso elegido, ¿puede traer asociado algún problema?**
  Si se requiere más de un recurso, es conveniente mantener la conexión abierta para no consumir recursos en establecer la conexión cada vez que se realiza un requerimiento.

---
### 17. En el siguiente ejercicio veremos la diferencia entre los métodos POST y GET. Para ello, será necesario utilizar la VM y la herramienta Wireshark. Antes de iniciar considere:
- Capture los paquetes utilizando la interfaz con IP 172.28.0.1. (Menú “Capture -> Options”. Luego seleccione la interfaz correspondiente y presione Start).
- Para que el analizador de red sólo nos muestre los mensajes del protocolo http introduciremos la cadena ‘http’ (sin las comillas) en la ventana de especificación de filtros de visualización (display-filter). Si no hiciéramos esto veríamos todo el tráfico que es capaz de capturar nuestra placa de red. De los paquetes que son capturados, aquel que esté seleccionado será mostrado en forma detallada en la ​sección que está justo debajo. Como sólo estamos interesados en http ocultaremos toda la información que no es relevante para esta práctica (Información de trama, Ethernet, IP y TCP). Desplegar la información correspondiente al protocolo HTTP bajo la leyenda “Hypertext Transfer Protocol”.
- Para borrar la cache del navegador, deberá ir al menú “Herramientas->Borrar historial reciente”. Alternativamente puede utilizar Ctrl+F5 en el navegador para forzar la petición HTTP evitando el uso de caché del navegador.
- En caso de querer ver de forma simplificada el contenido de una comunicación http, utilice el botón derecho sobre un paquete HTTP perteneciente al flujo capturado y seleccione la opción Follow TCP Stream.
	- **a.​ Abra un navegador e ingrese a la URL: www.redes.unlp.edu.ar e ingrese al link en la sección “Capa de Aplicación” llamado “Métodos HTTP”. En la página mostrada se visualizan dos nuevos links llamados: Método GET y Método POST. Ambos muestran un formulario como el siguiente:**
	![[Pasted image 20260830160010.png]]
	- **b.​ Analice el código HTML**
	- **c.​ Utilizando el analizador de paquetes Wireshark capture los paquetes enviados y recibidos al presionar el botón Enviar.**
	- **d.​ ¿Qué diferencias detectó en los mensajes enviados por el cliente?**
	  Con el método `GET` los valores del form deben llegar al servidor mediante URL Query (`?form_nombre=Juan&form_apellido=Pérez&...`).
	  Con el método `POST` los valores del form se mandan en un apartado `HTML Form URL Encoded` que es parte del body.
	  
	- **e.​ ¿Observó alguna diferencia en el browser si se utiliza un mensaje u otro?**

---
### 18. Investigue cuál es el principal uso que se le da a las cabeceras Set-Cookie y Cookie en HTTP y qué relación tienen con el funcionamiento del protocolo HTTP.

El servidor puede almacenar "Cookies" en el dispositivo cliente. Esto puede servir a múltiples propósitos, dado que funciona para almacenar "estados" en un protocolo de comunicación que no los admite. Por ejemplo, para tener en cuenta ciertas preferencias del cliente como el modo oscuro/claro, entre otros.
El cliente luego envía esa cookie con el header "Cookie".

---
### 19. ¿Cuál es la diferencia entre un protocolo binario y uno basado en texto? ¿De qué tipo de protocolo se trata HTTP/1.0, HTTP/1.1 y HTTP/2?

La diferencia entre un protocolo binario y uno basado en texto radica en que el protocolo binario utiliza un formato de datos más compacto y eficiente, mientras que el basado en texto transmite información en un formato legible por humanos. HTTP/1.0 y HTTP/1.1 son protocolos basados en texto, mientras que HTTP/2 es un protocolo binario.

---
### 20. Responder las siguientes preguntas:
- a.​ ¿Qué función cumple la cabecera Host en HTTP 1.1? ¿Existía en HTTP 1.0? ¿Qué sucede en HTTP/2? (Ayuda: https://undertow.io/blog/2015/04/27/An-in-depth-overview-of-HTTP2.html para HTTP/2)
- b.​ En HTTP/1.1, ¿es correcto el siguiente requerimiento?
```HTTP
GET /index.php HTTP/1.1
User-Agent: curl/7.54.0
```
- c.​ ¿Cómo quedaría en HTTP/2 el siguiente pedido realizado en HTTP/1.1 si se está usando https?
```HTTP
GET /index.php HTTP/1.1
Host: www.info.unlp.edu.ar
```

---
### Ejercicio integrador
curl -X ?? www.redes.unlp.edu.ar/??
(`curl -X "HEAD" www.redes.unlp.edu.ar/metodos/`)
```
> HEAD /metodos/ HTTP/1.0
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.54.0
< HTTP/1.1 200 OK
< Server: nginx/1.4.6 (Ubuntu)
< Date: Wed, 31 Jan 2018 22:22:22 GMT
< Last-Modified: Sat, 20 Jan 2018 13:02:41 GMT
< Content-Type: text/html; charset=UTF-8
< Connection: close
```
- a.​ ¿Qué método está utilizando? Dicho método, ¿retorna el recurso completo solicitado?
  Usa el método HEAD. Este método hace que sólo se retornen las cabeceras, no el contenido del recurso solicitado.
  
- b.​ ¿Cuál es el recurso solicitado?
  El recurso solicitado es `redes.unlp.edu.ar/metodos/`.
  
- c.​ ¿El método funcionó correctamente?
  Sí, el código de respuesta del servidor fue `200 OK`, que significa que la request fue exitosa y los headers solicitados (porque la request usa el método `HEAD`) fueron incluidos en la response.

- d.​ Si la solicitud hubiera llevado un encabezado que diga: `If-Modified-Since: Sat, 20 Jan 2018 13:02:41 GMT` ¿Cuál habría sido la respuesta del servidor web? ¿Qué habría hecho el navegador en este caso?
  La response hubiera sido con el código de estado `304 Not Modified`,  y en el cuerpo no se incluye el contenido ya que el header `If-Modified-Since` funciona como un "get condicional". Si el valor del header `If-Modified-Since` presente en la request y el valor del header `Last-Modified` presente en la response coinciden, no se incluye el contenido del recurso en la response. Sólo se recupera si el contenido fue modificado en una fecha posterior (indicada en el header `Last-Modified`) a la indicada en el valor de `If-Modified-Since`.