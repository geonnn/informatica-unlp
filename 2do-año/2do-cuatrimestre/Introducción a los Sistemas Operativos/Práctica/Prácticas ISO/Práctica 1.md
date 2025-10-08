#### 1. Características de GNU/Linux:

>a. Mencione y explique las características más relevantes de GNU/Linux.

GNU/Linux es un un término que hace referencia a un sistema operativo Unix-like, libre y de código abierto. Que sea libre y de código abierto implica que miles de programadores en todo el mundo pueden ver el código fuente. Así se logra un sistema operativo altamente personalizable y con diversas distribuciones que varían las características del mismo en muchos aspectos.
Código abierto refiere a 4 libertades principales de los usuarios del software:
- Libertad de usar el programa con cualquier propósito
- Libertad de estudiar su funcionamiento
- Libertad para distribuir sus copias
- Libertad para mejorar los programas

>b. Mencione otros sistemas operativos y compárelos con GNU/Linux en cuanto a los puntos mencionados en el inciso a.

Windows, por ejemplo, no es de distribución libre ni de código abierto. Windows es propiedad de Microsoft, sólo lo desarrolla y distribuye la misma empresa. El código fuente del SO no está disponible para que cualquier persona lo vea por lo que no puede ser estudiado para ser modificado y redistribuido. Además se debe adquirir una licencia para usar el SO de forma legal, aunque esto es más una regla general, el software libre no necesariamente es gratuito.

>c. ¿Qué es GNU?

GNU es el sistema operativo similar a Unix constituido en su totalidad por software libre. Fue diseñado para ser totalmente compatible con Unix, entonces, está compuesto de pequeñas piezas individuales de software. Para asegurar que GNU sea libre, es decir, que todos los usuarios pudieran "ejecutarlo, copiarlo, modificarlo y distribuirlo", el proyecto debía ser liberado bajo una licencia que garantice esos derechos y al mismo tiempo evitase restricciones posteriores de los mismos. Esta idea se conoce como copyleft y está contenida en un marco regulatorio conocido como GPL (General Public License de GNU).

>d. Indique una breve historia sobre la evolución del proyecto GNU.

GNU es iniciado por Richard Stallman en 1983 con el fin de crear un sistema operativo similar a Unix pero libre. Para eso, necesitaba la GPL (desarrollada en c.).
En 1985, crea la Free Software Foundation (FSF) para proveer soporte logístico, legal y financiero al proyecto GNU.
En 1990, el sistema GNU ya tenía la mayor parte de bibliotecas y utilidades que componen un UNIX típico, pero faltaba un componente clave, llamado núcleo (kernel). Stallman menciona que un núcleo inicial existe pero que hacen falta otros programas para emular Unix. Se refería a TRIX, un núcleo desarrollado por el MIT cuyos autores decidieron que sea distribuido libremente, pero el problema era que sólo funcionaba en equipos caros y complejos.
En 1988, se decidió utilizar como base el núcleo Mach desarrollado en la Universidad Carnegie Mellon. Luego fue renombrado a Hurd y debido a razones técnicas y conflictos personales entre los programadores, el desarrollo acabó estancándose.
En 1991, Linus Torvalds empezó a trabajar en ideas para un SO. Comenzó con un intento por obtener un SO libre similar a Unix que funcionara con microprocesadores Intel 80386. Ese mismo año empezó a escribir el núcleo Linux y decidió distribuirlo bajo la licencia GPL. Rápidamente, múltiples programadores se unieron a Linus en el desarrollo, colaborando a través de Internet y consiguiendo paulatinamente que Linux llegase a ser un núcleo compatible con UNIX.
En 1992, el núcleo Linux fue combinado con el sistema GNU, resultando en un SO libre y completamente funcional. El SO formado por esta combinación es usualmente conocido como "GNU/Linux" o como una "distribución Linux" y existen diversas variantes.

>e. Explique qué es la multitarea, e indique si GNU/Linux hace uso de ella.

