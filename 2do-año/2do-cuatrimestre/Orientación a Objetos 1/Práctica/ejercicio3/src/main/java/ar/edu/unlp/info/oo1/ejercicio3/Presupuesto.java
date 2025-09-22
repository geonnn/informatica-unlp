package ar.edu.unlp.info.oo1.ejercicio3;

import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;

public class Presupuesto {

	private LocalDate fecha;
	private String cliente;
	private List<Item> items;
	
	public Presupuesto(String cliente) {
		this.cliente = cliente;
		fecha = LocalDate.now();
		items = new LinkedList<Item>();
	}
	
	LocalDate getFecha() {
		return fecha;
	}
	
	String getCliente() {
		return cliente;
	}
	
	void agregarItem(Item item) {
		items.add(item);
	}
	
	double calcularTotal() {
		double total = 0;
		for (Item item : items) {
			total += item.costo();
		}
		return total;
	}
}
