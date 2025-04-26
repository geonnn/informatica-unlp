package tp2.ejercicio7;

import tp2.ejercicio1.BinaryTree;

public class ParcialArboles {
	private BinaryTree<Integer> arbol;
	
	public ParcialArboles(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public boolean isLeftTree(int num) {
		if (this.arbol == null) return false;
		
		BinaryTree<Integer> nodo = buscarNum(this.arbol, num);
		if (nodo == null) return false;
		
		// Inicializa en -1 partiendo de la base de que no hay hijo izq/der.
		// Si hay se sobreescribe.
		int izq = -1, der = -1;
		
		if (nodo.hasLeftChild())
			izq = contarHijosUnicos(nodo.getLeftChild());
		if (nodo.hasRightChild())
			der = contarHijosUnicos(nodo.getRightChild());

		return (izq > der);
	}
	
	private BinaryTree<Integer> buscarNum(BinaryTree<Integer> nodo, int num) {
		
		if (nodo == null) return null;
		if (nodo.getData() == num) return nodo;
		
		BinaryTree<Integer> nodoAux = null;
		
		if (nodo.hasLeftChild())
			nodoAux = buscarNum(nodo.getLeftChild(), num);
		
		if (nodoAux != null) return nodoAux;
		
		if (nodo.hasRightChild())
			nodoAux = buscarNum(nodo.getRightChild(), num);
		
		return nodoAux;
	}
	
	private int contarHijosUnicos(BinaryTree<Integer> nodo) {
		if (nodo == null) return -1;
		if (nodo.isLeaf()) return 0;
				
		if (nodo.hasLeftChild() && nodo.hasRightChild())
			return
					contarHijosUnicos(nodo.getLeftChild()) + contarHijosUnicos(nodo.getRightChild());
		
		else if (nodo.hasLeftChild())
			return contarHijosUnicos(nodo.getLeftChild()) + 1;
		else
			return contarHijosUnicos(nodo.getRightChild()) + 1;
	}
	
}