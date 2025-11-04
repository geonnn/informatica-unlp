package ar.edu.unlp.info.oo1.ejercicio22;

import java.util.ArrayList;
import java.util.List;

public class PedidoSupermercado extends Pedido {

	private boolean aptaCeliacos;
	private List<ArticuloSupermercado> articulos;
	
	public PedidoSupermercado() {
		this.articulos = new ArrayList<ArticuloSupermercado>();
	}
	
	public void addVianda(ArticuloSupermercado a) {
		this.articulos.add(a);
	}
	
	public double costo() {
		return this.articulos.stream()
		.mapToDouble(v -> v.getPrecio()).sum();
	}
}
