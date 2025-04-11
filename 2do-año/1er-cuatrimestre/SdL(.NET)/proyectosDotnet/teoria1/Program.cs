void ProcesarNumero(ref double num, string input) {
    try
    {
        num += double.Parse(input);
    }
    catch (Exception e)
    {
        System.Console.WriteLine($"Número ingresado no válido, excepción: {e.Message}");
    }
    finally {
        System.Console.WriteLine($"Acumulado: {num}");
    }
}


double num = 0;
string? input;

System.Console.WriteLine("Ingrese un número a sumar");
input = Console.ReadLine();
ProcesarNumero(ref num, input);
while (input != "") {
    System.Console.WriteLine("Ingrese un número a sumar");
    input = Console.ReadLine();
    System.Console.WriteLine();
    ProcesarNumero(ref num, input);
}