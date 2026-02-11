1) Codificar la clase **Cuenta** de tal forma que el siguiente código produzca la salida por consola que se indica.
```csharp
Cuenta c1 = new Cuenta();
c1.Depositar(100).Depositar(50).Extraer(120).Extraer(50);
Cuenta c2 = new Cuenta();
c2.Depositar(200).Depositar(800);
new Cuenta().Depositar(20).Extraer(20);
c2.Extraer(1000).Extraer(1);
Console.WriteLine("\nDETALLE");
Cuenta.ImprimirDetalle();
```
```console
Se creó la cuenta Id=1
Se depositó 100 en la cuenta 1 (Saldo=100)
Se depositó 50 en la cuenta 1 (Saldo=150)
Se extrajo 120 de la cuenta 1 (Saldo=30)
Operación denegada - Saldo insuficiente
Se creó la cuenta Id=2
Se depositó 200 en la cuenta 2 (Saldo=200)
Se depositó 800 en la cuenta 2 (Saldo=1000)
Se creó la cuenta Id=3
Se depositó 20 en la cuenta 3 (Saldo=20)
Se extrajo 20 de la cuenta 3 (Saldo=0)
Se extrajo 1000 de la cuenta 2 (Saldo=0)
Operación denegada - Saldo insuficiente

DETALLE
CUENTAS CREADAS: 3
DEPÓSITOS: 5    - Total depositado: 1170
EXTRACCIONES: 3 - Total extraído: 1140
                - Saldo: 30
* Se denegaron 2 extracciones por falta de fondos
```

```csharp
// ----- Cuenta.cs ----- //
namespace teoria5;

public class Cuenta
{
    private static int s_cantCuentas = 0;
    private static int s_cantDepositos = 0;
    private static int s_cantExtracciones = 0;
    private static int s_cantExtraccionesFallidas = 0;
    private static double s_totalDepositado = 0;
    private static double s_totalExtraido = 0;
    private readonly int _id;
    public double Saldo {get; private set;} = 0;

    public Cuenta()
    {
        s_cantCuentas++;
        this._id = s_cantCuentas;
        Console.WriteLine($"Se creó la cuenta Id = {this._id}");
    }

    public Cuenta Depositar(double valor)
    {
        s_cantDepositos++;
        s_totalDepositado += valor;
        this.Saldo += valor;
        Console.WriteLine($"Se depositó {valor} en la cuenta {this._id} (Saldo = {this.Saldo})");
        return this;
    }

    public Cuenta Extraer(double valor)
    {
        if (this.Saldo >= valor)
        {
            s_cantExtracciones++;
            s_totalExtraido += valor;
            this.Saldo -= valor;
            Console.WriteLine($"Se extrajo {valor} de la cuenta {this._id} (Saldo = {this.Saldo})");
        }
        else
        {
            s_cantExtraccionesFallidas++;
            Console.WriteLine("Operación denegada - Saldo insuficiente");
        }
        return this;
    }

    public static void ImprimirDetalle()
    {
        Console.WriteLine($"CUENTAS CREADAS: {s_cantCuentas}");
        Console.Write($"DEPÓSITOS: {s_cantDepositos}");
        Console.WriteLine($" - Total depositado: {s_totalDepositado}");
        Console.Write($"EXTRACCIONES: {s_cantExtracciones}");
        Console.WriteLine($" - Total extraído: {s_totalExtraido}");
        Console.WriteLine($"- Saldo: {s_totalDepositado - s_totalExtraido}");
        Console.WriteLine($"* Se denegaron {s_cantExtraccionesFallidas} extracciones por falta de fondos");
    }
}
```

