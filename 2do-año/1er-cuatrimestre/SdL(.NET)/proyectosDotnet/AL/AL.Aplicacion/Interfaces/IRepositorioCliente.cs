using AL.Aplicacion.Entidades;

namespace AL.Aplicacion.Interfaces;

public interface IRepositorioCliente
{
    List<Cliente> GetClientes();
    Cliente? GetCliente(int id);
    void ModificarCliente(Cliente cliente);
    void EliminarCliente(int id);
    void AgregarCliente(Cliente cliente);
}