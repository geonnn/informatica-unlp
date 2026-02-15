namespace teoria8;

public class Ingresador
{
    public event EventHandler? LineaVaciaIngresada;
    public event NroIngresadoEventHandler? NroIngresado;

    public void Ingresar()
    {
        string st = Console.ReadLine() ?? "";
        while (st != "fin")
        {
            if (st.Equals(""))
                LineaVaciaIngresada?.Invoke(this, EventArgs.Empty);
            else if (double.TryParse(st, out double n))
                NroIngresado?.Invoke(this, new NroIngresadoEventArgs() {Valor = n});

            st = Console.ReadLine() ?? "";
        }
    }
}