---
2) Agregar a la clase Cuenta del ejercicio anterior un método estático GetCuentas() que devuelva un List\<Cuenta> con todas las cuentas creadas. Controlar que la modificación de la lista devuelta, por ejemplo borrando algún elemento, no afecte el listado que internamente mantiene la clase Cuenta. Sin embargo debe ser posible interactuar efectivamente con los objetos Cuenta de la lista devuelta. Verificar que el siguiente código produzca la salida por consola que se indica:
```csharp
new Cuenta();
new Cuenta();
List<Cuenta> cuentas = Cuenta.GetCuentas();
// se recuperó la lista de cuentas creadas
cuentas[0].Depositar(50);
// se depositó 50 en la primera cuenta de la lista devuelta
cuentas.RemoveAt(0);
Console.WriteLine(cuentas.Count);
// se borró un elemento de la lista devuelta
// pero la clase Cuenta sigue manteniendo todos
// los datos "La cuenta id: 1 tiene 50 de saldo"
cuentas = Cuenta.GetCuentas();
// se recuperó nuevamente la lista de cuentas
Console.WriteLine(cuentas.Count);
cuentas[0].Extraer(30);
//se extrajo 30 de la cuenta id: 1 que tenía 50 de saldo
```
```console
Se creó la cuenta Id=1
Se creó la cuenta Id=2
Se depositó 50 en la cuenta 1 (Saldo=50)
1
2
Se extrajo 30 de la cuenta 1 (Saldo=20)
```

```csharp

...
	private static List<Cuenta> s_cuentas = [];
...
    public Cuenta()
    {
        s_cantCuentas++;
        this._id = s_cantCuentas;
        Console.WriteLine($"Se creó la cuenta Id = {this._id}");
        s_cuentas.Add(this);
    }

...

    public static List<Cuenta> GetCuentas()
    {
        List<Cuenta> lista = new List<Cuenta>(s_cuentas);
        return lista;
    }
}
```

---
3) Reemplazar el método estático GetCuentas() del ejercicio anterior por una propiedad estática de sólo lectura.
```csharp
...
	public static readonly List<Cuenta> Cuentas = [];
...
    public Cuenta()
    {
        s_cantCuentas++;
        this._id = s_cantCuentas;
        Console.WriteLine($"Se creó la cuenta Id = {this._id}");
        Cuentas.Add(this);
    }
...
```
El problema con hacerlo propiedad es que la lista que la propia clase Cuenta utiliza es lo que queda expuesto al hacer `Cuenta.Cuentas`, entonces puede ser modificada desde afuera.

---
4) Indicar en cada caso si la definición de la clase A es correcta, en caso de no serlo detallar cuál es el error.
```csharp
// a) ✅
class A
{
	static int s_a=0;
	static A()
	{
		s_a++;
	}
	public A()
	{
		s_a++;
	}
}

// b) ❌
class A
{
	static int s_a = 0;
	public static A() // no se permiten modificadores de acceso en const. estáticos.
	{
		s_a++;
	}
	A()
	{
		s_a++;
	}
}

// c) ❌
class A
{
	static int s_a = 0;
	static A(int a) // los const. estáticos no pueden recibir parámetros.
	{
		s_a=a;
	}
	A(int a)
	{
		s_a = a;
	}
}

// d) ✅
class A
{
	static int s_a = 0;
	int a = 0;
	static A()
	{
		s_a = 30;
	}
	A(int a)
	{
		s_a = a;
		this.a = a;
	}
}

// e) ❌
class A
{
	static int s_a = 0;
	int a = 0;
	static A()
	{
		a = 30; // An object reference is required for the non-static field, method, or property 'A.a'
	}
	A(int a)
	{
		a = s_a;
	}
}

// f)
class A ✅
{
	static int s_a = 1;
	int a = 0;
	static A() => s_a += s_a;
	public static A GetInstancia() => new A(1);
	A(int a) => this.a = a + s_a;
}

// g) ✅
class A
{
	const double PI = 3.1416;
	static double DoblePI = 2 * PI;
}

// h) ❌
class A
{
	static double PI = 3.1416;
	const double DoblePI = 2*PI; // no se pueden declarar constantes con otras variables.
}

// i) ✅
class A {
	static readonly List<int> _lista;
	static A()
	{
		_lista = new List<int>();
	}
	public static void P(int i)
	{
		_lista.Add(i);
	}
}

// j) ❌
class A {
	static readonly List<int> _lista;
	static A()
	{
		_lista = new List<int>();
	}
	public static void P(List<int> li)
	{
		_lista = li; // variables estáticas readonly sólo pueden ser asignadas en su declaración o en constructores.
	}
}

// k) ✅
class A
{
	static int[] vector = { 1, 2, 3 };
	public int this[int i]
	{
		get { return vector[i]; }
	}
}

// l) ❌
class A
{
	static int[] vector = { 1, 2, 3 };
	public static int this[int i] // no se pueden declarar indizadores estáticos.
	{
		get { return vector[i]; }
	}
}
```

