package objetosdos;

import java.util.List;

public class FileSystem {
	
	private ElementoFileSystem raiz;

	public FileSystem(Directorio raiz) {
		this.raiz = raiz;
	}
	
	public int tamanoTotalOcupado() {
		return this.raiz.getTamanoEnBytes();
	}
	
	public Archivo archivoMasGrande() {
		return this.raiz.archivoMasGrande();
	}
	
	public Archivo archivoMasNuevo() {
		return this.raiz.archivoMasNuevo();
	}
	
	public ElementoFileSystem buscar(String nombre) {
		return this.raiz.buscar(nombre);
	}
	
	public List<ElementoFileSystem> buscarTodos(String nombre) {
		return this.raiz.buscarTodos(nombre);
	}
	
	public String listadoDeContenido() {
		return this.raiz.listadoDeContenido();
	}
}
