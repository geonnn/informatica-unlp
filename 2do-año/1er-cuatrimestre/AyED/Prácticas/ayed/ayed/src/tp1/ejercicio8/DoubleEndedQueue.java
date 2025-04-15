package tp1.ejercicio8;

public class DoubleEndedQueue<T> extends Queue<T> {

	public void enqueueFirst(T dato) {
		this.lista.addFirst(dato);
	}
}
