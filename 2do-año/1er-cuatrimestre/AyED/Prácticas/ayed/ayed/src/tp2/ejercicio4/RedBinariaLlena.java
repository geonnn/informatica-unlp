package tp2.ejercicio4;

import tp2.ejercicio1.BinaryTree;

public class RedBinariaLlena {
	private BinaryTree<Integer> arbol;
	
	public RedBinariaLlena(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public int retardoReenvio() {
		return retardoRec(arbol, 0);
	}
	
	private int retardoRec(BinaryTree<Integer> nodo, int total) {
		if (nodo == null) return 0;
		
		total += nodo.getData();
		
		if (nodo.isLeaf())
			return total;
			
		int	izq = retardoRec(nodo.getLeftChild(), total);
		int der = retardoRec(nodo.getRightChild(), total);
		
		return Math.max(izq, der);
	}
}
