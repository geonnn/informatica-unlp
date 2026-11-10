package objetosdos;

import java.util.ArrayList;
import java.util.List;

// LEAF
public class Archivo extends ElementoFileSystem {
	
	private int tamanoEnBytes;

	public Archivo(String nombre, int tamanoEnBytes) {
		super(nombre);
		this.tamanoEnBytes = tamanoEnBytes;
	}

	@Override
	public int getTamanoEnBytes() {
		return this.tamanoEnBytes;
	}

	@Override
	public Archivo archivoMasGrande() {
		return this;
	}

	@Override
	public Archivo archivoMasNuevo() {
		return this;
	}

	@Override
	public ElementoFileSystem buscar(String nombre) {
		return this.getNombre().equals(nombre) ? this : null;
	}

	@Override
	public List<ElementoFileSystem> buscarTodos(String nombre) {
		List<ElementoFileSystem> result = new ArrayList<>();
		if (this.getNombre().equals(nombre))
			result.add(this);
		
		return result;
	}

	@Override
	public String listadoDeContenido() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
