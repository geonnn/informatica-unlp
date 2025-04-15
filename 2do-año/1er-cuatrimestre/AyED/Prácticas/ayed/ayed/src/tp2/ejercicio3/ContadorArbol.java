package tp2.ejercicio3;

import java.util.LinkedList;
import java.util.List;
import tp2.ejercicio1.BinaryTree;

public class ContadorArbol {
	private BinaryTree<Integer> arbol;
	
	public ContadorArbol(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	/**
	 * @return
	 * ArrayList de los números pares InOrden.
	 **/
	public List<Integer> numerosParesInOrden() {
		List<Integer> list = new LinkedList<Integer>();
		if (this.arbol == null || this.arbol.isEmpty());
		
		else numerosParesInOrden(this.arbol, list);
		return list;
	}
	
	private void numerosParesInOrden(BinaryTree<Integer> nodo, List<Integer> list) {
		
		if (nodo.hasLeftChild())
			numerosParesInOrden(nodo.getLeftChild(), list);
		
		if (nodo.getData() % 2 == 0)
			list.add(nodo.getData()); 

		if (nodo.hasRightChild())
			numerosParesInOrden(nodo.getRightChild(), list);
	}
	
	/**
	 * @return
	 * ArrayList de los números pares PostOrden.
	 **/
	public List<Integer> numerosParesPostOrden() {
		List<Integer> list = new LinkedList<Integer>();
		if (this.arbol == null || this.arbol.isEmpty());
		else numerosParesPostOrden(this.arbol, list);
		return list;
	}
	
	private void numerosParesPostOrden(BinaryTree<Integer> nodo, List<Integer> list) {
		
		if (nodo.hasLeftChild())
			numerosParesInOrden(nodo.getLeftChild(), list);
		
		if (nodo.hasRightChild())
			numerosParesInOrden(nodo.getRightChild(), list);
		
		if (nodo.getData() % 2 == 0)
			list.add(nodo.getData()); 
	}
}
