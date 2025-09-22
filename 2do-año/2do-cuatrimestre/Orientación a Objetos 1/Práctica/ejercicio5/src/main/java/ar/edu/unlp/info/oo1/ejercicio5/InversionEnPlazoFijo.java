package ar.edu.unlp.info.oo1.ejercicio5;

import java.time.LocalDate;
import java.time.Period;

public class InversionEnPlazoFijo implements Inversion {
	
	private LocalDate fechaConst;
	private double montoDepositado;
	private double interesDiario;	

	public InversionEnPlazoFijo(LocalDate fechaConst, double montoDepositado, double interesDiario) {
		this.fechaConst = fechaConst;
		this.montoDepositado = montoDepositado;
		this.interesDiario = interesDiario;
	}

	@Override
	public double getValorActual() {
		int dias = Period.between(fechaConst, LocalDate.now()).getDays();
		double intereses = montoDepositado * interesDiario * dias;
		return montoDepositado + intereses;
	}

}
