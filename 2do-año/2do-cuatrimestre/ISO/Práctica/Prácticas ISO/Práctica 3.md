#### 1. ¿Qué es el Shell Scripting? ¿A qué tipos de tareas están orientados los script? ¿Los scripts deben compilarse? ¿Por qué?


---
#### 2. Investigar la funcionalidad de los comandos echo y read.
a. ¿Cómo se indican los comentarios dentro de un script?
b. ¿Cómo se declaran y se hace referencia a variables dentro de un script?

---
#### 3. Crear dentro del directorio personal del usuario logueado un directorio llamado practica-shell-script y dentro de él un archivo llamado mostrar.sh cuyo contenido sea el siguiente:

```bash
#!/bin/bash
# Comentarios acerca de lo que hace el script
# Siempre comento mis scripts, si no lo hago hoy,
# mañana ya no me acuerdo de lo que quise hacer
echo "Introduzca su nombre y apellido:"
read nombre apellido
echo "Fecha y hora actual:"
date
echo "Su apellido y nombre es:"
echo "$apellido $nombre"
echo "Su usuario es: `whoami`"
echo "Su directorio actual es: `pwd`"
```

> a. Asignar al archivo creado los permisos necesarios de manera que pueda ejecutarlo. 
```bash
chmod 764 mostrar.sh
```
> b. Ejecutar el archivo creado de la siguiente manera: ./mostrar
> c. ¿Qué resultado visualiza?
```
Introduzca su nombre y apellido:  
g g  
Fecha y hora actual:  
mar 21 oct 2025 09:37:01 -03  
Su apellido y nombre es:  
g g  
Su usuario es: gonzalo  
Su directorio actual es: /home/gonzalo/practica-shell-script
```
> d. Las backquotes (\`) entre el comando whoami ilustran el uso de la sustitución de comandos. ¿Qué significa esto?
> e. Realizar modificaciones al script anteriormente creado de manera de poder mostrar distintos resultados (cuál es su directorio personal, el contenido de un directorio en particular, el espacio libre en disco, etc.). Pida que se introduzcan por teclado (entrada estándar) otros datos.

---
#### 4. Parametrización: ¿Cómo se acceden a los parámetros enviados al script al momento de su invocación? ¿Qué información contienen las variables $#, $\*, $? y $HOME dentro de un script?

**$#**: cántidad de parámetros. 
**$\***: todos los parámetros, en orden.
**$?**: estado de salida del último comando ejecutado. Si es = 0, exitoso, si no, hubo algún error.
**$HOME**: ruta home del usuario actual. Por ejemplo /home/usuario.

---
#### 5. ¿Cual es la funcionalidad de comando exit? ¿Qué valores recibe como parámetro y cuál es su significado?

Finaliza el proceso shell con un estado N recibido por parámetro.

---
#### 6. El comando expr permite la evaluación de expresiones. Su sintaxis es: expr arg1 op arg2, donde arg1 y arg2 representan argumentos y op la operación de la expresión. Investigar que tipo de operaciones se pueden utilizar.

---
#### 7. El comando test expresion permite evaluar expresiones y generar un valor de retorno, true o false. Este comando puede ser reemplazado por el uso de corchetes de la siguiente manera \[ expresión ]. Investigar qué tipo de expresiones pueden ser usadas con el comando test. Tenga en cuenta operaciones para: evaluación de archivos, evaluación de cadenas de caracteres y evaluaciones numéricas.

---
#### 8. Estructuras de control. Investigue la sintaxis de las siguientes estructuras de control incluidas en shell scripting:
> ➢ if
> ➢ case
> ➢ while
> ➢ for
> ➢ select
---
#### 9. ¿Qué acciones realizan las sentencias break y continue dentro de un bucle? ¿Qué parámetros reciben?

---
#### 10. ¿Qué tipo de variables existen? ¿Es shell script fuertemente tipado? ¿Se pueden definir arreglos? ¿Cómo?

---
#### 11. ¿Pueden definirse funciones dentro de un script? ¿Cómo? ¿Cómo se maneja el pasaje de parámetros de una función a la otra?

---
#### 12. Evaluación de expresiones.
> a. Realizar un script que le solicite al usuario 2 números, los lea de la entrada Standard e imprima la multiplicación, suma, resta y cual es el mayor de los números leídos.
> 
> b. Modificar el script creado en el inciso anterior para que los números sean