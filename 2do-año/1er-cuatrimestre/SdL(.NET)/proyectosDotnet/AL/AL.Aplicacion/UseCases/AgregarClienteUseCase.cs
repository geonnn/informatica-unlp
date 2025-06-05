using AL.Aplicacion.Entidades;
using AL.Aplicacion.Interfaces;

namespace AL.Aplicacion.UseCases;

public class AgregarClienteUseCase(IRepositorioCliente repositorio) : ClienteUseCase(repositorio)
{
    public void Ejecutar(Cliente cliente)
    {
        //aquí podríamos insertar código de validación de cliente

        Repositorio.AgregarCliente(cliente);
    }
}