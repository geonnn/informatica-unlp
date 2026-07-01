# Parámetros
**Objetivo:** Descubrir las técnicas existentes para pasaje de parámetros entre unidades y sus diferencias esenciales de acuerdo al lenguaje que lo implementa.

---
### Ejercicio 1
Explique brevemente los siguientes conceptos
- Parámetro
- Parámetro real
- Parámetro formal
- Ligadura posicional
- Ligadura por palabra clave o nombre

- **Parámetro:** Es el mecanismo de comunicación explícita y más recomendado para **conectar y compartir datos o subprogramas entre diferentes unidades de programa** (rutinas). Brinda ventajas fundamentales como la flexibilidad (al permitir transferir distintos datos en cada ejecución) y mayor seguridad (al evitar los efectos colaterales de acceder a variables globales en el ambiente no local).
- **Parámetro real (argumento):** Es el valor, variable o expresión concreta que se envía y especifica exactamente en el **momento de la invocación (o llamada)** a una rutina.
- **Parámetro formal:** Es la variable abstracta que se define en la **declaración o encabezado de la rutina**. Actúa como una variable local dentro de la unidad y su función es recibir o alojar el dato proveniente del parámetro real.
- **Ligadura posicional:** Es el método de vinculación donde los parámetros reales se asocian a los parámetros formales de manera estricta, **uno a uno, dependiendo de la posición que ocupan** en la lista. Para utilizarlo, el programador debe conocer y respetar obligatoriamente el orden exacto de los parámetros.
- **Ligadura por palabra clave o nombre:** Es una variante de vinculación donde los parámetros reales se asocian explícitamente nombrando al parámetro formal que los va a recibir. Su gran ventaja es que **permite colocar los argumentos en cualquier orden** (de manera indistinta) en la lista al momento de la llamada, aunque requiere conocer exactamente cómo se llama cada variable en la declaración. Un ejemplo de esta sintaxis en el lenguaje Ada sería `Ejem (C => z, A => x, B => y)`.
---
### Ejercicio 2
Unir los siguientes puntos según corresponda y de una definición y un ejemplo de cada par.

- Modo IN:
	- Valor
	- Valor constante

- Modo OUT:
	- Resultado
	- Resultado de funciones

- Modo IN / OUT:
	- Valor / Resultado
	- Referencia
	- Nombre

1. MODO IN (Conexión de Entrada)
En este modo, el parámetro formal recibe el dato desde el parámetro real únicamente al comienzo de la ejecución. Se debe unir con:
- **Valor (Por valor):**
    - **Definición:** El parámetro formal funciona como una nueva variable local que se inicializa con una copia del valor del parámetro real al invocar la unidad. La conexión se corta inmediatamente; las modificaciones locales no afectan a la variable original, lo que brinda mucha seguridad.
    - **Ejemplo:** Es el pasaje por defecto en C y Pascal. Por ejemplo, en Pascal: `Procedure P(a:integer);`. Si se invoca `P(x)`, la variable local `a` simplemente copia el valor numérico de `x`.
- **Valor constante:**
    - **Definición:** Se envía un valor inicial a la rutina, pero la semántica estática del lenguaje prohíbe terminantemente que la rutina receptora modifique ese parámetro formal.
    - **Ejemplo:** En C o C++, esto se logra anteponiendo la palabra reservada `const`, como en: `void ActualizarMax(const int x, const int y)`.

2. MODO OUT (Conexión de Salida)
El parámetro formal devuelve el dato al parámetro real únicamente cuando la rutina finaliza. Se debe unir con:
- **Resultado (Por resultado):**
    - **Definición:** El parámetro formal actúa como una variable local sin valor inicial (no recibe nada al comienzo). La rutina debe asignarle un valor y, al terminar su ejecución, este resultado se copia hacia el parámetro real.
    - **Ejemplo:** En el lenguaje Ada se utiliza el modo explícito `out`. Un ejemplo esquemático sería declarar `Procedure P(out a:integer)`, calcular un valor para `a` internamente, y al retornar, el parámetro real adoptará ese valor.
- **Resultado de funciones:**
    - **Definición:** Es el mecanismo estricto de retorno donde el valor calculado por una función reemplaza a la expresión en el punto donde dicha función fue invocada.
    - **Ejemplo:** Dependiendo del lenguaje, se efectúa usando la sentencia `return` (ej. `return m + 5;` en C y Python) o asignando el valor al nombre de la propia función (ej. `F1 := m + 5;` en Pascal).

