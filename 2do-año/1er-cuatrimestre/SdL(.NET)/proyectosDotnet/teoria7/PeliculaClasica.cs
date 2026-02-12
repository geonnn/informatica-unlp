namespace teoria7;

public class PeliculaClasica : Pelicula, IVendible
{
    public void SeVendeA(Persona p)
    {
        Console.WriteLine($"Vendiendo {this} a {p}");
    }

    public override string ToString()
    {
        return "película clásica";
    }
}