void Imprimir(params object[] v) {
    foreach (object obj in v)
    {
        Console.Write(obj + " ");
    }
    Console.Write("\n");
}

Imprimir(1, "casa", 'A', 3.4, DayOfWeek.Saturday);
Imprimir(1, 2, "tres");
Imprimir();
Imprimir("-------------");