package tp3.ejerciciosVideos;

import java.util.List;

import tp3.ejercicio1.GeneralTree;

public class Main {

	public static void main(String[] args) {
		GeneralTree<Integer> ag = new GeneralTree<Integer>(4);
		GeneralTree<Integer> n1 = new GeneralTree<Integer>(2);
		GeneralTree<Integer> n3 = new GeneralTree<Integer>(-5);
		
		n3.addChild(new GeneralTree<Integer>(17));
		
		n1.addChild(new GeneralTree<Integer>(6));
		n1.addChild(new GeneralTree<Integer>(3));
		n1.addChild(new GeneralTree<Integer>(9));
		
		ag.addChild(n1);		
		ag.addChild(new GeneralTree<Integer>(5));		
		ag.addChild(n3);
		
		List<Integer> sumaMin = CaminosArboles.buscarCaminoSumaMinima(ag);
		
		System.out.println(sumaMin);
		
	}

}
