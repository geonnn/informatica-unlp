package tp2.ejercicio4;

import tp2.ejercicio1.BinaryTree;

public class Main {

	public static void main(String[] args) {
		
		// Árbol de ejemplo en la práctica:
		BinaryTree<Integer> arbol = new BinaryTree<Integer>(10);
		
		arbol.addLeftChild(new BinaryTree<Integer>(2));
		arbol.addRightChild(new BinaryTree<Integer>(3));
		
		arbol.getLeftChild().addLeftChild(new BinaryTree<Integer>(5));
		arbol.getLeftChild().addRightChild(new BinaryTree<Integer>(4));
		arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(9));
		arbol.getRightChild().addRightChild(new BinaryTree<Integer>(8));
		
		arbol.getLeftChild().getLeftChild().addLeftChild(new BinaryTree<Integer>(7));
		arbol.getLeftChild().getLeftChild().addRightChild(new BinaryTree<Integer>(8));
		arbol.getLeftChild().getRightChild().addLeftChild(new BinaryTree<Integer>(5));
		arbol.getLeftChild().getRightChild().addRightChild(new BinaryTree<Integer>(6));
		arbol.getRightChild().getLeftChild().addLeftChild(new BinaryTree<Integer>(12));
		arbol.getRightChild().getLeftChild().addRightChild(new BinaryTree<Integer>(8));
		arbol.getRightChild().getRightChild().addLeftChild(new BinaryTree<Integer>(2));
		arbol.getRightChild().getRightChild().addRightChild(new BinaryTree<Integer>(1));
		
		RedBinariaLlena redB = new RedBinariaLlena(arbol);
		
		System.out.println(redB.retardoReenvio());

	}

}
