namespace teoria5;

public class ListaDePersonas
{
    private List<Persona> _lista = [];

    public Persona? this[int dni]
    {
        get => _lista.Find(p => p.Dni == dni);
    }
    
    public List<string> this[char c]
    {
        get
        {
            return _lista.Where(p => p.Nombre[0] == c)
                    .Select(p => p.Nombre).ToList();
        }
    }

    public void Agregar(Persona p)
    {
        _lista.Add(p);
    }
}