# Excepciones
**Objetivo:** Conocer e interpretar los distintos modelos de excepciones que implementan los lenguajes de programación.

---
### Ejercicio 1
¿Explique claramente a qué se denomina excepción?

En el contexto de los lenguajes de programación, una **excepción** se define como un evento inusual, anómalo o de error que ocurre durante la ejecución de un programa y que interrumpe o altera su flujo normal de instrucciones.
Al presentarse esta situación excepcional, el procesador suspende la ejecución secuencial y transfiere el control a un bloque de código especial diseñado específicamente para tratar ese problema, conocido como **manejador de excepciones** (o _handler_).

Las excepciones pueden originarse de dos formas principales:
- **Detectadas por el entorno o el hardware:** Como por ejemplo un intento de división por cero (`ArithmeticException`), ingresar un tipo de dato incorrecto (`ValueError`), o acceder a un índice fuera de los límites de un arreglo (`ArrayIndexOutOfBoundsException`).
- **Levantadas explícitamente por el programador:** Cuando la lógica del programa detecta una condición inválida que no permite continuar y el programador fuerza la excepción utilizando instrucciones específicas como `raise` (en Python), `throw` (en Java) o `signal` (en PL/1).
El propósito principal de conceptualizar estos eventos como "excepciones" es permitir **separar el código de la lógica principal del código dedicado al manejo de errores**. Esto permite construir software más robusto, evitando que situaciones anómalas provoquen fallos mayores en el sistema.

---
### Ejercicio 2
¿Qué debería proveer un lenguaje para el manejo de las excepciones? ¿Todos los lenguajes lo proveen?

1. ¿Qué debería proveer un lenguaje para el manejo de las excepciones?

Para que un lenguaje de programación pueda gestionar excepciones de manera completa y estructurada, debe proveerle al programador mínimamente cuatro facilidades:
- **Un modo de definirlas:** El lenguaje debe permitir declarar qué es una excepción, reconociendo tanto las implícitas (predefinidas por el propio lenguaje, como la división por cero) como las explícitas (las anomalías propias de la lógica del negocio definidas por el programador).
- **Una forma de alcanzarlas (reconocerlas y lanzarlas):** Debe existir un mecanismo explícito mediante instrucciones (como `throw`, `raise` o `signal`) para indicar en el código que ha ocurrido la condición anómala y que la ejecución normal debe interrumpirse.
- **Una forma de manejarlas (Controlador/Handler):** Debe proveer una estructura para especificar el bloque de código encargado de "atrapar" el error y ejecutar las acciones correctivas, con el objetivo de evitar que el programa se detenga abruptamente.
- **Un criterio de continuación (Punto de retorno):** Debe definir claramente a dónde se cede el control una vez que el manejador termina de atender la excepción (por ejemplo, si el programa retoma la ejecución donde falló, si continúa en la línea posterior al manejador, si propaga el error o si finaliza).

2. ¿Todos los lenguajes lo proveen?

**No, no todos los lenguajes proveen estas facilidades.**
Si bien los lenguajes modernos (como Java, Python, C++, Ada) sí incorporan estructuras especializadas para atrapar errores de manera nativa, existen otros enfoques:
- **Lenguajes que carecen del mecanismo:** Lenguajes más antiguos como C clásico o Pascal no cuentan con bloques `try-catch` nativos. Para lograr un comportamiento similar, el programador está obligado a **simular** el manejo de excepciones, por ejemplo, devolviendo códigos de error numéricos constantes en cada función o pasando procedimientos manejadores como parámetros.
- **Lenguajes que deciden no usarlas por diseño (El caso de Rust):** Rust es un lenguaje moderno que **no tiene ni maneja excepciones** de forma tradicional. Para evitar la complejidad del flujo de las excepciones, Rust agrupa los errores de otra forma: si son "recuperables" exige que se traten retornando un tipo especial llamado `Result<T, E>`, y si son "irrecuperables" utiliza la macro `panic!` para limpiar la pila e interrumpir y cerrar el programa de inmediato.

---
### Ejercicio 3
¿Qué ocurre cuando un lenguaje no provee manejo de excepciones? ¿Se podría simular? Explique cómo lo haría

1. ¿Qué ocurre cuando un lenguaje no provee manejo de excepciones?

Cuando un lenguaje de programación no incluye construcciones especiales (como `try-catch`) para el manejo de excepciones, **la responsabilidad de gestionar los errores recae íntegramente sobre el programador**.
La principal consecuencia de esto es que el código que resuelve el problema central del programa (el "camino feliz") debe mezclarse forzosamente con múltiples comprobaciones de errores en cada paso. Esto entorpece el flujo natural del programa, reduce drásticamente la legibilidad del código y aumenta las probabilidades de que el programador olvide chequear alguna condición anómala que termine provocando una falla fatal en el sistema.

