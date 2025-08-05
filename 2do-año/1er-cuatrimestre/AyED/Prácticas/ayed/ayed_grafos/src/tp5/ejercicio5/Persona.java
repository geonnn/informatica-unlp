package tp5.ejercicio5;

public class Persona {
	
	private String nombre;
	private String domicilio;
	private boolean jubilado;
	private boolean cobro;

	public Persona(String nombre, String domicilio, boolean esJubilado, boolean cobro) {
		super();
		setNombre(nombre);
		setDomicilio(domicilio);
		setJubilado(esJubilado);
		setCobro(cobro);
	}

	public String getNombre() {
		return nombre;
	}

	public String getDomicilio() {
		return domicilio;
	}

	public boolean isJubilado() {
		return jubilado;
	}
	
	public boolean cobroElMes() {
		return this.cobro;
	}

	private void setNombre(String nombre) {
		this.nombre = nombre;
	}

	private void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}

	private void setJubilado(boolean jubilado) {
		this.jubilado = jubilado;
	}
	
	private void setCobro(boolean cobro) {
		this.cobro = cobro;
	}
	
	public boolean cumple() {
		return this.jubilado && !this.cobro;
	}
}