3. MODO IN / OUT (Conexión de Entrada y Salida)
Permite recibir un valor al inicio y devolver un resultado al final, o mantener una vinculación constante durante la ejecución. Se debe unir con:
- **Valor / Resultado:**
    - **Definición:** Hay conexión solo en dos momentos: al inicio (se copia el valor del parámetro real al formal) y al final (el cálculo final del formal se copia de vuelta al real). Durante el intermedio, la rutina opera con su copia independiente.
    - **Ejemplo:** El lenguaje Ada utiliza este mecanismo por defecto cuando se usa la cláusula `in out` para tipos de datos primitivos (ej. enteros).
- **Referencia:**
    - **Definición:** No se copia el dato, sino que se transfiere el L-valor (dirección de memoria) del parámetro real. El parámetro formal se convierte en un puntero a esa misma dirección en el ambiente no local (generando una situación de _aliasing_). Los cambios efectuados en la rutina impactan inmediata y automáticamente sobre el parámetro real.
    - **Ejemplo:** En Pascal se especifica anteponiendo la palabra `var` en la firma de la rutina, por ejemplo: `Procedure P(var a:integer)`.
- **Nombre:**
    - **Definición:** Introducido conceptualmente por ALGOL60, se basa en la "Regla de la copia", donde el parámetro formal se sustituye textualmente por el parámetro real. Su evaluación es perezosa/diferida: utiliza cápsulas de código llamadas _thunks_ para evaluar la expresión en el entorno del llamador cada vez que se requiere dentro de la rutina.
    - **Ejemplo:** Si un parámetro real es un elemento indexado de un arreglo (por ejemplo, `a[i]`), y el iterador `i` cambia dentro de la rutina, el pasaje por nombre recalculará la posición de memoria apuntando a un elemento diferente en cada iteración del bucle, produciendo comportamientos sumamente dinámicos (y a veces engañosos).
---
### Ejercicio 3
1. Complete el siguiente cuadro según lo correspondiente a cada lenguaje:

| Tipo de pasaje de parámetros (por defecto)                                                                                                                                                                                                                                                                                                                                                    | Lenguaje |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| Implementa un abanico completo de modos: **IN** (por copia, es el que usa por defecto), **OUT** (por resultado) e **IN-OUT**.                                                                                                                                                                                                                                                                 | ADA      |
| Utiliza pasaje **por valor** por defecto. Si el programador necesita un comportamiento por referencia, debe simularlo explícitamente enviando punteros (la dirección de memoria). También admite explícitamente el pasaje por **valor constante** anteponiendo la keyword `const`.                                                                                                            | C        |
| Nominalmente es **por valor**, pero su comportamiento es idéntico al de Python: si el objeto enviado es mutable, no se copia la estructura y cualquier modificación impacta sobre el objeto original.                                                                                                                                                                                         | Ruby     |
| Estrictamente utiliza **sólo copia de valor**. Sin embargo, tiene un comportamiento dual: como las variables de tipos no primitivos (objetos, arreglos) son internamente referencias a variables anónimas en el Heap, cuando pasamos una de estas variables "por valor", estamos copiando la referencia. Por lo tanto, en la práctica, constituye un paso **por referencia** hacia el objeto. | Java     |
| Su comportamiento depende puramente del dato, el cual puede ser "inmutable" o "mutable". Si se envía un objeto inmutable (ej. un entero o tupla), actúa como un pasaje **por valor**. Si se envía un objeto mutable (ej. una lista), el lenguaje no realiza ninguna copia y la rutina trabaja directamente sobre la estructura original.                                                      | Python   |

2. Ada es más seguro que Pascal, respecto al pasaje de parámetros en las funciones. Explique por qué.
3. Explique cómo maneja Ada los tipos de parámetros in-out de acuerdo al tipo de dato
---
### Ejercicio 4
Sea el siguiente programa escrito en Pascal-like:
```pascal
Procedure Main;
var j, m, i: integer;

Procedure Recibe (x:integer; y:integer);
begin
	m:= m + 1 + y;
	x:=i + x + j;
	y:=m - 1;
	write (x, y, i, j, m);
end;

Procedure Dos;
var m:integer;
begin
	m:= 5;
	Recibe(i, j);
	write (i, j, m);
end;

begin
	m:= 2;
	i:=1; j:=3;
	Dos;
	write (i, j, m);
end.
```
1. Arme el árbol de anidamiento sintáctico y el registro de activación de cada una de las unidades.
2. Decir qué imprime el programa suponiendo que para todas las variables que se pasan el pasaje de parámetros es por: (Deberá hacer la pila estática y dinámica para cada caso)
	1. Referencia.
	2. Valor
	3. Valor Resultado
	4. Nombre
	5. Resultado.

