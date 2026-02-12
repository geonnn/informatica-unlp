namespace teoria6;

public class Administrativo : Empleado
{
    public decimal Premio {get; set;}
    
    public Administrativo(string nombre, int dni, DateTime fIngreso, decimal salarioBase) : base(nombre, dni, fIngreso, salarioBase) { }
    
    protected override decimal GetBonus()
        => Premio;

    public override void AumentarSalario()
    {   
        this.SalarioBase += this.SalarioBase * this.Antiguedad/100m; // 100m para hacer división decimal y que no quede 0 entero.
    }

    public override string ToString()
    {
        return $"Administrativo {base.ToString()}";
    }
}