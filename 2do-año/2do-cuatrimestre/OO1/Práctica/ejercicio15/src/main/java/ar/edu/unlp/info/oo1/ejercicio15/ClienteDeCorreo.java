package ar.edu.unlp.info.oo1.ejercicio15;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ClienteDeCorreo {
	
	private Carpeta inbox;
	private List<Carpeta> carpetas;
	
	public ClienteDeCorreo() {
		this.inbox = new Carpeta("Inbox");
		this.carpetas = new ArrayList<Carpeta>();
	}

	public void recibir(Email email) {
		this.inbox.agregarEmail(email);
	}
	
	public void agregarCarpeta(Carpeta c) {
		if (c != null && !this.carpetas.contains(c))
			this.carpetas.add(c);
	}
	
	public Email buscar(String texto) {
		Email em = null;
		Carpeta c;
		em = this.inbox.buscar(texto);
		if (em != null) {
			Iterator<Carpeta> it = this.carpetas.iterator();
			while (it.hasNext() && em == null) {
				c = it.next();
				em = c.buscar(texto);
			}
		}
		return em;
	}
	
	public int espacioOcupado() {
		return this.inbox.tamanio() +
				this.carpetas.stream()
				.mapToInt(c -> c.tamanio())
				.sum();
	}
}
