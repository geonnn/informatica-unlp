package objetosdos;

import java.time.LocalDate;
import java.util.List;

// COMPONENT
public abstract class ElementoFileSystem {
	
	private String nombre;
	private LocalDate fechaCreacion;
	
	protected ElementoFileSystem(String nombre) {
		this.nombre = nombre;
		this.fechaCreacion = LocalDate.now();
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public LocalDate getFechaCreacion() {
		return fechaCreacion;
	}
	
	public abstract int getTamanoEnBytes();
	
	public abstract Archivo archivoMasGrande();
	public abstract Archivo archivoMasNuevo();
	public abstract ElementoFileSystem buscar(String nombre);
	public abstract List<ElementoFileSystem> buscarTodos(String nombre);
	public abstract String listadoDeContenido();

}
