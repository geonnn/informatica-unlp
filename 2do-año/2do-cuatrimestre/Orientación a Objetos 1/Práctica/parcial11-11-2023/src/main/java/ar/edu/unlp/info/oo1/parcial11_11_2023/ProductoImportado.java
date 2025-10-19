package ar.edu.unlp.info.oo1.parcial11_11_2023;

public class ProductoImportado extends Producto {
	
	private String paisDeOrigen;

	public ProductoImportado(String nombre, double costoUnitario, String descripcion, String paisDeOrigen) {
		super(nombre, costoUnitario, descripcion);
		this.paisDeOrigen = paisDeOrigen;
	}

	@Override
	protected double getImpuesto(int cantidad) {
		return (this.isMercosur() && cantidad > 50) ? 0.08 : 0.21;
	}
	
	private boolean isMercosur() {
		return this.paisDeOrigen.equals("Brasil") ||
				this.paisDeOrigen.equals("Uruguay") ||
				this.paisDeOrigen.equals("Paraguay");
	}
	
	enum Mercosur {Brasil, Uruguay, Paraguay};

}
