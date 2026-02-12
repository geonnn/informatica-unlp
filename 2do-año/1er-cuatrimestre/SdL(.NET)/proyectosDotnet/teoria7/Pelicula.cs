namespace teoria7;

public class Pelicula : IAlquilable
{
    public void SeAlquilaA(Persona p)
    {
        Console.WriteLine($"Alquilando {this} a {p}");
    }

    public void SeDevuelvePor(Persona p)
    {
        Console.WriteLine($"{this} devuelta por {p}");
    }

    public override string ToString()
    {
        return "película";
    }
}