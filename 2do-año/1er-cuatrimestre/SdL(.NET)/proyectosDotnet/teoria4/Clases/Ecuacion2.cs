// -------------------- Ecuacion2.cs -------------------- //

namespace Clases;

public class Ecuacion2
{
    private double a;
    private double b;
    private double c;

    public Ecuacion2(double a, double b, double c)
    {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public double GetDiscriminante()
    {
        return (b*b)-4*a*c;
    }

    public int GetCantidadDeRaices()
    {
        double discr = this.GetDiscriminante();
        return (discr < 0) ? 0 : (discr == 0) ? 1 : 2;
    }

    public void ImprimirRaices()
    {
        int cantRaices = this.GetCantidadDeRaices();
        switch (cantRaices)
        {
            case 0:
                Console.WriteLine("La ecuación no posee soluciones reales.");
                break;
            case 1:
                Console.WriteLine((-b)/2*a);
                break;
            case 2:
                Console.WriteLine("x1: " + (-b + Math.Sqrt(this.GetDiscriminante()))/2*a);
                Console.WriteLine("x2: " + (-b - Math.Sqrt(this.GetDiscriminante()))/2*a);
                break;
        }
    }
}