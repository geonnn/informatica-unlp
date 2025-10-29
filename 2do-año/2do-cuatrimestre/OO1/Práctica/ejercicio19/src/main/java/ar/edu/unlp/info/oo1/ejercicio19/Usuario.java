package ar.edu.unlp.info.oo1.ejercicio19;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Usuario {
	
	private String nombre;
	private String direccion;
	private int dni;
	private List<Inmueble> propiedades; // como dueño
	
	public Usuario(String nombre, String direccion, int dni) {
		this.nombre = nombre;
		this.direccion = direccion;
		this.dni = dni;
		this.propiedades = new ArrayList<>();
	}
	
	public double getIngresos(DateLapse dl) {
		return this.propiedades.stream()
				.mapToDouble(i -> i.getIngresos(dl))
				.sum();
	}
}
