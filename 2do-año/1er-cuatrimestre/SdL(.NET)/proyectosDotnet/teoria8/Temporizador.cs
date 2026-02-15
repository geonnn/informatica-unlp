namespace teoria8;

public class Temporizador
{
    public event TicEventHandler? Tic;

    private int _intervalo = 100;
    public int Intervalo
    {
        get => _intervalo;
        set
        {
            if (value < 100)
                throw new Exception("El intervalo debe ser mayor o igual a 100");
            else
                _intervalo = value;
        }
    }

    private bool _habilitado = false;
    public bool Habilitado
    {
        get => _habilitado;
        set
        {
            if (value == true && Tic == null)
                throw new Exception("No se puede habilitar si no hay suscriptores");
            else
                _habilitado = value;

            if (_habilitado)
                Ejecutar();
        }
    }
    
    private void Ejecutar()
    {
        int contador = 0;
        
        while (_habilitado)
        {
            DateTime inicio = DateTime.Now;

            while ((DateTime.Now - inicio).TotalMilliseconds < _intervalo) {}

            contador++;
            Tic?.Invoke(this, new TicEventArgs {Tics = contador});
        }
    }
}