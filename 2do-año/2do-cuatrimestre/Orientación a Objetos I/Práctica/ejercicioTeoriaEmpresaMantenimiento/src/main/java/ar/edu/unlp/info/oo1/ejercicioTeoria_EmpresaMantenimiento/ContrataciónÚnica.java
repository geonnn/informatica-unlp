package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

import java.time.DayOfWeek;
import java.time.LocalDate;

public class ContrataciónÚnica extends Contratación {
	
	private int cantDias;

	public ContrataciónÚnica(LocalDate fecha, Servicio servicio) {
		super(fecha, servicio);
	}

	double aplicarCondiciones(double monto) {
		DayOfWeek dia = DayOfWeek.from(getFecha());
		if (dia.equals(DayOfWeek.SATURDAY) || dia.equals(DayOfWeek.SUNDAY))
			monto *= 1.15;
		return monto;
	}
}
