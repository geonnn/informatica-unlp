1) Tomar como base el ejercicio 2 de la práctica 7 e incorporar las interfaces, propiedades y métodos necesarios para que el siguiente código produzca la salida indicada:
```csharp
INombrable[] vector = [
new Persona() {Nombre="Zulema"},
new Perro() { Nombre = "Sultán" },
new Persona() { Nombre = "Claudia" },
new Persona() { Nombre = "Carlos" },
new Perro() { Nombre = "Chopper" },
];
Array.Sort(vector); // debe ordenar por Nombre alfabéticamente
foreach (INombrable n in vector)
{
    Console.WriteLine($"{n.Nombre}: {n}");
}
```
```console
Salida por consola
Carlos: Carlos es una persona
Chopper: Chopper es un perro
Claudia: Claudia es una persona
Sultán: Sultán es un perro
Zulema: Zulema es una persona
```

```csharp
// ----- INombrable.cs -----
namespace teoria8;

public interface INombrable : IComparable
{
    string Nombre {get; set;}
}

// ----- Persona.cs -----
namespace teoria8;

public class Persona : INombrable
{
    public string Nombre {get; set;} = "";

    public void Atender()
    {
        Console.WriteLine($"Atendiendo {this}");
    }

    public int CompareTo(object? obj)
    {
        int result = 0;
        if (obj is INombrable o)
        {
            result = this.Nombre.CompareTo(o.Nombre);
        }
        return result;
    }

    public override string ToString()
    {
        return $"{Nombre} es una persona";
    }
}

// ----- Perro.cs -----
namespace teoria8;

public class Perro : INombrable
{
    public string Nombre {get; set;} = "";

    public int CompareTo(object? obj)
    {
        int result = 0;
        if (obj is INombrable o)
        {
            result = this.Nombre.CompareTo(o.Nombre);
        }
        return result;
    }

    public override string ToString()
    {
        return $"{Nombre} es un perro";
    }
}
```
----
2) Modificar el ejercicio anterior para que el siguiente código produzca la salida indicada:
```csharp
INombrable[] vector = [
    new Persona() {Nombre="Ana María"},
    new Perro() { Nombre = "Sultán" },
    new Persona() { Nombre = "Ana" },
    new Persona() { Nombre = "José Carlos" },
    new Perro() { Nombre = "Chopper" },
];
Array.Sort(vector, new ComparadorLongitudNombre()); // ordena por longitud de nombre.
foreach (INombrable n in vector)
{
    Console.WriteLine($"{n.Nombre.Length}: {n.Nombre}");
}
```
```console
3: Ana
6: Sultán
7: Chopper
9: Ana María
11: José Carlos
```

```csharp
// ----- ComparadorLongitudNombre.cs -----

namespace teoria8;

public class ComparadorLongitudNombre : System.Collections.IComparer
{
    public int Compare(object? x, object? y)
    {
        int result = 0;
        if (x is INombrable o1 && y is INombrable o2)
        {
            int nom1 = o1.Nombre.Length;
            int nom2 = o2.Nombre.Length;
            result = nom1.CompareTo(nom2);
        }
        return result;
    }
}
```
---
3) Codificar usando iteradores los métodos:
   Rango(i, j, p) que devuelve la secuencia de enteros desde i hasta j con un paso de p.
   Potencia(b, k) que devuelve la secuencia b¹ ,b² ,....b$^k$.
   DivisiblePor(e,  i) retorna los elementos de e que son divisibles por i
   Observar la salida que debe producir el siguiente código:

```csharp
using System.Collections;

IEnumerable rango = Rango(6, 30, 3);
IEnumerable potencias = Potencias(2, 10);
IEnumerable divisibles = DivisiblesPor(rango, 6);
foreach (int i in rango)
{
	Console.Write(i + " ");
}
Console.WriteLine();
foreach (int i in potencias)
{
	Console.Write(i + " ");
}
Console.WriteLine();
foreach (int i in divisibles)
{
	Console.Write(i + " ");
}
Console.WriteLine();
```
```console
6 9 12 15 18 21 24 27 30
2 4 8 16 32 64 128 256 512 1024
6 12 18 24 30
```

```csharp
using System.Collections;

IEnumerable rango = Rango(6, 30, 3);
IEnumerable potencias = Potencias(2, 10);
IEnumerable divisibles = DivisiblesPor(rango, 6);

foreach (int i in rango)
{
    Console.Write(i + " ");
}
Console.WriteLine();
foreach (int i in potencias)
{
    Console.Write(i + " ");
}
Console.WriteLine();
foreach (int i in divisibles)
{
    Console.Write(i + " ");
}
Console.WriteLine();

IEnumerable Rango(int i, int j, int p)
{
    for (int current = i; current <= j; current += p)
        yield return current;
}

IEnumerable Potencias(int b, int k)
{
    int resultado = 1;
    for (int i = 1; i <= k; i++)
    {
        resultado *= b;
        yield return resultado;
    }
}

IEnumerable DivisiblesPor(IEnumerable e, int i)
{
    foreach (int n in e)
        if (n % i == 0)
            yield return n;
}
```
---
4) Declarar los tipos delegados necesarios para que el siguiente programa compile y produzca la salida en la consola indicada.
```csharp
Del1 d1 = delegate (int x) { Console.WriteLine(x); };
d1(10);

Del2 d2 = x => Console.WriteLine(x.Length);
d2(new int[] { 2, 4, 6, 8 });

Del3 d3 = x =>
{
    int sum = 0;
    for (int i = 1; i <= x; i++)
    {
        sum += i;
    }
    return sum;
};
int resultado = d3(10);
Console.WriteLine(resultado);

Del4 d4 = new Del4(LongitudPar);
Console.WriteLine(d4("hola mundo"));

bool LongitudPar(string st)
{
    return st.Length % 2 == 0;
}
```
```console
10
4
55
True
```

