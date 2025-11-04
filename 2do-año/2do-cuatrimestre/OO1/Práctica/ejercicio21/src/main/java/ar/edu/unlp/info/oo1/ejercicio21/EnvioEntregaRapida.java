package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;

public abstract class EnvioEntregaRapida extends Envio {

	private boolean entregaRapida;
	
	protected EnvioEntregaRapida(LocalDate fechaDespacho, double pesoEnGramos,
								boolean entregaRapida, String origen, String destino) {
		super(fechaDespacho, pesoEnGramos, origen, destino);
		this.entregaRapida = entregaRapida;
	}
	
	protected boolean isEntregaRapida() {
		return this.entregaRapida;
	}
}
