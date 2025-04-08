package tp1.ejercicio7;

import java.util.*;

public class EjercicioSucesion {
	
	public static List<Integer> calcularSucesion(int n) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(n);
		if (n != 1) {
			int num = (n % 2 == 0) ? n/2 : 3*n+1;
			list.addAll(calcularSucesion(num));
		}
		return list;
	}
	
	public static void invertirArrayList(ArrayList<Integer> lista) {
		int aux;
		for (int i = 0; i < lista.size()/2; i++) {
			aux = lista.get(i);
			lista.set(i, lista.get(lista.size()-1-i));
			lista.set(lista.size()-1-i, aux);
		}
	}
	
	public static void invertirArrayListRecursivo(ArrayList<Integer> lista) {
		if (lista.size() <= 1) return;
		else {
			Integer n;
			n = lista.remove(0);
			invertirArrayListRecursivo(lista);
			lista.add(n);
		}
	}
	
	public static int sumarLinkedListRec(LinkedList<Integer> lista) {
		if (lista.isEmpty()) return 0;
		else {
			return lista.remove(0) + sumarLinkedListRec(lista);
		}
	}
	
	public static ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1, ArrayList<Integer> lista2) {
		
		ArrayList<Integer> listaResult = new ArrayList<>(lista1.size() + lista2.size()); 
		int i = 0, j = 0; 
		while (i < lista1.size() && j < lista2.size()) {
			if (lista1.get(i) < lista2.get(j))
				listaResult.add(lista1.get(i++));
			else
				listaResult.add(lista2.get(j++));
		}
		
		while (i < lista1.size()) listaResult.add(lista1.get(i++));
		while (j < lista2.size()) listaResult.add(lista2.get(j++));

		return listaResult;
	}
	
}