La multitarea es la ejecución simultánea de múltiples programas o procesos. El kernel de Linux implementa la multitarea asignando porciones de tiempo de CPU a cada proceso de forma intercalada, logrando que todos los programas en ejecución tengan tiempo de procesador.

>f. ¿Qué es POSIX?

POSIX (Portable Operating System Interface, X proviene de UNIX) es una norma escrita por la IEEE que define una interfaz estándar del sistema operativo y del entorno, incluyendo un intérprete de comandos (shell), y programas de utilidades comunes.

---
#### 2. Distribuciones de GNU/Linux:

> a. ¿Qué es una distribución de GNU/Linux? Nombre al menos 4 distribuciones de GNU/Linux y cite diferencias básicas entre ellas.



> b. ¿En qué se diferencia una distribución de otra?



> c. ¿Qué es Debian? Acceda al sitio https://www.debian.org/ e indique cuáles son los objetivos del proyecto y una breve cronología del mismo.



---
#### 3. Estructura de GNU/Linux:

> a. Nombre cuáles son los 3 componentes fundamentales de GNU/Linux.

El kernel, el shell, y el file system.

> b. Mencione y explique la estructura básica del Sistema Operativo GNU/Linux.

El kernel es la parte del sistema operativo que siempre se encuentra en memoria, y hace posible las interacciones entre el software y el hardware.
El shell es el programa que lee las entradas del usuario y las convierte en instrucciones para el sistema.
El file system es la forma en que los archivos se organizan y administran en un sistema operativo.

---
#### 4. Kernel:

> a. ¿Cuáles son sus funciones principales?

El kernel administra los recursos físicos de la máquina (memoria, CPU, E/S). Siempre está activo y cargado en memoria y decide qué programa o proceso podrá usar un dispositivo de hardware y durante cuánto tiempo (multiprogramación). 

> b. ¿Cuál es la versión actual? ¿Cómo se definía el esquema de versionado del Kernel en versiones anteriores a la 2.4? ¿Qué cambió en el versionado que se impuso a partir de la versión 2.6?

Actualmente se encuentra en la versión 6 (6.17.1 el 06/10/2025).
El esquema de versionado es A.B.C.\[D]:

- A: versión del kernel. Cambia con menor frecuencia, asociado a cambios en el código o en el concepto del kernel.
- B: denota mayor revisión del kernel. Antes de la 2.6.x los números pares indicaban la versión "estable" y los impares la versión de desarrollo. Luego de la 2.6.x no hay gran diferencia entre las versiones pares o impares.
- C: indica una revisión menor en el kernel. Asociado a nuevos drivers o características.
- D: bug-fixes y parches de seguridad. Se introdujo en la versión 2.6.8 cuando se encontró un error que requería arreglo inmediato. Como no había otros cambios para lanzar una siguiente versión (que hubiera sido la 2.6.9), se lanzó la 2.6.8.1, con el error arreglado.

> c. ¿Es posible tener más de un Kernel de GNU/Linux instalado en la misma máquina?

Sí, puede ser útil para mantener estabilidad y compatibilidad con el hardware, aunque sólo uno puede estar activo durante la ejecución del sistema.

> d. ¿Dónde se encuentra ubicado dentro del File System?

/boot

---
#### 5. Intérprete de comandos (Shell):

> a. ¿Qué es?

El shell es un programa que actúa como interfaz para comunicar al usuario con el sistema operativo mediante una ventana que espera comandos textuales ingresados por el usuario
en el teclado, los interpreta y los entrega al SO para su ejecución. La respuesta del SO es
mostrada al usuario en la misma ventana. A continuación, la shell queda esperando más
instrucciones. Se interactúa con la información de la manera más simple posible, sin
gráficas, solo el texto.

> b. ¿Cuáles son sus funciones?

Comunicar al usuario con el sistema operativo.


