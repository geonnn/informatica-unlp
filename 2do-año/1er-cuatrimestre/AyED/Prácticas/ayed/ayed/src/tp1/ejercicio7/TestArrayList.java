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
		
		for (Integer n : lista) {
			System.out.println(n);
		}
		
		// Estudiante.Estudiantes();
		
		System.out.println("Es capicúa: " + esCapicua(lista));
		
		List<Integer> listaRecursiva = EjercicioSucesion.calcularSucesion(6);
		
		for (Integer integer : listaRecursiva) {
			System.out.println(integer);
		}
		
		long fin = System.nanoTime();
		System.out.println("Tiempo de ejecución: " + (fin - inicio) + " nanosegundos." );
	}

}
