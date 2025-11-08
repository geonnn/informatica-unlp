package ar.edu.unlp.info.oo1.ejercicio29;

import java.time.LocalDate;

public class ReproduccionDeVideo extends Actividad {
	
	private int durTotal;
	private int durPubli;

	protected ReproduccionDeVideo(LocalDate fIni, String ip, int durTotal, int durPubli) {
		super(fIni, ip);
		this.durTotal = durTotal;
		this.durPubli = durPubli;
	}

	@Override
	protected double monto() {
		return (this.durTotal - this.durPubli) * 10;
	}

}
