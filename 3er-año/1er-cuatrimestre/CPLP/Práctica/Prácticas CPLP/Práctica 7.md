# Sistemas y tipos de datos
**Objetivo:** Comprender las nociones fundamentales sobre las diversas propiedades de los sistemas de tipos y los tipos de datos.

---
### Ejercicio 1
**Sistemas de tipos**

1. ¿Qué es un sistema de tipos y cuál es su principal función?
   Un **sistema de tipos** es el conjunto de reglas utilizadas por un lenguaje de programación para estructurar y organizar sus tipos. Además, provee los mecanismos de expresión para definir tipos intrínsecos o nuevos, y establece las reglas de resolución (como la equivalencia, compatibilidad e inferencia de tipos).
   Su objetivo fundamental es permitir la escritura de **programas seguros**. Conocer este sistema ayuda a comprender profundamente los aspectos semánticos del lenguaje y cómo este previene o detecta errores.
   
2. Definir y contrastar las definiciones de un sistema de tipos fuerte y débil (probablemente en la bibliografía se encuentren dos definiciones posibles. Volcar ambas en la respuesta). Ejemplificar con al menos 2 lenguajes para cada uno de ellos y justificar.
   - **Definición 1 (Genérica):** Se dice que un sistema de tipos es **fuerte** cuando especifica restricciones estrictas sobre cómo pueden operarse valores de diferentes tipos en conjunto (por ejemplo, impidiendo sumar un texto y un número sin conversión explícita). Lo contrario establece un sistema **débil** de tipos.
   - **Definición 2 (Type Safety - Orientada a lenguajes compilados):** Un lenguaje es fuertemente tipado si el sistema impone restricciones que **aseguran que no se producirán errores de tipo en ejecución**. Es decir, el compilador puede garantizar la ausencia de errores de tipo y todos los errores son detectados tan pronto como sea posible.
 **Ejemplos y justificación:**
   - **Python (Fuerte):** Python es un lenguaje fuertemente tipado. Aunque no requiere declarar el tipo de las variables, una vez que un dato asume un tipo en ejecución, el lenguaje restringe operaciones inseguras (por ejemplo, si intentas concatenar el entero `2` con el string `"2"`, arrojará un error de tipos en lugar de forzar una conversión implícita silenciosa).
   - **C (Débil):** C es un lenguaje débilmente tipado. Permite que los datos esquiven las restricciones de tipo, usando operaciones de coerción implícita de forma insegura o manipulando la memoria mediante punteros genéricos, lo que puede provocar que tipos incompatibles interactúen sin advertencias del compilador.

3. Además de la clasificación anterior, también es posible caracterizar el tipado como estático o dinámico. ¿Qué significa esto? Ejemplificar con al menos 2 lenguajes para cada uno de ellos y justificar.
   Independientemente de si el lenguaje es de tipado fuerte o débil, los lenguajes también se clasifican según **cuándo** se liga (binding) la variable con su tipo:
   - **Tipado Estático:** Las ligaduras de tipo se resuelven en **tiempo de compilación**. Esto generalmente exige que el programador declare todas las variables con un tipo asociado antes de usarlas, y que todas las operaciones especifiquen el tipo de los operandos y el resultado.
    - _Ejemplo 1:_ **C** utiliza tipado estático, obligando a declarar variables (ej. `int x;`) antes de su uso.
    - _Ejemplo 2:_ **Ada** o **Pascal**. Todas las variables tienen su tipo fijado en la traducción y son verificadas rígidamente antes de ejecutar el programa.
   - **Tipado Dinámico:** Las ligaduras de tipo se resuelven en **tiempo de ejecución**. Las variables no necesitan una declaración explícita de tipo; adquieren el tipo del valor que se les asigna en ese momento, lo que provoca que las comprobaciones de seguridad se deban hacer mientras el programa corre (haciéndolos más flexibles pero requiriendo más trabajo en tiempo de ejecución).
    - _Ejemplo 1:_ **Python** tiene tipado dinámico. Una variable `x` puede contener un entero en una línea y luego apuntar a un string en la siguiente.
    - _Ejemplo 2:_ **Ruby** o **JavaScript** también utilizan tipado dinámico, donde las variables nacen o asumen su tipo directamente en la asignación del valor.
---
### Ejercicio 2
**Tipos de datos**
1. Dar una definición de tipo de dato.
   Un tipo de datos se define formalmente como un **conjunto de valores** posibles y un **conjunto de operaciones** válidas que se pueden utilizar para manipular esos valores. No se trata simplemente de una agrupación de información, sino que poseen un comportamiento semántico o sentido lógico que dicta cómo esos datos deben ser interpretados y operados por el lenguaje.
   