2. ¿Se podría simular? ¿Cómo lo haría?

**Sí, el manejo de excepciones se puede simular** utilizando las subrutinas y las estructuras de control estándar (como la selección `if`) que provee el lenguaje.
De acuerdo con la teoría de la cátedra, esta simulación se logra de la siguiente manera:
- **Simular los Manejadores (Handlers):** En lugar de escribir un bloque estructurado con palabras reservadas como `except` o `catch`, el programador **encapsula el código de recuperación dentro de procedimientos o funciones regulares** independientes. (Por ejemplo, definiendo un `procedure Manejador_DivisionPorCero();`).
- **Simular el Lanzamiento (Throw/Raise):** Como no existe una palabra clave para disparar o levantar el error hacia un bloque superior, el programador está obligado a **intercalar sentencias condicionales (`if`) preventivas** antes de realizar acciones riesgosas.
- **Simular la Captura y el Flujo:** Si la condición del `if` se evalúa como verdadera (es decir, se detecta el error), en lugar de abortar el programa, se realiza una **invocación explícita a la subrutina que actúa como manejador** (por ejemplo: `if (m=0) then Manejador3(); else ...`).

_(Nota adicional: Otra técnica complementaria muy común al simular excepciones es diseñar los subprogramas para que devuelvan_ **códigos de error pactados** _—como retornar_ _-1_ _o_ _false_—, obligando a quien invocó la rutina a verificar siempre el valor devuelto y actuar en consecuencia).

---
### Ejercicio 4
Cuando se termina de manejar la excepción, la acción que se toma luego es importante. Indique:
1. ​¿Qué modelos diferentes existen en este aspecto?
2. ​Dé ejemplos de lenguajes que utilizan cada uno de los modelos presentados anteriormente. Por cada uno responda respecto de la forma en que trabaja las excepciones.
	1. ¿Cómo se define?
	2. ¿Cómo se lanza?
	3. ¿Cómo se maneja?
	4. ¿Cuál es su criterio de continuación?
3. ​¿Cuál de esos modelos es más inseguro y por qué?



1. **¿Qué modelos diferentes existen en este aspecto?**
   Existen dos grandes modelos de manejo de excepciones que definen a dónde se cede el control tras atrapar el error:
   - **Modelo de Reasunción:** En este modelo, el controlador de excepciones toma el mando, realiza las acciones necesarias (medidas correctivas) e inmediatamente **retoma la ejecución normal del programa a partir del punto exacto donde se produjo la excepción**.
   - **Modelo de Terminación:** En este modelo, el controlador maneja la excepción, pero **no se retorna** al punto donde ocurrió el error (invocador). En cambio, se da por finalizado y abandonado el bloque que falló, y el programa continúa su ejecución a partir de la finalización del manejador,. Este es el modelo más utilizado en la actualidad.

2. **Ejemplos de lenguajes para cada modelo**
**A. Lenguaje con modelo de REASUNCIÓN: PL/1**
- **a. ¿Cómo se define?** Posee excepciones ya predefinidas (Built-in, como `zerodivide`).
- **b. ¿Cómo se lanza?** Las excepciones se levantan mediante la instrucción `SIGNAL CONDITION nombre`.
- **c. ¿Cómo se maneja?** Se manejan mediante la instrucción `ON CONDITION nombre Manejador`. Los manejadores en PL/1 **se ligan dinámicamente** con las excepciones mediante una pila de manejadores en memoria; cuando ocurre un error, se asocia siempre con el último manejador apilado,.
- **d. Criterio de continuación:** Aplica reasunción pura; ningún proceso termina al levantar el error, sino que se atiende la anomalía y se continúa el flujo en el punto siguiente a donde se originó.

**B. Lenguajes con modelo de TERMINACIÓN: ADA** _(También aplican C++, Java, Python, PHP, etc.)_
- **a. ¿Cómo se define?** En ADA, las excepciones se declaran explícitamente en la zona de variables utilizando la sintaxis `MiExcepcion: exception;` (además de poseer excepciones predefinidas como `Constraint_Error`),.
- **b. ¿Cómo se lanza?** Se levantan forzadamente a través de la palabra clave `raise`.
- **c. ¿Cómo se maneja?** Al final de una unidad (subprograma o bloque) se colocan controladores precedidos por la palabra `exception`, seguidos de las cláusulas `when Nombre_Excepcion =>`.
- **d. Criterio de continuación:** Aplica terminación estricta; se omiten las acciones que seguían al punto de error, se abandona (termina) el bloque donde se levantó, se ejecuta el manejador y luego la ejecución continúa desde la instrucción externa que sigue al manejador,.

