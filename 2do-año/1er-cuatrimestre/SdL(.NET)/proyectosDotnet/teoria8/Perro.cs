namespace teoria8;

public class Perro : INombrable
{
    public string Nombre {get; set;} = "";

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
        return $"{Nombre} es un perro";
    }
}