3. ¿Existió algún caso que no pudo realizarlo porque saltó algún tipo de error? Diga cuál y por qué.
4. ¿Dará el mismo resultado si se trata de un lenguaje que sigue la cadena dinámica?Justifique la respuesta realizando las pilas de activación.
---
### Ejercicio 5
Suponiendo que se está ejecutando un programa con el siguiente registro de activación en memoria y se llama al procedimiento rutina(iter,vec,a). Determine el tipo de parámetro que se deben utilizar en el llamado para que los resultados sean los siguientes:
- **a)** (4,6,7),(4,6,7), 2, 2
- **b)** (3,5,6),(4,6,7), 2, 2
- **c)** (3,5,6),(5,5,6), 0, -1

| PR<br>LD<br>LE<br>Iter: true<br>Vec:[3,5,6]<br>a: -1<br>Rutina()<br>VR |
| ---------------------------------------------------------------------- |
```pascal
...

procedure rutina(tipoParam iteracion,tipoParam vector,tipoParam vit):​
	while iteracion begin
		vit = a+1
		vector[vit] = vector[vit]+1
		iteracion = (vector[vit] mod 2)==0​
	end​
	print vec
	print vector
	print vit
	print a

...

rutina(iter,vec,a)
```

Teniendo en cuenta que las instrucciones de impresión al final de la rutina siguen el orden `vec` (global), `vector` (parámetro), `vit` (parámetro) y `a` (global), los pasajes de parámetros se realizan de la siguiente manera:

Caso a) Resultados: `(4,6,7), (4,6,7), 2, 2`

- **Análisis:** El arreglo global `vec` terminó exactamente con los mismos datos que el parámetro local `vector`. A su vez, la variable global `a` terminó valiendo `2`, exactamente igual que el parámetro `vit`. Esto indica que los cambios realizados localmente impactaron de forma inmediata en las variables originales.
- **Respuesta:** Todos los parámetros (`vector` y `vit`) fueron pasados por **Referencia** (también daría el mismo resultado el pasaje por **Nombre**). Al ser alias, `vit = a + 1` equivale a `a = a + 1`, logrando que se incrementen las posiciones del arreglo de a una (`0, 1, 2`) en cada ciclo.

Caso b) Resultados: `(3,5,6), (4,6,7), 2, 2`

- **Análisis:** En este escenario, el arreglo global `vec` quedó intacto en `(3,5,6)`, indicando que la rutina operó sobre una copia. Sin embargo, la variable global `a` sí se modificó y terminó valiendo `2` (igual que `vit`), lo que permitió que la lógica avanzara a través de los índices `0, 1 y 2` del arreglo local.
- **Respuesta:** Se utilizaron modos de pasaje combinados. El parámetro `vector` fue pasado por **Valor** (o Modo IN), lo que protegió a la estructura original. Por el contrario, el parámetro `vit` debió ser pasado por **Referencia** (o Nombre), para mantener la situación de alias con `a` y lograr que su incremento avanzara el ciclo.

Caso c) Resultados: `(3,5,6), (5,5,6), 0, -1`

- **Análisis:** Ninguna de las variables globales (`vec` y `a`) sufrieron modificaciones, manteniéndose en `(3,5,6)` y `-1`. Como `a` se mantuvo siempre en `-1`, la instrucción local `vit = a + 1` causó que `vit` siempre valiera `0`. Por lo tanto, el bucle solo modificó repetidas veces el índice cero del `vector` local (pasando de 3 a 4, y luego de 4 a 5) hasta que la condición cortó.
- **Respuesta:** Todos los parámetros fueron pasados por **Valor** (creando copias puramente locales y desconectadas de las globales). _(Nota: Un pasaje por Valor-Resultado también produciría esta exacta impresión en pantalla, ya que los prints se ejecutan antes del cierre de la rutina, momento en el cual recién se sobreescribirían las variables globales)._
---
### Ejercicio 6
Indique con un ejemplo el comportamiento del parámetro por nombre (en el parámetro formal) para los siguientes casos de parámetros reales:
- Un valor entero.
- Una constante.
- Un elemento de un arreglo.
- Una expresión.
¿Qué sucede en cada caso? 

