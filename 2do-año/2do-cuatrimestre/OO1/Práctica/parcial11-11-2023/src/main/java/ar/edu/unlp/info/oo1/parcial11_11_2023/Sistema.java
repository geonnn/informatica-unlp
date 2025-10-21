package ar.edu.unlp.info.oo1.parcial11_11_2023;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Sistema {
	
	private List<Cliente> clientes;
	private List<Producto> productos;
	private List<Pedido> pedidos;

	public Cliente registrarCliente(String nombre, String email) {
		Cliente c = new Cliente(nombre, email, LocalDate.now());
		this.clientes.add(c);
		return c;
	}
	
	public ProductoNacional registrarProductoNacional(String nombre, double costoUnitario, String descripcion) {
		ProductoNacional p = new ProductoNacional(nombre, costoUnitario, descripcion);
		this.productos.add(p);
		return p;
	}
	
	public ProductoImportado registrarProductoImportado(String nombre, double costoUnitario, String descripcion, String paisDeOrigen) {
		ProductoImportado p = new ProductoImportado(nombre, costoUnitario, descripcion, paisDeOrigen);
		this.productos.add(p);
		return p;
	}
	
	public Pedido registrarPedido(Cliente cliente) {
		Pedido p = new Pedido(cliente, LocalDate.now());
		this.pedidos.add(p);
		return p;
	}
	
	public void agregarItem(Pedido pedido, Producto p, int cantidad) {
		pedido.agregarItem(new Item(p, cantidad));
	}
	
	public int cantidadSolicitadaProducto(Producto p) {
		return this.pedidos.stream().mapToInt(ped -> ped.getCantidadProducto(p)).sum();
	}
	
	// debería ser responsabilidad del cliente devolver su costo total por periodo?
	public double costoTotalClientePeriodo(Cliente c, LocalDate fechaInicio, LocalDate fechaFin) {
		return c.costoTotalPeriodo(fechaInicio, fechaFin);
	}
	
	// idem ^
	private double costoTotalUlt30Dias(Cliente c) {
		return this.costoTotalClientePeriodo(c, LocalDate.now().minusDays(30), LocalDate.now());
	}
	
	public List<Cliente> top5Clientes() {
		List<Cliente> top5 = new ArrayList<Cliente>(this.clientes);
		return top5.stream()
				.sorted((c1, c2) -> Double.compare(
					this.costoTotalUlt30Dias(c1),
					this.costoTotalUlt30Dias(c2)
				))
				.limit(5)
				.toList();
	}
}