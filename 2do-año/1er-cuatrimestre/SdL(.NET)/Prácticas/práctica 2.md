1) Sea el siguiente código:
```C#
object o1 = "A";
object o2 = o1;
o2 = "Z";
Console.WriteLine(o1 + " " + o2);
```

El tipo object es un tipo referencia, por lo tanto luego de la sentencia o2 = o1 ambas variables están apuntando a la misma dirección. ¿Cómo explica entonces que el resultado en la consola no sea “Z Z”?
> Después de la sentencia o2 = "Z", o2 almacena un puntero que apunta a otra dirección en memoria heap en donde se contiene "Z". Mientras tanto o1 no se modifica nunca y sigue apuntando a "A" en la heap.
---
2) Qué líneas del siguiente código provocan conversiones boxing y unboxing.
```C#
char c1 = 'A'; 
string st1 = "A";
object o1 = c1; // boxing.
object o2 = st1; // boxing.
char c2 = (char)o1; // unboxing
string st2 = (string)o2; // unboxing.
```
---
3) ¿Qué diferencias existen entre las conversiones de tipo implícitas y explícitas?
> Las operaciones explícitas requieren un operador de conversión, mientras que las implícitas no. Las conversiones implícitas las realiza por sí mismo el compilador, las explícitas requieren de una expresión cast, escrita por el programador.
```C#
byte b = 10;
double x = 12.25;
int i = b; // Conversión implícita de byte a int.
double y = i; // Conversión implícita de int a double.
short j = (short)i; // Conversión explícita de int a short.
i = (int)x; // Conversión explícita de double a int.
```
---
4) Resolver los errores de compilación en el siguiente fragmento de código. Utilizar el operador as cuando sea posible.
```C#
object o = "Hola Mundo!";
string st = o;
int i = 12;
byte b = i;
double d = i;
float f = d;
o = i;
i = o + 1;
```

```C#
object o = "Hola Mundo!";
string? st = o as string;
int? i = 12;
byte? b = (byte)i; // i as byte => byte is a non-nullable value type. i as byte? => the result of the expression is always null.
double? d = i;
float? f = (float)d; // d as float => float is a non-nullable value type. d as float? => the result of the expression is always null.
o = i;
i = (o as int?) + 1;
```
---
6) Supongamos que Program.cs sólo tiene las siguientes dos líneas:
```C#
int i;
Console.WriteLine(i);
```
¿Por qué no compila?
> La variable i no tiene ningún valor de inicialización. Basura =/= null.
---
7) ¿Cuál es la salida por consola del siguiente fragmento de código? ¿Por qué la tercera y sexta línea producen resultados diferentes?
```C#
char c1 = 'A';
char c2 = 'A';
Console.WriteLine(c1 == c2);
object o1 = c1;
object o2 = c2;
Console.WriteLine(o1 == o2);
```
> True
> False
> c1 == c2 compara dos variables cuyo valor se almacena en stack. o1 == o2 compara dos punteros que apuntan a distintas posiciones de memoria, por lo tanto son distintos. Para comparar el contenido de dos variables de tipo object se podría hacer o1.Equals(o2).
---
8) Investigar acerca de la clase StringBuilder del espacio de nombre System.Text ¿En qué circunstancias es preferible utilizar StringBuilder en lugar de utilizar string? Implementar un caso de ejemplo en el que el rendimiento sea claramente superior utilizando StringBuilder en lugar de string y otro en el que no.
9) Investigar sobre el tipo DateTime y usarlo para medir el tiempo de ejecución de los algoritmos implementados en el ejercicio anterior.
```C#
DateTime dt1 = DateTime.Now;
System.Console.WriteLine("Start Time: " + dt1);

string st = "";
int fin = 10000;
for (int i = 1; i < fin; i++)
{
    st += i + ", ";
}
st += fin;
System.Console.WriteLine(st);
DateTime dt2 = DateTime.Now;
System.Console.WriteLine("End Time: " + dt2);

TimeSpan duration = dt2 - dt1;
System.Console.WriteLine("Duration: " + duration.TotalMilliseconds + " ms");
```
> ~90ms.
```C#
using System.Text;
DateTime dt1 = DateTime.Now;
System.Console.WriteLine("Start Time: " + dt1);

StringBuilder st = new StringBuilder();
int fin = 10000;
for (int i = 1; i < fin; i++)
{
    st.Append(i).Append(", ");
}
st.Append(fin);
System.Console.WriteLine(st);

DateTime dt2 = DateTime.Now;
System.Console.WriteLine("End Time: " + dt2);

TimeSpan duration = dt2 - dt1;
System.Console.WriteLine("Duration: " + duration.TotalMilliseconds + " ms");
```
> ~40ms.
---
10) Comprobar el funcionamiento del siguiente programa y dibujar el estado de la pila y la memoria heap cuando la ejecución alcanza los puntos indicados (comentarios en el código).
```C#
using System.Text;

object[] v = new object[10];
v[0] = new StringBuilder("Net");
for (int i = 1; i < 10; i++)
{
v[i] = v[i - 1];
}
(v[5] as StringBuilder).Insert(0, "Framework .");
foreach (StringBuilder s in v)
Console.WriteLine(s);

//dibujar el estado de la pila y la mem. heap
//en este punto de la ejecución

v[5] = new StringBuilder("CSharp");
foreach (StringBuilder s in v)
Console.WriteLine(s);

//dibujar el estado de la pila y la mem. heap
//en este punto de la ejecución
```
![[Screenshot_3.png]]![[Screenshot_4.png]]
>Corrección: los objetos en el vector que está en la heap son punteros a un único object, modificar uno afecta a lo que se imprime en todas las posiciones del vector.
---
11) ¿Para qué sirve el método Split de la clase string? Usarlo para escribir en la consola todas las palabras (una por línea) de una frase ingresada por consola por el usuario.
```C#
void Imprimir(params string[] arrStr) {
    foreach (string st in arrStr) {
        Console.WriteLine(st);
    }
}

string? st = Console.ReadLine();
Imprimir(st.Split(' '));
```
---
12) Definir el tipo de datos enumerativo llamado Meses y utilizarlo para:
a) Imprimir en la consola el nombre de cada uno de los meses en orden inverso (diciembre, noviembre, octubre ..., enero).
b) Solicitar al usuario que ingrese un texto y responder si el texto tipeado corresponde al nombre de un mes
Nota: en todos los casos utilizar un for iterando sobre una variable de tipo Meses

