package ar.edu.unlp.info.oo1.parcial11_11_2023;

public class Item {
	
	private Producto producto;
	private int cantidad;
	
	public Item(Producto producto, int cantidad) {
		this.producto = producto;
		this.cantidad = cantidad;
	}
	
	protected int getCantidad() {
		return this.cantidad;
	}
	
	protected Producto getProducto() {
		return this.producto;
	}
	
	protected double getCosto() {
		return (this.producto.getCostoUnitario() * this.cantidad) + this.getImpuesto();
	}
	
	private double getImpuesto() {
		return this.producto.getImpuesto(this.cantidad) * this.producto.getCostoUnitario();
	}
}
