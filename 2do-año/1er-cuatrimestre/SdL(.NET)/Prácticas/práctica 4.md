1) Definir una clase Persona con 3 campos públicos: Nombre, Edad y DNI. Escribir un algoritmo que permita al usuario ingresar en una consola una serie de datos de esta forma: Nombre,Documento,Edad \<ENTER>. Una vez finalizada la entrada de datos, el programa debe imprimir en la consola un listado con 4 columnas de la siguiente forma: 
```Nro) Nombre Edad DNI.```
Ejemplo de listado por consola:
```
1) Juan Perez 40 2098745
2) José García 41 1965412
...
```

> [!NOTE] NOTA
> Se puede utilizar: Console.SetIn(new System.IO.StreamReader(nombreDeArchivo)); para cambiar la entrada estándar de la consola y poder leer directamente desde un archivo de texto.

---
2) Modificar el programa anterior haciendo privados todos los campos. Definir un constructor adecuado y un método público Imprimir() que escriba en la consola los campos del objeto con el formato requerido para el listado.
---
3) Agregar a la clase Persona un método EsMayorQue(Persona p) que devuelva verdadero si la persona que recibe el mensaje tiene más edad que la persona enviada como parámetro. Utilizarlo para realizar un programa que devuelva la persona más jóven de la lista.

##### Programa principal:
```csharp
// -------------------- Program.cs -------------------- //

using Clases;

Console.WriteLine("Ingrese los datos de las personas de la siguiente manera:");
Console.WriteLine("Nombre, documento, edad.");
Console.WriteLine("Presione ENTER para ingresar los datos de la siguiente persona.");
Console.WriteLine("Ingrese nombre \"zzz\" para finalizar.");

string[] datos = Console.ReadLine().Split(", ");
int edad, dni;
LinkedList<Persona> personas = new();

while (datos[0] != "zzz") {
    dni = int.Parse(datos[1]);
    edad = int.Parse(datos[2]);
    personas.AddLast(new Persona(datos[0], edad, dni));
    Console.WriteLine("Ingrese datos de la siguiente persona: ");
    datos = Console.ReadLine().Split(", ");
}

Persona pJoven = new Persona("", int.MaxValue, 0);
int i = 1;
foreach (Persona p in personas)
{
    if (pJoven.EsMayorQue(p))
        pJoven = p;
    System.Console.WriteLine($"{i++}) {p}");
}

System.Console.WriteLine("La persona más joven es: " + pJoven);
```

##### Clase Persona:
```csharp
// -------------------- Persona.cs -------------------- //

namespace Clases;

public class Persona
{
    private string Nombre {get; set;}
    private int Edad {get; set;}
    private int DNI {get; set;}

    public Persona(string nom, int edad, int dni)
    {
        this.Nombre = nom;
        this.Edad = edad;
        this.DNI = dni;
    }
    
	public bool EsMayorQue(Persona p)
    {
        return this.Edad > p.Edad;
    }

    public override string ToString()
    {
        return $"Nombre: {Nombre}, Edad: {Edad}, DNI: {DNI}";
    }
}
```
---
4) Codificar la clase Hora de tal forma que el siguiente código produzca la salida por consola que se observa.
```csharp
Hora h = new Hora(23,30,15);
h.Imprimir
```
```
23 horas, 30 minutos y 15 segundos
```
---
5) Agregar un segundo constructor a la clase Hora para que pueda especificarse la hora por medio de un único valor que admita decimales. Por ejemplo 3,5 indica la hora 3 y 30 minutos. Si se utiliza este segundo constructor, el método imprimir debe mostrar los segundos con tres dígitos decimales. Así el siguiente código debe producir la salida por consola que se observa.
```csharp
new Hora(23, 30, 15).Imprimir();
new Hora(14.43).Imprimir();
new Hora(14.45).Imprimir();
new Hora(14.45114).Imprimir();
```
```
23 horas, 30 minutos y 15 segundos
14 horas, 25 minutos y 48,000 segundos
14 horas, 27 minutos y 0,000 segundos
14 horas, 27 minutos y 4,104 segundos
```

