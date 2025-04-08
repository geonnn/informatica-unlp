package tp1.ejercicio7;

import java.util.*;

public class TestArrayList {
	
	public static boolean esCapicua(ArrayList<Integer> list) {
		Iterator<Integer> it = list.iterator();
		Iterator<Integer> itRev = list.reversed().iterator();
		for (int i = 0; i < list.size()/2; i++) {
			if (it.next() != itRev.next())
				return false;
		}
		return true;
	}
	
	public static void main(String[] args) {
		long inicio = System.nanoTime();
		
		ArrayList<Integer> lista = new ArrayList<Integer>();
		for (String num : args) {
			lista.add(Integer.parseInt(num));
		}
		
		ArrayList<Integer> lista2 = new ArrayList<Integer>();
		for (String num : args) {
			lista2.add(Integer.parseInt(num));
		}
		
		LinkedList<Integer> listaLinked = new LinkedList<Integer>();
		for (String num : args) {
			listaLinked.add(Integer.parseInt(num));
		}
		
		System.out.println("lista:\n");
		for (Integer n : lista) {
			System.out.println(n);
		}
		
		System.out.println("lista 2:\n");
		for (Integer n : lista) {
			System.out.println(n);
		}
		/*
		Estudiante.Estudiantes();
		
		System.out.println("Es capicúa: " + esCapicua(lista));
		
		List<Integer> listaRecursiva = EjercicioSucesion.calcularSucesion(6);
		
		for (Integer integer : listaRecursiva) {
			System.out.println(integer);
		}
		
		
		EjercicioSucesion.invertirArrayList(lista);
		System.out.println("lista invertida:\n");
		
		for (Integer n : lista) {
			System.out.println(n);
		}
		
		System.out.println("suma: " + EjercicioSucesion.sumarLinkedListRec(listaLinked));
		*/
		
		ArrayList<Integer> listaOrd = EjercicioSucesion.combinarOrdenado(lista, lista2);
		
		System.out.println("lista ordenada:\n");
		
		for (Integer integer : listaOrd) {
			System.out.println(integer);
		}
		
		
		
		long fin = System.nanoTime();
		System.out.println("Tiempo de ejecución: " + (fin - inicio)/1_000_000 + " milisegundos." );
	}

}
