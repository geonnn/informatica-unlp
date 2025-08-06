package tp5.ejercicioMasterclass;

public class Usuario {
	
	private String nombre;
	private int distancia;
	
	public Usuario(String nombre, int distancia) {
		super();
		this.nombre = nombre;
		this.distancia = distancia;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public int getDistancia() {
		return distancia;
	}

	@Override
	public String toString() {
		return "(" + nombre + ", " + distancia + ")";
	}
}
