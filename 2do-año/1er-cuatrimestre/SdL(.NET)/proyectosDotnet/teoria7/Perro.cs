namespace teoria7;

public class Perro : IVendible, IAtendible, ILavable
{
    public void SeVendeA(Persona p)
    {
        Console.WriteLine($"Vendiendo perro a {p}");
    }

    public void Atender()
    {
        Console.WriteLine($"Atendiendo perro");
    }

    public void Lavar()
    {
        Console.WriteLine("Lavando perro");
    }

    public void Secar()
    {
        Console.WriteLine("Secando perro");
    }
}