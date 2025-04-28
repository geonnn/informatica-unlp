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
```C#
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
```C#
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
```C#
Hora h = new Hora(23,30,15);
h.Imprimir
```
```
23 horas, 30 minutos y 15 segundos
```
---
5) Agregar un segundo constructor a la clase Hora para que pueda especificarse la hora por medio de un único valor que admita decimales. Por ejemplo 3,5 indica la hora 3 y 30 minutos. Si se utiliza este segundo constructor, el método imprimir debe mostrar los segundos con tres dígitos decimales. Así el siguiente código debe producir la salida por consola que se observa.
```C#
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

```C#
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

```C#
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
```C#
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

```C#

```