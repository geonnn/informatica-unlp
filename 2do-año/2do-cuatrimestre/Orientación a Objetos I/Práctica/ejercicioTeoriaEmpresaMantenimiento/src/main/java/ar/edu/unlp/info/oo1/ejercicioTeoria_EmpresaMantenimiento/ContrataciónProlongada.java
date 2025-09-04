package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

import java.time.LocalDate;

public class ContrataciónProlongada extends Contratación {
	
	private int cantDias;

	public ContrataciónProlongada(LocalDate fecha, Servicio servicio, int cantDias) {
		super(fecha, servicio);
		this.cantDias = cantDias;
	}

	double aplicarCondiciones(double monto) {
		monto *= cantDias;
		if (cantDias > 5)
			monto *= 0.90;
		return monto;
	}
}
