## CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS DE PASAJE DE MENSAJES ASINCRÓNICO (PMA):
- Los canales son compartidos por todos los procesos.
- Cada canal es una cola de mensajes; por lo tanto, el primer mensaje encolado es el primero en ser atendido.
- Por ser PMA, el send no bloquea al emisor.
- Se puede usar la sentencia empty para saber si hay algún mensaje en el canal, pero no se puede consultar por la cantidad de mensajes encolados.
- Se puede utilizar el if/do no determinístico donde cada opción es una condición booleana donde se puede preguntar por variables locales y/o por empty de canales.
```
if (cond 1) -> Acciones 1;
 (cond 2) -> Acciones 2;
….
 (cond N) -> Acciones N;
end if
```
De todas las opciones cuya condición sea Verdadera elige una en forma no determinística y ejecuta las acciones correspondientes. Si ninguna es verdadera, sale del if/do sin ejecutar acción alguna.
- Se debe evitar hacer busy waiting siempre que sea posible (sólo hacerlo si no hay otra opción).
- En todos los ejercicios el tiempo debe representarse con la función delay.
---
## Ejercicio 1
Suponga que N clientes llegan a la cola de un banco y que serán atendidos por sus empleados. Analice el problema y defina qué procesos, recursos y canales/comunicaciones serán necesarios/convenientes para resolverlo. Luego, resuelva considerando las siguientes situaciones:
### a. Existe un único empleado, el cual atiende por orden de llegada.
```csharp
chan solicitudes(int, string);
chan[N] resultados(string);

Process Empleado
{
	string solicitud;
	int id;
	
	for int i = 1..N
	{	
		receive solicitudes(id, solicitud);
		res = Resolver(solicitud);
		send resultados[id](res);
	}
}

Process Cliente[id 0..N-1]
{
	string solicitud;
	string res;
	
	send solicitudes(id, solicitud);
	receive resultados[id](res);
}
```

### b. Ídem a) pero considerando que hay 2 empleados para atender, ¿qué debe modificarse en la solución anterior?
```csharp
chan solicitudes(int, string);
chan[N] resultados(string);

Process Empleado[id 0..1]
{
	string solicitud;
	int id;
	
	while (true)
	{	
		receive solicitudes(id, solicitud);
		res = resolver(solicitud);
		send resultados[id](res);
	}
}

Process Cliente[id 0..N-1]
{
	string solicitud;
	string res;
	
	send solicitudes(id, solicitud);
	receive resultados[id](res);
}
```
### c. Ídem b) pero considerando que, si no hay clientes para atender, los empleados realizan tareas administrativas durante 15 minutos. ¿Se puede resolver sin usar procesos adicionales? ¿Qué consecuencias implicaría?
```csharp
chan solicitudes(int, string);
chan libres(int);
chan[2] solsEmpleados();
chan[N] resultados(string);

Process Empleado[id 0..1]
{
	string solicitud;
	int id;
	
	while (true)
	{
		send empleados[id]("libre");
		receive solsEmpleados(id, solicitud);
		if (id == -1)
			delay(15mins);
		else
		{
			res = resolver(solicitud);
			send resultados[id](res);
		}
	}
}

Process Administrador
{
	int id;
	int empleadoLibre;
	string solicitud;

	while (true)
	{
		receive libres(empleadoLibre);
		if empty(solicitudes)
			send solsEmpleados[empleadoLibre](-1, "");
		else
		{
			receive solicitudes(id, solicitud);
			send solsEmpleados[empleadoLibre](id, solicitud);
		}
	}
}

Process Cliente[id 0..N-1]
{
	string solicitud;
	string res;
	
	send solicitudes(id, solicitud);
	receive resultados[id](res);
}
```
---
## Ejercicio 2
Se desea modelar el funcionamiento de un banco en el cual existen 5 cajas para realizar pagos. Existen P clientes que desean hacer un pago. Para esto, cada uno selecciona la caja donde hay menos personas esperando; una vez seleccionada, espera a ser atendido. En cada caja, los clientes son atendidos por orden de llegada por los cajeros. Luego del pago, se les entrega un comprobante.
Nota: maximizar la concurrencia.
```csharp
chan pedirCaja(int);
chan[P] recibirCaja(int);

chan cajaLibre(int);

chan[5] esperarAtención(int);
chan[P] atención();

chan[5] pagos(Pago);
chan[P] comprobantes(string);

Process Caja[id 0..4]
{
	int cliente;
	Pago p;
	string comprobante;
	
	while(true)
	{
		receive esperarAtención[id](cliente);
		send Atención[cliente]();
		
		receive pagos[id](p);
		comprobante = GenerarComprobante(p);
		send comprobantes[cliente](comprobante);
		
		send cajaLibre(id);
	}
}

Process Administrador
{
	int[5] esperandoEnCaja = ([5] 0);
	int id;
	int caja;
	int libre;
	
	while (true)
	{		
		receive pedirCaja(id);
		caja = Min(esperandoCaja); // retorna la pos. que tenga el menor valor.
		esperandoEnCaja[caja]++;
		send recibirCaja[id](caja);
		
		if (not empty(cajasLibres))
		{
			receive cajasLibres(libre);
			esperandoEnCaja[libre]--;
		}
	}
}

Process Cliente[id 0..P-1]
{
	int caja;
	Pago p;
	string comprobante;

	send pedirCaja(id);
	receive recibirCaja[id](caja);
	send esperarAtención[caja](id);
	receive atención[id]();
	// realizar pago
	send pagos[caja](p);
	receive comprobantes[id](comprobante);
}
```