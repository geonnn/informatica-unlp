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