2. ¿Qué es un tipo predefinido elemental? Dar ejemplos.
   Los tipos predefinidos (también llamados primitivos o _built-in_) son los tipos base que ya vienen integrados y descritos en la definición del lenguaje de programación.
   - **Características:** Son fundamentalmente una **abstracción del comportamiento del hardware subyacente**. Sus valores se ligan en la implementación a representaciones físicas de la máquina (por ejemplo, cómo se guarda un número binario en la memoria).
   - **Ventajas:** Ocultan la complejidad de la representación interna, permiten realizar verificaciones estáticas de seguridad durante la compilación, ayudan a desambiguar operadores (por ejemplo, saber si el signo `+` suma enteros o concatena textos) y controlan la precisión de los cálculos.
   - **Ejemplos:** Los números **Enteros**, los números **Reales** (flotantes), los **Caracteres** y los **Booleanos** (`true` / `false`).
  
3. ¿Qué es un tipo definido por el usuario? Dar ejemplos.
   Son aquellos tipos que el lenguaje permite crear al programador para modelar estructuras más complejas, agrupando tipos predefinidos elementales mediante herramientas llamadas **constructores**.
   - **Características:** Su principal fortaleza es que **separan la especificación de la implementación**, permitiendo que el programador defina exactamente las estructuras que su problema particular necesita.
   - **Ventajas:** Permiten elevar el nivel de abstracción (encapsulando datos y lógica en un solo lugar), mejoran drásticamente la legibilidad mediante la elección de nombres representativos para el problema, favorecen la modificabilidad (ya que un cambio en la estructura interna solo requiere modificar la definición) y promueven la reutilización o factorización del código.
   - **Ejemplos:** Los **Arreglos**, las **Listas**, los **Tipos Enumerados** y los **Registros** (`structs` o `records`). La evolución máxima de este concepto derivó en la creación de los Tipos Abstractos de Datos (TAD) y las **Clases** en la programación orientada a objetos.
---
### Ejercicio 3
**Tipos compuestos**
1. Dar una breve definición de: producto cartesiano (en la bibliografía puede aparecer también como product type), correspondencia finita, uniones (en la bibliografía puede aparecer también como sum type) y tipos recursivos.
   - **Producto Cartesiano:** Es un conjunto cuyos elementos son n-tuplas ordenadas formadas a partir de múltiples conjuntos (dominios) diferentes. Básicamente, permite agrupar varios datos de tipos distintos bajo una misma entidad. Se implementa en los lenguajes a través de las _Estructuras_ (como `struct` en C) o los _Registros_ (como `record` o clases con atributos).
   - **Correspondencia Finita:** Es una función o mapeo que asocia un conjunto finito de valores de un tipo de dominio (índice o clave) con valores de un tipo de rango (resultado). Se utiliza para modelar estructuras accesibles mediante un índice numérico o alfanumérico, tales como _Arreglos_, _Colecciones_, _Diccionarios_ o _Hashes_.
   - **Uniones (Sum Type / Disyunción):** Es un constructor que define un tipo como la disyunción de varios tipos dados, permitiendo almacenar _diferentes tipos de datos en la misma ubicación de memoria_, pero donde los campos son mutuamente excluyentes (sólo uno es válido a la vez). La **Unión Discriminada** es una variante más segura que añade un "tag" o discriminante para que el programa sepa exactamente cuál de las opciones se está utilizando en ese momento.
   - **Tipos Recursivos:** Es un tipo de dato que se define como una estructura que puede contener componentes u objetos de su mismo tipo. Se utiliza para definir datos agrupados cuyo tamaño o complejidad puede crecer de manera arbitraria o dinámica. Dado que el tamaño es indeterminado, en la mayoría de los lenguajes convencionales se implementan apoyándose en el uso de _punteros_ o referencias (como en el caso de Listas Enlazadas o Árboles).

2. Identificar a qué clase de tipo de datos pertenecen los siguientes extractos de código. En algunos casos puede corresponder más de una:
**Java**
```java
class Persona {
	String nombre;
	String apellido;
	int edad;
}
```
Producto cartesiano (string x string x int).

**C**
```C
typedef struct _nodoLista {
	void *dato;
	struct _nodoLista *siguiente
} nodoLista;
	typedef struct _lista {
	int cantidad;
	nodoLista *primero
} Lista;
```
Producto cartesiano (puntero a dato X \_nodoLista) y tipo recursivo (la estructura \_nodoLista contiene a un puntero de su mismo tipo).

**C**
```C
union codigo {
	int numero;
	char id;
};
```
Unión pura (no discriminada, no tiene tag para indicar qué elemento se está utilizando).

**Ruby**
```ruby
hash = {
	uno: 1,
	dos: 2,
	tres: 3,
	cuatro: 4
}
```
Correspondencia finita.

