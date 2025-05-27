var lista = Enumerable.Range(0, 7)
                      .Select(i => ((DayOfWeek)i).ToString())
                      .Where(st => st.Contains('u'));

lista.ToList().ForEach(Console.WriteLine);

Console.WriteLine((Autos)2);

enum Autos
{
    corolla, toyota, peugeot
}