---
5) Qué líneas del código siguiente provocan error de compilación? Analizar cuándo es posible acceder a miembros estáticos y de instancia.
```csharp
class A
{
	char c;
	static string st; // (warning) Non-nullable field 'st' must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring the field as nullable.
	
	void metodo1()
	{
		st = "string";
		c = 'A';
	}
	
	static void metodo2()
	{
		new A().c = 'a';
		st = "st2";
		c = 'B'; // An object reference is required for the non-static field, method, or property 'A.c'
		new A().st = "otro string"; // Member 'A.st' cannot be accessed with an instance reference; qualify it with a type name instead
	}
}
```
---
6) Modificar la definición de la clase Matriz realizada en la práctica 4. Eliminar los métodos SetElemento(...) y GetElemento(...). Definir un indizador adecuado para leer y escribir elementos de la matriz. Eliminar los métodos GetDiagonalPrincipal() y GetDiagonalSecundaria() reemplazándolos por las propiedades de sólo lectura DiagonalPrincipal y DiagonalSecundaria.
```csharp
...
    public double this[int fila, int columna]
    {
        get { return this.matriz[fila, columna]; }
        set { this.matriz[fila, columna] = value; }
    }
...
    private bool EsCuadrada => filas == columnas;

    public double[] DiagonalPrincipal
    {
        get
        {
            if (!EsCuadrada)
                throw new ArgumentException();

            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, i];
            return vector;
        }
    }

    public double[] DiagonalSecundaria
    {
        get
        {
            if (!EsCuadrada)
                throw new ArgumentException();
            
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, filas - 1 - i];
            return vector;
        }
    }
...
```
---
7) Definir la clase Persona con las siguientes propiedades de lectura y escritura: Nombre de tipo string, Sexo de tipo char, DNI de tipo int, y FechaNacimiento de tipo DateTime. Además definir una propiedad de sólo lectura (calculada) Edad de tipo int. Definir un indizador de lectura/escritura que permita acceder a las propiedades a través de un índice entero. Así, si p es un objeto Persona, con p[0] se accede al nombre, p[1] al sexo p[2] al DNI, p[3] a la fecha de nacimiento y p[4] a la edad. En caso de asignar p[4] simplemente el valor es descartado. Observar que el tipo del indizador debe ser capaz almacenar valores de tipo int, char, DateTime y string.
```csharp
public class Persona
{
    private const int _idxNombre = 0;
    private const int _idxSexo = 1;
    private const int _idxDni = 2;
    private const int _idxFechaNacimiento = 3;
    private const int _idxEdad = 4;

    public string Nombre { get; set; }
    public char Sexo { get; set; }
    public int Dni { get; set; }
    public DateTime FechaNacimiento { get; set; }

    public int Edad
    {
        get
        {
            DateTime today = DateTime.Today;
            int edad = today.Year - this.FechaNacimiento.Year;
            if (this.FechaNacimiento.DayOfYear > today.DayOfYear)
                edad -= 1;
            return edad;
        }
    }

    public object this[int i]
    {
        get => i switch
        {
            _idxNombre => Nombre,
            _idxSexo => Sexo,
            _idxDni => Dni,
            _idxFechaNacimiento => FechaNacimiento,
            _idxEdad => Edad,
            _ => throw new IndexOutOfRangeException($"El índice {i} no es válido para Persona.")
        };

        set
        {
            switch (i)
            {
                case _idxNombre:
                    if (value is string s) Nombre = s;
                    else throw new ArgumentException("El índice 0 (Nombre) espera un string.");
                    break;

                case _idxSexo:
                    if (value is char c) Sexo = c;
                    else if (value is string str && str.Length == 1) Sexo = str[0];
                    else throw new ArgumentException("El índice 1 (Sexo) espera un char.");
                    break;

                case _idxDni:
                    if (value is int dni) Dni = dni;
                    else throw new ArgumentException("El índice 2 (DNI) espera un entero.");
                    break;

                case _idxFechaNacimiento:
                    if (value is DateTime fecha) FechaNacimiento = fecha;
                    else throw new ArgumentException("El índice 3 (Fecha) espera un DateTime.");
                    break;

                case _idxEdad:
                    throw new InvalidOperationException("La propiedad Edad es calculada y de solo lectura.");
                default:
                    throw new IndexOutOfRangeException($"El índice {i} no es válido para Persona.");
            }
        }
    }
}
```
---
8) Dada la siguiente definición incompleta de clase:
```csharp
class ListaDePersonas
{
	public void Agregar(Persona p)
	{
	. . .
	}
	. . .
}
```
Completarla y agregar dos indizadores de sólo lectura:
Un índice entero que permite acceder a las personas de la lista por número de documento. Por ejemplo p=lista[30456345] devuelve el objeto Persona que tiene DNI=30456345 o null en caso que no exista en la lista.
Un índice de tipo char que devuelve un List\<string> con todos los nombres de las personas de la lista que comienzan con el carácter pasado como índice.
```csharp
namespace teoria5;

public class ListaDePersonas
{
    private List<Persona> _lista = [];

    public Persona? this[int dni]
    {
        get => _lista.Find(p => p.Dni == dni);
    }
    
    public List<string> this[char c]
    {
        get
        {
            return _lista.Where(p => p.Nombre[0] == c)
                    .Select(p => p.Nombre).ToList();
        }
    }

    public void Agregar(Persona p)
    {
        _lista.Add(p);
    }
}
```
---
9) ¿Cuál es el error en el siguiente programa?
```csharp
Auto a = new Auto();
a.Marca = "Ford";
Console.WriteLine(a.Marca);

class Auto
{
	private string marca;
	public string Marca
	{
		set
		{
			Marca = value; // esta línea vuelve a llamar a este set. Lo que debería asignarse acá es la variable privada. Se genera un stack overflow.
		}
		get
		{
			return marca;
		}
	}
}
```
---
10) Identificar todos los miembros en la siguiente declaración de clase. Indicar si se trata de un constructor, método, campo, propiedad o indizador, si es estático o de instancia, y en caso que corresponda si es de sólo lectura, sólo escritura o lectura y escritura. En el caso de las propiedades indicar también si se trata de una propiedad auto-implementada.
    Nota: La clase compila perfectamente. Sólo prestar atención a la sintaxis, la semántica es irrelevante.
