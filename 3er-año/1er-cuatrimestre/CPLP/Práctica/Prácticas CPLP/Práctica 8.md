# Estructuras de control y sentencias
**Objetivo:** reconocer las diferencias entre las implementaciones de las estructuras de control de los distintos lenguajes.

### Ejercicio 1
Una sentencia puede ser simple o compuesta, ¿Cuál es la diferencia?

- **Sentencia Simple:** Es una instrucción única y autónoma que expresa una sola acción a ser ejecutada por el procesador (por ejemplo, una sentencia de asignación o la invocación a un subprograma). No contiene otras sentencias anidadas en su estructura.
- **Sentencia Compuesta (o Bloque):** Es una agrupación de múltiples sentencias (que también puede incluir declaraciones de variables locales) encapsuladas lógicamente para que el compilador o intérprete las trate como si fueran **una única sentencia**. Para agruparlas, los lenguajes de programación exigen el uso de delimitadores sintácticos explícitos, como las llaves `{ ... }` en lenguajes derivados de C, o las palabras clave `begin ... end` en Pascal.
---
### Ejercicio 2
Analice como C implementa la asignación.

El lenguaje **C implementa la asignación de una manera particular: la define como una "expresión con efectos colaterales"**. A diferencia de muchos otros lenguajes convencionales que distinguen estrictamente entre una sentencia de asignación (que solo produce un cambio en la memoria) y una expresión (que devuelve un valor al combinarse con operadores), en C la asignación hace ambas cosas de forma simultánea.
Esta característica de diseño permite comportamientos específicos en el lenguaje:
- **Asignaciones múltiples:** Debido a que la asignación devuelve el r-valor (el valor asignado), es posible encadenar operaciones como `a = b = c = 0;`. En C, **el operador de asignación asocia de derecha a izquierda**. Por lo tanto, primero asigna el valor `0` a la variable `c` y devuelve `0`; luego asigna ese `0` a la variable `b` y devuelve `0`, y finalmente se lo asigna a la variable `a`.
- **Asignaciones dentro de condicionales:** Al ser una expresión que retorna un valor, C permite utilizar asignaciones donde normalmente iría una condición, como en `if (i = 30)`. En este caso, el lenguaje no está comparando (ya que la comparación en C se hace con `==`), sino que primero asigna el valor `30` a la variable `i` y luego evalúa ese `30`. Como cualquier valor distinto de 0 se considera verdadero (`true`), la condición se cumplirá siempre.
- **Restricción obligatoria de L-valor:** A pesar de ser tratada como una expresión, la implementación exige rígidamente que **del lado izquierdo del operador de asignación exista siempre un l-valor** (una dirección de memoria válida capaz de almacenar datos), y nunca un r-valor. Por ejemplo, una instrucción como `++p = *q;` generará un error de compilación en C, porque la operación previa `++p` devuelve un r-valor (el resultado de sumar 1), el cual no puede actuar como receptor de una nueva asignación.
---
### Ejercicio 3
¿Una expresión de asignación puede producir efectos laterales que afecten al resultado final, dependiendo de cómo se evalúe? De ejemplos.

**Sí, absolutamente.** Una expresión de asignación puede producir efectos laterales (o colaterales) que alteren drásticamente el resultado de un programa si el orden en que el procesador evalúa sus componentes no está rígidamente definido por el lenguaje, o si el programador asume un orden incorrecto.
En lenguajes como C, **la asignación no es solo una instrucción que guarda un dato, sino que es tratada como una "expresión con efectos colaterales"**. Esto significa que, además de modificar el espacio de memoria (efecto colateral principal), la operación **devuelve un valor** (el _r-valor_ asignado) que puede ser utilizado inmediatamente por otra parte de la misma instrucción.
Ejemplos clásicos de efectos laterales dependientes de la evaluación:

