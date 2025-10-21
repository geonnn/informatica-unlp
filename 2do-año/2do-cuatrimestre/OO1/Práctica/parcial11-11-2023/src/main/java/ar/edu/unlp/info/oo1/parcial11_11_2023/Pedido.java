package ar.edu.unlp.info.oo1.parcial11_11_2023;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Pedido {
	
	private Cliente cliente;
	private List<Item> items;
	private LocalDate fecha;
	
	// LocalDate.now() iría en el constructor o lo recibe como parámetro?
	public Pedido(Cliente cliente, LocalDate fecha) {
		this.cliente = cliente;
		this.items = new ArrayList<Item>();
		this.fecha = fecha;
		cliente.asignarPedido(this);
	}
	
	public void agregarItem(Item i) {
		this.items.add(i);
	}
	
	protected List<Item> getItems() {
		return new ArrayList<Item>(this.items);
	}
	
	protected LocalDate getFecha() {
		return this.fecha;
	}
	
	protected double getCostoTotal() {
		return this.items.stream().mapToDouble(p -> p.getCosto()).sum();
	}
	
	protected int getCantidadProducto(Producto p) {
		return this.items.stream()
				.filter(i -> i.getProducto().equals(p))
				.mapToInt(i -> i.getCantidad()).sum();
		}
}
