package ar.edu.unlp.info.oo1.ejercicio29;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class SesionDeJuego extends Actividad {
	
	private int duracion;
	private List<Item> items;

	protected SesionDeJuego(LocalDate fIni, String ip, int duracion) {
		super(fIni, ip);
		this.duracion = duracion;
		this.items = new ArrayList<>();
	}
	
	public void addItem(Item i) {
		this.items.add(i);
	}

	@Override
	protected double monto() {
		double monto = 0;
		if (this.duracion > 360)
			monto = this.items.stream()
					.mapToDouble(i -> i.precioTotal())
					.sum();
		return monto;
	}

}