**1. El orden de evaluación de los operandos (Izquierda vs. Derecha)** Imagina la siguiente expresión donde se utiliza el operador de post-incremento (que en sí mismo es un efecto colateral, ya que suma 1 a la variable): `A[i] = i++;`
- **Si se evalúa primero el lado izquierdo (L-valor):** El procesador determina que la dirección destino es `A[i]` (con el valor original de `i`). Luego evalúa el lado derecho, obtiene el valor de `i`, lo asigna a `A[i]`, y finalmente incrementa `i`.
- **Si se evalúa primero el lado derecho (R-valor):** El procesador evalúa `i++`, obtiene el valor original de `i` para la asignación, pero **el efecto colateral incrementa** **i** **inmediatamente**. Cuando luego va a evaluar el lado izquierdo para saber dónde guardar el dato, evalúa `A[i]` pero con la `i` ya incrementada, guardando el dato en la siguiente celda del arreglo. _(Nota: En C clásico, el comportamiento de esta instrucción es "indefinido" justamente porque el estándar no obliga al compilador a priorizar un lado sobre el otro)._

**2. Asignaciones múltiples y la asociatividad** En lenguajes que permiten asignaciones en cadena, el resultado depende de la regla de asociatividad del operador de asignación. `a = b = c = 0;`
- En C, esta expresión **se evalúa de derecha a izquierda**. Primero, ocurre el efecto colateral de asignar `0` a `c`, y esa subexpresión devuelve el valor `0`. Luego, ese `0` es el _r-valor_ que se le asigna a `b`, devolviendo `0`. Finalmente, ese `0` se le asigna a `a`. Si el lenguaje evaluara de izquierda a derecha, la expresión fallaría (intentaría asignar `b` a `a` antes de que `b` tenga un valor definido).

**3. Efectos laterales a través de llamadas a funciones en la misma expresión** Supongamos que tenemos una variable global `x = 1`, y una función `Modificar()` que hace `x = x + 5` y retorna `x`. ¿Qué ocurre si ejecutamos la siguiente asignación? `resultado = x + Modificar();`
- **Si evalúa de izquierda a derecha:** Lee `x` (vale 1). Luego llama a `Modificar()` (que sube `x` a 6 y retorna 6). `resultado = 1 + 6 = 7`.
- **Si evalúa de derecha a izquierda:** Llama primero a `Modificar()` (sube `x` a 6 y retorna 6). Luego lee la variable `x` para el primer término de la suma (pero por el efecto lateral de la función, `x` ahora vale 6). `resultado = 6 + 6 = 12`.

**Conclusión:** Los lenguajes que permiten tratar a la asignación como una expresión y permiten incrustar funciones o incrementos dentro de sentencias matemáticas, exponen al programa a que los **efectos laterales silenciosos** dependan exclusivamente del orden de evaluación que aplique el compilador.

---
### Ejercicio 4
Qué significa que un lenguaje utilice circuito corto o circuito largo para la evaluación de una expresión. De un ejemplo en el cual por un circuito de error y por el otro no.

1. Evaluación por Circuito Corto (Short-Circuit o Evaluación Perezosa)
   Es una técnica utilizada en la evaluación de expresiones booleanas (operadores `AND` y `OR`) donde los operandos se analizan de izquierda a derecha, **pero la evaluación se detiene inmediatamente en cuanto se determina el resultado final** de la expresión completa. En ese punto, el resto de los operandos son ignorados.
   - **En una conjunción (_AND / y_):** Este operador da como resultado verdadero únicamente si ambos términos lo son. Por lo tanto, si se evalúa el primer término y resulta ser **Falso**, el resultado final será inexorablemente falso, por lo que **no es necesario evaluar el segundo término**.
   - **En una disyunción (_OR / o_):** Este operador da como resultado falso solo si ambos términos lo son. Si se evalúa el primer término y resulta ser **Verdadero**, la expresión ya está cumplida, por lo que **no es necesario evaluar el segundo término**.

