package tp3.ejercicio11;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {
	
	public static boolean resolver(GeneralTree<Integer> arbol) {
		if (arbol == null || arbol.isEmpty()) return true;
		
		Queue<GeneralTree<Integer>> cola = new Queue<>();
		GeneralTree<Integer> nodoAux;
		cola.enqueue(arbol);
		int cantNodosEsperados = 1; // la raíz. 
		
		while (!cola.isEmpty()) {
			
			int cantNodosNivelActual = cola.size();
			
			if (cantNodosEsperados != cantNodosNivelActual)
				return false;
			
			cantNodosEsperados++;
			
			for (int i = 0; i < cantNodosNivelActual; i++) {
				nodoAux = cola.dequeue();
				if (nodoAux.hasChildren())
					for (GeneralTree<Integer> child : nodoAux.getChildren())
						cola.enqueue(child);
			}
		}
		return true;
	}
	
	public static boolean resolverConNull(GeneralTree<Integer> arbol) {
		if (arbol == null || arbol.isEmpty()) return true;
		
		Queue<GeneralTree<Integer>> cola = new Queue<>();
		GeneralTree<Integer> nodoAux;
		cola.enqueue(arbol); cola.enqueue(null);
		int cantNodosNivel = 1; // la raíz. 
		
		while (!cola.isEmpty()) {
			nodoAux = cola.dequeue();
			if (nodoAux != null) {
				if (nodoAux.hasChildren())
					for (GeneralTree<Integer> child : nodoAux.getChildren())
						cola.enqueue(child);
			}
			else {
				if (!cola.isEmpty()) {
					if (cantNodosNivel+1 != cola.size())
						return false;
					cantNodosNivel++;
					cola.enqueue(null);
				}
			}
		}
		return true;
	}

}