> c. Mencione al menos 3 intérpretes de comandos que posee GNU/Linux y compárelos entre ellos.

- /bin/sh: Bourne Shell. Está disponible en todas las versiones de UNIX y es lo suficientemente básico como para que funcione en todas las plataformas.
- /bin/csh: Debe su nombre al lenguaje de programación C (al hacer scripts, puede utilizarse una sintaxis similar a la de C). Estándar en los BSD y derivados.
- /bin/ksh: Korn Shell; estándar de SYSV. Maneja un historial de comandos. Basado en sh, con agregados para hacerlo más amigable.
- /bin/bash: Bourne Again Shell. Uno de los shells más avanzados y populares en GNU/Linux. Tiene licencia GNU. Ofrece las mismas capacidades que csh, pero incluye funciones avanzadas: un historial de los comandos ejecutados, que se conserva incluso al pasar de una sesión a otra, accesible utilizando los cursores (arriba/abajo), autocompletado de nombres de comandos o archivos presionando TAB, manejo de varios tipos de redirecciones de entrada/salida.
- /bin/zsh: Se diseñó para poder usarse interactivamente. Se le han incorporado muchas de las características principales de otras shells de Unix como bash, ksh y además posee características propias originales. macOS Catalina, lanzada en octubre de 2019 adoptó a Zsh como la shell predeterminada, reemplazando a Bash.

> d. ¿Dónde se ubican (path) los comandos propios y externos al Shell?

Los comandos propios al shell son funciones integradas directamente en el proceso del shell. Los externos generalmente en /bin, /usr/bin, /sbin o /usr/sbin, que deben estar incluidos en la variable de entorno $PATH para ser accesibles desde el shell.

> e. ¿Por qué considera que el Shell no es parte del Kernel de GNU/Linux?

El shell comunica al usuario con el sistema operativo, entonces no es parte del kernel, sino que lo hace accesible al usuario.

> f. ¿Es posible definir un intérprete de comandos distinto para cada usuario? ¿Desde dónde se define? ¿Cualquier usuario puede realizar dicha tarea?

La shell es iniciada por un proceso denominado “login”, y dado que cada usuario tiene asignado una shell por defecto, la misma se inicia cada vez que un usuario comienza a trabajar en su estación de trabajo (es decir se “loguea” en una terminal). Dentro del contenido del archivo /etc/passwd, se puede ver cual es la shell que cada usuario tiene asignada por defecto.

---
#### 6. El sistema de Archivos (File System) en Linux:

> a. ¿Qué es?

Es la forma en la que se organizan y administran los archivos. Esto abarca:
- Métodos de acceso: cómo se acceden los datos contenidos en el archivo.
- Manejo de archivos: cómo actúan los mecanismos para almacenar, referenciar, compartir y proteger los archivos.
- Manejo de la memoria secundaria: Cómo se administra el espacio para los archivos en memoria secundaria.
- Mecanismos de integridad: con qué métodos se garantiza la incorruptibilidad del archivo.

> b. ¿Cuál es la estructura básica de los File System en GNU/Linux? Mencione los directorios más importantes e indique qué tipo de información se encuentra en ellos. ¿A qué hace referencia la sigla FHS?

