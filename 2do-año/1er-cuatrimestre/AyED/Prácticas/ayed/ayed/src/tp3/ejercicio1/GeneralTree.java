package tp3.ejercicio1;

import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;

public class GeneralTree<T>{

	private T data;
	private List<GeneralTree<T>> children = new LinkedList<GeneralTree<T>>(); 

	public GeneralTree() {
		
	}
	public GeneralTree(T data) {
		this.data = data;
	}

	public GeneralTree(T data, List<GeneralTree<T>> children) {
		this(data);
		this.children = children;
	}	
	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public List<GeneralTree<T>> getChildren() {
		return this.children;
	}
	
	public void setChildren(List<GeneralTree<T>> children) {
		if (children != null)
			this.children = children;
	}
	
	public void addChild(GeneralTree<T> child) {
		this.getChildren().add(child);
	}

	public boolean isLeaf() {
		return !this.hasChildren();
	}
	
	public boolean hasChildren() {
		return !this.children.isEmpty();
	}
	
	public boolean isEmpty() {
		return this.data == null && !this.hasChildren();
	}

	public void removeChild(GeneralTree<T> child) {
		if (this.hasChildren())
			children.remove(child);
	}
	
	// Ejercicio 3:
	
	public int altura() {
		if (this.isLeaf())
			return 0;
		
		int maxAltura = 0;
		
		for (GeneralTree<T> child : this.getChildren())
			maxAltura = Math.max(maxAltura, child.altura());
		
		return maxAltura += 1;
	}
	
	public int nivel(T dato){
		Queue<GeneralTree<T>> cola = new Queue<GeneralTree<T>>();
		GeneralTree<T> nodoAux;
		int nivel = 0;
		
		cola.enqueue(this); cola.enqueue(null);
		while (!cola.isEmpty()) {
			nodoAux = cola.dequeue();
			if (nodoAux != null) {
				if (nodoAux.getData().equals(dato))
					return nivel;					
			if (nodoAux.hasChildren())
				for (GeneralTree<T> child : nodoAux.getChildren())
					cola.enqueue(child);
			}
			else {
				if (!cola.isEmpty()) {
					nivel++;
					cola.enqueue(null);
				}
			}
		}
		// Si no lo encuentra retorna -1.
		return -1;
	  }

	public int ancho(){
		Queue<GeneralTree<T>> cola = new Queue<GeneralTree<T>>();
		GeneralTree<T> nodoAux;
		int maxAncho = Integer.MIN_VALUE;
		
		cola.enqueue(this); cola.enqueue(null);
		while (!cola.isEmpty()) {
			maxAncho = Math.max(maxAncho, cola.size()-1); // Se resta el null.
			nodoAux = cola.dequeue();
			if (nodoAux != null) {	
				if (nodoAux.hasChildren())
					for (GeneralTree<T> child : nodoAux.getChildren())
						cola.enqueue(child);
			}
			else {
				if (!cola.isEmpty()) {
					cola.enqueue(null);
				}
			}
		}
		return maxAncho;
	}
	
	// Ejercico 5:
	public boolean esAncestro(T a, T b) {
		GeneralTree<T> nodoA = buscar(this, a);
		if (nodoA == null) return false; // Nodo ancestro no existe.
		return contiene(nodoA, b);
	}
	
	private GeneralTree<T> buscar(GeneralTree<T> nodo, T valor) {
		if (nodo.getData().equals(valor)) return nodo;
		if (nodo.hasChildren()) {
			GeneralTree<T> result;
			for (GeneralTree<T> child : nodo.getChildren()) {
				result = buscar(child, valor);
				if (result != null) return result;
			}
		}
		// Si llega a este punto no lo encontró y retorna null.
		return null;
	}
	
	/* Recibe un nodo y un dato.
	 * Retorna true si el dato es descendiente del nodo.
	 * Retorna false si el dato no se encuentra en el subárbol del nodo. 
	 */
	private boolean contiene(GeneralTree<T> nodo, T dato) {
		if (nodo.getData().equals(dato)) return true;
		if (nodo.hasChildren())
			for (GeneralTree<T> child : nodo.getChildren()) {
				if (contiene(child, dato)) return true;
			}
		// El dato no existe en el subárbol del nodo.
		return false;
	}
	
}