Introducido conceptualmente por ALGOL60, el pasaje **por nombre** no envía un valor ni una dirección simple, sino que aplica la "Regla de la copia": el parámetro formal es sustituido textualmente por la expresión del parámetro real. Para lograr esto, se utilizan **Thunks**, que son pequeñas cápsulas de código que posponen la evaluación del parámetro real hasta el momento exacto en que se lo necesita dentro de la rutina (evaluación perezosa o diferida).

Qué sucede en cada caso enviando distintos tipos de parámetros reales:

**1. Un valor entero (variable simple)**

- **Comportamiento:** Si pasamos el identificador de una variable simple (por ejemplo, una variable `x` de tipo entero), el pasaje por nombre **se comporta exactamente igual que el pasaje por Referencia**. Al sustituir textualmente la variable formal por la real, cualquier modificación local impactará directamente sobre la variable original.
- **Ejemplo:** Si invocamos `Rutina(x)` y la rutina hace `param = param + 1`, el compilador lo traduce literalmente como `x = x + 1`.

**2. Una constante**

- **Comportamiento:** Si pasamos un valor constante (por ejemplo, el número `5`), **se comporta de manera equivalente al pasaje por Valor** (o modo IN constante). El parámetro formal será reemplazado por el literal en todo el código.
- **Ejemplo:** Si invocamos `Rutina(5)`, cualquier intento de asignarle un nuevo valor al parámetro dentro de la rutina se traduciría en una aberración lógica como `5 = 5 + 1`, lo cual generará un error sintáctico/semántico inmediato, protegiendo así al dato de ser modificado.

**3. Un elemento de un arreglo (por ej. `vec[i]`)**

- **Comportamiento:** Este es el caso más característico y dinámico del pasaje por nombre. Si pasamos una posición indexada, el parámetro formal es reemplazado por el texto literal `vec[i]` (o `vec[a]`). Como la evaluación se recalcula cada vez que se usa el parámetro, **si el índice (`i` o `a`) cambia su valor durante la ejecución de la rutina, el parámetro formal pasará a apuntar a una posición completamente distinta del arreglo**.
- **Ejemplo:** Supongamos que pasamos `vec[a]` a una rutina y `a` vale inicialmente `1`. Si la rutina hace `param = 0` (entonces `vec` `= 0`), y luego la misma rutina incrementa la variable global haciendo `a = 2`, la próxima vez que se llame a `param = 0` internamente, estará modificando `vec` `= 0`.

**4. Una expresión (por ej. `x + y`)**

- **Comportamiento:** Si pasamos una expresión matemática o lógica completa, **esta se reevaluará por completo cada vez que el parámetro formal sea leído dentro de la rutina**, utilizando los valores más actualizados del entorno del llamador.
- **Ejemplo:** Si invocamos `Rutina(x + y)` y dentro de la rutina se ejecuta un bucle que imprime el valor del parámetro, imprimirá la suma original. Pero si en el medio del bucle la rutina altera la variable `x` global, la siguiente impresión del parámetro arrojará un resultado diferente, porque el _Thunk_ volverá a evaluar `x + y` con el nuevo valor de `x`.
---
### Ejercicio 7
Realice la pila de ejecución del siguiente programa:
- **a)** siguiendo la cadena estática
- **b)** siguiendo la cadena dinámica
```pascal
Procedure Uno;
	y, z: integer;
	r1:array[1..6] of integer;
	r2:array[1..5] of integer;
	Procedure Dos(nombre x, t:integer; var io:integer; valor-resultado y:integer);
		Procedure Dos(nombre t1:integer);
			Procedure Tres;
			begin
				y:= y + 1;
				z:= z + 1;
			end;
		begin
			t1:= t1 + 1;
			t:= t + 1;
			Tres;
			t1:= t1 + 2;
			t:= t + 2;
		end;
	begin
		x:= x + 1;
		t:= t + 1;
		io:= io + 1;
		x:= x + 2;
		if z =2 then Dos ( t );
	end;
begin
	for y:= 1 to 6 do r1(y):= 2;
	for y:= 1 to 5 do r2(y):= 1;
	z:= 2;
	y:= 1;
	Dos( r1( y + r2( y )), r2( z ), y, z);
	for y:= 1 to 6 do write (r1(y));
	for y:= 1 to 5 do write (r2(y));
end.
```
---
### Ejercicio 8
**a)​** Indique las diferencias entre los pasaje de subprogramas como parámetros deep y shallow.
**b)​** Realice la pila estática y dinámica tanto con el pasaje de parámetros deep y shallow para el siguiente código.
```pascal
Program A
Var x:integer;
Var y: char;
	
	Procedure B;
	Var h:integer;
	Begin
		h:=1+x;
		Write (y);
		C(D);
		Write (y);
	End;
	
	Procedure C (Subrutina S);
	Var x:integer;
	Var y: char;
	Begin
		x:=3;
		y:= "b";
		x:=S(x,y)
		y:= "j";
		Write (x,y);
	End;
	
	Function D (j:integer, k:char);
	Begin
		j:=j+x;
		k:=y;
		Write (k);
		Return j;
	End;
	
BEGIN
	x:=0;
	y:="a";
	B();
	Write (x,y);
END.
```

