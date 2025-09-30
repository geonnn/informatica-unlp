package ar.edu.unlp.info.oo1.ejercicio5;

import java.util.ArrayList;
import java.util.List;

public class Inversor {
	
	private String nombre;
	private List<Inversion> inversiones;
	
	public Inversor(String nombre) {
		this.nombre = nombre;
		this.inversiones = new ArrayList<>();
	}
	
	public void agregarInversion(Inversion inversion) {
		this.inversiones.add(inversion);
	}
	
	public void removerInversion(Inversion inversion) {
		this.inversiones.remove(inversion);
	}
	
	protected List<Inversion> getInversiones() {
		return this.inversiones;
	}

	public double getValorInversiones() {
		return inversiones.stream().mapToDouble(i -> i.getValorActual()).sum();
	}
}
