package tp5.ejercicio5compa;

public class Persona {
	private String domicilio;
	private String nombre;
	private String tipo;
	private boolean cobro;
	
	public Persona (String unaD, String unN, String unT, boolean unC) {
		this.domicilio = unaD;
		this.nombre = unN;
		this.tipo = unT;
		this.cobro = unC;
	}

	public String getDomicilio() {
		return domicilio;
	}

	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	
	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public boolean getCobro() {
		return this.cobro;
	}
	
	public void setCobro (boolean unC) {
		this.cobro = unC;
	}
	
	public boolean cumple () {
		return this.tipo.equals("Jubilado") && !this.getCobro();
	}
}
