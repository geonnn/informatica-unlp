package ar.edu.unlp.info.oo1.ejercicio5;

public class InversionEnAccion implements Inversion {
	
	private Accion accion;
	private int cantidad;
	
	public InversionEnAccion(Accion accion, int cantidad) {
		this.accion = accion;
		this.cantidad = cantidad;
	}

	public double getValorActual() {
		return this.accion.getValorUnitario() * this.cantidad;
	}

}
