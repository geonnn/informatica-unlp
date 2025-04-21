namespace Automotores;

public class Auto
{
    private string _marca;
    private int _modelo;

    public Auto(string marca, int modelo)
    {
        _marca = marca;
        _modelo = modelo;
    }

    public String ObtenerDescripcion()
    {
        return $"Auto {_marca} {_modelo}";
    }

}
