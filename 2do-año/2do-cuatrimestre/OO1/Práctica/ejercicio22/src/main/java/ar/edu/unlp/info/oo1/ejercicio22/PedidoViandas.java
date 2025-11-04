package ar.edu.unlp.info.oo1.ejercicio22;

import java.util.ArrayList;
import java.util.List;

public class PedidoViandas extends Pedido {

	private boolean aptaCeliacos;
	private List<Vianda> viandas;
	
	public PedidoViandas() {
		this.viandas = new ArrayList<Vianda>();
	}
	
	public void addVianda(Vianda v) {
		this.viandas.add(v);
	}
	
	public double costo() {
		return this.viandas.stream()
		.mapToDouble(v -> v.getPrecio()).sum();
	}
}
