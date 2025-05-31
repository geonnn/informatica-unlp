using System.Text;

class Cuenta
{
    private double _monto;
    private int _titularDNI;
    private string? _titularNombre;

    public Cuenta()
    {
        
    }

    public void Imprimir()
    {
        Console.WriteLine($"Nombre: {_titularNombre}, DNI: {_titularDNI}, Monto: {_monto}");
    }
        
}