namespace teoria7;

public class Persona : IAtendible
{
    protected string Nombre = "";

    public void Atender()
    {
        Console.WriteLine($"Atendiendo {this}");
    }

    public override string ToString()
    {
        return "persona";
    }
}