**Ejemplo clásico de su utilidad (Evitar errores fatales en C):**
```
int x = 0;
int division_segura() {
    return (x != 0) && (10 / x); 
}
```
En este código, el lenguaje C aplica circuito corto. Como `x == 0`, la condición `(x != 0)` es **Falsa**. El procesador detiene la evaluación ahí mismo y jamás ejecuta la operación matemática `(10 / x)`, salvando al programa de arrojar un error de división por cero.
Python también utiliza esta evaluación perezosa. Por ejemplo, en una validación encadenada como `if a() and b() and c() and d():`, si la función `c()` retorna `False`, el flujo se corta ahí y la función `d()` nunca será invocada.

2. Evaluación por Circuito Largo
   Por el contrario, el circuito largo significa que **todos y cada uno de los operandos se evalúan siempre**, sin importar si el valor del primer operando ya determinaba el resultado final de la expresión.
   Bajo este esquema estricto, si utilizáramos el ejemplo anterior de la división segura, el programa siempre fallaría. Al evaluar obligatoriamente ambos lados del `AND`, intentaría ejecutar la división `(10 / 0)` a pesar de que la primera comprobación ya indicaba que la variable valía cero.

---
### Ejercicio 5
¿Qué regla define Delphi, Ada y C para la asociación del else con el if correspondiente? ¿Cómo lo maneja Python?

1. C y Delphi (basado en Pascal): Estos lenguajes resuelven la ambigüedad aplicando la regla de emparejamiento cercano. La regla dicta que **cada** **else** **se empareje con la instrucción** **if** **solitaria más próxima buscando de derecha a izquierda**. Es decir, el compilador empareja cada `else` para cerrar al último `if` que haya quedado abierto. Aunque esto elimina la ambigüedad sintáctica, la bibliografía advierte que puede generar problemas de claridad y legibilidad para el programador, especialmente si el programa se escribe sin respetar una sangría adecuada.

2. Ada: Para evitar los problemas de legibilidad que sufren C y Pascal, Ada aplica una regla distinta orientada al diseño seguro: **exige el uso de sentencias de cierre explícitas para el bloque condicional** **if**. En este lenguaje, cada bloque de selección debe cerrarse obligatoriamente con la palabra reservada **end if**. Esto elimina de raíz cualquier confusión sobre a qué `if` pertenece un `else` o dónde termina el bloque anidado.

3. Python: Python maneja la asociación de bloques de manera muy particular al no utilizar llaves ni palabras de cierre explícitas. Este lenguaje se basa estrictamente en la **indentación (sangría) obligatoria** del código. En Python, un `else` se asociará de forma automática y visual al `if` que se encuentre exactamente en su **mismo nivel de indentación**. Todo el "cuerpo" de sentencias que pertenece a una bifurcación debe estar indentado hacia la derecha; si una línea no está indentada correctamente, el lenguaje no la considerará parte de la estructura.

---
### Ejercicio 6
¿Cuál es la construcción para expresar múltiples selección que implementa C? ¿Trabaja de la misma manera que la de Pascal, ADA o Python?

El lenguaje C implementa la selección múltiple a través de la construcción **switch-case**. Su característica de diseño más peculiar (y peligrosa) es el comportamiento conocido como **"fall-through"** (caída libre). En C, cuando el procesador encuentra una etiqueta `case` que coincide con el valor evaluado, comienza a ejecutar las sentencias desde ese punto **y continúa ejecutando todos los** **case** **de abajo secuencialmente**, a menos que el programador escriba explícitamente la sentencia `break` para forzar la salida de la estructura.

Los demás lenguajes diseñaron alternativas más seguras para evitar los clásicos errores lógicos que genera el olvido de un `break` en C.