3. **¿Cuál de esos modelos es más inseguro y por qué?**
   El modelo de **Reasunción (como el de PL/1) es considerablemente más inseguro**.
   Hay dos motivos principales que justifican esto:
	1. **Complejidad del estado:** Retornar la ejecución al punto exacto donde falló el programa obliga al manejador a reparar perfectamente el estado de la memoria y las variables. Si la corrección no fue 100% adecuada, retomar el cálculo puede causar comportamientos inesperados, corrupción de datos o bucles infinitos.
	2. **Ligadura dinámica:** Al utilizar una "pila dinámica de manejadores" donde la asociación excepción-manejador se da en tiempo de ejecución basándose en quién fue el último en definirse,, se pierde el control estático del código. Es muy difícil para un programador predecir o rastrear visualmente qué bloque de código exacto va a terminar resolviendo el error.

Por estas razones lógicas y de seguridad, la industria se alejó de la reasunción y hoy en día los lenguajes modernos (C++, Java, Python) adoptaron el **modelo de Terminación**.

---
### Ejercicio 5
La propagación de los errores, cuando no se encuentra ningún manejador asociado, no se implementa igual en todos los lenguajes. Realice la comparación entre el modelo de Java, Python y PL/1, respecto a este tema. Defina la forma en que se implementa en un lenguaje conocido por Ud.

**Comparación de Propagación: Java vs. Python vs. PL/1**
- **Java:** Utiliza una **propagación dinámica** clásica a través de la pila de llamadas (_stack trace_). Si la unidad que generó la excepción no la maneja en un bloque `try-catch` local, la excepción se propaga hacia el método que la invocó, y así sucesivamente. Además, Java impone un control estricto: si un método puede generar o propagar una excepción (que no sea un error de tiempo de ejecución no chequeado) pero decide no manejarla internamente, está obligado a enunciarla en su firma o encabezado mediante la cláusula `throws`.
- **Python:** Posee un mecanismo mixto que realiza **dos tipos de propagación secuenciales**:
    1. **Búsqueda estática:** Primero, analiza si el bloque `try` que falló está contenido físicamente dentro de otro bloque `try` más externo en el mismo código. Si es así, busca el manejador allí.
    2. **Búsqueda dinámica:** Si no lo encuentra estáticamente, pasa a buscar en la pila de ejecución, analizando qué rutina invocó a la actual y buscando el manejador allí. Si luego de propagarse dinámicamente llega al programa principal y sigue sin encontrar un bloque `except` que la maneje, el proceso se corta abruptamente y arroja el mensaje estándar de error.
- **PL/1:** Difiere fundamentalmente de los lenguajes modernos porque **los manejadores se ligan dinámicamente** conformando una pila de manejadores en memoria. A medida que el flujo del programa se ejecuta y encuentra instrucciones de declaración (`ON CONDITION`), va apilando los manejadores. Cuando se levanta una excepción y no hay un manejador obvio, PL/1 busca desde el tope de esta pila hacia abajo; es decir, **la excepción siempre se ligará y será atrapada por el último manejador definido en el tiempo de ejecución**, sin importar si pertenece al invocador directo o no.

**Implementación en un lenguaje conocido: C++**
Para la segunda parte del ejercicio, podemos tomar a **C++** como lenguaje a definir:
En C++, el comportamiento es de terminación y propagación dinámica. Si ocurre una excepción y el bloque no tiene una cláusula `catch` correspondiente para ese tipo de dato, la excepción **se propaga hacia bloques** **try-catch** **externos** o hacia la función invocadora.
La particularidad de C++ ocurre cuando la excepción se propaga por toda la jerarquía de llamadas y **nunca encuentra un manejador coincidente**. En ese caso extremo, el lenguaje invoca automáticamente a una función especial predefinida llamada `terminate()`. El comportamiento por defecto de esta función es invocar a `abort()`, lo que provoca la **finalización abrupta e inmediata del programa**. _(Como detalle adicional, C++ le permite al programador redefinir el comportamiento de la función_ _terminate()_ _si desea hacer algo distinto antes de que el programa muera)_.

---
### Ejercicio 6
Sea el siguiente programa escrito en Pascal:
```pascal
...
Procedure Manejador;
	Begin ... end;
	
	Procedure P(X:Proc);
	begin
		....
		if Error then X;
		....
	end;
	
	Procedure A;
	begin​
		....​
		P(Manejador);​
		....
	end;
....
```
¿Qué modelo de manejo de excepciones está simulando? ¿Qué necesitaría el programa para que encuadre con los lenguajes que no utilizan este modelo? Justifique la respuesta.

1. ¿Qué modelo de manejo de excepciones está simulando?

