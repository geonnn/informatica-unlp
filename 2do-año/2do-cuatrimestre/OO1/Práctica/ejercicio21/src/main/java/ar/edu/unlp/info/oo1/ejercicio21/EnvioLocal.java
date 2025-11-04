package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;

public class EnvioLocal extends EnvioEntregaRapida {
	
	private double costoBase = 1000;

	public EnvioLocal(LocalDate fechaDespacho, double pesoEnGramos,
					boolean entregaRapida, String origen, String destino) {
		super(fechaDespacho, pesoEnGramos, entregaRapida, origen, destino);
	}
	
	@Override
	public double monto() {
		double monto = this.costoBase;
		if (this.isEntregaRapida())
			monto += 500;
		
		return monto;
	}
}
