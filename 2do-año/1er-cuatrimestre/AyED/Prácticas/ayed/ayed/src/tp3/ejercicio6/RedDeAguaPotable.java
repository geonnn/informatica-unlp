package tp3.ejercicio6;

import tp3.ejercicio1.GeneralTree;

public class RedDeAguaPotable {
	private GeneralTree<Character> red;
	
	public double minimoCaudal(double caudal) {
		return minimoCaudalRec(this.red, caudal);
	}
	
	private double minimoCaudalRec(GeneralTree<Character> nodo, double caudal) {
		
		if (nodo.isLeaf()) return caudal;
		
		int cantBifurcaciones = nodo.getChildren().size();
		double min = Double.MAX_VALUE;
		caudal /= cantBifurcaciones;
		
		// No hace falta preguntar si tiene hijos porque sino ya hubiera retornado por ser leaf.
		for (GeneralTree<Character> child : nodo.getChildren()) {
			min = Math.min(min, minimoCaudalRec(child, caudal));
		}
		
		return min;
	}

}