```csharp
delegate void Del1(int x);
delegate void Del2(int[] v);
delegate int Del3(int x);
delegate bool Del4(string st);
```
---
5) ¿Qué obtiene un método anónimo (o expresión lambda) cuando accede a una variable definida en el entorno que lo rodea, una copia del valor de la variable o la referencia a dicha variable?
   Tip: Observar la salida por consola del siguiente código:
```csharp
int i = 10;
Action a = delegate ()
{
	Console.WriteLine(i);
};
a.Invoke();
i = 20;
a.Invoke();
```
```console
10
20
```
Obtiene la referencia a la variable, implicando que puede modificarla y almacenarla.

---
6) Teniendo en cuenta lo respondido en el ejercicio anterior, ¿Qué salida produce en la consola la ejecución del siguiente programa?
```csharp
Action[] acciones = new Action[10];
for (int i = 0; i < 10; i++)
{
    acciones[i] = () => Console.Write(i + " ");
}
foreach (var a in acciones)
{
    a.Invoke();
}
```
Imprime diez veces "10".
```console
10 10 10 10 10 10 10 10 10 10
```
En el arreglo de acciones, se guarda en cada posición el delegado `Console.Write(i + " ")`, pero no se guarda una copia valor de i en el mismo momento, sólo queda la referencia a la variable. Cuando se termina de ejecutar el primer for, i queda en 10.
Después se hace `a.Invoke()` y cada delegado imprime i haciendo uso de la referencia a la variable.

---
7) En este ejercicio, se requiere extender el tipo int\[] con algunos métodos de extensión. Se presenta el código del método de extensión Print(this int\[] vector, string leyenda) que imprime en la consola los elementos del vector precedidos por una leyenda que se pasa como parámetro. Se requiere codificar el método de extensión Seleccionar(...) que recibe como parámetro un delegado de tipo FuncionEntera y devuelve un nuevo vector de enteros producto de aplicar la función recibida como parámetro a cada uno de los elementos del vector. El siguiente programa debe producir la salida indicada.
```csharp
// ----- Program.cs -----
int[] vector = [1, 2, 3, 4, 5];
vector.Print("Valores iniciales: ");
var vector2 = vector.Seleccionar(n => n * 3);
vector2.Print("Valores triplicados: ");
vector.Seleccionar(n => n * n).Print("Cuadrados: ");
// ----- FuncionEntera.cs -----
delegate int FuncionEntera(int n);
```
```console
Salida por consola
Valores iniciales: 1, 2, 3, 4, 5
Valores triplicados: 3, 6, 9, 12, 15
Cuadrados: 1, 4, 9, 16, 25
```
Para ello, completar el código de la siguiente clase estática VectorDeEnterosExtension
```csharp
// ----- VectorDeEnterosExtension.cs -----
namespace teoria8;

static class VectorDeEnterosExtension
{
    public static void Print(this int[] vector, string leyenda)
    {
        Console.WriteLine(leyenda + string.Join(", ", vector));
    }
    public static int[] Seleccionar(. . . )
    {
        . . .
    }
}
```

```csharp
namespace teoria8;

static class VectorDeEnterosExtension
{
    public static void Print(this int[] vector, string leyenda)
    {
        Console.WriteLine(leyenda + string.Join(", ", vector));
    }
    
    public static int[] Seleccionar(this int[] vector, FuncionEntera f)
    {
        int[] v = new int[vector.Length];
        for (int i = 0; i < vector.Length; i++)
        {
            v[i] = f(vector[i]);
        }
        return v;
    }
}
```
---
8) Agregar al ejercicio anterior el método de extensión Donde(...) para el tipo int\[] que recibe como parámetro un delegado de tipo Predicado y devuelve un nuevo vector de enteros con los elementos del vector que cumplen ese predicado. El siguiente programa debe producir la salida indicada.
```csharp
// -------Program.cs---------
int[] vector =[1, 2, 3, 4, 5];
vector.Print("Valores iniciales: ");
vector.Donde(n => n % 2 == 0).Print("Pares: ");
vector.Donde(n => n % 2 == 1).Seleccionar(n => n * n).Print("Impares al cuadrado: ");
// -------Predicado.cs---------
delegate bool Predicado(int n);
// -------FuncionEntera.cs---------
delegate int FuncionEntera(int n);
```
```console
Valores iniciales: 1, 2, 3, 4, 5
Pares: 2, 4
Impares al cuadrado: 1, 9, 25
```

```csharp
// ----- VectorDeEnterosExtension.cs -----
...
    public static int[] Donde(this int[] vector, Predicado p)
    {
        List<int> l = new List<int>();
        for (int i = 0; i < vector.Length; i++)
        {
            if (p(vector[i]))
            {
                l.Add(vector[i]);
            }
        }
        return l.ToArray();
    }
}
```