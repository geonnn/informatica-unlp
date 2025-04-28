// -------------------- Program.cs -------------------- //

using Clases;

Matriz m = new Matriz(2, 4);
m.SetElemento(0, 2, 4);
m.SetElemento(1, 1, 4000);
m.SetElemento(1, 2, 3001);
m.Imprimir("0.00");

double[] fila = m.GetFila(1);

System.Console.WriteLine("---------");
foreach (double d in fila)
{
    System.Console.Write(d + " | ");
}

double[] columna = m.GetColumna(2);
System.Console.WriteLine("\n---------");
foreach (double d in columna)
{
    System.Console.Write(d + " | ");
}