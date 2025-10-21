package ar.edu.unlp.info.oo1.parcial11_11_2023;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Cliente {
	
	private String nombre;
	private String email;
	private LocalDate fechaAlta;
	private List<Pedido> pedidos;
	
	public Cliente(String nombre, String email, LocalDate fechaAlta) {
		this.nombre = nombre;
		this.email = email;
		this.fechaAlta = fechaAlta;
		this.pedidos = new ArrayList<Pedido>();
	}
	
	protected void asignarPedido(Pedido p) {
		this.pedidos.add(p);
	}

	protected List<Pedido> getPedidos() {
		return new ArrayList<Pedido>(this.pedidos);
	}
	
	protected double costoTotalPeriodo(LocalDate fechaInicio, LocalDate fechaFin) {
		double total = 0;
		for (Pedido p : this.getPedidos()) {
			LocalDate fechaP = p.getFecha();
			if (!fechaP.isBefore(fechaInicio) && !fechaP.isAfter(fechaFin))
				total += p.getCostoTotal();
		}			
		return total;
	}
	
}
