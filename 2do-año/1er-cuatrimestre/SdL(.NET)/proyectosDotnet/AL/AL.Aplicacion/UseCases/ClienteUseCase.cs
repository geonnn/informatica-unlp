using AL.Aplicacion.Interfaces;

namespace AL.Aplicacion.UseCases;

public abstract class ClienteUseCase
{
    protected IRepositorioCliente Repositorio { get; private set; }

    public ClienteUseCase(IRepositorioCliente repositorio)
    {
        this.Repositorio = repositorio;
    }
}