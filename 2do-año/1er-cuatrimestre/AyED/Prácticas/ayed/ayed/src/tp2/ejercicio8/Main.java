package tp2.ejercicio8;

import tp2.ejercicio1.BinaryTree;

public class Main {

	public static void main(String[] args) {
		
		ParcialArboles pA = new ParcialArboles();
		
		BinaryTree<Integer> arbol1 = new BinaryTree<Integer>(65);
		arbol1.addLeftChild(new BinaryTree<Integer>(37));
		arbol1.addRightChild(new BinaryTree<Integer>(81));
		
		arbol1.getLeftChild().addRightChild(new BinaryTree<Integer>(47));
		arbol1.getRightChild().addRightChild(new BinaryTree<Integer>(93));
		
		BinaryTree<Integer> arbol2 = new BinaryTree<Integer>(65);
		arbol2.addLeftChild(new BinaryTree<Integer>(37));
		arbol2.addRightChild(new BinaryTree<Integer>(81));
		
		arbol2.getLeftChild().addLeftChild(new BinaryTree<Integer>(22));
		arbol2.getLeftChild().addRightChild(new BinaryTree<Integer>(47));
		arbol2.getRightChild().addLeftChild(new BinaryTree<Integer>(76));
		arbol2.getRightChild().addRightChild(new BinaryTree<Integer>(93));
		
		arbol2.getLeftChild().getLeftChild().addLeftChild(new BinaryTree<Integer>(11));
		arbol2.getLeftChild().getLeftChild().addRightChild(new BinaryTree<Integer>(29));
		arbol2.getRightChild().getRightChild().addLeftChild(new BinaryTree<Integer>(85));
		arbol2.getRightChild().getRightChild().addRightChild(new BinaryTree<Integer>(94));
		
		System.out.println(pA.esPrefijo(arbol1, arbol2));

	}

}
