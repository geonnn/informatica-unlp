package tp5.ejercicio5compa;

public class Jubilado {
	private String nombre;
	private String domicilio;
	
	public Jubilado (String unN, String unD) {
		this.nombre = unN;
		this.domicilio = unD;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDomicilio() {
		return domicilio;
	}

	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}
	
	
}
