# Ejercicio 9 - Pedidos
Se tiene el siguiente modelo de un sistema de pedidos y la correspondiente implementación.
![[Pasted image 20261108181714.png]]
```Java
public class Pedido {
	
	private Cliente cliente;
	private List<Producto> productos;
	private String formaPago;
	
	public Pedido (Cliente cliente, List<Producto> productos, String formaPago) {
		if (!"efectivo".equals(formaPago)
		&& !"6 cuotas".equals(formaPago)
		&& !"12 cuotas".equals(formaPago)) {
			throw new Error("Forma de pago incorrecta");
		}
		this.cliente = cliente;
		this.productos = productos;
		this.formaPago = formaPago;
	}
	public double getCostoTotal() {
		double costoProductos = 0;
		for (Producto producto: this.productos) {
			costoProductos += producto.getPrecio();
		}
		double extraFormaPago = 0;
		if ("efectivo".equals(this.formaPago)) {
			extraFormaPago = 0;
		} else if ("6 cuotas".equals(this.formaPago)) {
			extraFormaPago = costoProductos * 0.2;
		} else if ("12 cuotas".equals(this.formaPago)) {
			extraFormaPago = costoProductos * 0.5;
		}
		int añosDesdeFechaAlta =
			Period.between(
				this.cliente.getFechaAlta(),
				LocalDate.now()).getYears()
			);
		// Aplicar descuento del 10% si el cliente tiene más de 5 años de antigüedad
		if (añosDesdeFechaAlta > 5) {
			return (costoProductos + extraFormaPago) * 0.9;
		}
		return costoProductos + extraFormaPago;
	}
}

public class Cliente {
	private LocalDate fechaAlta;
	public LocalDate getFechaAlta() {
		return this.fechaAlta;
	}
}

public class Producto {
	private double precio;
	public double getPrecio() {
		return this.precio;
	}
}
```
**Tareas:**
## 1. Dado e​l código anterior, aplique únicamente los siguientes refactoring:
- Replace Loop with Pipeline (líneas 16 a 19)
- Replace Conditional with Polymorphism (líneas 21 a 27)
- Extract method y move method (línea 28)
- Extract method y replace temp with query (líneas 28 a 33)

### *Replace Loop with Pipeline*
```Java
public class Pedido {
	
	private Cliente cliente;
	private List<Producto> productos;
	private String formaPago;
	
	public Pedido (Cliente cliente, List<Producto> productos, String formaPago) {
		if (!"efectivo".equals(formaPago)
		&& !"6 cuotas".equals(formaPago)
		&& !"12 cuotas".equals(formaPago)) {
			throw new Error("Forma de pago incorrecta");
		}
		this.cliente = cliente;
		this.productos = productos;
		this.formaPago = formaPago;
	}
	public double getCostoTotal() {

		// Replace loop with pipeline:
		double costoProductos = this.productos
								.stream()
								.mapToDouble(Producto::getPrecio)
								.sum();

		double extraFormaPago = 0;
		if ("efectivo".equals(this.formaPago)) {
			extraFormaPago = 0;
		} else if ("6 cuotas".equals(this.formaPago)) {
			extraFormaPago = costoProductos * 0.2;
		} else if ("12 cuotas".equals(this.formaPago)) {
			extraFormaPago = costoProductos * 0.5;
		}
		int añosDesdeFechaAlta =
			Period.between(
				this.cliente.getFechaAlta(),
				LocalDate.now()).getYears()
			);
		// Aplicar descuento del 10% si el cliente tiene más de 5 años de antigüedad
		if (añosDesdeFechaAlta > 5) {
			return (costoProductos + extraFormaPago) * 0.9;
		}
		return costoProductos + extraFormaPago;
	}
}

public class Cliente {
	private LocalDate fechaAlta;
	public LocalDate getFechaAlta() {
		return this.fechaAlta;
	}
}

public class Producto {
	private double precio;
	public double getPrecio() {
		return this.precio;
	}
}
```

