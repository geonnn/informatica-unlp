package tp3.ejercicio7;

import java.util.ArrayList;
import java.util.List;
import tp3.ejercicio1.GeneralTree;

public class Caminos {
	private GeneralTree<Integer> arbol;
	
	public Caminos(GeneralTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public List<Integer> caminoAHojaMasLejana() {
		List<Integer> caminoAct = new ArrayList<Integer>();
		List<Integer> caminoMax = new ArrayList<Integer>();
		caminoRec(this.arbol, caminoAct, caminoMax);
		return caminoMax;
	}
	
	private void caminoRec(GeneralTree<Integer> nodo, List<Integer> cAct, List<Integer> cMax) {
		
		cAct.add(nodo.getData());
		if (nodo.isLeaf()) {
			if (cAct.size() > cMax.size()) {
				cMax.clear();
				cMax.addAll(new ArrayList<Integer>(cAct));
			}
		}
		else
			for (GeneralTree<Integer> child : nodo.getChildren())
				caminoRec(child, cAct, cMax);
		
		// Cuando llega a este punto está volviendo y se debe borrar el último dato agregado.
		cAct.remove(cAct.size() - 1);
	}
}
