# CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS DE PASAJE DE MENSAJES ASINCRÓNICO (PMA):
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
chan[2] empleados(string);

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
		
		if (not empty(cajaLibre))
		{
			receive cajaLibre(libre);
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
---
## Ejercicio 3
Se debe modelar el funcionamiento de una casa de comida rápida, en la cual trabajan 2 cocineros y 3 vendedores, y que debe atender a C clientes. El modelado debe considerar que:
- Cada cliente realiza un pedido y luego espera a que se lo entreguen.
- Los pedidos que hacen los clientes son tomados por cualquiera de los vendedores y se lo pasan a los cocineros para que realicen el plato. Cuando no hay pedidos para atender, los vendedores aprovechan para reponer un pack de bebidas de la heladera (tardan entre 1 y 3 minutos para hacer esto).
- Repetidamente cada cocinero toma un pedido pendiente dejado por los vendedores, lo cocina y se lo entrega directamente al cliente correspondiente.
Nota: maximizar la concurrencia.
```csharp
chan[C] entregas(Comida);
chan realizarPedido(int, Pedido);
chan comandas(int, Pedido);
chan vendedorLibre(int);
chan[3] pedirPedido(int, Pedido);

Process Cocinero[id 0..1]
{
	int id;
	Pedido p;
	Comida c;
	
	while(true)
	{
		receive comandas(id, p);
		c = cocinar(p);
		send entregas[id](c);
	}
}

Process Vendedor[id 0..2]
{
	int idCliente;
	Pedido p;

	while (true)
	{
		send vendedorLibre(id);
		receive pedirPedido[id](idCliente, p);
		
		if (idCliente == -1)
			delay(random(1..3mins));
		else
			send comandas(idCliente, p);
	}
}

Process Coordinador
{
	int idVendedor;
	int idCliente;
	Pedido p;

	while (true)
	{
		receive vendedorLibre(idVendedor);
		
		if (empty(realizarPedido))
			send pedirPedido[idVendedor](-1, null);
		else
		{
			receive realizarPedido(idCliente, p);
			send pedirPedido[idVendedor](idCliente, p);
		}
	}
}

Process Cliente[id 0..C-1]
{
	Pedido p;
	Comida c;
	
	send realizarPedido(id, p);
	receive entregas[id](c);
}
```
---
## Ejercicio 4
Simular la atención en un locutorio con 10 cabinas telefónicas, el cual tiene un empleado que se encarga de atender a N clientes. Al llegar, cada cliente espera hasta que el empleado le indique a qué cabina ir, la usa y luego se dirige al empleado para pagarle. El empleado atiende a los clientes en el orden en que hacen los pedidos. A cada cliente se le entrega un
ticket factura por la operación.
Nota: maximizar la concurrencia; suponga que hay una función Cobrar() llamada por el
empleado que simula que el empleado le cobra al cliente.

**a) Implemente una solución para el problema descrito.**
```csharp
chan pedidos(int, int, int);
chan[N] recibirCabina(int);
chan[N] recibirTicket(Ticket);

Process Empleado
{
	cola qLibres = {0, 1, ..., 9};
	cola qEspera;
	int idC;
	int cabina;
	int tipo;
	Ticket t;

	while (true)
	{
		// tipo 0: PEDIR
		// tipo 1: PAGAR
		// al pedir, el valor de cabina no se utiliza.
		receive pedidos(tipo, idC, cabina);
		
		if (tipo == 0) // PEDIR
		{
			if (not qLibres.IsEmpty())
			{
				cabina = qLibres.Pop();
				send recibirCabina[idC](cabina);
			}
			else
				qEspera.push(idC);
		}
		else // PAGAR
		{
			t = Cobrar(idC);
			send recibirTicket[idC](t);
			
			if (not qEspera.IsEmpty())
			{
				idC = qEspera.Pop();
				send recibirCabina[idC](cabina);
			}
			else
				qLibres.push(cabina);
		}
	}
}

Process Cliente[id 0..N-1]
{
	int cabina;
	Ticket t;

	send pedidos(0, id, 0);
	receive recibirCabina[id](cabina);
	// usar cabina
	send pedidos(1, id, cabina);
	receive recibirTicket[id](t);
}
```

