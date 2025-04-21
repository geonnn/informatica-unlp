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

int i = 1;
foreach (Persona p in personas)
{
    System.Console.WriteLine($"{i++}) {p}");
}
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

    public override string ToString()
    {
        return $"Nombre: {Nombre}, Edad: {Edad}, DNI: {DNI}";
    }

}

```
---
2) Modificar el programa anterior haciendo privados todos los campos. Definir un constructor adecuado y un método público Imprimir() que escriba en la consola los campos del objeto con el formato requerido para el listado.
---
3) Agregar a la clase Persona un método EsMayorQue(Persona p) que devuelva verdadero si la persona que recibe el mensaje tiene más edad que la persona enviada como parámetro. Utilizarlo para realizar un programa que devuelva la persona más jóven de la lista.
---