En el momento de instalación GNU/Linux crea una estructura de directorios básica, definida por la Filesystem Hierarchy Standard Group llamada Filesystem Hierarchy Standard (FHS).
FHS define los directorios principales y sus contenidos en el sistema operativo GNU/Linux y otros sistemas de la familia Unix. Se diseñó originalmente en 1994 para estandarizar el sistema de archivos de las distribuciones GNU/Linux, basándose en la tradicional organización de directorios de los sistemas Unix. En 1995 se amplió el ámbito del estándar a cualquier Unix que se adhiriese voluntariamente. Todos los archivos y directorios aparecen bajo el directorio raíz /, aunque se encuentre en distintos dispositivos físicos.
Ejemplos de directorios definidos por FHS incluyen:
- /: tope de la estructura de directorios.
- /var: información que varía de tamaño.
- /usr: aplicaciones de usuarios.
- /bin: bin es la abreviación de binaries, o ejecutables. Es donde residen la mayoría de los programas esenciales del sistema, como cp, ls y mv. Por ejemplo, cuando se usa la orden cp, se está ejecutando el programa /bin/cp.
- /dev: Los archivos en /dev son conocidos como controladores de dispositivo (device drivers) son usados para acceder a los dispositivos del sistema y recursos, como discos duros, memoria, etc.
- /etc: contiene una serie de archivos de configuración del sistema. Estos incluyen /etc/passwd (la base de datos de usuarios), /etc/rc (scripts de inicialización del sistema), etc.
- /sbin: se usa para almacenar programas esenciales del sistema, que usará el administrador del sistema.
- /home: contiene los directorios "home" de los usuarios. Por ejemplo, /home/ISO_CSO es el directorio del usuario ISO_CSO.

> c. Mencione sistemas de archivos soportados por GNU/Linux.

El adoptado por GNU/Linux es el Extended: ext2, ext3 o ext4. Aunque también soporta XFS, Btrfs, JFS, ReiserFS, entre otros.

> d. ¿Es posible visualizar particiones del tipo FAT y NTFS (que son de Windows) en GNU/Linux?

Para formatos de otras plataformas como NTFS, FAT32, exFAT, HFS+ y ZFS GNU/Linux proporciona acceso de lectura y escritura (puede ser mediante módulos del kernel o herramientas externas).

---
#### 7. Particiones:

> a. Definición. Tipos de particiones. Ventajas y Desventajas.


> b. ¿Cómo se identifican las particiones en GNU/Linux? (Considere discos IDE, SCSI y SATA).


> c. ¿Cuántas particiones son necesarias como mínimo para instalar GNU/Linux? Nómbrelas indicando tipo de partición, identificación, tipo de File System y punto de montaje.


> d. Dar ejemplos de diversos casos de particionamiento dependiendo del tipo de tarea que se deba realizar en su sistema operativo.


> e. ¿Qué tipo de software para particionar existe? Menciónelos y compare.

---
#### 8. Arranque (bootstrap) de un Sistema Operativo:

> a. ¿Qué es el BIOS? ¿Qué tarea realiza?


> b. ¿Qué es UEFI? ¿Cuál es su función?


> c. ¿Qué es el MBR? ¿Qué es el MBC?


> d. ¿A qué hacen referencia las siglas GPT? ¿Qué sustituye? Indique cuál es su formato.


> e. ¿Cuál es la funcionalidad de un “Gestor de Arranque”? ¿Qué tipos existen? ¿Dónde se instalan? Cite gestores de arranque conocidos.


> f. ¿Cuáles son los pasos que se suceden desde que se prende una computadora hasta que el Sistema Operativo es cargado (proceso de bootstrap)?


> g. Analice el proceso de arranque en GNU/Linux y describa sus principales pasos.


> h. ¿Cuáles son los pasos que se suceden en el proceso de parada (shutdown) de GNU/Linux?


> i. ¿Es posible tener en una PC GNU/Linux y otro Sistema Operativo instalado? Justifique.

---
#### 9. Archivos y editores:

> a. ¿Cómo se identifican los archivos en GNU/Linux?


> b. Investigue el funcionamiento de los editores vim, nano y mcedit, y los comandos cat, more y less.


> c. Cree un archivo llamado “prueba.exe” en su directorio personal usando el vim. El mismo debe contener su número de alumno y su nombre.


> d. Investigue el funcionamiento del comando file. Pruébelo con diferentes archivos. ¿Qué diferencia nota?


> e. Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con el uso de archivos:
> i. cd
> ii. mkdir
> iii. rmdir
> iv. ln
> v. tail
> vi. locate
> vii. ls
> viii. pwd
> ix. cp
> x. mv
> xi. find

