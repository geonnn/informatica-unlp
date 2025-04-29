package tp2.ejercicio9;

import tp2.ejercicio1.BinaryTree;

public class Main {

	public static void main(String[] args) {
		
		ParcialArboles pA = new ParcialArboles();
		
		BinaryTree<Integer> arbol1 = new BinaryTree<Integer>(20);
		arbol1.addLeftChild(new BinaryTree<Integer>(5));
		arbol1.addRightChild(new BinaryTree<Integer>(30));
		
		arbol1.getLeftChild().addLeftChild(new BinaryTree<Integer>(-5));
		arbol1.getLeftChild().addRightChild(new BinaryTree<Integer>(10));
		arbol1.getRightChild().addLeftChild(new BinaryTree<Integer>(50));
		arbol1.getRightChild().addRightChild(new BinaryTree<Integer>(-9));
		
		arbol1.getLeftChild().getRightChild().addLeftChild(new BinaryTree<Integer>(1));
		arbol1.getRightChild().getLeftChild().addRightChild(new BinaryTree<Integer>(4));
		arbol1.getRightChild().getLeftChild().getRightChild().addRightChild(new BinaryTree<Integer>(6));
		
		arbol1.imprimirArbol();
		
		System.out.println("\n-----------------------------\n");
		
		arbol1.imprimirArbolArray(pA.sumAndDif(arbol1));

	}

}