El código presentado está simulando el **Modelo de Reasunción**.
En el procedimiento `P`, al cumplirse la condición de anomalía (`if Error then`), se invoca al subprograma pasado como parámetro `X`, que en este caso es el procedimiento `Manejador`. Una vez que el `Manejador` finaliza la ejecución de sus acciones correctivas, **el flujo de control retorna automáticamente al procedimiento** **P**, exactamente a la instrucción que le sigue a la llamada de `X`, y el subprograma `P` continúa su ejecución normal. Esta capacidad de ejecutar una reparación y retomar el cálculo en el punto exacto donde se produjo el problema es la definición teórica del modelo de reasunción (característico de lenguajes como PL/1).

2. ¿Qué necesitaría el programa para que encuadre con los lenguajes que no utilizan este modelo?

Los lenguajes que decidieron no utilizar la reasunción adoptaron el **Modelo de Terminación** (como lo hacen Ada, Java, C++, Python, etc.).

Para que este programa en Pascal simule el modelo de Terminación, necesitaría incorporar mecanismos que garanticen que **el procedimiento** **P** **finalice o abandone su ejecución inmediatamente después de detectar el error**, impidiendo que se retorne al punto donde este ocurrió.

Dado que Pascal carece de un `raise` o `throw` para romper la pila de ejecución nativamente, el programador tendría que modificar el código utilizando alguna de estas alternativas:

- **Encapsulamiento con `if-else`:** Transformar la lógica de `P` para que todas las instrucciones que le siguen a la comprobación de error estén dentro de una rama `else`. Así, si hay error, se llama al manejador y al no entrar al `else`, el procedimiento termina naturalmente.
- **Códigos de estado:** Modificar `P` para que devuelva un código de estado (o altere una variable booleana global compartida) en lugar de invocar al manejador directamente. Luego, el invocador (`A`) verifica ese código; si detecta el error, es `A` quien llama al `Manejador` y aborta la continuación de su propio bloque de código.
- **Salto incondicional (`goto`):** Utilizar una instrucción de salto directo que, tras la detección del error, envíe el flujo de control hacia una etiqueta ubicada en el final (`end`) del procedimiento, forzando la terminación del bloque.

---
### Ejercicio 7
Sea el siguiente programa escrito en Pascal:
```pascal​
Program Principal;
var
	x:int;
	b1,b2: boolean;
	
	Procedure P (b1:boolean);
	var
		x:int;
		Procedure Manejador1​
		begin
			x:=x + 1; ​
		end;
	begin
		x:=1; ​
		if b1=true then
			Manejador1;
		x:=x+4;
	end;

	Procedure Manejador2;
	begin
		x:=x * 100;
	end;
	
Begin
	x:=4;
	b2:=true;
	b1:=false;​
	if b1=false then
		Manejador2;​
	P(b);​
	write (x);
End.
```
a)​ Implemente este ejercicio en PL/1 utilizando manejo de excepciones
b)​ ¿Podría implementarlo en JAVA utilizando manejo de excepciones? En caso afirmativo, realícelo.

**a)**
```PL/1
Prog Main;
var
	x: int;
	b1, b2: boolean;
 
PROC P(b1: boolean);
var
	x: int;
begin
	
	ON CONDITION Error1 begin
		x := x + 1;
	end;
	
	x := 1;
	if (b1 = true) then
		SIGNAL CONDITION Error1;
	x := x + 4;
end;

	
begin
	
	ON CONDITION Error2 begin
		x := x * 100;
	end;
	
	x := 4;
	b2 := true;
	b1 := false;
	if (b1 = false) then
		SIGNAL CONDITION Error2;
	P(b1);
	write(x);
end.
```

