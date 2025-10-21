package ar.edu.unlp.info.oo1.ejercicio15;

import java.util.ArrayList;
import java.util.List;

public class Email {
	
	private String titulo;
	private String cuerpo;
	private List<Archivo> adjuntos;
	
	public Email(String titulo, String cuerpo) {
		this.titulo = titulo;
		this.cuerpo = cuerpo;
		this.adjuntos = new ArrayList<Archivo>();
	}

	public String getTitulo() {
		return this.titulo;
	}

	public String getCuerpo() {
		return this.cuerpo;
	}

	public List<Archivo> getAdjuntos() {
		return this.adjuntos;
	}
	
	public void addAdjunto(Archivo archivo) {
		this.adjuntos.add(archivo);
	}
	
	public boolean contiene(String texto) {
		return this.titulo.contains(texto)
				|| this.cuerpo.contains(texto);
	}

	public int tamanio() {
		return this.adjuntos.stream().mapToInt(a -> a.tamanio()).sum()
				+ this.titulo.length()
				+ this.cuerpo.length();
	}
}