- **ADA***: Implementa la selección múltiple mediante la estructura **case ... is ... when**. Trabaja de forma mucho más robusta y segura que C:
    - **Mutuamente excluyente:** No existe el _fall-through_. Cada bloque `when` se ejecuta de forma aislada y la estructura termina automáticamente sin necesidad de un `break`.
    - **Mayor expresividad:** Permite agrupar selecciones especificando rangos (por ejemplo, `when MIE..VIE =>`) o listas de alternativas en una misma línea (por ejemplo, `when MAR | SAB =>`).
    - **Exhaustividad estricta:** ADA obliga en tiempo de compilación a que todos los posibles valores del tipo evaluado estén contemplados en las ramas. Si las etiquetas no abarcan todo el dominio, es obligatorio el uso explícito de la cláusula de descarte **when others =>** para evitar errores.
- **Pascal**: Implementa la estructura **case ... of**. Al igual que en ADA, su evaluación es segura: cada rama es independiente, no hay _fall-through_ y la ejecución del bloque finaliza automáticamente tras ejecutar la sentencia coincidente. También permite el uso de subrangos (ej. `1..5`).
- **Python**: Históricamente, Python tomó la decisión de diseño de **no incluir** una estructura `switch-case`, promoviendo en su lugar el uso de secuencias lógicas `if-elif-else` o el mapeo a través de diccionarios (Hash) para simular el mismo comportamiento. _(Nota: Recientemente, en Python 3.10, se introdujo la sintaxis_ _match-case, pero funciona bajo el paradigma de "Pattern Matching" o coincidencia de patrones estructurales, lo cual es mucho más avanzado, seguro y estricto que un simple_ _switch_ _de C, y tampoco utiliza fall-through)._
---
### Ejercicio 7
Sea el siguiente código:
```pascal
.....
var i, z:integer;
	Procedure A;
	begin
		i:= i +1;
	end;
begin
	z:=5;
	for i:=1..5 do begin
		z:=z*5;
		A;
		z:=z + i;
	end;
end;
```
- **a-** Analice en las versiones estándar de ADA y Pascal, si este código puede llegar a traer problemas. Justifique la respuesta.
- **b-** Comente qué sucedería con las versiones de Pascal y ADA, que Ud. utilizó.
---
### Ejercicio 8
Sea el siguiente código en Pascal:
```pascal
var puntos: integer;
begin
	...
	case puntos
	1..5: write(“No puede continuar”);
	10:write(“Trabajo terminado”)
end;
..
```
Analice, si esto mismo, con la sintaxis correspondiente, puede trasladarse así a los lenguajes ADA, C. ¿Provocaría error en algún caso? Diga cómo debería hacerse en cada lenguaje y explique el por qué. Codifíquelo.

1. Traslado al lenguaje ADA

**¿Provocaría error?** Sí, provocaría un **error de compilación**. **¿Por qué?** ADA posee reglas mucho más estrictas para la selección múltiple. El lenguaje exige obligatoriamente que el `case` contemple **todos los valores posibles** que puede tomar la expresión evaluada (en este caso, todo el dominio de los números enteros). Como las etiquetas `1..5` y `10` no abarcan todos los enteros, el compilador rechazará el código a menos que se agregue explícitamente la rama **when others =>** para manejar el descarte.

**Codificación correcta en ADA:**

```ADA
case puntos is
    when 1..5 => 
        Put_Line("No puede continuar"); -- ADA permite especificar rangos con ..
    when 10 => 
        Put_Line("Trabajo terminado");
    when others => 
        null; -- Es obligatorio capturar el resto de los valores. 'null' indica no hacer nada explícitamente.
end case;
```

---

2. Traslado al lenguaje C (y C++)

**¿Provocaría error?** Provocaría errores sintácticos si intentamos copiar el rango literalmente, y generaría un error lógico gravísimo si olvidamos alterar la estructura. **¿Por qué?**

