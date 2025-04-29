package tp2.ejercicio1;

import tp1.ejercicio8.Queue;

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
    
    public void imprimirArbol() {
        imprimirRecursivo(this, 0);
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

    public void imprimirArbolArray(BinaryTree<Integer[]> arbol) {
        imprimirRecursivoArray(arbol, 0);
    }

    private void imprimirRecursivoArray(BinaryTree<Integer[]> nodo, int nivel) {
        if (nodo == null || nodo.isEmpty()) return;

        // Imprimir primero el hijo derecho
        imprimirRecursivoArray(nodo.getRightChild(), nivel + 1);

        // Indentación para simular estructura del árbol
        for (int i = 0; i < nivel; i++) System.out.print("   ");

        // Imprimir el array de Integer[] como string
        Integer[] datos = nodo.getData();
        if (datos != null) {
            System.out.print("[");
            for (int i = 0; i < datos.length; i++) {
                System.out.print(datos[i]);
                if (i < datos.length - 1) System.out.print(", ");
            }
            System.out.println("]");
        } else {
            System.out.println("null");
        }

        // Imprimir después el hijo izquierdo
        imprimirRecursivoArray(nodo.getLeftChild(), nivel + 1);
    }


	// 0<=n<=m
    
    // Se usa null como separador de niveles.
    // Se encolan los nodos de un nivel y antes de pasar al siguiente se encola null.
    
    /**
     * Imprime el recorrido por niveles de los elementos del árbol receptor entre los niveles n y m (ambos inclusive).
     * (0≤n<m≤altura del árbol)
     */
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