```csharp
// -------------------- Hora.cs -------------------- //

namespace Clases;

public class Hora
{
    private int Hr {get; set;}
    private int Min {get; set;}
    private double Seg {get; set;}
    private bool desdeDecimal;

    public Hora(int h, int m, int s)
    {
        this.Hr = h;
        this.Min = m;
        this.Seg = s;
        desdeDecimal = false;
    }

    public Hora(double h)
    {
        this.Hr = (int)h;

        double minsDecimales = (h - this.Hr) * 60;
        this.Min = (int)minsDecimales;

        this.Seg = (minsDecimales - this.Min) * 60;

        if (this.Seg >= 59.99995) {
            this.Seg = 0;
            this.Min++;
        }

        if (this.Min >= 60) {
            this.Min = 0;
            this.Hr++;
        }

        desdeDecimal = true;
    }

    public void Imprimir()
    {
        if (desdeDecimal)
            System.Console.WriteLine($"{Hr} horas, {Min} minutos y {Seg:0.000} segundos.");
        else
            System.Console.WriteLine($"{Hr} horas, {Min} minutos y {(int)Seg} segundos.");
    }
}
```
---
6) Codificar una clase llamada Ecuacion2 para representar una ecuación de 2º grado. Esta clase debe tener 3 campos privados, los coeficientes a, b y c de tipo double. La única forma de establecer los valores de estos campos será en el momento de la instanciación de un objeto Ecuacion2. Codificar los siguientes métodos:
● GetDiscriminante(): devuelve el valor del discriminante (double), el discriminante tiene la siguiente formula, (b^2)-4*a*c.
● GetCantidadDeRaices(): devuelve 0, 1 ó 2 dependiendo de la cantidad de raíces reales que posee la ecuación. Si el discriminante es negativo no tiene raíces reales, si el discriminante es cero tiene una única raíz, si el discriminante es mayor que cero posee 2 raíces reales.
● ImprimirRaices(): imprime la única o las 2 posibles raíces reales de la ecuación. En caso de no
poseer soluciones reales debe imprimir una leyenda que así lo especifique.

```csharp
// -------------------- Ecuacion2.cs -------------------- //

namespace Clases;

public class Ecuacion2
{
    private double a;
    private double b;
    private double c;

    public Ecuacion2(double a, double b, double c)
    {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public double GetDiscriminante()
    {
        return (b*b)-4*a*c;
    }

    public int GetCantidadDeRaices()
    {
        double discr = this.GetDiscriminante();
        return (discr < 0) ? 0 : (discr == 0) ? 1 : 2;
    }

    public void ImprimirRaices()
    {
        int cantRaices = this.GetCantidadDeRaices();
        switch (cantRaices)
        {
            case 0:
                Console.WriteLine("La ecuación no posee soluciones reales.");
                break;
            case 1:
                Console.WriteLine((-b)/2*a);
                break;
            case 2:
                Console.WriteLine("x1: " +
                (-b + Math.Sqrt(this.GetDiscriminante()))/2*a);
                
                Console.WriteLine("x2: " +
                (-b - Math.Sqrt(this.GetDiscriminante()))/2*a);
                
                break;
        }
    }
}
```
---
7) Implementar la clase Matriz que se utilizará para trabajar con matrices matemáticas. Implementar los dos constructores y todos los métodos que se detallan a continuación:
```csharp
public Matriz(int filas, int columnas)
public Matriz(double[,] matriz)
public void SetElemento(int fila, int columna, double elemento)
public double GetElemento(int fila, int columna)
public void imprimir()
public void imprimir(string formatString)
public double[] GetFila(int fila)
public double[] GetColumna(int columna)
public double[] GetDiagonalPrincipal()
public double[] GetDiagonalSecundaria()
public double[][] getArregloDeArreglo()
public void sumarle(Matriz m)
public void restarle(Matriz m)
public void multiplicarPor(Matriz m)
```

