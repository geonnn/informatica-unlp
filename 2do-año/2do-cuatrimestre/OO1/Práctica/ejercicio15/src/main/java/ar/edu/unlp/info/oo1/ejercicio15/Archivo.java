package ar.edu.unlp.info.oo1.ejercicio15;

public class Archivo {
	
	private String nombre;
	
	public Archivo(String nombre) {
		this.nombre = nombre;
	}

	public int tamanio() {
		return this.nombre.length();
	}
	
}
