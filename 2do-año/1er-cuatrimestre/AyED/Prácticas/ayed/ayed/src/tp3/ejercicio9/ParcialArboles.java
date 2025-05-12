package tp3.ejercicio9;

import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {
	
	public static boolean esDeSeleccion(GeneralTree<Integer> arbol) {
		if (arbol == null || arbol.isEmpty() || arbol.isLeaf()) return true;
		return esDeSeleccionPrivt(arbol);
	}
	
	private static boolean esDeSeleccionPrivt(GeneralTree<Integer> arbol) {
				
		int min = Integer.MAX_VALUE;
		
		for (GeneralTree<Integer> child : arbol.getChildren())
			min = Math.min(min, child.getData());
		
		if (!arbol.getData().equals(min)) return false;
		
		for (GeneralTree<Integer> child : arbol.getChildren())
			if (!child.isLeaf())
				if (!esDeSeleccionPrivt(child))
					return false;
		
		return true;
	}
}