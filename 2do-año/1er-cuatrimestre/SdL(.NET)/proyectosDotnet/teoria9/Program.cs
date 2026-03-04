using System.Collections;

var lista = new ListaEnlazada<int>();
lista.AgregarAdelante(3);
lista.AgregarAdelante(100);
lista.AgregarAtras(10);
lista.AgregarAtras(11);
lista.AgregarAdelante(0);
IEnumerator<int> enumerador = lista.GetEnumerator();
while (enumerador.MoveNext())
{
    int i = enumerador.Current;
    Console.Write(i + " ");
}
Console.WriteLine();

class Nodo<T>
{
    public T Valor { get; private set; }
    public Nodo<T>? Proximo { get; set; } = null;
    public Nodo(T valor) => Valor = valor;
}

public class ListaEnlazada<T> : IEnumerable<T>
{
    private Nodo<T>? pri = null;

    public void AgregarAdelante(T v)
    {
        Nodo<T> n = new Nodo<T>(v);
        n.Proximo = pri;
        pri = n;
    }

    public void AgregarAtras(T v)
    {
        Nodo<T> n = new Nodo<T>(v);

        if (pri == null)
            pri = n;
        else
        {
            Nodo<T> aux = pri;
            while (aux.Proximo != null)
                aux = aux.Proximo;
            aux.Proximo = n;
        }
    }

    public IEnumerator<T> GetEnumerator()
    {
        Nodo<T>? current = pri;
        while (current != null)
        {   
            yield return current.Valor;
            current = current.Proximo;
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}