package ar.edu.unlp.info.oo1.ejercicio6;

import java.time.LocalDate;

public class Factura {
	
	private Usuario usuario;
	private LocalDate fecha;
	private double bonificacion;
	private double monto;

	public Factura(Usuario usuario, CuadroTarifario cuadroTarifario) {
		this.usuario = usuario;
		this.fecha = LocalDate.now();
		
		Consumo ultConsumo = usuario.getUltimoConsumo();
		
		this.bonificacion = (ultConsumo.calcularFPE() > 0.8) ? (monto * 0.10) : 0;
		
		this.monto = ( ultConsumo.getEnergiaActiva() * cuadroTarifario.getPrecioKWh()) - bonificacion;
	}

	@Override
	public String toString() {
		return "Factura [usuario=" + usuario + ", fecha=" + fecha + ", bonificacion=" + bonificacion + ", monto="
				+ monto + "]";
	}
}