**b) Modifique la solución implementada para que el empleado dé prioridad a los que terminaron de usar la cabina sobre los que están esperando para usarla.**
```csharp
chan aviso();
chan pedirCabina(int);
chan pagarCabina(int, int);
chan[N] recibirCabina(int);
chan[N] recibirTicket(Ticket);

Process Empleado
{
	cola qLibres = {0, 1, ..., 9};
	cola qEspera;
	int idC;
	int cabina;
	Ticket t;

	while (true)
	{
		receive aviso();
		
		if (not empty(pagarCabina)) 
		{
			receive pagarCabina(idC, cabina);
			t = Cobrar(idC); // cobra al cliente idC.
			send recibirTicket[idC](t);
			
			if (not qEspera.IsEmpty())
			{
				idC = qEspera.Pop();
				send recibirCabina[idC](cabina);
			}
			else
				qLibres.push(cabina);
		}
		else
		{
			receive pedirCabina(idC);
			
			if (not qLibres.IsEmpty())
			{
				cabina = qLibres.Pop();
				send recibirCabina[idC](cabina);
			}
			else
				qEspera.push(idC);
		}
	}
}

Process Cliente[id 0..N-1]
{
	int cabina;
	Ticket t;

	send pedirCabina(id);
	send aviso();
	receive recibirCabina[id](cabina);
	// usar cabina
	send pagarCabina(id, cabina);
	send aviso();
	receive recibirTicket[id](t);
}
```
---
## Ejercicio 5
Resolver la administración de 3 impresoras de una oficina. Las impresoras son usadas por N administrativos, los cuales están continuamente trabajando y cada tanto envían documentos a imprimir. Cada impresora, cuando está libre, toma un documento y lo imprime, de acuerdo con el orden de llegada.
**Nota:** ni los administrativos ni el director deben esperar a que se imprima el documento.
### a) Implemente una solución para el problema descrito.
```csharp
chan imprimir(Documento);

Process Impresora[id 0..2]
{
	Documento d;
	
	while (true)
	{
		receive imprimir(d);
		ImprimirDocumento(d);
	}
}

Process Administrativo[id 0..N-1]
{
	Documento d;

	while (true)
	{
		d = CrearDocumento();
		send imprimir(d);
	}
}
```
### b) Modifique la solución implementada para que considere la presencia de un director de oficina que también usa las impresoras, el cual tiene prioridad sobre los administrativos.
```csharp
chan aviso();
chan imprimir(Documento);
chan imprimirConPrioridad(Documento);
chan colaImpresión(Documento);

Process Impresora[id 0..2]
{
	Documento d;
	
	while (true)
	{
		receive colaImpresión(d);
		ImprimirDocumento(d);
	}
}

Process Coordinador
{
	Documento d;
	
	while (true)
	{
		receive aviso();
		
		if (not empty(imprimirConPrioridad))
		{
			receive imprimirConPrioridad(d);
			send colaImpresión(d);
		}
		else
		{
			receive imprimir(d);
			send colaImpresión(d);
		}
	}
}

Process Director
{
	Documento d;
	
	while (true)
	{
		d = CrearDocumento();
		send imprimirConPrioridad(d);
		send aviso();
	}
}

Process Administrativo[id 0..N-1]
{
	Documento d;

	while (true)
	{
		d = CrearDocumento();
		send imprimir(d);
		send aviso();
	}
}
```
### c) Modifique la solución (a) considerando que cada administrativo imprime 10 trabajos y que todos los procesos deben terminar su ejecución.
```csharp
chan colaImpresión(Documento);
chan imprimir(Documento);

Process Impresora[id 0..2]
{
	Documento d;
	bool fin = false;
	
	while (not fin)
	{
		receive colaImpresión(d);
		
		if (d != null)
			ImprimirDocumento(d);
		else
			fin = true;
	}
}

Process Coordinador
{	
	Documento d;
	
	for int i = 1..N*10
	{
		receive imprimir(d);
		send colaImpresión(d);
	}
	
	for int i = 0..2
		send colaImpresión(null);
}

Process Administrativo[id 0..N-1]
{
	Documento d;

	for int i = 1..10
	{
		d = CrearDocumento();
		send imprimir(d);
	}
}
```
### d) Modifique la solución (b) considerando que tanto el director como cada administrativo imprimen 10 trabajos y que todos los procesos deben terminar su ejecución.
```csharp
chan aviso();
chan imprimir(Documento);
chan imprimirConPrioridad(Documento);
chan colaImpresión(Documento);

Process Impresora[id 0..2]
{
	Documento d;
	bool fin = false;
	
	while (not fin)
	{
		receive colaImpresión(d);
		
		if (d != null)
			ImprimirDocumento(d);
		else
			fin = true;
	}
}

Process Coordinador
{
	Documento d;
	
	for int i = 1..(N+1)*10
	{
		receive aviso();
		
		if (not empty(imprimirConPrioridad))
			receive imprimirConPrioridad(d);
		else
			receive imprimir(d);
			
		send colaImpresión(d);
	}
	
	for int i = 1..3
		send colaImpresión(null);
}

Process Director
{
	Documento d;
	
	for int i = 1..10
	{
		d = CrearDocumento();
		send imprimirConPrioridad(d);
		send aviso();
	}
}

Process Administrativo[id 0..N-1]
{
	Documento d;

	for int i = 1..10
	{
		d = CrearDocumento();
		send imprimir(d);
		send aviso();
	}
}
```
### e) Si la solución al ítem d) implica realizar Busy Waiting, modifíquela para evitarlo.