---

#### 10. Indique qué comando es necesario utilizar para realizar cada una de las siguientes acciones. Investigue su funcionamiento y parámetros más importantes:

> a. Cree la carpeta ISOCSO

```bash
mkdir ISOCSO
```


> b. Acceda a la carpeta

```bash
cd ISOCSO
```

> c. Cree dos archivos con los nombres isocso.txt e isocso.csv

```bash
touch isocso.txt isocso.csv
```

> d. Liste el contenido del directorio actual

```bash
ls
```

> e. Visualizar la ruta donde estoy situado

```bash
pwd
```

> f. Busque todos los archivos en los que su nombre contiene la cadena “iso*”

```bash
find iso*
```

> g. Informar la cantidad de espacio libre en disco

```bash
df / -h
```

> h. Verifique los usuarios conectados al sistema

```bash
who
```

> i. Editar a el archivo isocso.txt e ingresar Nombre y Apellido

```bash
echo Gonzalo > isocso.txt
echo Gil >> isocso.txt
```

> j. Mostrar en pantalla las últimas líneas de un archivo.

```bash
tail isocso.txt
```

---
#### 11. Investigue el funcionamiento, parámetros y ubicación (directorio) de los siguientes comandos:

```bash
whatis [comando]
which [comando]
```

> ➔ man

Manual para el funcionamiento de comandos.
/usr/bin/man.

> ➔ shutdown

Halt, power off or reboot the machine.
/usr/sbin/shutdown

> ➔ reboot

Halt, power off or reboot the machine.
/usr/sbin/reboot

> ➔ halt

Halt, power off or reboot the machine.
/usr/sbin/halt

> ➔ uname

Print system information.
/usr/bin/uname

> ➔ dmesg

Print or control kernel ring buffer.
/usr/bin/dmesg

> ➔ lspci

List all PCI devices.
/usr/bin/lspci

> ➔ at

Queue, examine or delete jobs for later execution.
/usr/bin/at

> ➔ netstat

Print network connections, routing tables, interface statistics, masquerade connections, and multicast memberships.
/usr/bin/netstat

> ➔ head

Output the first part of files (default 10 líneas). 
/usr/bin/head

> ➔ tail

Output the last part of files (default 10 líneas).
/usr/bin/tail

---
#### 12. Procesos:

> a. ¿Qué es un proceso? ¿A que hacen referencia las siglas PID y PPID? ¿Todos los procesos tienen estos atributos en GNU/Linux? Justifique. Indique qué otros atributos tiene un proceso.


> b. Investigue el funcionamiento, parámetros y ubicación (directorio) de los siguientes comandos relacionados a procesos. En caso de que algún comando no venga por defecto en la distribución que utiliza deberá proceder a instalarlo:
> i. top
> ii. htop
> iii. ps
> iv. pstree
> v. kill
> vi. pgrep
> vii. pkill
> viii. killall
> ix. renice
> x. xkill
> xi. atop
> xii. nice

---
#### 13. Proceso de Arranque SystemV (https://github.com/systeminit/si):

> a. Enumere los pasos del proceso de inicio de un sistema GNU/Linux, desde que se prende la PC hasta que se logra obtener el login en el sistema.


> b. Proceso INIT. ¿Quién lo ejecuta? ¿Cuál es su objetivo?


> c. RunLevels. ¿Qué son? ¿Cuál es su objetivo?


> d. ¿A qué hace referencia cada nivel de ejecución según el estándar? ¿Dónde se defi ne qué Runlevel ejecutar al iniciar el sistema operativo? ¿Todas las distribuciones respetan estos estándares?


> e. Archivo /etc/inittab. ¿Cuál es su fi nalidad? ¿Qué tipo de información se almacena en el? ¿Cuál es la estructura de la información que en él se almacena?


> f. Suponga que se encuentra en el runlevel \<X>. Indique qué comando(s) deberá ejecutar para cambiar al runlevel \<Y>. ¿Este cambio es permanente? ¿Por qué?