**PHP**
```PHP
function doble($x) {
	return 2 * $x;
}
```
¿Correspondencia? Es una función, cumpliría con la definición de asociar conjunto **finito(?, depende el tipo de x supongo)** de valores de un tipo de dominio (el parámetro `$x`) a un conjunto de valores de un tipo de rango (el valor de retorno).

**Python**
```python
tuple = ('physics', 'chemistry', 1997, 2000)
```
Producto cartesiano (tupla inmutable).

```Haskell
data ArbolBinarioInt =
	Nil |
	Nodo int
	(ArbolBinarioInt dato)
	(ArbolBinarioInt dato)
```
> Ayuda para interpretar: 'ArbolBinarioInt' es un tipo de dato que puede ser Nil (“vacío”) o un Nodo con un dato número entero (int) junto a un árbol como hijo izquierdo y otro árbol como hijo derecho.

Producto cartesiano, tipo recursivo y unión. Unión porque puede ser Nil o Nodo.

```Haskell
data Color =
	Rojo |
	Verde |
	Azul
```
> Ayuda para interpretar: 'Color' es un tipo de dato que puede ser Rojo, Verde o Azul.

Unión.

---
### Ejercicio 4
**Mutabilidad/inmutabilidad**
1. Definir mutabilidad e inmutabilidad respecto a un dato. Dar ejemplos en al menos 2 lenguajes. 
   _TIP: indagar sobre los tipos de datos que ofrece Python y sobre la operación \#freeze en los objetos de Ruby._
   
   La mutabilidad se refiere a la capacidad que tiene un objeto de datos para cambiar su estado o valor interno (R-valor) una vez que ya ha sido creado y alojado en memoria.
   - **Mutabilidad:** Un tipo de dato es **mutable** si, después de ser instanciado, sus componentes internos pueden ser alterados o modificados sin necesidad de destruir el objeto original ni cambiar su identidad (su ubicación en memoria).
   - **Inmutabilidad:** Un tipo de dato es **inmutable** si su estado no puede cambiar tras su creación. Cualquier operación que aparentemente "modifique" a un objeto inmutable, en realidad está destruyendo el original o creando un objeto completamente nuevo en otra dirección de memoria con el nuevo valor.
**Ejemplos en distintos lenguajes:**
   - **Python:** Tiene una división muy clara entre tipos.
     - _Inmutables:_ Los números (`int`, `float`), los textos (`str`) y las tuplas (`tuple`). Al intentar cambiar un carácter de un string (ej. `texto = 'a'`), Python arrojará un error de tipos.
     - _Mutables:_ Las listas (`list`), los diccionarios (`dict`) y los conjuntos (`set`). Se puede agregar, eliminar o cambiar elementos internos y la lista seguirá siendo el mismo objeto en memoria.
   - **Ruby:** En Ruby, por defecto, casi todos los objetos son mutables (incluso los strings, a diferencia de Java o Python). Sin embargo, Ruby ofrece el método explícito **#freeze**. Al enviarle el mensaje `freeze` a un objeto (ej. `mi_texto.freeze`), este queda "congelado" y se vuelve **estrictamente inmutable** para el resto de la ejecución. Cualquier intento de alterarlo levantará una excepción (`FrozenError`).
   
2. Dado el siguiente código:
   ```
   a = Dato.new(1)
   a = Dato.new(2)
   ```
¿Se puede afirmar entonces que el objeto “Dato.new(1)” es mutable? Justificar la respuesta sea por afirmativa o por la negativa.

NO, no se puede afirmar que el objeto sea mutable.

Se debe separar conceptualmente lo que le ocurre a la variable (el contenedor) de lo que le ocurre al objeto (el dato en memoria). En este fragmento de código, **no se está modificando el estado interno del objeto original**. Lo que está ocurriendo es una **reasignación de la variable** **a**.

1. En la primera línea, se crea un objeto en la memoria Heap con el valor `1`, y la variable `a` apunta (se liga) a esa dirección de memoria.
2. En la segunda línea, se crea un **objeto completamente nuevo** e independiente con el valor `2`. La variable `a` simplemente rompe su enlace anterior y pasa a apuntar a este nuevo objeto.

El objeto original `Dato.new(1)` jamás fue alterado ni mutado; simplemente quedó "suelto" (sin referencias) en la memoria y eventualmente será eliminado por el Recolector de Basura (_Garbage Collector_). Para demostrar que un objeto es mutable, deberíamos ver una operación que altere su estado interno sin usar una reasignación completa (por ejemplo, llamando a un método interno como `a.cambiar_valor(2)`).

---
### Ejercicio 5
**Manejo de punteros**
1. ¿Permite C tomar el l-valor de las variables? Ejemplificar.

