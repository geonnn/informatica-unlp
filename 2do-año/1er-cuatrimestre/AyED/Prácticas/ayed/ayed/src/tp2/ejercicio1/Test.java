package tp2.ejercicio1;

public class Test {
	
	public static void main(String[] args) {
		
		BinaryTree<Integer> arbol = new BinaryTree<Integer>(1);
		arbol.addLeftChild(new BinaryTree<Integer>(2));
		arbol.addRightChild(new BinaryTree<Integer>(3));
		arbol.getLeftChild().addLeftChild(new BinaryTree<Integer>(4));
		arbol.getLeftChild().addRightChild(new BinaryTree<Integer>(5));
		arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(6));
		
		arbol.imprimirArbol(arbol);
		System.out.println("-------------------");
		arbol.imprimirArbol(arbol.espejo());		
	}

}