> g. Scripts RC. ¿Cuál es su finalidad? ¿Dónde se almacenan? Cuando un sistema GNU/Linux arranca o se detiene se ejecutan scripts, indique cómo determina qué script ejecutar ante cada acción. ¿Existe un orden para llamarlos? Justifique.

---
#### 14. SystemD (https://github.com/systemd/systemd):


> a. ¿Qué es systemd?


> b. ¿A qué hace referencia el concepto de Unit en SystemD?


> c. ¿Para qué sirve el comando systemctl en SystemD?


> d. ¿A qué hace referencia el concepto de target en SystemD?


> e. Ejecutar el comando pstree. ¿Qué es lo que se puede observar a partir de la ejecución de este comando?

---
#### 15. Usuarios:

> a. ¿Qué archivos son utilizados en un sistema GNU/Linux para guardar la información de los usuarios?
>

> b. ¿A qué hacen referencia las siglas UID y GID? ¿Pueden coexistir UIDs iguales en un sistema GNU/Linux? Justifique.


> c. ¿Qué es el usuario root? ¿Puede existir más de un usuario con este perfi l en GNU/Linux? ¿Cuál es la UID de root?


> d. Agregue un nuevo usuario llamado isocso a su instalación de GNU/Linux, especifi que que su home sea creada en /home/isocso, y hágalo miembro del grupo informatica (si no existe, deberá crearlo). Luego, sin iniciar sesión como este usuario cree un archivo en su home personal que le pertenezca. Luego de todo esto, borre el usuario y verifi que que no queden registros de él en los archivos de información de los usuarios y grupos.


> e. Investigue la funcionalidad y parámetros de los siguientes comandos:
> i. useradd y adduser
> ii. usermod
> iii. userdel
> iv. su
> v. groupadd
> vi. who
> vii. groupdel
> viii. passwd

---
#### 16. FileSystem y permisos:

> a. ¿Cómo son definidos los permisos sobre archivos en un sistema GNU/Linux?


> b. Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con los permisos en GNU/Linux:
> i. chmod
> ii. chown
> iii. chgrp


> c. Al utilizar el comando chmod generalmente se utiliza una notación octal asociada para definir permisos. ¿Qué significa esto? ¿A qué hace referencia cada valor?


>d. ¿Existe la posibilidad de que algún usuario del sistema pueda acceder a determinado archivo para el cual no posee permisos? Indiquelo y realice las pruebas correspondientes.


> e. Explique los conceptos de “full path name” (path absoluto) y “relative path name” (path relativo). De ejemplos claros de cada uno de ellos.


> f. ¿Con qué comando puede determinar en qué directorio se encuentra actualmente? ¿Existe alguna forma de ingresar a su directorio personal sin necesidad de escribir todo el path completo? ¿Podría utilizar la misma idea para acceder a otros directorios? ¿Cómo? Explique con un ejemplo.


> g. Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con el uso del FileSystem:
> i. umount
> ii. du
> iii. df
> iv. mount
> v. mkfs
> vi. fdisk (con cuidado)
> vii. write
> viii. losetup
> ix. stat

---
#### 17. Procesos:

> a. ¿Qué significa que un proceso se está ejecutando en Background? ¿Y en Foreground?


> b. ¿Cómo puedo hacer para ejecutar un proceso en Background? ¿Como puedo hacer para pasar un proceso de background a foreground y viceversa?


> c. Pipe ( | ). ¿Cuál es su finalidad? Cite ejemplos de su utilización.


> d. Redirección. ¿Qué tipo de redirecciones existen? ¿Cuál es su finalidad? Cite ejemplos de utilización.

---
#### 18. Otros comandos de Linux (Indique funcionalidad y parámetros):

> a. ¿A qué hace referencia el concepto de empaquetar archivos en GNU/Linux?


