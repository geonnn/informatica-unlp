package ar.edu.unlp.info.oo1.ejercicio6;

public class Domicilio {
	
	private String calle;
	private int numero;
	private String depto;
	private Integer piso;
	private Consumo consumo;
	
	public Domicilio(String calle, int numero) {
		this.calle = calle;
		this.numero = numero;
		this.depto = null;
		this.piso = null;
	}
	
	public Domicilio(String calle, int numero, String depto, int piso) {
		this(calle, numero);
		this.depto = depto;
		this.piso = piso;
	}

	public String getCalle() {
		return calle;
	}

	public int getNumero() {
		return numero;
	}

	public String getDepto() {
		return depto;
	}

	public int getPiso() {
		return piso;
	}
	
}
