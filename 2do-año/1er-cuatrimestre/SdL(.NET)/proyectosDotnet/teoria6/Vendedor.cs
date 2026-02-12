namespace teoria6;

public class Vendedor : Empleado
{
    public Vendedor(string nombre, int dni, DateTime fIngreso, decimal salarioBase) : base(nombre, dni, fIngreso, salarioBase)
    {
    }

    public decimal Comision {get; set;}

    protected override decimal GetBonus()
        => Comision;

    public override void AumentarSalario()
    {
        if (this.Antiguedad >= 10)
            this.SalarioBase *= 1.10m;
        else
            this.SalarioBase *= 1.05m;
    }

    public override string ToString()
    {
        return $"Vendedor {base.ToString()}";
    }
}