> b. Seleccione 4 archivos dentro de algún directorio al que tenga permiso y sume el tamaño de cada uno de estos archivos. Cree un archivo empaquetado conteniendo estos 4 archivos y compare los tamaños de los mismos. ¿Qué característica nota?


> c. ¿Qué acciones debe llevar a cabo para comprimir 4 archivos en uno solo? Indique la secuencia de comandos ejecutados.


> d. ¿Pueden comprimirse un conjunto de archivos utilizando un único comando?


> e. Investigue la funcionalidad de los siguientes comandos:
> i. tar
> ii. grep
> iii. gzip
> iv. zgrep
> v. wc

---
#### 19. Indique qué acción realiza cada uno de los comandos indicados a continuación considerando su orden. Suponga que se ejecutan desde un usuario que no es root ni pertenece al grupo de root. (Asuma que se encuentra posicionado en el directorio de trabajo del usuario con el que se logueó). En caso de no poder ejecutarse el comando, indique la razón:

```bash
l s −l > prueba
ps > PRUEBA
chmod 710 prueba
chown root:root PRUEBA
chmod 777 PRUEBA
chmod 700 /etc/passwd
passwd root
rm PRUEBA
man /etc/shadow
find / −name ∗ .conf
usermod root −d /home/ newroot −L
cd / root
rm ∗
cd / etc
cp ∗ /home −R
shutdown
```

---
#### 20. Indique qué comando sería necesario ejecutar para realizar cada una de las siguientes acciones:

> a. Terminar el proceso con PID 23.


> b. Terminar el proceso llamado init o systemd. ¿Qué resultados obtuvo?


> c. Buscar todos los archivos de usuarios en los que su nombre contiene la cadena “.conf”


> d. Guardar una lista de procesos en ejecución el archivo /home/\<su nombre de usuario>/procesos


> e. Cambiar los permisos del archivo /home/\<su nombre de usuario>/xxxx a:
> i. Usuario: Lectura, escritura, ejecución
> ii. Grupo: Lectura, ejecución
> iii. Otros: ejecución


> f. Cambiar los permisos del archivo /home/\<su nombre de usuario>/yyyy a:
> i. Usuario: Lectura, escritura.
> ii. Grupo: Lectura, ejecución
> iii. Otros: Ninguno


> g. Borrar todos los archivos del directorio /tmp


> h. Cambiar el propietario del archivo /opt/isodata al usuario isocso


> i. Guardar en el archivo /home/\<su nombre de usuario>/donde el directorio donde me encuentro en este momento, en caso de que el archivo exista no se debe eliminar su contenido anterior.

---
#### 21. Indique qué comando sería necesario ejecutar para realizar cada una de las siguientes acciones:

> a. Ingrese al sistema como usuario “root”


> b. Cree un usuario. Elija como nombre, por convención, la primera letra de su nombre seguida de su apellido. Asígnele una contraseña de acceso.


> c. ¿Qué archivos fueron modificados luego de crear el usuario y qué directorios se crearon?


> d. Crear un directorio en /tmp llamado miCursada


> e. Copiar todos los archivos de /var/log al directorio antes creado.


> f. Para el directorio antes creado (y los archivos y subdirectorios contenidos en él) cambiar el propietario y grupo al usuario creado y grupo users.


> g. Agregue permiso total al dueño, de escritura al grupo y escritura y ejecución a todos los demás usuarios para todos los archivos dentro de un directorio en forma recursiva.


> h. Acceda a otra terminal para loguearse con el usuario antes creado.


> i. Una vez logueado con el usuario antes creado, averigüe cuál es el nombre de su terminal.


> j. Verifique la cantidad de procesos activos que hay en el sistema.


> k. Verifiqué la cantidad de usuarios conectados al sistema.


> l. Vuelva a la terminal del usuario root y envíele un mensaje al usuario anteriormente creado enviándole que el sistema va a ser apagado.


> m. Apague el sistema.

---
