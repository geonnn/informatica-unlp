package tp2.ejercicio3;

import java.util.ArrayList;
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
	public ArrayList<Integer> numerosParesInOrden() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		numerosParesInOrden(this.arbol, list);
		return list;
	}
	
	private void numerosParesInOrden(BinaryTree<Integer> nodo, ArrayList<Integer> list) {
		if (nodo == null || nodo.isEmpty()) return;
		
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
	public ArrayList<Integer> numerosParesPostOrden() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		numerosParesPostOrden(this.arbol, list);
		return list;
	}
	
	private void numerosParesPostOrden(BinaryTree<Integer> nodo, ArrayList<Integer> list) {
		if (nodo == null || nodo.isEmpty()) return;
		
		if (nodo.hasLeftChild())
			numerosParesInOrden(nodo.getLeftChild(), list);
		
		if (nodo.hasRightChild())
			numerosParesInOrden(nodo.getRightChild(), list);
		
		if (nodo.getData() % 2 == 0)
			list.add(nodo.getData()); 
	}
}
