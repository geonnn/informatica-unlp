package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;

public class EnvioInternacional extends EnvioEntregaRapida {

	private double costoBase = 5000; // variaría dependiendo el país de destino
	
	public EnvioInternacional(LocalDate fechaDespacho, double pesoEnGramos,
							boolean entregaRapida, String origen, String destino) {
		super(fechaDespacho, pesoEnGramos, entregaRapida, origen, destino);
	}
	
	@Override
	public double monto() {
		double monto = this.costoBase;
		
		if (this.isEntregaRapida())
			monto += 800;
		
		return monto + this.costoAdicionalPorPeso();
		
	}
	
	private double costoAdicionalPorPeso() {
		double peso = this.getPesoGr();
		double costoPorGramo;
		
		if (peso <= 1000)
			costoPorGramo = 10;
		else
			costoPorGramo = 12;
		
		return peso * costoPorGramo;
	}
}
