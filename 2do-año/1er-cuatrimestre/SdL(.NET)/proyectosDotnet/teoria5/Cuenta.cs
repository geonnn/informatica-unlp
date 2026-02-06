namespace teoria5;

public class Cuenta
{
    private static int s_cantCuentas = 0;
    private static int s_cantDepositos = 0;
    private static int s_cantExtracciones = 0;
    private static int s_cantExtraccionesFallidas = 0;
    private static double s_totalDepositado = 0;
    private static double s_totalExtraido = 0;
    public static readonly List<Cuenta> Cuentas = [];
    private readonly int _id;
    public double Saldo {get; private set;} = 0;

    public Cuenta()
    {
        s_cantCuentas++;
        this._id = s_cantCuentas;
        Console.WriteLine($"Se creó la cuenta Id = {this._id}");
        Cuentas.Add(this);
    }

    public Cuenta Depositar(double valor)
    {
        s_cantDepositos++;
        s_totalDepositado += valor;
        this.Saldo += valor;
        Console.WriteLine($"Se depositó {valor} en la cuenta {this._id} (Saldo = {this.Saldo})");
        return this;
    }

    public Cuenta Extraer(double valor)
    {
        if (this.Saldo >= valor)
        {
            s_cantExtracciones++;
            s_totalExtraido += valor;
            this.Saldo -= valor;
            Console.WriteLine($"Se extrajo {valor} de la cuenta {this._id} (Saldo = {this.Saldo})");
        }
        else
        {
            s_cantExtraccionesFallidas++;
            Console.WriteLine("Operación denegada - Saldo insuficiente");
        }
        return this;
    }

    public static void ImprimirDetalle()
    {
        Console.WriteLine($"CUENTAS CREADAS: {s_cantCuentas}");
        Console.Write($"DEPÓSITOS: {s_cantDepositos}");
        Console.WriteLine($" - Total depositado: {s_totalDepositado}");
        Console.Write($"EXTRACCIONES: {s_cantExtracciones}");
        Console.WriteLine($" - Total extraído: {s_totalExtraido}");
        Console.WriteLine($"- Saldo: {s_totalDepositado - s_totalExtraido}");
        Console.WriteLine($"* Se denegaron {s_cantExtraccionesFallidas} extracciones por falta de fondos");
    }
}