**Sí, lo permite.** El **L-valor** representa la dirección del área de memoria física que está ligada a una variable durante la ejecución. C permite a los programadores acceder a esta dirección de memoria directamente mediante el uso de operadores específicos, fundamentalmente el operador de dirección `&`.
**Ejemplo:**
```
int x = 0;
int *i = &x;
```
En este fragmento, `&x` está tomando explícitamente el L-valor de la variable `x` (su ubicación en la memoria) y se lo está asignando al puntero `i`. A partir de este momento, `i` es una referencia directa a la dirección de memoria de `x`.

2. ¿Qué problemas existen en el manejo de punteros? Ejemplificar.

El uso de punteros y la administración manual de la memoria (particularmente en la zona de la _Heap_) proporcionan mucho poder y acceso a bajo nivel, pero introducen problemas graves en la seguridad y confiabilidad del software:
- **Aliasing y efectos colaterales:** El _aliasing_ ocurre cuando múltiples identificadores o punteros diferentes apuntan a una misma entidad (la misma dirección de memoria). Esto provoca que una modificación realizada a través de un puntero altere silenciosamente el estado para todos los demás que miran a esa misma dirección.
    - _Ejemplo:_ Siguiendo el caso anterior de C: `int x = 0; int *i = &x; int *j = &x;` Si ejecutamos `*i = 10;`, no solo cambia lo que apunta `i`, sino que por efecto colateral tanto la variable `x` como el contenido apuntado por `j` pasan a valer `10`.
- **Errores de doble liberación (Double Free) y corrupción:** Si el programador libera la memoria a la que apunta un puntero, pero existe otro puntero (un alias) apuntando a esa misma dirección e intenta liberarla de nuevo, se produce un error de doble liberación. Esto puede conducir directamente a la corrupción de la memoria y a generar vulnerabilidades graves de seguridad en la aplicación. _(Nota: Lenguajes como Rust evitan esto prohibiendo a nivel de compilador que dos punteros posean y liberen el mismo lugar de memoria simultáneamente)._
- **Generación de basura (Fugas de memoria / Memory Leaks):** Las variables dinámicas creadas mediante punteros no se destruyen automáticamente cuando finaliza la rutina (su tiempo de vida no está atado a la pila de ejecución, sino que viven en la _Heap_ mientras existan). Si un programador crea un objeto dinámico (ej. `new p`), y luego reasigna ese puntero hacia un objeto nuevo (ej. `p = B`) sin haber liberado el anterior, el primer objeto queda "suelto" en la memoria, inaccesible e imposible de borrar, convirtiéndose en basura que consume recursos inútilmente.
---
### Ejercicio 6
**TAD**
1. ¿Qué características debe cumplir una unidad para que sea un TAD?
   Un Tipo Abstracto de Dato (TAD) es una abstracción que combina en una misma entidad la representación (los datos) con sus operaciones asociadas (funciones y procedimientos). Para que una unidad de programación se considere estrictamente un TAD, debe satisfacer dos características fundamentales:
   - **Encapsulamiento:** La representación del tipo y las operaciones permitidas para interactuar con los objetos de ese tipo deben agruparse y describirse en una **única unidad sintáctica**. Esto ayuda a reflejar las abstracciones que se descubren durante el diseño del programa.
   - **Ocultamiento de la información:** La representación interna de los datos y los detalles concretos de implementación de las operaciones deben **permanecer ocultos** para quien utiliza el TAD. El principio básico es separar qué hace la estructura de cómo lo hace, lo cual aumenta drásticamente la modificabilidad y la seguridad del código.
  
2. Dar algunos ejemplos de TAD en lenguajes tales como ADA, Java, Python, entre otros.
   Las unidades de programación que implementan los TADs reciben diferentes nombres dependiendo del lenguaje. En términos prácticos, suelen ser tipos definidos por el usuario que asocian estados (atributos) y comportamientos (métodos):
   - **ADA:** Implementa los TADs utilizando la unidad llamada **paquete (****package****)**. Un paquete en ADA logra el encapsulamiento agrupando las definiciones, y cumple con el ocultamiento declarando los tipos en una sección `private` y delegando el código real de las rutinas a una unidad completamente separada y oculta llamada `package body`.
   - **Java y C++:** Utilizan la estructura **clase (****class****)** para representar sus TADs. En una clase de Java o C++, el encapsulamiento se logra definiendo toda la entidad entre llaves, y el ocultamiento de la información se aplica a través de modificadores de acceso, declarando por ejemplo variables como `private` (inaccesibles desde afuera) y las operaciones como `public`.
   - **Python:** Al ser un lenguaje multiparadigma que incorpora características orientadas a objetos, Python también implementa la abstracción de datos a través de **clases**, agrupando estados (variables locales de instancia) y comportamientos (métodos). _(Nota: A diferencia de Java o Ada, el ocultamiento estricto en Python es más una convención de uso mediante prefijos, ya que el lenguaje se inclina más hacia la flexibilidad dinámica)_.