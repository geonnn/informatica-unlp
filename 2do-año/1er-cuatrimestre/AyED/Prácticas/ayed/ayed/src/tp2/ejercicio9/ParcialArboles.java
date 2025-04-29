package tp2.ejercicio9;

import tp2.ejercicio1.BinaryTree;

public class ParcialArboles {
	
	
	public BinaryTree<Integer[]> sumAndDif(BinaryTree<Integer> arbol) {
		if (arbol == null) return null;
		if (arbol.isEmpty()) return new BinaryTree<Integer[]>();
		
		return sumAndDifRec(arbol, 0, 0);
	}
	
	private BinaryTree<Integer[]> sumAndDifRec(BinaryTree<Integer> nodo, int valorPadre, int valorAcumulado) {		
		BinaryTree<Integer[]> nodoNuevo = new BinaryTree<Integer[]>();
		
		nodoNuevo.setData(new Integer[] {
			nodo.getData() + valorAcumulado,
			nodo.getData() - valorPadre
		});
		
		if (nodo.hasLeftChild())
			nodoNuevo.addLeftChild(sumAndDifRec(nodo.getLeftChild(), nodo.getData(), valorAcumulado + nodo.getData()));
		if (nodo.hasRightChild())
			nodoNuevo.addRightChild(sumAndDifRec(nodo.getRightChild(), nodo.getData(), valorAcumulado + nodo.getData()));
		
		return nodoNuevo;
	}
}