### *Replace Conditional with Polymorphism*
```Java
public class Pedido {
	
	private Cliente cliente;
	private List<Producto> productos;
	private FormaPago formaPago;
	
	public Pedido (Cliente cliente, List<Producto> productos, FormaPago formaPago) {
		
		this.cliente = cliente;
		this.productos = productos;
		this.formaPago = formaPago;
	}
	
	public double getCostoTotal() {

		double costoProductos = this.productos
								.stream()
								.mapToDouble(Producto::getPrecio)
								.sum();

		double extraFormaPago = formaPago.getExtra(costoProductos);
		
		int añosDesdeFechaAlta =
			Period.between(
				this.cliente.getFechaAlta(),
				LocalDate.now()).getYears()
			);
		// Aplicar descuento del 10% si el cliente tiene más de 5 años de antigüedad
		if (añosDesdeFechaAlta > 5) {
			return (costoProductos + extraFormaPago) * 0.9;
		}
		return costoProductos + extraFormaPago;
	}
}

public class Cliente {
	private LocalDate fechaAlta;
	public LocalDate getFechaAlta() {
		return this.fechaAlta;
	}
}

public class Producto {
	private double precio;
	public double getPrecio() {
		return this.precio;
	}
}

public abstract class FormaPago {
	public abstract double getExtra(double costoProductos);
}

public class Efectivo extends FormaPago {
	public double getExtra(double costoProductos) {
		return 0;
	}
}

public class SeisCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.2;
	}
}

public class DoceCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.5;
	}
}
```

### Extract Method y Move Method
```Java
public class Pedido {
	
	private Cliente cliente;
	private List<Producto> productos;
	private FormaPago formaPago;
	
	public Pedido (Cliente cliente, List<Producto> productos, FormaPago formaPago) {
		
		this.cliente = cliente;
		this.productos = productos;
		this.formaPago = formaPago;
	}
	
	public double getCostoTotal() {

		double costoProductos = this.productos
								.stream()
								.mapToDouble(Producto::getPrecio)
								.sum();

		double extraFormaPago = formaPago.getExtra(costoProductos);
		
		int añosDesdeFechaAlta = this.cliente.getAñosDesdeFechaAlta();
		// Aplicar descuento del 10% si el cliente tiene más de 5 años de antigüedad
		if (añosDesdeFechaAlta > 5) {
			return (costoProductos + extraFormaPago) * 0.9;
		}
		return costoProductos + extraFormaPago;
	}
}

public class Cliente {
	private LocalDate fechaAlta;
	public LocalDate getFechaAlta() {
		return this.fechaAlta;
	}
	
	public int getAñosDesdeFechaAlta() {
		return Period.between(
			this.getFechaAlta(),
			LocalDate.now()).getYears();
	}
}

public class Producto {
	private double precio;
	public double getPrecio() {
		return this.precio;
	}
}

public abstract class FormaPago {
	public abstract double getExtra(double costoProductos);
}

public class Efectivo extends FormaPago {
	public double getExtra(double costoProductos) {
		return 0;
	}
}

public class SeisCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.2;
	}
}

public class DoceCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.5;
	}
}
```

### *Extract Method y Replace Temp with Query*
```Java
public class Pedido {
	
	private Cliente cliente;
	private List<Producto> productos;
	private FormaPago formaPago;
	
	public Pedido (Cliente cliente, List<Producto> productos, FormaPago formaPago) {
		
		this.cliente = cliente;
		this.productos = productos;
		this.formaPago = formaPago;
	}
	
	public double getCostoTotal() {

		double costoProductos = this.productos
								.stream()
								.mapToDouble(Producto::getPrecio)
								.sum();

		double extraFormaPago = formaPago.getExtra(costoProductos);
		
		return (costoProductos + extraFormaPago) * this.getDescuento();
	}
	
	private double getDescuento() {
		return (this.cliente.getAntiguedad() > 5) ? 0.9 : 1.0;
	}
}

public class Cliente {
	private LocalDate fechaAlta;
	public LocalDate getFechaAlta() {
		return this.fechaAlta;
	}
	
	public int getAntiguedad() {
		return Period.between(
			this.getFechaAlta(),
			LocalDate.now()).getYears()
		);
	}
}

public class Producto {
	private double precio;
	public double getPrecio() {
		return this.precio;
	}
}

public abstract class FormaPago {
	public abstract double getExtra(double costoProductos);
}

public class Efectivo extends FormaPago {
	public double getExtra(double costoProductos) {
		return 0;
	}
}

public class SeisCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.2;
	}
}

public class DoceCuotas extends FormaPago {
	public double getExtra(double costoProductos) {
		return costoProductos * 0.5;
	}
}
```
## 2.​ Realice el diagrama de clases del código refactorizado.
![[Pasted image 20261108191626.png]]