namespace teoria6;

class Auto: Automotor
{
    public Auto(string marca, int modelo, TipoAuto tipo): base(marca, modelo)
    {
        this.Tipo = tipo;
    } 
    public TipoAuto Tipo;
    public override void Imprimir()
    {
        Console.Write($"Auto {Tipo} ");
        base.Imprimir();
    }
}