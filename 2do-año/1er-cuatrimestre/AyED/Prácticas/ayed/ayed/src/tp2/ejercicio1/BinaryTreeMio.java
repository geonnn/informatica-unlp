package tp2.ejercicio1;

public class BinaryTreeMio<T> {
	private T dato;
	private BinaryTreeMio<T> leftChild;
	private BinaryTreeMio<T> rightChild;

	
	public BinaryTreeMio(T data) {
		this.dato = data;
		this.leftChild = null;	
		this.rightChild = null;	
	}

	public BinaryTreeMio<T> getLeftChild() {
		if (this.leftChild == null)
			throw new NullPointerException("El hijo izquierdo es null.");
		else
			return this.leftChild;
	}

	public BinaryTreeMio<T> getRightChild() {
		if (this.leftChild == null)
			throw new NullPointerException("El hijo derecho es null.");
		else
			return this.rightChild;
	}		
	
	public void addLeftChild(BinaryTreeMio<T> child) {
		this.leftChild = child;
	}
	
	public void addRightChild(BinaryTreeMio<T> child) {
		this.rightChild = child;
	}
		
	public void removeLeftChild() {
		this.leftChild = null;
	}
	
	public void removeRightChild() {
		this.rightChild = null;
	}
	
	public boolean isEmpty() {
		return (this.dato == null);
	}
	
	public boolean isLeaf() {
		return (this.leftChild != null || this.rightChild != null);
	}
	
	public boolean hasLeftChild() {
		return (this.leftChild != null);
	}
	
	public boolean hasRightChild() {
		return (this.rightChild != null);
	}
	
}
