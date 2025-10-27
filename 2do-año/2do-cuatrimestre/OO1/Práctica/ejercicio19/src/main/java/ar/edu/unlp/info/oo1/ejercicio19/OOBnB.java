package ar.edu.unlp.info.oo1.ejercicio19;

import java.time.LocalDate;
import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class OOBnB {

	public boolean inmuebleIsAvailable(Inmueble i, LocalDate fini, LocalDate ffin) {
		DateLapse dl = new DateLapse(fini, ffin);
		return i.isAvailable(dl);
	}
}
