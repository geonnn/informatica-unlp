namespace teoria8;

public class ComparadorLongitudNombre : System.Collections.IComparer
{
    public int Compare(object? x, object? y)
    {
        int result = 0;
        if (x is INombrable o1 && y is INombrable o2)
        {
            int nom1 = o1.Nombre.Length;
            int nom2 = o2.Nombre.Length;
            result = nom1.CompareTo(nom2);
        }
        return result;
    }
}