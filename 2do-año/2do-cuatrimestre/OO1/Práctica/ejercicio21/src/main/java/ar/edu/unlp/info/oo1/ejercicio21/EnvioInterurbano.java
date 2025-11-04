package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;

public class EnvioInterurbano extends Envio {
	
	private double distancia;

	protected EnvioInterurbano(LocalDate fechaDespacho, double pesoEnGramos, String origen, String destino) {
		super(fechaDespacho, pesoEnGramos, origen, destino);
	}

	@Override
	public double monto() {
		return this.costoPorGramo() * this.getPesoGr();
	}

	private double costoPorGramo() {
		if (this.distancia < 100)
			return 20;
		else if (this.distancia >= 100 && this.distancia <= 500)
			return 25;
		else
			return 30;
	}
}
