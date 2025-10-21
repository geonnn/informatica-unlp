package ar.edu.unlp.info.oo1.ejercicio11;

public class CuentaCorriente extends Cuenta {
	
	private double limiteDeDescubierto;
	
	public CuentaCorriente() {
		super();
		this.limiteDeDescubierto = 0;
	}
	
	public boolean puedeExtraer(double monto) {
		return (this.getSaldo() + this.limiteDeDescubierto) >= monto;
	}

	public double getDescubierto() {
		return this.limiteDeDescubierto;
	}
	
	public void setDescubierto(double descubierto) {
		this.limiteDeDescubierto = descubierto;
	}
}