```csharp
// -------------------- Matriz.cs -------------------- //

namespace Clases;

public class Matriz
{
    private int filas;
    private int columnas;
    private double[,] matriz;

    public Matriz(int filas, int columnas)
    {
        this.matriz = new double[filas, columnas];
        this.filas = filas;
        this.columnas = columnas;
    }

    public Matriz(double[,] matriz)
    {
        this.matriz = matriz;
    }

    public void SetElemento(int fila, int columna, double elemento)
    {
        try
        {
            this.matriz[fila,columna] = elemento;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    public double GetElemento(int fila, int columna)
    {
        try
        {
            return this.matriz[fila,columna];
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return 0;
        }
    }

    public void Imprimir()
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
                Console.Write($"{matriz[i, j], 4} | ");
            Console.WriteLine();
        }
    }
    public void Imprimir(string formato)
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
                Console.Write($"{matriz[i, j].ToString(formato), 7} | ");
            Console.WriteLine();
        }
    }

    public double[] GetFila(int fila)
    {
        try
        {
            double[] vector = new double[columnas];
            for (int i = 0; i < columnas; i++)
                vector[i] = matriz[fila,i];
            return vector;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return new double[0];
        }
    }

    public double[] GetColumna(int columna)
    {
        try
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i,columna];
            return vector;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return new double[0];
        }
    }

    private bool EsCuadrada(double[,] matriz) => filas == columnas;

    public double[] GetDiagonalPrincipal(double[,] matriz)
    {
        if (!EsCuadrada(matriz))
            throw new ArgumentException();
        else
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, i];
            return vector;
        }
    }

    public double[] GetDiagonalSecundaria(double[,] matriz)
    {
        if (!EsCuadrada(matriz))
            throw new ArgumentException();
        else
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, filas - 1 - i];
            return vector;
        }
    }

    public double[][] GetArregloDeArreglo()
    {
        double[][] arrDeArr = new double[filas][];
        for (int i = 0; i < filas; i++) {
            arrDeArr[i] = new double[columnas];
            for (int j = 0; j < columnas; j++)
                arrDeArr[i][j] = matriz[i,j];
        }
        return arrDeArr;
    }

    public void Sumarle(Matriz m)
    {
        for (int i = 0; i < filas; i++)
            for (int j = 0; j < columnas; j++)
                this.matriz[i,j] += m.GetElemento(i,j);
    }

    public void Restarle(Matriz m)
    {
        for (int i = 0; i < filas; i++)
            for (int j = 0; j < columnas; j++)
                this.matriz[i,j] -= m.GetElemento(i,j);
    }

    public void MultiplicarPor(Matriz m)
    {
        if (this.columnas != m.filas)
            throw new ArgumentException();
        // En este punto ya se sabe que columnas de A = filas de B.
        else
        {
            double[,] matriz = new double[filas, m.columnas];

            // C# inicializa automáticamente en 0.
            // for (int i = 0; i < fA; i++)
            //     for (int j = 0; j < cB; j++)
            //         matriz[i,j] = 0;

            for (int i = 0; i < filas; i++)
            {
                for (int j = 0; j < m.columnas; j++)
                {
                    for (int k = 0; k < m.filas; k++)
                        matriz[i, j] += matriz[i, k] * m.GetElemento(k, j);
                }
            }
        }
    }
}
```
---
8) Prestar atención a los siguientes programas (ninguno funciona correctamente):
```csharp
Foo f = new Foo();
f.Imprimir();

class Foo
{
	string? _bar;
	public void Imprimir()
	{
	Console.WriteLine(_bar.Length);
	}
}
```

```csharp
Foo f = new Foo();
f.Imprimir();
class Foo
{
	public void Imprimir()
	{
		string? bar;
		Console.WriteLine(bar.Length);
	}
}
```

¿Qué se puede decir acerca de la inicialización de los objetos? ¿En qué casos son inicializados
automáticamente y con qué valor?

> No puede imprimir bar porque no tiene ningún valor de inicialización.
---
9) ¿Qué se puede decir en relación a la sobrecarga de métodos en este ejemplo?
```csharp
class A
{
    public void Metodo(short n)
    {
        Console.Write("short {0} - ", n);
    }
    public void Metodo(int n)
    {
        Console.Write("int {0} - ", n);
    }
    public int Metodo(int n)
    {
        return n + 10;
    }
}
```

> No se puede sobrecargar un método que ya existe con los mismos parámetros.
---
10) Completar la clase Cuenta para que el siguiente código produzca la salida indicada:
```csharp
Cuenta cuenta = new Cuenta();
cuenta.Imprimir();
cuenta = new Cuenta(30222111);
cuenta.Imprimir();
cuenta = new Cuenta("José Perez");
cuenta.Imprimir();
cuenta = new Cuenta("Maria Diaz", 20287544);
cuenta.Imprimir();
cuenta.Depositar(200);
cuenta.Imprimir();
cuenta.Extraer(150);
cuenta.Imprimir();
cuenta.Extraer(1500);
```

Salida:
```
Nombre: No especificado, DNI: No especificado, Monto: 0
Nombre: No especificado, DNI: 30222111, Monto: 0
Nombre: José Perez, DNI: No especificado, Monto: 0
Nombre: Maria Diaz, DNI: 20287544, Monto: 0
Nombre: Maria Diaz, DNI: 20287544, Monto: 200
Nombre: Maria Diaz, DNI: 20287544, Monto: 50
Operación cancelada, monto insuficiente
```

```csharp
class Cuenta
{
	private double _monto;
	private int _titularDNI;
	private string? _titularNobre;
. . .
}
```