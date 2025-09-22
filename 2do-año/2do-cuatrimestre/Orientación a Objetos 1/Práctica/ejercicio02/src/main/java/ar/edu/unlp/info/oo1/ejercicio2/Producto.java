package ar.edu.unlp.info.oo1.ejercicio2;

public class Producto {
	
	private double peso;
	private double precioPorKilo;
	private String descripcion;
	
	public Producto(String descripcion, double peso, double precioPorKilo) {
		this.descripcion = descripcion;
		this.peso = peso;
		this.precioPorKilo = precioPorKilo;
	}

	double getPeso() {
		return peso;
	}
	
	void setPrecioPorKilo(double precioPorKilo) {
		this.precioPorKilo = precioPorKilo;
	}
	
	double getPrecioPorKilo() {
		return precioPorKilo;
	}
	
	double getPrecio() {
		return precioPorKilo * peso;
	}
	
	String getDescripcion() {
		return descripcion;
	}
}