**a)** Cuando una rutina se transfiere como parámetro a otra y posteriormente es ejecutada, surge el problema semántico de decidir a qué entorno pertenecen y dónde se deben buscar sus variables "libres" o no locales (es decir, aquellas variables que usa en su interior pero que no están declaradas localmente dentro de ella). Para resolver esto, existen distintas reglas de ligadura:
- **Ligadura Deep (Profunda):** La rutina pasada como parámetro evalúa sus variables no locales en el entorno donde fue **definida o declarada** originalmente. Es el mecanismo estándar y natural adoptado por los lenguajes que utilizan reglas de **alcance estático o léxico**.
- **Ligadura Shallow (Superficial):** La rutina pasada como parámetro evalúa sus variables no locales en el entorno donde **es finalmente ejecutada o invocada** (es decir, busca los valores en el subprograma que la recibió como argumento y la llamó). Este mecanismo es propio de lenguajes que utilizan **alcance dinámico**.
---
### Ejercicio 9
Sea el siguiente código escrito en Pascal-like:
```pascal
Procedure main
	a: array(1..5) of integer;
	x: integer;
	i;integer;

	Procedure Uno (tipo_pasaje m:integer)
	Begin
		x:=0;
		x:=x+1;
		m:=m+x + a(3);
		x:=x*2;
		a(3):=a(3) - 1;
		m:=m+1;
	End;

Begin
	For i:=1 to 5 a(i):=1;
	x:=3;
	Uno(a(x));
	For i:=1 to 5 write (a(i));
End.
```
- **a)** Plantee diferencias, relacionada con la forma de implementación de cada uno y los resultados sobre este ejemplo considerando los siguientes tipos de pasajes parámetros nombre, referencia y valor resultado.
- **b)** ¿Qué sucede si en Uno se agrega la siguiente declaración: x: integer? Indique el resultado para cada uno de los tipos de pasajes de parámetros (nombre, referencia y valor resultado)

**a)** Diferencias e implementación con `x` como variable GLOBAL

En este caso inicial, el procedimiento `Uno` **no declara** una variable `x` local, por lo que cada vez que modifica `x` en su interior, está alterando directamente la variable global `x` del programa principal. El estado de la memoria antes de invocar a `Uno(a(x))` es:

- Arreglo global `a`: `(1, 1, 1, 1, 1)`
- Variable global `x`: `3`
- Invocación: `Uno(a(3))`

**1. Pasaje por REFERENCIA (o Variable)**

- **Implementación:** Se envía la dirección de memoria (L-valor) de `a(3)`. El parámetro formal `m` se convierte en un alias exacto de la posición `a(3)`. Cualquier modificación a `m` afectará a `a(3)` y viceversa.
- **Traza de ejecución:**
    - `x := 0; x := x + 1;` -> La variable global `x` pasa a valer `1`.
    - `m := m + x + a(3);` -> Como `m` es un alias de `a(3)`, la ecuación es `a(3) := a(3) + 1 + a(3)`. Inicialmente `a(3)` es 1, por lo que `a(3) := 1 + 1 + 1` = **3**.
    - `x := x * 2;` -> La variable global `x` pasa a valer `2`.
    - `a(3) := a(3) - 1;` -> Modifica directamente el arreglo. `a(3) := 3 - 1` = **2**. _(Nota: como_ _m_ _es alias, internamente_ _m_ _también vale 2 ahora)._
    - `m := m + 1;` -> Se modifica el alias. `a(3) := 2 + 1` = **3**.
- **Impresión Final:** **1, 1, 3, 1, 1**

**2. Pasaje por VALOR-RESULTADO**