**a)**
```C#
using System.Text;

StringBuilder sb = new StringBuilder();
for (Meses mes = Meses.diciembre; mes >= Meses.enero; mes--) {
    sb.Append(mes).Append(", ");
}
Console.Write(sb.ToString().TrimEnd(' ', ','));
    
enum Meses {
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre
}
```

**b)**
```C#
Console.WriteLine("Ingrese un texto: ");
string texto = Console.ReadLine();

foreach (Meses mes in Enum.GetValues(typeof(Meses))) {
    if (texto.Equals(mes.ToString())) {
        Console.WriteLine("El texto ingresado es un mes del año.");
    }
}

enum Meses {
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre
}
```
---
13) ¿Cuál es la salida por consola si no se pasan argumentos por la línea de comandos?
```C#
Console.WriteLine(args == null);
Console.WriteLine(args.Length);
```
> False
> 0
---
14) ¿Qué hace la instrucción? ¿Asigna a la variable vector el valor null?
```C#
int[]? vector = new int[0]
```
> No, inicializa un vector de enteros vacío.
---
15) Determinar qué hace el siguiente programa y explicar qué sucede si no se pasan parámetros cuando se invoca desde la línea de comandos.
```C#
Console.WriteLine("¡Hola {0}!", args[0]);
```
> Imprime el primer parámetro pasado por la consola, es decir el de la posición 0 en el arreglo args. Si no se pasa ningún parámetro tira el siguiente error:
```
Unhandled exception. System.IndexOutOfRangeException: Index was outside the bounds of the array.
```
---
16) Escribir un programa que reciba una lista de nombres como parámetro por la línea de comandos e imprima por consola un saludo personalizado para cada uno de ellos. 
	a) Utilizando la sentencia for
	b) Utilizando la sentencia foreach
