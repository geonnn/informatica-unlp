package objetosdos;

import java.util.ArrayList;
import java.util.List;

// COMPOSITE
public class Directorio extends ElementoFileSystem {
	
	private static final int TAMANO_INICIAL_KB = 32768; 

	private List<ElementoFileSystem> elementos;
	
	public Directorio(String nombre) {
		super(nombre);
		this.elementos = new ArrayList<>();
	}
	
	public void agregar(ElementoFileSystem elemento) {
		this.elementos.add(elemento);
	}

	@Override
	public int getTamanoEnBytes() {
		return TAMANO_INICIAL_KB
				+ this.elementos.stream()
				.mapToInt(e -> e.getTamanoEnBytes())
				.sum();
	}

	@Override
	public Archivo archivoMasGrande() {
		return this.elementos.stream()
				.map(e -> e.archivoMasGrande())
				.max((a1, a2) -> Integer.compare(a1.getTamanoEnBytes(), a2.getTamanoEnBytes()))
				.orElse(null);
	}

	@Override
	public Archivo archivoMasNuevo() {
		return this.elementos.stream()
				.map(e -> e.archivoMasNuevo())
				.max((a1, a2) -> a1.getFechaCreacion().compareTo(a2.getFechaCreacion()))
				.orElse(null);
	}

	@Override
	public ElementoFileSystem buscar(String nombre) {
		if (this.getNombre().equals(nombre))
			return this;
		
		return this.elementos.stream()
				.map(e -> e.buscar(nombre))
				.findFirst()
				.orElse(null);
	}

	@Override
	public List<ElementoFileSystem> buscarTodos(String nombre) {
		List<ElementoFileSystem> result = new ArrayList<>();
		if (this.getNombre().equals(nombre))
			result.add(this);
		for (ElementoFileSystem e : this.elementos)
			result.addAll(e.buscarTodos(nombre));
		
		return result;
	}

	@Override
	public String listadoDeContenido() {
		// TODO Auto-generated method stub
		return null;
	}

}
