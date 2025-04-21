package tp2.ejercicio6;

import tp2.ejercicio1.BinaryTree;

public class Main {

	public static void main(String[] args) {
		BinaryTree<Integer> arbol = new BinaryTree<Integer>(1);

		arbol.addLeftChild(new BinaryTree<Integer>(2));
		arbol.addRightChild(new BinaryTree<Integer>(3));
		
		arbol.getLeftChild().addRightChild(new BinaryTree<Integer>(4));
		arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(5));
		arbol.getRightChild().addRightChild(new BinaryTree<Integer>(6));
		
		arbol.getRightChild().getLeftChild().addLeftChild(new BinaryTree<Integer>(7));
		arbol.getRightChild().getLeftChild().addRightChild(new BinaryTree<Integer>(8));
		
		arbol.imprimirArbol();
		System.out.println("---------------------");
		
		Transformacion abT = new Transformacion(arbol);
		abT.suma().imprimirArbol(); 
		

	}

}