**a)**
```C#
for (int i = 0; i < args.Length; i++)
{
    Console.WriteLine($"¡Hola {args[i]}!");
}
```
**b)**
```C#
foreach (string nom in args)
{
    Console.WriteLine($"¡Hola {nom}!");
}
```
---
17) Implementar un programa que muestre todos los números primos entre 1 y un número natural dado (pasado al programa como argumento por la línea de comandos). Definir el método bool EsPrimo(int n) que devuelve true sólo si n es primo. Esta función debe comprobar si n es divisible por algún número entero entre 2 y la raíz cuadrada de n. (Nota: Math.Sqrt(d) devuelve la raíz cuadrada de d)
```C#
bool EsPrimo(int n) {
    if (n <= 1) return false;
    if (n == 2) return true;
    for (int i = 2; i <= Math.Sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int? n = int.TryParse(args[0], out int result) ? result : null;
if (n != null) {
    int x = (int)n;
    for (int i = 1; i <= x; i++) {
        if (EsPrimo(i)) {
            Console.WriteLine($"El número {i} es primo.");
        }
    }
}
else Console.WriteLine("El parámetro ingresado debe ser un número entero.");
```
---
18) Escribir una función (método int Fac(int n)) que calcule el factorial de un número n pasado al programa como parámetro por la línea de comando.
	a) Definiendo una función no recursiva
	b) Definiendo una función recursiva
	c) idem a b) pero con expression-bodied methods (Tip: utilizar el operador condicional ternario)
```C#
// a)
int Fac(int n) {
    for (int i = n-1; i >= 2; i--) {
        n *= i;
    }
    return n;
}

// b)
int FacRecurs(int n) {
    if (n <= 2) return n;
    return n * FacRecurs(n - 1);
}

// c)
int FacEBM(int n) => (n <= 2) ? n : n * FacEBM(n-1);

int? n = int.TryParse(args[0], out int result) ? result : null;
if (n != null) {
    int x = (int)n;
    Console.WriteLine(Fac(x));
    Console.WriteLine(FacRecurs(x));
    Console.WriteLine(FacEBM(x));
}
else Console.WriteLine("El parámetro ingresado debe ser un número entero.");
```
---
19) Idem. al ejercicio 18.a) y 18.b) pero devolviendo el resultado en un parámetro de salida void Fac(int n, out int f)
```C#
// a)
void Fac(int n, out int f) {
    f = n;
    for (n = n-1; n >= 2; n--) {
        f *= n;
    }
}

// b)
void FacRecurs(int n, out int f) {
    if (n > 2)
    {
        FacRecurs(n - 1, out f);
        f *= n;
    }
    else f = n;
}

int? n = int.TryParse(args[0], out int result) ? result : null;
if (n != null) {
    int y, z;
    int x = (int)n;
    Fac(x, out y);
    FacRecurs(x, out z);
    Console.WriteLine(y);
    Console.WriteLine(z);
}
else Console.WriteLine("El parámetro ingresado debe ser un número entero.");
```
---
20) Codificar el método Swap que recibe 2 parámetros enteros e intercambia sus valores. El cambio debe apreciarse en el método invocador.
```C#
void Swap(ref int x, ref int y) {
    (x, y) = (y, x);
}

int x = 10; int y = 20;
System.Console.WriteLine($"x: {x} | y: {y}");
Swap(ref x, ref y);
System.Console.WriteLine($"x: {x} | y: {y}");
```
---
21) Codificar el método Imprimir para que el siguiente código produzca la salida por consola que se observa. Considerar que el usuario del método Imprimir podría querer más adelante imprimir otros datos, posiblemente de otros tipos pasando una cantidad distinta de parámetros cada vez que invoque el método. Tip: usar params
```C#
Imprimir(1, "casa", 'A', 3.4, DayOfWeek.Saturday);
Imprimir(1, 2, "tres");
Imprimir();
Imprimir("-------------");

// 1 casa A 3,4 Saturday
// 1 2 tres
//
// -------------
```

```C#
void Imprimir(params object[] v) {
    foreach (object obj in v)
    {
        Console.Write(obj + " ");
    }
    Console.Write("\n");
}

Imprimir(1, "casa", 'A', 3.4, DayOfWeek.Saturday);
Imprimir(1, 2, "tres");
Imprimir();
Imprimir("-------------");
```
