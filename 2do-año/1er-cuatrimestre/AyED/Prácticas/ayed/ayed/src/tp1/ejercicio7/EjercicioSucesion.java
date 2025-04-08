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
}
