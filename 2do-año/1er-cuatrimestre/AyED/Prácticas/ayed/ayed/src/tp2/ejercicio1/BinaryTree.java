package tp2.ejercicio1;

import tp1.ejercicio8.Queue;
import java.util.LinkedList;

public class BinaryTree <T> {
	
	private T data;
	private BinaryTree<T> leftChild;   
	private BinaryTree<T> rightChild; 

	
	public BinaryTree() {
		super();
	}

	public BinaryTree(T data) {
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	/**
	 * Preguntar antes de invocar si hasLeftChild()
	 * @return
	 */
	public BinaryTree<T> getLeftChild() {
		return this.leftChild;
	}
	/**
	 * Preguntar antes de invocar si hasRightChild()
	 * @return
	 */
	public BinaryTree<T> getRightChild() {
		return this.rightChild;
	}

	public void addLeftChild(BinaryTree<T> child) {
		this.leftChild = child;
	}

	public void addRightChild(BinaryTree<T> child) {
		this.rightChild = child;
	}

	public void removeLeftChild() {
		this.leftChild = null;
	}

	public void removeRightChild() {
		this.rightChild = null;
	}

	public boolean isEmpty(){
		return (this.isLeaf() && this.getData() == null);
	}

	public boolean isLeaf() {
		return (!this.hasLeftChild() && !this.hasRightChild());
	}
		
	public boolean hasLeftChild() {
		return this.leftChild!=null;
	}

	public boolean hasRightChild() {
		return this.rightChild!=null;
	}
	@Override
	public String toString() {
		return this.getData().toString();
	}

	public int contarHojas() {
		if (this.isEmpty()) return 0;
		else if (this.isLeaf()) return 1;
		else {
			int count = 0;
			if (this.hasLeftChild()) count = this.leftChild.contarHojas();
			if (this.hasRightChild()) count += this.rightChild.contarHojas();
			return count;
		}
	}
	
    public BinaryTree<T> espejo(){
    	if (this.isEmpty()) return new BinaryTree<T>();
    	else {
    		BinaryTree<T> arbol = new BinaryTree<T>(this.getData());
    		if (this.hasLeftChild()) arbol.addRightChild(this.leftChild.espejo());
    		if (this.hasRightChild()) arbol.addLeftChild(this.rightChild.espejo());
    		
    		return arbol;
    	}
    }
    
    public void imprimirArbol(BinaryTree<T> arbol) {
        imprimirRecursivo(arbol, 0);
    }

    private void imprimirRecursivo(BinaryTree<T> nodo, int nivel) {
        if (nodo == null || nodo.isEmpty()) return;

        // Primero imprime el hijo derecho
        imprimirRecursivo(nodo.getRightChild(), nivel + 1);

        // Imprime el dato con indentación
        for (int i = 0; i < nivel; i++) System.out.print("   ");
        System.out.println(nodo.getData());

        // Después imprime el hijo izquierdo
        imprimirRecursivo(nodo.getLeftChild(), nivel + 1);
    }


	// 0<=n<=m
    // Se usa null como separador de niveles.
    // Se encolan los nodos de un nivel y antes de pasar al siguiente se encola null.
	public void entreNiveles(int n, int m) {
	    Queue<BinaryTree<T>> cola = new Queue<BinaryTree<T>>();
	    
	    cola.enqueue(this);
	    cola.enqueue(null);
	    BinaryTree<T> nodo;
	    int nivelActual = 0;
	    
	    while (!cola.isEmpty()) {	
	    	nodo = cola.dequeue();
	    	if (nodo != null) {
	    		if (nivelActual >= n && nivelActual <= m)
	    			System.out.println(nodo.getData().toString());
	    		if (nodo.hasLeftChild())
	    			cola.enqueue(nodo.getLeftChild());
	    		if (nodo.hasRightChild())
	    			cola.enqueue(nodo.getRightChild());
	    	}
	    	else {
	    		if (!cola.isEmpty()) {
	    			cola.enqueue(null);
	    			nivelActual++;
	    		}
	    	}
	    }
	    
	}	
}
