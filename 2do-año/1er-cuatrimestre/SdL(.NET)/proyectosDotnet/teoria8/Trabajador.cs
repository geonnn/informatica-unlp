namespace teoria8;

public class Trabajador
{
    private EventHandler? _trabajando;

    public event EventHandler Trabajando
    {
        add
        {
            _trabajando += value;
            Trabajar();
        }
        
        remove
        {
            _trabajando -= value;
        }
    }
    
    public void Trabajar()
    {
        _trabajando?.Invoke(this, EventArgs.Empty);
        Console.WriteLine("Trabajo concluido");
    }
}