---
# CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS DE PASAJE DE MENSAJES SINCRÓNICO (PMS):
- Los canales son punto a punto y no deben declararse.
- No se puede usar la sentencia empty para saber si hay algún mensaje en un canal.
- Tanto el envío como la recepción de mensajes es bloqueante.
- Sintaxis de las sentencias de envío y recepción:
	*Envío:* `nombreProcesoReceptor!port (datos a enviar)`
	*Recepción:* `nombreProcesoEmisor?port (datos a recibir)`
	El port (o etiqueta) puede no ir. Se utiliza para diferenciar los tipos de mensajes que podrían comunicarse entre dos procesos.
- En la sentencia de comunicación de recepción se puede usar el comodín `*` si el origen es un proceso dentro de un arreglo de procesos. Ejemplo: `Clientes[*]?port(datos)`.
- Sintaxis de la Comunicación guardada:
	*Guarda:* (condición booleana); sentencia de recepción → sentencia a realizar
	Si no se especifica la condición booleana se considera verdadera (la condición booleana sólo puede hacer referencia a variables locales al proceso).
	Cada guarda tiene tres posibles estados:
		**Elegible:** la condición booleana es verdadera y la sentencia de comunicación se puede resolver inmediatamente.
		**No elegible:** la condición booleana es falsa.
		**Bloqueada:** la condición booleana es verdadera y la sentencia de comunicación no se puede resolver inmediatamente.
	Sólo se puede usar dentro de un `if` o un `do` guardado:
		El `if` funciona de la siguiente manera: de todas las guardas **elegibles** se selecciona una en forma no determinística, se realiza la sentencia de comunicación correspondiente, y luego las acciones asociadas a esa guarda. Si todas las guardas tienen el estado de **no elegibles**, se sale sin hacer nada. Si no hay ninguna guarda **elegible**, pero algunas están en estado **bloqueado**, se queda esperando en el `if` hasta que alguna se vuelva **elegible**. El `do` funciona de la siguiente manera: sigue iterando de la misma manera que el `if` hasta que todas las guardas sean **no elegibles**.

## Ejercicio 1
Suponga que existe un antivirus distribuido que se compone de R procesos robots Examinadores y 1 proceso Analizador. Los procesos Examinadores están buscando continuamente posibles sitios web infectados; cada vez que encuentran uno avisan la dirección, esperan la respuesta del Analizador, y luego continúan buscando. El proceso Analizador se encarga de hacer todas las pruebas necesarias con cada uno de los sitios encontrados por los robots para determinar si están o no infectados, para luego responderle al Examinador.
### a) Analice el problema y defina qué procesos, recursos y comunicaciones serán necesarios/convenientes para resolverlo.

