Console.WriteLine("Ingrese un texto: ");
string texto = Console.ReadLine();

foreach (Meses mes in Enum.GetValues(typeof(Meses))) {
    if (texto.Equals(mes.ToString())) {
        Console.WriteLine("El texto ingresado es un mes del año.");
    }
}

enum Meses {
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre
}