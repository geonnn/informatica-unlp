package tp1.ejercicio8;

import java.util.LinkedList;

public class Queue<T> extends Sequence {
	LinkedList <T> lista;
	
	public Queue() {
		this.lista = new LinkedList<T>();
	}
	
	public void enqueue(T dato) {
		lista.add(dato); //Agrega al final
	}
	
	public T dequeue() {
		if(lista.size()!=0) {
			return(lista.remove(0));
		}
		else {
			throw new IllegalStateException("La cola esta vacia no se puede hacer Dequeue");
		}
	}
	
	public T head() {
		if(lista.size()!= 0) {
			return(lista.getFirst());
		}
		else {
			throw new IllegalStateException("La cola esta vacia no se puede acceder al Head");
		}
	}
	
	public boolean isEmpty() {
		return(lista.isEmpty());
	}
	
	public int size() {
		return(lista.size());
	}
	
	public String toString() {
		return(lista.toString());
	}
	
}