**b)** Se puede implementar cambiando un poco la lógica para adaptar el modo de reasunción al modo de terminación y manejo con `try-catch` que utiliza Java:
```java
public class Principal {
    static int x;
    static boolean b1, b2;

    public static void P(boolean b1_param) {
        int x_local = 1;
        
        try {
            if (b1_param == true) {
                // Levantamiento explícito [6]
                throw new ExcepcionManejador1(); 
            }
        } catch (ExcepcionManejador1 e) {
            x_local = x_local + 1; // Lógica del Manejador1 [6]
        }
        
        // En el modelo de terminación, el bloque try murió al hacer throw. 
        // Poniendo esta línea afuera logramos el efecto "reasunción" de Pascal.
        x_local = x_local + 4; 
    }

    public static void main(String[] args) {
        x = 4;
        b2 = true;
        b1 = false;

        try {
            if (b1 == false) {
                throw new ExcepcionManejador2();
            }
        } catch (ExcepcionManejador2 e) {
            x = x * 100; // Lógica del Manejador2
        }

        P(b1); // (Asumiendo corrección del typo 'b' en el original)
        
        System.out.println(x);
    }
}
```
```java
public class ExcepcionManejador1 extends Exception {
	
}
```
```java
public class ExcepcionManejador2 extends Exception {
	
}
```
---
### Ejercicio 8
Sean los siguientes, procedimientos de un programa escrito en JAVA:
```java
public static void main (String[] argos){
	
	Double array_doubles[]= new double[500];
	
	for (int i=0; i<500; i++){
		array_doubles[i]=7*i;
	}
	
	for (int i=0 ; i<600 ; i=i+25){
		try {
			system.out.println(“El elemento en “+ i + ” es “ + acceso_por_indice (array_doubles,i));
		}
		catch(ArrayIndexOutOfBoundsException e) {
			system.out.println(e.tostring());
		}
		catch(Exception a) {
			system.out.println(a.tostring());
		}
		finally {
			system.out.println(“sentencia finally”);
		}
	}
}

Public static double acceso_por_indice (double [] v, int indice) throws Exception; ArrayIndexOutOfBoundsException {
	if ((indice>=0) && (indice<v.length)) {
		Return v[indice];
	}
	else {
		if (indice<0) {
		// caso excepcional
		Throw new ArrayIndexOutOfBoundsException(“ el índice” + indice + “ es un número negativo”);
		}
		else {
			// caso excepcional
			Throw new Exception(“ el indice” + indice + “ no es una posición válida”);
		}
}
```
**a)** Analizar el ejemplo y decir qué manejadores ejecuta y en qué valores quedan las variables. JUSTIFIQUE LA RESPUESTA.
**b)** La excepción se propaga o se maneja en el mismo método? ¿Qué instrucción se agrega para poder propagarla y que lleve información?
**c)** como modificaría el método “acceso_por_indice” para que maneje él mismo la excepción.

**a) Análisis de la ejecución y variables** Dado que Java emplea el **Modelo de Terminación** para el manejo de excepciones, en el momento en que se evalúa el caso excepcional y se ejecuta la instrucción `throw new Exception(...)`, el flujo de ejecución normal se interrumpe inmediatamente. Esto significa que cualquier instrucción que estuviera después del `throw` dentro de ese mismo bloque no se ejecutará. Las variables mantendrán exactamente los valores que tenían asignados hasta la línea previa a que se levantara la excepción. A partir de allí, el flujo buscará el primer bloque `catch` que coincida con el tipo de excepción para ejecutar su código (el manejador).

**b) ¿La excepción se propaga o se maneja en el mismo método? ¿Qué instrucción se agrega?**

- **¿Se propaga o maneja?** Si el método (`acceso_por_indice`) lanza la excepción con `throw` pero no la envuelve en un bloque `try-catch` propio, la excepción **no se maneja localmente y se propaga dinámicamente** hacia el método que lo haya invocado (propagación por _stack trace_).
- **Instrucción para permitir la propagación:** En Java, si un método puede generar o propagar una excepción y decide no manejarla internamente, está obligado a enunciarla en la firma de su encabezado utilizando la cláusula **throws** (por ejemplo: `void acceso_por_indice(...) throws Exception`).
- **Instrucción para llevar información:** Para que la excepción viaje con información personalizada, se la levanta instanciando un objeto (con `new`) y pasándole una cadena de texto, utilizando la instrucción **throw**. En el código se ve claramente: `throw new Exception(" el indice" + indice + " no es una posición válida");`.

**c) ¿Cómo modificaría el método para que maneje él mismo la excepción?** Para que el método `acceso_por_indice` no propague el error y se encargue de atraparlo internamente, se debe incorporar la estructura de control de excepciones propia de Java:

1. **Bloque `try`**: Encerrar el código que evalúa el índice y lanza el error dentro de un bloque **try { ... }**.
2. **Bloque `catch`**: Inmediatamente debajo del `try`, agregar un manejador utilizando la cláusula **catch (Exception e) { ... }**. Dentro de las llaves del `catch` irá el código encargado de recoger el error, analizarlo e imprimir el mensaje o realizar la acción correctiva pertinente.
3. **Bloque** **`finally`** **(Opcional):** Si el método requiere ejecutar alguna limpieza de recursos (como cerrar un archivo) independientemente de si hubo error o no, agregar al final un bloque **finally { ... }**.
---
### Ejercicio 9 
Indique diferencias y similitudes entre Phyton y Java con respecto al manejo de excepciones.

Similitudes entre Java y Python

