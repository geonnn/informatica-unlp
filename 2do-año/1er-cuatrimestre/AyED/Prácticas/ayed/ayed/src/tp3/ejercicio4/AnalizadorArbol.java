package tp3.ejercicio4;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class AnalizadorArbol {
	
	public double devolverMaximoPromedio(GeneralTree<AreaEmpresa> arbol) {
		Queue<GeneralTree<AreaEmpresa>> cola = new Queue<GeneralTree<AreaEmpresa>>();
		GeneralTree<AreaEmpresa> nodoAux;
		int latenciaTotalNivel = 0, cantNodosNivel = 0;
		double promMax = Double.MIN_VALUE;
		
		cola.enqueue(arbol); cola.enqueue(null);
		
		while (!cola.isEmpty()) {
			nodoAux = cola.dequeue();
			
			if (nodoAux != null) {
				latenciaTotalNivel += nodoAux.getData().getLatencia();
				cantNodosNivel++;
				
				if (nodoAux.hasChildren())
					for (GeneralTree<AreaEmpresa> child : nodoAux.getChildren())
						cola.enqueue(child);
				
			}
			else {
				promMax = Math.max(promMax, (latenciaTotalNivel/cantNodosNivel));
				latenciaTotalNivel = 0;
				cantNodosNivel = 0;
				
				if (!cola.isEmpty())
					cola.enqueue(null);
			}
		}
		return promMax;
	}
}
