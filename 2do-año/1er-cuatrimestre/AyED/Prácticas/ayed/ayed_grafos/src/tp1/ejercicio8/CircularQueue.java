package tp1.ejercicio8;

public class CircularQueue<T> extends Queue<T>{

	public T shift() {
		T dato = this.dequeue();
		this.enqueue(dato);
		return dato;
	}
}
