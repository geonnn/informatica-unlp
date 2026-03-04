1) Codificar el método genérico Get para que el siguiente código produzca la salida en la consola indicada.
```csharp
List<object> lista = [ "hola", 7, 'A' ];
string st = Get<string>(lista, 0);
int i = Get<int>(lista, 1);
char c = Get<char>(lista, 2);
Console.WriteLine($"{st} {i} {c}");
```
```console
hola 7 A
```

```csharp
T Get<T>(List<object> l, int pos)
{
    if (l[pos] is T valor)
        return valor;
    
    throw new Exception($"El elemento en la pos {pos} no es del tipo indicado {typeof(T)}.");
}
```
---
2) Codificar los métodos que faltan para que el siguiente código produzca la salida en la consola indicada.
```csharp
int[] vector1 = [1, 2, 3];
bool[] vector2 = [true, true, true];
string[] vector3 = ["uno", "dos", "tres"];
Set<int>(vector1, 110, 2);
Set<bool>(vector2, false, 1);
Set<string>(vector3, "Hola Mundo!", 0);
Imprimir(vector1);
Imprimir(vector2);
Imprimir(vector3);
```
```console
1 2 110
True False True
Hola Mundo! dos tres
```
Debe evitarse que durante la ejecución del método Imprimir se produzca boxing o unboxing. **Tip:** El método Imprimir también es un método genérico, no se advierte fácilmente porque no se ha explicitado el parámetro de tipo (el compilador lo infiere).
```csharp
static void Set<T>(T[] arr, T valor, int pos)
    => arr[pos] = valor;

static void Imprimir<T>(T[] arr)
{
    Array.ForEach(arr, x => Console.Write(x + " "));
    Console.WriteLine();
}
```
---
3) Codificar los métodos genéricos CrearArreglo y GetNuevoObjetoDelMismoTipo que faltan para que el siguiente código produzca la salida en la consola indicada. El método GetNuevoObjetoDelMismoTipo debe crear y devolver un nuevo elemento del mismo tipo del que recibe como parámetro. Tip: Para codificar el método CrearArreglo tener presente el uso de params
 ```csharp
string[] vector1 = CrearArreglo<string>("uno", "dos");
foreach (string st in vector1) Console.Write(st + " - ");
Console.WriteLine();
double[] vector2 = CrearArreglo<double>(1, 2.3, 4.1, 6.7);
foreach (double valor in vector2) Console.Write(valor + " - ");
Console.WriteLine();
var stb = new System.Text.StringBuilder();
var a = GetNuevoObjetoDelMismoTipo(stb);
var b = GetNuevoObjetoDelMismoTipo(17);
Console.WriteLine(a.GetType());
Console.WriteLine(b.GetType());
 ```
```console
uno - dos -
1 - 2,3 - 4,1 - 6,7 -
System.Text.StringBuilder
System.Int32
```
Nota: el método GetNuevoObjetoDelMismoTipo sólo funciona con parámetros cuyo tipo debe ser no abstracto y con un constructor público sin parámetros.
```csharp
T[] CrearArreglo<T>(params T[] p)
    => p;

T GetNuevoObjetoDelMismoTipo<T>(T v) where T : new()
{
    return new T();
}
```
---
4) Dada la siguiente clase genérica
```csharp
class Nodo<T>
{
	public T Valor { get; private set; }
	public Nodo<T>? Proximo { get; set; } = null;
	public Nodo(T valor) => Valor = valor;
}
```
Utilizar la clase Nodo\<T> para codificar codificar una lista enlazada genérica tal manera que el código siguiente produzca la salida indicada:
```csharp
var lista = new ListaEnlazada<int>();
lista.AgregarAdelante(3);
lista.AgregarAdelante(100);
lista.AgregarAtras(10);
lista.AgregarAtras(11);
lista.AgregarAdelante(0);
IEnumerator<int> enumerador = lista.GetEnumerator();
while (enumerador.MoveNext())
{
	int i = enumerador.Current;
	Console.Write(i + " ");
}
Console.WriteLine();
```
```console
0 100 3 10 11
```

```csharp
public class ListaEnlazada<T> : IEnumerable<T>
{
    private Nodo<T>? pri = null;

    public void AgregarAdelante(T v)
    {
        Nodo<T> n = new Nodo<T>(v);
        n.Proximo = pri;
        pri = n;
    }

    public void AgregarAtras(T v)
    {
        Nodo<T> n = new Nodo<T>(v);

        if (pri == null)
            pri = n;
        else
        {
            Nodo<T> aux = pri;
            while (aux.Proximo != null)
                aux = aux.Proximo;
            aux.Proximo = n;
        }
    }

    public IEnumerator<T> GetEnumerator()
    {
        Nodo<T>? current = pri;
        while (current != null)
        {   
            yield return current.Valor;
            current = current.Proximo;
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}
```
---
5) En esta teoría vimos que la clase List\<T> implementa el método Foreach que recibe un Action\<T> como parámetro y que permite código como el siguiente: