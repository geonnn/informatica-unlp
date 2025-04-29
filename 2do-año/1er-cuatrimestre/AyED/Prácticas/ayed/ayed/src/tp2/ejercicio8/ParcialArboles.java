package tp2.ejercicio8;

import tp2.ejercicio1.BinaryTree;

public class ParcialArboles {
	
	public boolean esPrefijo(BinaryTree<Integer> arbol1, BinaryTree<Integer> arbol2) {
		
		if (arbol1 == null) return true;
		if (arbol2 == null) return false;
		if (arbol1.getData() != arbol2.getData()) return false;
		
		// Inicializa en true y si encuentra un contraejemplo corta la búsqueda en el método recursivo.
		boolean izq = esPrefijo(
			arbol1.hasLeftChild() ? arbol1.getLeftChild() : null,
			arbol2.hasLeftChild() ? arbol2.getLeftChild() : null
		);
		
		boolean der = esPrefijo(
			arbol1.hasRightChild() ? arbol1.getRightChild() : null,
			arbol2.hasRightChild() ? arbol2.getRightChild() : null
		);
		
		return (izq && der);
	}
}
