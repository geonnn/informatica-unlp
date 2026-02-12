namespace teoria6;

public abstract class Empleado
{
    public string Nombre { get; protected set; }
    public int Dni { get; protected set; }
    public DateTime FechaDeIngreso { get; protected set; }
    public decimal SalarioBase { get; protected set; }
    public decimal Salario
    {
        get => SalarioBase + GetBonus();
    }
    protected int Antiguedad
    {
        get
        {
            // DateTime today = DateTime.Today;
            DateTime today = new DateTime(2022, 04, 09);
            DateTime fIngreso = this.FechaDeIngreso;

            int anios = today.Year - fIngreso.Year;

            if (fIngreso.AddYears(anios) > today)
                anios--;

            return (anios < 0) ? 0 : anios;
        }
    }

    protected Empleado(string nombre, int dni, DateTime fIngreso, decimal salarioBase)
    {
        this.Nombre = nombre;
        this.Dni = dni;
        this.FechaDeIngreso = fIngreso;
        this.SalarioBase = salarioBase;
    }

    protected abstract decimal GetBonus();
    public abstract void AumentarSalario();

    public override string ToString()
    {
        return $"Nombre: {this.Nombre}, DNI: {this.Dni}, Antigüedad: {this.Antiguedad}, Salario base: {this.SalarioBase}, Salario: {this.Salario}.";
    }
}