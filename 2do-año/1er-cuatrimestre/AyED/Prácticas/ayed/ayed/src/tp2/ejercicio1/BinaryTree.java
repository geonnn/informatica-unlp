package tp2.ejercicio1;

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
			if (this.hasLeftChild()) count += this.leftChild.contarHojas();
			if (this.hasRightChild()) count += this.rightChild.contarHojas();
			return count;
		}
	}
	
    public BinaryTree<T> espejo(){
    	if (this.isEmpty()) return null;
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
	public void entreNiveles(int n, int m) {
	    entreNivelesRec(n, m, 0);  // nivel inicial = 0
	}

	private void entreNivelesRec(int n, int m, int nivelActual) {
	    if (this.isEmpty()) return;

	    if (nivelActual >= n && nivelActual <= m)
	        System.out.print(this.getData().toString() + " ");

	    if (nivelActual < m) {
	        if (this.hasLeftChild())
	            this.getLeftChild().entreNivelesRec(n, m, nivelActual + 1);
	        if (this.hasRightChild())
	            this.getRightChild().entreNivelesRec(n, m, nivelActual + 1);
	    }
	}
		
}
