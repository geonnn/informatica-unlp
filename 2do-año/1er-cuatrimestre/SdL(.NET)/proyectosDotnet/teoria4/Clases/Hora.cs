// -------------------- Hora.cs -------------------- //

namespace Clases;

public class Hora
{
    private int Hr {get; set;}
    private int Min {get; set;}
    private double Seg {get; set;}
    private bool desdeDecimal;

    public Hora(int h, int m, int s)
    {
        this.Hr = h;
        this.Min = m;
        this.Seg = s;
        desdeDecimal = false;
    }

    public Hora(double h)
    {
        this.Hr = (int)h;

        double minsDecimales = (h - this.Hr) * 60;
        this.Min = (int)minsDecimales;

        this.Seg = (minsDecimales - this.Min) * 60;

        if (this.Seg >= 59.99995) {
            this.Seg = 0;
            this.Min++;
        }

        if (this.Min >= 60) {
            this.Min = 0;
            this.Hr++;
        }

        desdeDecimal = true;
    }

    public void Imprimir()
    {
        if (desdeDecimal)
            System.Console.WriteLine($"{Hr} horas, {Min} minutos y {Seg:0.000} segundos.");
        else
            System.Console.WriteLine($"{Hr} horas, {Min} minutos y {(int)Seg} segundos.");
    }
}