- **Modelo de manejo:** Ambos lenguajes implementan el **Modelo de Terminación**. Esto significa que cuando ocurre un error, el bloque que generó la excepción interrumpe su ejecución, busca manejarla y luego la ejecución continúa después de la estructura de manejo, sin retornar al punto donde ocurrió el error.
- **Orientación a Objetos:** En ambos lenguajes, las excepciones están representadas como **objetos o clases**. En Java deben ser instancias de `Throwable` (o de sus subclases `Error` y `Exception`), mientras que en Python son clases que derivan de `Exception`.
- **Tipos de excepciones:** Tanto Java como Python poseen un conjunto de excepciones predefinidas por el propio lenguaje (_built-in exceptions_) y permiten al programador crear excepciones personalizadas (_user-defined exceptions_) definiendo nuevas clases.
- **Bloque a evaluar:** Ambos utilizan la palabra reservada **try** para delimitar el bloque de código riesgoso que puede llegar a levantar una excepción.
- **Bloque de cierre garantizado:** Ambos lenguajes proveen la cláusula **finally**, la cual se utiliza para colocar sentencias (como el cierre de un archivo) que el programador desea que se ejecuten **siempre**, sin importar si se levantó o no una excepción en el bloque principal.

Diferencias entre Java y Python

- **Palabras clave para el Manejador (Handler):** Para definir los bloques encargados de capturar y tratar el error, Java utiliza la palabra reservada **catch**, mientras que Python utiliza **except**.
- **Palabras clave para el Levantamiento (Lanzamiento):** Para disparar una excepción explícitamente, Java utiliza la instrucción **throw** (usualmente acompañada de `new` para instanciar el objeto), mientras que Python utiliza la instrucción **raise**.
- **Propagación y Declaración:**
    - **Java** utiliza una propagación estrictamente **dinámica** a través de la pila de llamadas (_stack trace_). Además, obliga a que si un método puede generar una excepción (chequeada) y decide no manejarla internamente, deba declararla explícitamente en el encabezado del método usando la cláusula **throws**.
    - **Python** utiliza un mecanismo mixto: primero realiza una búsqueda **estática** (analiza si el bloque `try` está anidado dentro de otro `try` más externo en el mismo código) y, si no lo encuentra, pasa a una búsqueda **dinámica** consultando a quién lo llamó. A diferencia de Java, Python no requiere especificar en la firma de la función qué excepciones se van a propagar.
- **Cláusula adicional** **`else`**: Python incorpora en su estructura de excepciones una cláusula opcional **else**. El bloque de código de esta cláusula se ejecuta **únicamente si no se levanta ninguna excepción** dentro del bloque `try`. Java no posee una instrucción equivalente nativa.
- **Excepciones anónimas:** Python permite utilizar la instrucción **raise** de manera solitaria (sin indicar qué excepción lanzar). Si se hace esto, el lenguaje vuelve a lanzar la última excepción que estaba activa en el entorno actual de forma anónima (o `RuntimeError` si no había ninguna activa). En Java, siempre es necesario especificar el objeto de la excepción que se está lanzando.
---
### Ejercicio 10
¿Qué modelo de excepciones implementa Ruby? ¿Qué instrucciones específicas provee el lenguaje para manejo de excepciones y cómo se comportan cada una de ellas?

---
### Ejercicio 11
Indique el mecanismo de excepciones de javascript.

---
### Ejercicio 12
Sea el siguiente programa escrito en Python, indique el camino de ejecución.
```python
#!/usr/bin/env python
#calc.py
def dividir():
	x = a / b
	print (("Resultado"), (x))
while True:
	try:
		a = int(input("Ingresa el primer numero: \n"))
		b = int(input("Ingresa el segundo numero: \n"))
		dividir()
		break
	except ZeroDivisionError:
		print ("No se permite dividir por cero")
	finally:
		print ("Vuelve a probar")
```
**a)** Describa qué caminos ejecuta para diferentes valores de ingreso.
**b)** Agregar el uso de una excepción anónima.

**a)**
Al utilizar un bloque `try-except-finally` dentro de un bucle `while True`, el programa presenta tres caminos de ejecución principales dependiendo de los valores que ingrese el usuario:

**Camino 1: Ingreso de valores válidos (Camino feliz)**
- _Valores:_ El usuario ingresa enteros válidos y el segundo número (`b`) es distinto de cero (ej. `a=10`, `b=2`).
- _Ejecución:_
    1. El programa entra al bucle `while` y luego al bloque `try`.
    2. Lee ambos números exitosamente e invoca a la función `dividir()`, la cual imprime el resultado.
    3. El flujo retorna al bloque `try` y ejecuta la instrucción `break` para salir del bucle `while`.
    4. **Dato clave:** Antes de ejecutar efectivamente el `break` y abandonar la estructura, el procesador ejecuta obligatoriamente el bloque `finally`, imprimiendo _"Vuelve a probar"_.
    5. El programa finaliza exitosamente.

