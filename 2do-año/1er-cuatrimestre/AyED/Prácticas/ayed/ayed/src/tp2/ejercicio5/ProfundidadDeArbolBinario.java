package tp2.ejercicio5;

import tp1.ejercicio8.Queue;

import tp2.ejercicio1.BinaryTree;

public class ProfundidadDeArbolBinario {
	private BinaryTree<Integer> arbol;
	
	public ProfundidadDeArbolBinario(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public int sumaElementosProfundidad(int p) {
		Queue<BinaryTree<Integer>> cola = new Queue<>();
		cola.enqueue(this.arbol);
		cola.enqueue(null);
		BinaryTree<Integer> nodo;
		int nivAct = 0, total = 0;
		
		while (!cola.isEmpty() && nivAct <= p) {
			nodo = cola.dequeue();
			if (nodo != null) {
				if (nivAct == p)
					total += nodo.getData();
				
				if (nodo.hasLeftChild())
					cola.enqueue(nodo.getLeftChild());
				if (nodo.hasRightChild())
					cola.enqueue(nodo.getRightChild());
			}
			else
				if (!cola.isEmpty()) {
					cola.enqueue(null);
					nivAct++;
				
			}
		}
		return total;
	}

}
