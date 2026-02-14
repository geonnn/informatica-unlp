namespace teoria8;

public class Persona : INombrable
{
    public string Nombre {get; set;} = "";

    public void Atender()
    {
        Console.WriteLine($"Atendiendo {this}");
    }

    public int CompareTo(object? obj)
    {
        int result = 0;
        if (obj is INombrable o)
        {
            result = this.Nombre.CompareTo(o.Nombre);
        }
        return result;
    }

    public override string ToString()
    {
        return $"{Nombre} es una persona";
    }
}