**Camino 2: División por cero (ZeroDivisionError)**
- _Valores:_ El usuario ingresa un entero válido para `a`, pero ingresa `0` para `b`.
- _Ejecución:_
    1. Entra al bloque `try`, lee los números y llama a `dividir()`.
    2. Al ejecutar `x = a / b`, se produce una división por cero. Siguiendo el modelo de terminación de Python, la ejecución de la función se interrumpe y la instrucción `break` del `try` nunca se alcanza.
    3. La excepción se propaga y es capturada por el manejador `except ZeroDivisionError:`, imprimiendo _"No se permite dividir por cero"_.
    4. Luego, ejecuta el bloque `finally` imprimiendo _"Vuelve a probar"_.
    5. Al no haberse ejecutado el `break`, el bucle `while True` continúa en su siguiente iteración, volviendo a pedir el ingreso de números.

**Camino 3: Ingreso de tipos de datos inválidos (Ej. letras)**
- _Valores:_ El usuario ingresa una letra o símbolo en lugar de un número entero.
- _Ejecución:_
    1. Al intentar convertir el ingreso con `int(input(...))`, Python levanta una excepción `ValueError`.
    2. Se interrumpe el bloque `try` y busca un manejador local. Al ver que el único manejador es para `ZeroDivisionError`, no atrapa esta anomalía.
    3. Al no encontrar un manejador que coincida estáticamente, pasa a buscar de manera dinámica hacia afuera.
    4. Independientemente de esto, ejecuta el bloque `finally` garantizado e imprime _"Vuelve a probar"_.
    5. Al llegar al nivel principal sin encontrar un `except ValueError`, el proceso se corta abruptamente arrojando el mensaje estándar de error de Python (Traceback).

**b)**
En Python, el lanzamiento de una **excepción anónima** se logra utilizando únicamente la palabra reservada **raise** sin especificar el nombre de la excepción. Esto provoca que se vuelva a lanzar la última excepción que estaba activa en el entorno actual para propagarla hacia niveles superiores.
Para agregarla, debemos colocar el `raise` dentro del manejador existente:
```
# ... código anterior ...
    except ZeroDivisionError:
        print ("No se permite dividir por cero")
        raise # <-- Levantamiento de excepción anónima
    finally:
        print ("Vuelve a probar")
```
**Efecto de esta modificación:** Si el usuario ingresa un divisor de cero, el programa atrapará el error, imprimirá el mensaje personalizado ("No se permite dividir por cero"), ejecutará el `finally` garantizado ("Vuelve a probar") y luego, por culpa de este `raise` anónimo, la excepción de división por cero se propagará hacia afuera. Como no hay otro bloque `try` que lo envuelva, el programa abortará su ejecución mostrando el error estándar de Python por consola, en lugar de continuar iterando en el bucle `while`.

---
### Ejercicio 13
Sea el siguiente código escrito en Java.
```java
public class ExcepcionUno extends Exception {
	
	public ExcepcionUno(){​
		super(); // constructor por defecto de Exception
	}
	
	public ExcepcionUno( String cadena ){​
		super( cadena ); // constructor param. de Exception
	}
}
```
```java
public class ExcepcionDos extends Exception {
	
	public ExcepcionDos(){​
		super(); // constructor por defecto de Exception
	}
	
	public ExcepcionDos( String cadena ){
		super( cadena ); // constructor param. de Exception
	}
}
```
```java
public class ExcepcionTres extends Exception {

	public ExcepcionTres() {​
		super(); // constructor por defecto de Exception
	}

	public ExcepcionTres( String cadena ){
		super( cadena ); // constructor param. de Exception
	}
}
```
```java
public class Lanzadora {
	
	public void lanzaSiNegativo(int param) throws ExcepcionUno {​
		 if (param < 0)​
			 throw new ExcepcionUno("Numero negativo");
	}
	
	public void lanzaSimayor100(int param) throws ExcepcionDos {​
		if (param >100 and param<125)
			throw new ExcepcionDos("Numero mayor100");
	}
	
	public void lanzaSimayor125(int param) throws ExcepcionTres {​
		if (param >= 125)​
			throw new ExcepcionTres("Numero mayor125");
	}
}
```
```java
import java.io.FileInputStream;
import java.io.IOException;

public class Excepciones {
	public static void main(String[] args) {​
		// Para leer un fichero
		Lanzadora lanza = new Lanzadora();
		FileInputStream entrada = null;
		int leo;​
		try {
			entrada = new FileInputStream("fich.txt");
			while ((leo = entrada.read()) != -1) {
				if (leo < 0)
					lanza.lanzaSiNegativo(leo);
				else if (leo > 100)
					lanza.lanzaSimayor100(leo);
			}
			entrada.close();
			System.out.println("Todo fue bien");
		}
		catch (ExcepcionUno e) { // Personalizada
			System.out.println("Excepcion: " + e.getMessage());
		}
		catch (ExcepcionDos e) { // Personalizada
			System.out.println("Excepcion: " + e.getMessage());
		}
		catch (IOException e) { // Estándar
			System.out.println("Excepcion: " + e.getMessage());
		}
		finally {
			if (entrada != null)
				try {
					entrada.close(); // Siempre queda cerrado
				}
				catch (Exception e) {
					System.out.println("Excepcion: " + e.getMessage());
				}
			System.out.println("Fichero cerrado.");
		}
	}
}
```
**a)​** Indique cómo se ejecuta el código. Debe quedar en claro los caminos posibles de ejecución, cuales son los manejadores que se ejecutan y cómo se buscan los mismos y si en algún caso se produce algún error.

