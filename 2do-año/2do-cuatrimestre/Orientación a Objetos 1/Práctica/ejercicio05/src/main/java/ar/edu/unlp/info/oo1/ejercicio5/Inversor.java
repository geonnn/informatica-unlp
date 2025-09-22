package ar.edu.unlp.info.oo1.ejercicio5;

import java.util.ArrayList;
import java.util.List;

public class Inversor {
	
	private String nombre;
	private List<Inversion> inversiones;
	
	public Inversor(String nombre) {
		this.nombre = nombre;
		inversiones = new ArrayList<>();
	}
	
	public void agregarInversion(Inversion inversion) {
		inversiones.add(inversion);
	}
	
	public void removerInversion(Inversion inversion) {
		inversiones.remove(inversion);
	}

	public double getValorInversiones() {
		return inversiones.stream().mapToDouble(i -> i.getValorActual()).sum();
	}
}
