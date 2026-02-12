namespace teoria7;

public class Libro : IAlquilable, IReciclable
{
    public void SeAlquilaA(Persona p)
    {
        Console.WriteLine($"Alquilando libro a {p}");
    }

    public void SeDevuelvePor(Persona p)
    {
        Console.WriteLine($"Libro devuelto por {p}");
    }

    public void Reciclar()
    {
        Console.WriteLine("Reciclando libro");
    }
}