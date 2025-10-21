package ar.edu.unlp.info.oo1.ejercicio15;

import java.util.ArrayList;
import java.util.List;

public class Carpeta {
	
	private String nombre;
	private List<Email> emails;

	public Carpeta(String nombre) {
		this.nombre = nombre;
		this.emails = new ArrayList<Email>();
	}

	public String getNombre() {
		return this.nombre;
	}
	
	public void mover(Email email, Carpeta destino) {
		destino.agregarEmail(email);
		this.emails.remove(email);
	}
	
	public void agregarEmail(Email email) {
		this.emails.add(email);
	}
	
	public Email buscar(String texto) {
		return this.emails.stream()
				.filter(e -> e.contiene(texto))
				.findFirst().orElse(null);
	}
	
	public int tamanio() {
		return this.emails.stream().mapToInt(e -> e.tamanio()).sum();
	}
	
}
