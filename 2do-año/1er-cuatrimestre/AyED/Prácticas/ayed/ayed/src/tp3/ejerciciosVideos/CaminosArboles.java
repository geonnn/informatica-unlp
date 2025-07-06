package tp3.ejerciciosVideos;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import tp3.ejercicio1.GeneralTree;

public class CaminosArboles {
	
	public static boolean esSustituto(GeneralTree<Integer> arbol1, GeneralTree<Integer> arbol2) {
		
		boolean result = false;
		
		if (arbol1 != null && arbol2 != null)
			if (!arbol1.isEmpty() && !arbol2.isEmpty())
				result = esSustitutoPrivate(arbol1, arbol2);
		
		return result;
	}
	
	private static boolean esSustitutoPrivate(GeneralTree<Integer> nodo1, GeneralTree<Integer> nodo2) {
		
		boolean cumple = true;
		
		if (nodo1.getData() % 2 != 0 || nodo1.getData() <= nodo2.getData())
			return false;
		
		if (nodo1.isLeaf())
			return true;
		
		if (!nodo1.isLeaf() && nodo2.isLeaf())
			return false;
		
		if (!nodo1.isLeaf() && !nodo2.isLeaf()) {
			int paresN1 = contarHijosPares(nodo1);
			int paresN2 = contarHijosPares(nodo2);
			
			if (paresN1 <= paresN2)
				return false;
			else {
				
				Iterator<GeneralTree<Integer>> it1 = nodo1.getChildren().iterator();
				Iterator<GeneralTree<Integer>> it2 = nodo2.getChildren().iterator();
				
				while (cumple && it1.hasNext() && it2.hasNext())
					cumple = esSustitutoPrivate(it1.next(), it2.next());
				
			}
		}
		return cumple;
	}
	
	private static int contarHijosPares(GeneralTree<Integer> nodo) {
		
		int count = 0;
		
		for (GeneralTree<Integer> child: nodo.getChildren())
			if (child.getData() % 2 == 0)
				count++;
		
		return count;
	}
	
	public static List<Integer> buscarCaminoSumaMinima(GeneralTree<Integer> arbol) {
		
		List<Integer> result = new LinkedList<Integer>();
		
		if (arbol != null && !arbol.isEmpty())
			caminoSumaPrivate(arbol, result, new LinkedList<Integer>(), Integer.MAX_VALUE, 0);
		
		return result;
	}
	
	private static int caminoSumaPrivate(GeneralTree<Integer> nodo, List<Integer> result, List<Integer> caminoAct, int min, int acum) {
		
		acum += nodo.getData();
		caminoAct.add(nodo.getData());
		
		if (nodo.isLeaf()) {			
			if (acum < min) {
				result.clear();
				result.addAll(caminoAct);
				min = acum;
			}
		}
		else
			for (GeneralTree<Integer> child: nodo.getChildren())
				min = caminoSumaPrivate(child, result, caminoAct, min, acum);
		
		caminoAct.remove(caminoAct.size()-1);
		
		return min;
	}
	
	public static List<List<Integer>> todosLosCaminosConValoresEntre(GeneralTree<Integer> arbol, int min, int max) {
		
		List<List<Integer>> result = new LinkedList<List<Integer>>();
		
		if (arbol != null && !arbol.isEmpty() && arbol.getData() >= min && arbol.getData() <= max)
			caminosValoresEntrePrivate(arbol, result, new LinkedList<Integer>(), min, max);
		
		return result;
	}
	
	private static void caminosValoresEntrePrivate(GeneralTree<Integer> nodo, List<List<Integer>> result, List<Integer> caminoAct, int min, int max) {
		
		caminoAct.add(nodo.getData());
		
		if (nodo.isLeaf())
			result.add(new LinkedList<Integer>(caminoAct));
		else {
			for (GeneralTree<Integer> child: nodo.getChildren()) {
				if (child.getData() >= min && child.getData() <= max) {
					caminosValoresEntrePrivate(child, result, caminoAct, min, max);
				}
			}
		}
		caminoAct.remove(caminoAct.size()-1);
	}

}
