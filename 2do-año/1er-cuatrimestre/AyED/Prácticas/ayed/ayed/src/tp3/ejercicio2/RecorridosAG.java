package tp3.ejercicio2;

import java.util.*;
import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class RecorridosAG {
	
	public List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		if (a == null) return list;
		
		this.numerosPreOrden(list, a, n);
		return list;
	}
	
	public List<Integer> numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		if (a == null) return list;
		
		this.numerosInOrden(list, a, n);
		return list;
	}
	
	public List<Integer> numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		if (a == null) return list;
		
		this.numerosPostOrden(list, a, n);
		return list;
	}
	
	public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		this.numerosPorNiveles(list, a, n);
		return list;
	}
	
	private void numerosPorNiveles(List<Integer> list, GeneralTree<Integer> n, int num) {
		Queue<GeneralTree<Integer>> cola = new Queue<GeneralTree<Integer>>();
		cola.enqueue(n); cola.enqueue(null);
		
		GeneralTree<Integer> nAux = new GeneralTree<Integer>();
		while(!cola.isEmpty()) {
			nAux = cola.dequeue();
			if (nAux != null) {
				
				int nAct = nAux.getData();
				if (nAct > num && (nAct % 2 != 0))
				list.add(nAct);
				
				if (nAux.hasChildren())
					for (GeneralTree<Integer> child : nAux.getChildren())
						cola.enqueue(child);
			}
			else {
				if (!cola.isEmpty())
					cola.enqueue(null);
			}
		}
	}
	
	private void numerosPreOrden(List<Integer> list, GeneralTree<Integer> n, int num) {
		
		int nAct = n.getData();
		if (nAct > num && (nAct % 2 != 0))
			list.add(nAct);
		
		List<GeneralTree<Integer>> children = n.getChildren();
		
		for (GeneralTree<Integer> child : children) {
			numerosPreOrden(list, child, num);
		}
	}
		
	private void numerosInOrden(List<Integer> list, GeneralTree<Integer> n, int num) {
		
		List<GeneralTree<Integer>> children = n.getChildren();
		
		if (!children.isEmpty()) {
			numerosInOrden(list, children.getFirst(), num);
			children.removeFirst();
		}
		
		int nAct = n.getData();
		if (nAct > num && (nAct % 2 != 0))
			list.add(nAct);
		
		
		for (GeneralTree<Integer> child : children) {
			numerosInOrden(list, child, num);
		}
	}
	
	private void numerosPostOrden(List<Integer> list, GeneralTree<Integer> n, int num) {
		
		List<GeneralTree<Integer>> children = n.getChildren();
		
		for (GeneralTree<Integer> child : children) {
			numerosPostOrden(list, child, num);
		}
		
		int nAct = n.getData();
		if (nAct > num && (nAct % 2 != 0))
			list.add(nAct);		
	}
	
	
}