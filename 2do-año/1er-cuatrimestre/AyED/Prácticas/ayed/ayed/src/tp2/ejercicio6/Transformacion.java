package tp2.ejercicio6;

import tp2.ejercicio1.BinaryTree;

public class Transformacion {
	private BinaryTree<Integer> arbol;
	
	public Transformacion(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}

	public BinaryTree<Integer> suma() {
		BinaryTree<Integer> nuevo = new BinaryTree<Integer>(0);
		sumaRec(arbol, nuevo);
		return nuevo;
	}
	
	private int sumaRec(BinaryTree<Integer> nodo, BinaryTree<Integer> nodoNuevo) {
		
		int sumaIzq = 0, sumaDer = 0;
		
		if (nodo.hasLeftChild()) {
			BinaryTree<Integer> izqNuevo = new BinaryTree<Integer>(0);
			sumaIzq += sumaRec(nodo.getLeftChild(), izqNuevo);
			nodoNuevo.addLeftChild(izqNuevo);
		}
		
		if (nodo.hasRightChild()) {
			BinaryTree<Integer> derNuevo = new BinaryTree<Integer>(0);
			sumaDer += sumaRec(nodo.getRightChild(), derNuevo);
			nodoNuevo.addRightChild(derNuevo);
		}
		
		nodoNuevo.setData(sumaIzq + sumaDer);
		
		return sumaIzq + sumaDer + nodo.getData();
	}
}
