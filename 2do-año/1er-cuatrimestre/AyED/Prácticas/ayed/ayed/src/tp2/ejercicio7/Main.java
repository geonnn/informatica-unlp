package tp2.ejercicio7;

import tp2.ejercicio1.BinaryTree;

public class Main {

	public static void main(String[] args) {
		BinaryTree<Integer> arbol = new BinaryTree<Integer>(2);

		arbol.addLeftChild(new BinaryTree<Integer>(7));
		arbol.addRightChild(new BinaryTree<Integer>(-5));
		
		arbol.getLeftChild().addLeftChild(new BinaryTree<Integer>(23));
		arbol.getLeftChild().addRightChild(new BinaryTree<Integer>(6));
		arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(19));
		
		arbol.getLeftChild().getLeftChild().addLeftChild(new BinaryTree<Integer>(-3));
		arbol.getLeftChild().getRightChild().addLeftChild(new BinaryTree<Integer>(55));
		arbol.getLeftChild().getRightChild().addRightChild(new BinaryTree<Integer>(11));
		arbol.getRightChild().getLeftChild().addRightChild(new BinaryTree<Integer>(4));
		
		arbol.getRightChild().getLeftChild().getRightChild().addLeftChild(new BinaryTree<Integer>(18));
		
		arbol.imprimirArbol();
		System.out.println("---------------------");
		
		ParcialArboles arb = new ParcialArboles(arbol);
		System.out.println(arb.isLeftTree(7));
	}

}
