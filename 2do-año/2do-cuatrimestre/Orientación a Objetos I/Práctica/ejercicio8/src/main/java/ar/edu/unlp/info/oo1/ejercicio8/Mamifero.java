package ar.edu.unlp.info.oo1.ejercicio8;

import java.time.LocalDate;
import java.util.LinkedList;
import java.util.Queue;

public class Mamifero {
	
	private String id;
	private String especie;
	private LocalDate fechaNac;
	private Mamifero padre;
	private Mamifero madre;

	public Mamifero() {
		this.padre = null;
		this.madre = null;
	}
	
	public Mamifero(String id) {
		this();
		this.id = id;
	}
	
	public String getIdentificador() {
		return id;
	}
	
	public void setIdentificador(String id) {
		this.id = id;
	}
	
	public String getEspecie() {
		return especie;
	}
	
	public void setEspecie(String especie) {
		this.especie = especie;
	}
	
	public LocalDate getFechaNac() {
		return fechaNac;
	}
	
	public void setFechaNac(LocalDate fechaNac) {
		this.fechaNac = fechaNac;
	}
	
	public Mamifero getPadre() {
		return padre;
	}
	
	public void setPadre(Mamifero padre) {
		this.padre = padre;
	}
	
	public Mamifero getMadre() {
		return madre;
	}
	
	public void setMadre(Mamifero madre) {
		this.madre = madre;
	}
	
	public Mamifero getAbueloMaterno() {
		if (madre != null)
			return madre.getPadre();
		return null;
	}
	
	public Mamifero getAbuelaMaterna() {
		if (madre != null)
			return madre.getMadre();
		return null;
	}
	
	public Mamifero getAbueloPaterno() {
		if (padre != null)
			return padre.getPadre();
		return null;
	}
	
	public Mamifero getAbuelaPaterna() {
		if (padre != null)
			return padre.getMadre();
		return null;
	}
	
	public boolean tieneComoAncestroA(Mamifero mamifero) {
		
		// ¿conviene hacer bfs?
		// no necesariamente:
		// bfs funciona mejor con árboles muy profundos y poco anchos.
		// dfs funciona mejor con árboles anchos, con ramas más cortas.
		
		// implementación bfs con queue:
		
//		Queue<Mamifero> q = new LinkedList<>();
//		
//		if (this.madre != null)
//			q.add(this.madre);
//		
//		if (this.padre != null)
//			q.add(this.padre);
//		
//		while (!q.isEmpty()) {
//			Mamifero m = q.poll();
//			if (m.equals(mamifero))
//				return true;
//			
//			if (m.madre != null)
//				q.add(m.madre);
//			
//			if (m.padre != null)
//				q.add(m.padre);
//		}
//		return false;
		
		// dfs:
		
		if (this.madre != null) {
			if (this.madre.equals(mamifero) || this.madre.tieneComoAncestroA(mamifero))
				return true;
		}
		
		if (this.padre != null) {
			if (padre.equals(mamifero) || this.padre.tieneComoAncestroA(mamifero))
				return true;
		}
	
		return false;
	}
}