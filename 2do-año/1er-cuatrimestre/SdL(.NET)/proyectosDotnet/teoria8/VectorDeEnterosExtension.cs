namespace teoria8;

static class VectorDeEnterosExtension
{
    public static void Print(this int[] vector, string leyenda)
    {
        Console.WriteLine(leyenda + string.Join(", ", vector));
    }
    
    public static int[] Seleccionar(this int[] vector, FuncionEntera f)
    {
        int[] v = new int[vector.Length];
        for (int i = 0; i < vector.Length; i++)
        {
            v[i] = f(vector[i]);
        }
        return v;
    }

    public static int[] Donde(this int[] vector, Predicado p)
    {
        List<int> l = new List<int>();
        for (int i = 0; i < vector.Length; i++)
        {
            if (p(vector[i]))
            {
                l.Add(vector[i]);
            }
        }
        return l.ToArray();
    }
}