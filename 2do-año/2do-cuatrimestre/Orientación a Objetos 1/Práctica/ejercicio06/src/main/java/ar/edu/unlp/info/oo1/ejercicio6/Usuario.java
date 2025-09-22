package ar.edu.unlp.info.oo1.ejercicio6;

public class Usuario {
	
	private String nombre;
	private Domicilio domicilio;
	private Consumo ultConsumo;
	
	public Usuario(String nombre, Domicilio domicilio, Consumo ultConsumo) {
		this.nombre = nombre;
		this.domicilio = domicilio;
		this.ultConsumo = ultConsumo;
	}
	
	public Consumo getUltimoConsumo() {
		return ultConsumo;
	}
	
}