- **Falta de rangos:** A diferencia de Pascal y ADA, en C estándar la sentencia `case` solo puede ser etiquetada por uno o más valores constantes individuales, **no soporta la sintaxis de rangos como** **1..5**. Deben enumerarse explícitamente (o agruparse apilando los `case`).
- **El problema del "Fall-Through":** En C, si la variable coincide con una etiqueta, se ejecuta ese código y **se continúa ejecutando secuencialmente el código de las ramas de abajo** a menos que coloquemos una sentencia **break;** para forzar la salida.
- **Exhaustividad opcional:** A diferencia de ADA, C no obliga a contemplar todos los valores, pero provee la cláusula `default:` (opcional) para los valores no coincidentes.

**Codificación correcta y segura en C:**

```C
switch (puntos) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5: // Agrupamos los casos individuales al no existir rangos nativos
        printf("No puede continuar");
        break; // Fundamental para evitar el fall-through
    case 10:
        printf("Trabajo terminado");
        break;
    default:
        // Opcional, recomendado por programación defensiva
        break;
}
```
---
### Ejercicio 9
Qué diferencia existe entre el generador YIELD de Python y el return de una función. De un ejemplo donde sería útil utilizarlo.

- **return** **(Finalización absoluta):** Cuando una función estándar ejecuta la sentencia `return`, entrega el valor evaluado al llamador y **termina su ejecución de forma definitiva**. A nivel semántico, su Registro de Activación se desaloja de la pila, liberando la memoria; por ende, finaliza el tiempo de vida de todas sus variables locales. Si se vuelve a llamar a la función, esta comenzará a ejecutarse desde cero en un ambiente totalmente nuevo.
- **yield** **(Pausa y preservación de estado):** Utilizar `yield` convierte a una función normal en un **generador**. Al ejecutarse la sentencia `yield`, la rutina emite un valor hacia el llamador pero **no termina, sino que se "pausa"**. Conserva intacto su Registro de Activación en memoria, recordando el valor de todas sus variables locales y la ubicación exacta de la instrucción donde se detuvo. La próxima vez que el programa solicite un valor de este generador (usualmente iterándolo o mediante la función `next()`), la rutina retoma la ejecución exactamente en la línea siguiente al último `yield`.

Ejemplo donde sería muy útil utilizar `yield`
El uso primordial de los generadores y el `yield` radica en la **eficiencia de memoria y la evaluación perezosa (_lazy evaluation_)** al manipular secuencias masivas de datos o secuencias infinitas.
**Ejemplo clásico: Lectura y procesamiento de un archivo gigantesco.** Imagina que debes buscar información dentro de un archivo de logs que pesa 50 GB.

- Si utilizaras **return**, la función se vería obligada a leer el archivo de principio a fin, guardar todas las líneas en una inmensa lista y devolver toda esa estructura junta. Esto colapsaría la memoria RAM de tu computadora inmediatamente.
- Al usar **yield**, puedes crear un generador que procese el archivo línea por línea:

```python
def procesar_log_gigante(nombre_archivo):
    archivo = open(nombre_archivo, "r")
    for linea in archivo:
        yield linea # Pausa la ejecución y entrega 1 sola línea
    archivo.close()

# En el programa principal
for log_individual in procesar_log_gigante("servidor_50GB.log"):
    if "ERROR" in log_individual:
        print("Error encontrado:", log_individual)
```

En este enfoque, **solo reside en memoria una línea a la vez**. El programa principal lee el `yield`, procesa esa línea, la descarta, y el generador reanuda la lectura para ir a buscar la siguiente, optimizando radicalmente el consumo de recursos de la máquina.

---
### Ejercicio 10
Describa brevemente la instrucción map en javascript y sus alternativas.

---
### Ejercicio 11
Determine si el lenguaje que utiliza frecuentemente implementa instrucciones para el manejo de espacio de nombres. Mencione brevemente qué significa este concepto y enuncie la forma en que su lenguaje lo implementa. Enuncie las características más importantes de este concepto en lenguajes como PHP o Python.