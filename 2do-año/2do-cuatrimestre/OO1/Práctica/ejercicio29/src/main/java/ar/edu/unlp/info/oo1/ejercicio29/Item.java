package ar.edu.unlp.info.oo1.ejercicio29;

public class Item {

	private String nombre;
	private int cantidad;
	private double precioUnit;
	
	public Item(String nombre, int cantidad, double precioUnit) {
		this.nombre = nombre;
		this.cantidad = cantidad;
		this.precioUnit = precioUnit;
	}
	
	protected double precioTotal() {
		return this.cantidad * this.precioUnit;
	}
}