El código está escrito en Java, por lo que implementa el **Modelo de Terminación** con **propagación dinámica**. Esto significa que, al levantarse una excepción con la instrucción `throw`, la ejecución del bloque actual se interrumpe de inmediato. Como los métodos de la clase `Lanzadora` no tienen bloques `try-catch` propios, las excepciones se propagan dinámicamente hacia el método invocador (`main`), donde se busca el primer bloque `catch` coincidente. Una vez manejada, el programa ejecuta obligatoriamente el bloque `finally` y continúa su ejecución normal sin retornar al punto de fallo.

Caminos posibles de ejecución

**Camino 1: Lectura exitosa (Camino Feliz)**

- **Condición:** El archivo "fich.txt" existe y todos los bytes leídos son menores o iguales a 100, o mayores o iguales a 125.
- **Ejecución:** El programa lee todo el archivo sin arrojar excepciones. El bucle `while` finaliza, se cierra el archivo (`entrada.close()`) y se imprime _"Todo fue bien"_. Se omiten todos los bloques `catch` y pasa directo al bloque `finally`, donde intenta cerrar el archivo nuevamente (protegido por un `try-catch` interno para evitar fallos) e imprime _"Fichero cerrado."_.

**Camino 2: Lectura de un valor entre 101 y 124**

- **Condición:** El bucle lee un byte mayor a 100.
- **Ejecución:** El flujo entra al `else if (leo > 100)` e invoca a `lanza.lanzaSimayor100(leo)`. Dentro de este método, se cumple la condición `(param > 100 and param < 125)`, ejecutando `throw new ExcepcionDos("Numero mayor100")`.
- **Manejo:** La excepción interrumpe el bloque `try` del `main` (descartando el `entrada.close()` y el mensaje de éxito). Se propaga al `main` y es capturada por su manejador: `catch (ExcepcionDos e)`, el cual imprime _"Excepcion: Numero mayor100"_. Finalmente, el bloque `finally` se ejecuta, cerrando el archivo de forma segura e imprimiendo _"Fichero cerrado."_.

**Camino 3: Error en la lectura o apertura del archivo**

- **Condición:** El archivo no existe o hay un error de I/O.
- **Ejecución:** Las clases nativas de Java levantarán una `IOException` (o `FileNotFoundException`).
- **Manejo:** El bloque `try` se interrumpe y la excepción es atrapada por el manejador `catch (IOException e)`. Tras imprimir el error, pasa al `finally`. Si el archivo nunca se abrió (`entrada == null`), simplemente imprime _"Fichero cerrado."_.

Observaciones de errores lógicos en el código

El análisis exhaustivo del código revela **dos situaciones donde el flujo no se comportará como el programador aparentemente esperaba**:

1. **ExcepcionTres jamás se ejecuta:** El método `lanzaSimayor125` es el único capaz de lanzar `ExcepcionTres`, pero **nunca es invocado desde el programa principal**. Si el archivo lee un valor mayor o igual a 125, el `main` invocará a `lanzaSimayor100` (porque 125 > 100), pero como la condición interna de dicho método pide que sea `< 125`, no hará absolutamente nada y el programa simplemente continuará el bucle ignorando el valor.
2. **ExcepcionUno es matemáticamente inalcanzable:** El método `entrada.read()` de Java devuelve el byte leído como un entero positivo entre `0` y `255`, y solamente devuelve `-1` cuando llega al final del archivo. Como la condición del `while` es salir si lee `-1`, la variable `leo` **jamás será negativa dentro del bucle**. Por lo tanto, el llamado a `lanzaSiNegativo(leo)` es código inalcanzable en tiempo de ejecución. _(Nota: Si asumiéramos teóricamente que entrara un número negativo, el método arrojaría `ExcepcionUno`, el try se cortaría, lo atraparía el `catch(ExcepcionUno e)` y luego pasaría al `finally`).

---
### Ejercicio 14
Dado el siguiente código en Java. Indique todos los posibles caminos de resolución, de acuerdo a los números que vaya leyendo del archivo.