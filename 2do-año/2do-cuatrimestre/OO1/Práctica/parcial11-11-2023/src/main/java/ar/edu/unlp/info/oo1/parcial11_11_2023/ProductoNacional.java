package ar.edu.unlp.info.oo1.parcial11_11_2023;

public class ProductoNacional extends Producto {

	public ProductoNacional(String nombre, double costoUnitario, String descripcion) {
		super(nombre, costoUnitario, descripcion);
	}

	@Override
	protected double getImpuesto(int cantidad) {
		return (cantidad > 10) ? 0 : 0.05;
	}

}
