package ar.edu.unlp.info.oo1.parcial11_11_2023;

public abstract class Producto {
	
	private String nombre;
	private double costoUnitario;
	private String descripcion;
	
	public Producto(String nombre, double costoUnitario, String descripcion) {
		this.nombre = nombre;
		this.costoUnitario = costoUnitario;
		this.descripcion = descripcion;
	}

	protected String getNombre() {
		return nombre;
	}

	protected double getCostoUnitario() {
		return costoUnitario;
	}

	protected String getDescripcion() {
		return descripcion;
	}
	
	protected abstract double getImpuesto(int cantidad);
}
