namespace teoria7;

public class Auto : ILavable, IReciclable, IVendible
{
    public void Lavar()
    {
        Console.WriteLine("Lavando auto");
    }

    public void Reciclar()
    {
        Console.WriteLine("Reciclando auto");
    }

    public void Secar()
    {
        Console.WriteLine("Secando auto");
    }

    public void SeVendeA(Persona p)
    {
        Console.WriteLine($"Vendiendo auto a {p}");
    }
}