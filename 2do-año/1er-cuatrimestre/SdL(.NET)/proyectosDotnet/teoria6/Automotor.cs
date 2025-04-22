namespace teoria6;

class Automotor
{
    public string Marca {get; }
    private int _modelo;
    public virtual int Modelo
    {
        get => _modelo;
        protected set => _modelo = (value < 2005) ? 2005 : value; 
    }
    public Automotor(string marca, int modelo) {
        Marca = marca;
        Modelo = modelo;
    }
    public virtual void Imprimir ()
        => Console.WriteLine($"{Marca} {Modelo}");
}