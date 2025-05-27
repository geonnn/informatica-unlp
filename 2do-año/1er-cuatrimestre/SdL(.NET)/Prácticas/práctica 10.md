1) Utilizando el método Range de la clase System.Linq.Enumerable y los métodos de LINQ que sean necesarios, obtener:
a) Lista con todos los múltiplos de 5 entre 100 y 200
b) Lista con todos los números primos menores que 100
c) Lista con las potencias de 2, desde $2^0$ a $2^10$
d) La suma y el promedio de los valores de la lista anterior
e) Lista de todos los $n^2$ que terminan con el dígito 6, para n entre 1 y 20
f) Lista con los nombres de los días de la semana en inglés que contengan una letra ‘u’
(tip: utilizar el enumerativo DayOfWeek)

```csharp
// a)
var lista = Enumerable.Range(100, 101)
                      .Where(n => n%5 == 0);

var enumerator = lista.GetEnumerator();

// Para imprimir:
while (enumerator.MoveNext())
    Console.WriteLine(enumerator.Current);
    
// también podría ser:
// lista.ToList().ForEach(Console.WriteLine);
```

```csharp
// b)
var lista = Enumerable.Range(1, 100)
                      .Where(EsPrimo);

bool EsPrimo(int n)
{
    if (n <= 1) return false;
    if (n == 2) return true;
    for (int i = 2; i <= Math.Sqrt(n); i++)
    {
        if (n % i == 0) return false;
    }
    return true;
}
```

```csharp
// c)
var lista = Enumerable.Range(0, 11)
                      .Select(n => Math.Pow(2, n));

// esto está mal porque leímos de 20 a 210 en la consigna pero lo dejo porque está buena la resolución y puede servir.
var lista = Enumerable.Range(20, 191)
                      .Where(n => double.IsInteger(Math.Log2(n)));
 
```

```csharp
// d)
var suma = lista.Sum();
var prom = lista.Average();

Console.WriteLine($"suma: {suma} | promedio: {prom:0.000}");
```

```csharp
// e)
var lista = Enumerable.Range(1, 21)
                      .Where(n => Math.Pow(n, 2) % 10 == 6)
                      .Select(n => n*n);
```

```csharp
// f)
var lista = Enumerable.Range(0, 7)
                      .Select(i => ((DayOfWeek)i).ToString())
                      .Where(st => st.Contains('u'));

// otra opción:
var lista = Enum.GetNames<DayOfWeek>().Where(st => st.Contains('u'));
```