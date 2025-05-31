// -------------------- Program.cs -------------------- //

class A
{
    public void Metodo(short n)
    {
        Console.Write("short {0} - ", n);
    }
    public void Metodo(int n)
    {
        Console.Write("int {0} - ", n);
    }
    public int Metodo(int n)
    {
        return n + 10;
    }
}