### b) Implemente una solución con PMS donde el Analizador no considere el orden de los pedidos de los Examinadores.
```csharp
Process Analizador
{
	Sitio sitio;
	string respuesta;
	int idE;
	
	while (true)
	{
		Examinador[*]?sitioInfectado(idE, sitio);
		respuesta = RealizarPruebas(sitio);
		Examinador[idE]!respuesta(respuesta);
	}
}

Process Examinador[id 0..R-1]
{
	string res;
	Sitio sitio;

	while (true)
	{
		sitio = BuscarInfectado(); // retorna un sitio web infectado.
		Analizador!sitioInfectado(id, sitio);
		Analizador?respuesta(res);
	}
}
```
### c) Implemente una solución con PMS donde el Analizador sí considere el orden de los pedidos de los Examinadores.
```csharp
Process Analizador
{
	Sitio sitio;
	string respuesta;
	int idE;
	
	while (true)
	{
		Coordinador!siguiente();
		Coordinador?sitio(idE, sitio);
		respuesta = RealizarPruebas(sitio);
		Examinador[idE]!respuesta(respuesta);
	}
}

Process Coordinador
{
	cola q;
	int idE;
	Sitio sitio;

	do (Examinador[*]?sitioInfectado(idE, sitio)) ->
		q.Push(idE, sitio);
	[] not q.IsEmpty(); Analizador?siguiente() ->
		{
			q.Pop(idE, sitio);
			Analizador!sitio(idE, sitio);
		}
	end do;
}

Process Examinador[id 0..R-1]
{
	string res;
	Sitio sitio;

	while (true)
	{
		sitio = BuscarInfectado(); // retorna un sitio web infectado.
		Coordinador!sitioInfectado(id, sitio);
		Analizador?respuesta(res);
	}
}
```
### d) Si los Examinadores no deben esperar la respuesta del Analizador, ¿cambiaría algo de la solución al inciso b)? ¿por qué?
```csharp
Process Analizador
{
	Sitio sitio;
	string respuesta;
	
	while (true)
	{
		Coordinador!siguiente();
		Coordinador?sitio(sitio);
		respuesta = RealizarPruebas(sitio);
		// ya no envía la respuesta.
	}
}

Process Coordinador
{
	cola q;
	Sitio sitio;

	do (Examinador[*]?sitioInfectado(sitio)) ->
		q.Push(sitio);
	[] not q.IsEmpty(); Analizador?siguiente() ->
		{
			q.Pop(sitio);
			Analizador!sitio(sitio);
		}
	end do;
}

Process Examinador[id 0..R-1]
{
	string res;
	Sitio sitio;

	while (true)
	{
		sitio = BuscarInfectado(); // retorna un sitio web infectado.
		Coordinador!sitioInfectado(sitio);
		// ya no recibe la respuesta.
	}
}
```
Se necesita el coordinador porque sino el Examinador se podría quedar mucho tiempo lockeado al enviar otro sitio, porque el Analizador no podría no atender su pedido rápidamente si está realizando otras tareas o atendiendo otros pedidos.