```csharp
class A
{
	private static int a; // campo estático privado, l y e.
	private static readonly int b; // campo estático privado, l.
	A() { } // constructor de instancia.
	public A(int i) : this() { } // constructor de instancia público.
	static A() => b = 2; // constructor estático.
	int c; // campo de instancia, l y e.
	public static void A1() => a = 1; // método estático público.
	public int A1(int a) => A.a + a; // método de instancia público.
	public static int A2; // campo estático público.
	static int A3 => 3; // propiedad estática, l.
	private int A4() => 4; // método de instancia privado.
	public int A5 { get => 5; } // propiedad de instancia pública, l.
	int A6 { set => c = value; } // propiedad de instancia, l.
	public int A7 { get; set; } // propiedad de instancia pública, l y e, auto-implementada.
	public int A8 { get; } = 8; // propiedad de instancia pública, l, auto-implementada.
	public int this[int i] => i; // indizador público de instancia (los indizadores siempre son de instancia), l.
}
```
---
11) ¿Qué diferencia hay entre estas dos declaraciones?
```csharp
// a) es un campo, que se inicializa con el valor 3.
// o sea una variable que almacena un valor modificable.
public int X = 3;

// b) es una propiedad de sólo lectura, que retorna un 3 siempre.
// => 3 es equivalente a get { return 3; }.
// es lógica que se ejecuta, no se almacena nada.
public int X => 3;
```
