package parcial;

import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {
	private GeneralTree<Integer> arbol;
	
	public List<Integer> nivel(int num) {
		List<Integer> lista = new LinkedList<>();
		if (arbol == null || arbol.isEmpty()) 
			return lista;
		
		Queue<GeneralTree<Integer>> cola = new Queue<>();
		GeneralTree<Integer> nodoAux;
		List<GeneralTree<Integer>> nivelActual = new LinkedList<>();
		
		cola.enqueue(arbol); cola.enqueue(null);
		
		while (!cola.isEmpty()) {
			nodoAux = cola.dequeue();
			if (nodoAux != null) {
				nivelActual.add(nodoAux);
				for (GeneralTree<Integer> child : nodoAux.getChildren())
					cola.enqueue(child);
			}
			else {
				boolean cumple = true;
				for (GeneralTree<Integer> nodo : nivelActual) {
					if (nodo.getChildren().size() < num) {
						cumple = false;
						break;
					}
				}
				if (cumple) {
					for (GeneralTree<Integer> nodo : nivelActual)
						lista.add(nodo.getData());
					break;
				}
				nivelActual.clear();
			}
			if (!cola.isEmpty()) {
				cola.enqueue(null);
			}
		}
		return lista;
	}
}