---
## Ejercicio 2
En un laboratorio de genética veterinaria hay 3 empleados. El primero de ellos continuamente prepara las muestras de ADN; cada vez que termina, se la envía al segundo empleado y vuelve a su trabajo. El segundo empleado toma cada muestra de ADN preparada, arma el set de análisis que se deben realizar con ella y espera el resultado para archivarlo. Por último, el tercer empleado se encarga de realizar el análisis y devolverle el resultado al segundo empleado.
```csharp
Process EmpleadoUno
{
	Muestra m;
	
	while (true)
	{
		m = PrepararMuestra();
		Coordinador!muestra(m);
	}	
}

Process Coordinador
{
	cola q;
	Muestra m;
	
	do EmpleadoUno?muestra(m) ->
		q.Push(m);
	[] not q.IsEmpty(); EmpleadoDos?listo() ->
	{
		q.Pop(m);
		EmpleadoDos!muestra(m);
	}
	end do;
}

Process EmpleadoDos
{
	Muestra m;
	Set s;
	Resultado r;

	while (true)
	{
		Coordinador!listo();
		Coordinador?muestra(m);
		s = ArmarSet(m);
		
		EmpleadoTres!setArmado(s);
		EmpleadoTres?resultadoSet(r);
		Archivar(r);
	}	
}

Process EmpleadoTres
{
	Set s;
	Resultado r;

	while (true)
	{
		EmpleadoDos?setArmado(s);
		r = RealizarAnalisis(s);
		EmpleadoDos!resultadoSet(r);
	}
}
```
---
## Ejercicio 3
En un examen final hay N alumnos y P profesores. Cada alumno resuelve su examen, lo entrega y espera a que alguno de los profesores lo corrija y le indique la nota. Los profesores corrigen los exámenes respetando el orden en que los alumnos van entregando.
Nota: maximizar la concurrencia; no generar demora innecesaria; todos los procesos deben
terminar su ejecución
### a) Considerando que P=1.
```csharp
Process Profesor
{
	int idA;
	Examen e;
	int nota;

	for int i = 1..N
	{
		Coordinador!siguiente();
		Coordinador?sigExamen(idA, e);
		nota = CorregirExamen(e);
		Alumno[idA]!nota(nota);
	}
}

Process Coordinador
{
	int idA;
	Examen e;
	cola q;
	
	for int i = 1..(N*2)
	{
		if Alumno[*]?examen(idA, e) -> // cond. booleana en true implícita
			q.Push(idA, e)
		[] (not q.IsEmpty()); Profesor?siguiente() ->
		{
			q.Pop(idA, e);
			Profesor!sigExamen(idA, e);
		}
		end if;
	}
}

Process Alumno[id 0..N-1]
{
	Examen e;
	int n;
	
	e = ResolverExamen();
	Coordinador!examen(id, e);
	Profesor?nota(n);
}
```
### b) Considerando que P>1.
```csharp
Process Profesor[id 0..P-1]
{
	bool fin = false;
	int idA;
	int nota;
	Examen e;

	while (not fin)
	{
		Coordinador!pedido(id);
		Coordinador?sigExamen(idA, e);
		if (idA == -1)
			fin = true;
		else
		{
			nota = CorregirExamen(e);
			Alumno[idA]!nota(nota);
		}
	}
}

Process Coordinador
{
	Examen e;
	int idA;
	int idP;
	cola q;
	
	for int i = 1..(2*N)
	{
		if Alumno[*]?examen(idA, e) ->
			q.Push(idA, e);
		[] not q.IsEmpty(); Profesor[*]?pedido(idP) ->
		{
			q.Pop(idA, e);
			Profesor[idP]!sigExamen(idA, e);
		}
		end if;
	}
	
	for int i = 1..P
	{
		Profesor[*]?pedido(idP);
		Profesor[idP]!sigExamen(-1, null);
	}
}

Process Alumno[id 0..N-1]
{
	Examen e;
	int n;
	
	e = ResolverExamen();
	Coordinador!examen(id, e);
	Profesor[*]?nota(n);
}
```
### c) Ídem b) pero considerando que los alumnos no comienzan a realizar su examen hasta que todos hayan llegado al aula.
```csharp
Process Profesor[id 0..P-1]
{
	bool fin = false;
	int idA;
	int nota;
	Examen e;

	while (not fin)
	{
		Coordinador!pedido(id);
		Coordinador?sigExamen(idA, e);
		if (idA == -1)
			fin = true;
		else
		{
			nota = CorregirExamen(e);
			Alumno[idA]!nota(nota);
		}
	}
}

Process Coordinador
{
	Examen e;
	int idA;
	int idP;
	cola q;
	
	for int i = 1..N
		Alumno[*]?llegada();
		
	for int i = 0..N-1
		Alumno[i]!barrera();
	
	for int i = 1..(2*N)
	{
		if Alumno[*]?examen(idA, e) ->
			q.Push(idA, e);
		[] not q.IsEmpty(); Profesor[*]?pedido(idP) ->
		{
			q.Pop(idA, e);
			Profesor[idP]!sigExamen(idA, e);
		}
		end if;
	}
	
	for int i = 1..P
	{
		Profesor[*]?pedido(idP);
		Profesor[idP]!sigExamen(-1, null);
	}
}

Process Alumno[id 0..N-1]
{
	Examen e;
	int n;
	
	Coordinador!llegada();
	Coordinador?barrera();
	
	e = ResolverExamen();
	Coordinador!examen(id, e);
	Profesor[*]?nota(n);
}
```
---
### Ejercicio 4
En una exposición aeronáutica hay un simulador de vuelo (que debe ser usado con exclusión mutua) y un empleado encargado de administrar su uso. Hay P personas que esperan a que el empleado las deje acceder al simulador de a una por vez, la usan por un rato y luego se retiran.
Nota: cada persona usa sólo una vez el simulador.
#### a) Implemente una solución donde el empleado sólo se ocupa de garantizar la exclusión mutua (sin importar el orden).
```csharp
Process Empleado
{
	for int i = 1..P
	{
		Persona[*]?pedirSimulador();
		// al atender este pedido ya le da permiso para pasar
		// ahora va a quedar esperando que la persona se retire.
		Persona[*]?retirarse();
		// solo una persona va a estar usando el simulador.
		// si bien pasando ids quedaría más claro, no hace falta:
		// el mensaje de retirada viene sí o sí de la única persona que está usando el simulador.
	}
}

Process Persona[id 0..P-1]
{
	Empleado!pedirSimulador();
	UsarSimulador();
	Empleado!retirarse();
}
```
#### b) Modifique la solución anterior para que el empleado los deje acceder según el orden de su identificador (hasta que la persona i no lo haya usado, la persona i+1 debe esperar).
```csharp
Process Empleado
{
	for int i = 0..P-1
	{
		Persona[i]?pedirSimulador();
		Persona[i]?retirarse();
	}
}

Process Persona[id 0..P-1]
{
	Empleado!pedirSimulador();
	UsarSimulador();
	Empleado!retirarse();
}
```
#### c) Modifique la solución a) para que el empleado considere el orden de llegada para dar acceso al simulador.
```csharp
Process Empleado
{
	int idP;

	for int i = 0..P-1
	{
		Coordinador!listo();
		Coordinador?sigPersona(idP);
		Persona[idP]!accesoSimulador();
		Persona[idP]?retirarse();
	}
}

Process Coordinador
{
	int idP;
	cola q;
	
	for int i = 1..(2*P)
	{
		if Persona[*]?pedirSimulador(idP) ->
			q.Push(idP);
		[] not q.IsEmpty(); Empleado?listo() ->
		{
			q.Pop(idP);
			Empleado!sigPersona(idP);
		}
		end if;
	}
}

Process Persona[id 0..P-1]
{
	Coordinador!pedirSimulador(id);
	Empleado?accesoSimulador();
	UsarSimulador();
	Empleado!retirarse();
}
```
---
### Ejercicio 5
En un estadio de fútbol hay una máquina expendedora de gaseosas que debe ser usada por
E Espectadores de acuerdo con el orden de llegada. Cuando el espectador accede a la máquina en su turno, usa la máquina y luego se retira para dejar al siguiente. Nota: cada
espectador usa la máquina sólo una vez.