- **Implementación:** Hay una copia al inicio y otra al final, pero **no hay vínculo durante la ejecución**. `m` es una variable puramente local que se inicializa con el R-valor de `a(3)`.
- **Traza de ejecución:**
    - El parámetro formal toma la copia: `m = 1`.
    - `x := 0; x := x + 1;` -> La variable global `x` pasa a valer `1`.
    - `m := m + x + a(3);` -> La ecuación opera con la copia de `m` y la variable global `a(3)` (que sigue valiendo 1 porque no se tocó). `m := 1 + 1 + 1` = **3**.
    - `x := x * 2;` -> La variable global `x` pasa a valer `2`.
    - `a(3) := a(3) - 1;` -> Modificamos globalmente el arreglo. `a(3) := 1 - 1` = **0**.
    - `m := m + 1;` -> La copia local cambia a `m := 3 + 1` = **4**.
    - **Retorno:** Al finalizar la rutina, se realiza la copia de salida del parámetro local `m` hacia la dirección reservada del parámetro real (generalmente evaluada a la entrada, que fue `a(3)`). Por ende, `a(3)` es sobrescrita y recibe el valor **4**.
- **Impresión Final:** **1, 1, 4, 1, 1**

**3. Pasaje por NOMBRE**

- **Implementación:** El parámetro formal `m` es sustituido textualmente por la expresión del parámetro real `a(x)`, mediante un _Thunk_. Por ende, **el índice al que apunta** **m** **variará si la variable** **x** **cambia durante la ejecución**.
- **Traza de ejecución:**
    - `x := 0; x := x + 1;` -> La variable global `x` pasa a valer **1**.
    - `m := m + x + a(3);` -> Textualmente es `a(x) := a(x) + x + a(3)`. Como `x` vale 1, modifica la posición 1. `a(1) := a(1) + 1 + a(3)`. O sea, `a(1) := 1 + 1 + 1` = **3**.
    - `x := x * 2;` -> La variable global `x` pasa a valer **2**.
    - `a(3) := a(3) - 1;` -> La variable global `a(3)` pasa a valer `1 - 1` = **0**.
    - `m := m + 1;` -> Textualmente es `a(x) := a(x) + 1`. Como `x` ahora vale 2, modifica la posición 2. `a(2) := a(2) + 1`. O sea, `a(2) := 1 + 1` = **2**.
- **Impresión Final:** **3, 2, 0, 1, 1**

**b)** ¿Qué sucede si se declara `x: integer` LOCALMENTE en `Uno`?

Al declarar `x: integer` dentro de la rutina `Uno`, se produce un "enmascaramiento" u ocultamiento. Todas las operaciones sobre `x` que ocurran dentro de `Uno` afectarán únicamente a esta nueva variable local. **La variable global** **x** **quedará estancada en** **3** **para todo el programa**.

El impacto en los resultados es total:

**1. Pasaje por REFERENCIA:** `m` será un alias inamovible de `a(global_x)`, es decir, `a(3)`. Aunque la `x` local suba a 1 y luego a 2, esto solo sumará localmente en la línea `m:=m+local_x+a(3)` (sumando 1). Al operar de esta manera, se repite exactamente la misma matemática que en el inciso _a)_, y la posición 3 absorbe todas las operaciones.

- **Impresión Final:** **1, 1, 3, 1, 1**

**2. Pasaje por VALOR-RESULTADO:** Ocurre exactamente la misma matemática que en el inciso _a)_. La variable `m` copia el valor original `1`, evoluciona temporalmente a `4`, y la instrucción intermedia `a(3):=a(3)-1` baja el arreglo a `0`. Al final, el `4` se copia hacia afuera y sobrescribe el `0`.

- **Impresión Final:** **1, 1, 4, 1, 1**

**3. Pasaje por NOMBRE (El cambio más notorio):** La teoría del pasaje por Nombre dictamina que **el parámetro formal debe evaluarse siempre en el entorno del llamador**. Por lo tanto, cuando el compilador sustituye `m` por el thunk `a(x)`, esa `x` no es la `x` local de `Uno`, sino que está firmemente ligada a la `x` global del `Main` (que vale rígidamente 3). Como la `x` global jamás cambia, `a(x)` siempre significará y apuntará exactamente a `a(3)`. En consecuencia, el pasaje por nombre pierde su comportamiento dinámico y pasa a actuar de forma **idéntica al pasaje por Referencia**.

- **Impresión Final:** **1, 1, 3, 1, 1**
---
