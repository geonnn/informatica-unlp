package tp3.ejercicio10;

import java.util.LinkedList;
import java.util.List;

import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {
	
	public static List<Integer> resolver(GeneralTree<Integer> arbol) {
		if (arbol == null || arbol.isEmpty())
			return new LinkedList<Integer>();
		
		List<Integer> caminoMax = new LinkedList<Integer>();
		int[] valorMax = {Integer.MIN_VALUE};
		resolverRec(arbol, new LinkedList<Integer>(), caminoMax, 0, valorMax, 0);
		return caminoMax;
	}
	
	private static void resolverRec(GeneralTree<Integer> nodo, List<Integer> cAct, List<Integer> cMax, int valorAct, int[] valorMax, int nivel) {
		
		// Sólo se opera si el nodo es 1, si es 0 sólo se llama a la recursión o a actualizar el máx. No sumar para el acumulador del camino, ni agregar a la lista.
		boolean esUno = nodo.getData().equals(1);
		// Uso otra variable para no tener que restaurar valor previo en el backtracking.
		int nuevaSuma = valorAct + (nodo.getData() * nivel); 
		
		if (esUno)
			cAct.add(1);
		
		if (nodo.isLeaf()) {
			if (nuevaSuma > valorMax[0]) {
				cMax.clear();
				cMax.addAll(cAct);
				valorMax[0] = nuevaSuma;
			}
		}
		else
			for (GeneralTree<Integer> child : nodo.getChildren())
				resolverRec(child, cAct, cMax, nuevaSuma, valorMax, nivel + 1);
		
		if (esUno)
			cAct.remove(cAct.size() - 1);
	}
}