**misma solución que el 4 c)**
```csharp
Process AdminMaquina
{
	int idE;

	for int i = 1..E
	{
		Coordinador!libre();
		Coordinador?sig(idE);
		Espectador[idE]!accesoMaquina();
		Espectador[idE]?retirarse();
	}
}

Process Coordinador
{
	int idE;
	cola q;

	for int i = 1..(2*E)
	{
		if Espectador[*]?pedirMaquina(idE) ->
			q.Push(idE);
		[] not q.IsEmpty(); AdminMaquina?libre() ->
		{
			q.Pop(idE);
			AdminMaquina!sig(idE);
		}
	}
}

Process Espectador[id 0..E-1]
{
	Coordinador!pedirMaquina(id);
	AdminMaquina?accesoMaquina();
	UsarMaquina();
	AdminMaquina!retirarse();
}
```

**otra solución:**
```csharp
Process AdminMaquina
{
	bool libre = true;
	int idE;
	int sig;
	cola q;
	
	for int i = 1..(2*E)
	{
		if Espectador[*]?pedirMaquina(idE) ->
		{
			if (libre)
			{
				Espectador[idE]!accesoMaquina();
				libre = false;
			}
			else
				q.Push(idE);
		}
		[] (not libre); Espectador[*]?retirarse() ->
		{
			if (not q.IsEmpty())
			{
				q.Pop(sig);
				Espectador[sig]!accesoMaquina();
			}
			else
				libre = true;
		}
		end if;
	}
}

Process Espectador[id 0..E-1]
{
	AdminMaquina!pedirMaquina(id);
	AdminMaquina?accesoMaquina();
	UsarMaquina();
	AdminMaquina!retirarse();
}
```