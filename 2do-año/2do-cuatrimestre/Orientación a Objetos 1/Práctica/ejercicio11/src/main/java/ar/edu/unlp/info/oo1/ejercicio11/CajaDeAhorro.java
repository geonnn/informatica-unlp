package ar.edu.unlp.info.oo1.ejercicio11;

public class CajaDeAhorro extends Cuenta {
	
	protected boolean puedeExtraer(double monto) {
		return this.getSaldo() >= monto * 1.02;
	}
	
	@Override
	protected void extraerSinControlar(double monto) {
		super.extraerSinControlar(monto * 1.02);
	}
}
