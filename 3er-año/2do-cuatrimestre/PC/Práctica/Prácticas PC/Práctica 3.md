### CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS:
- Los monitores utilizan el protocolo signal and continue.
- A una variable condition SÓLO pueden aplicársele las operaciones SIGNAL, SIGNALALL y WAIT.
- NO puede utilizarse el wait con prioridades.
- NO se puede utilizar ninguna operación que determine la cantidad de procesos encolados en una variable condition o si está vacía.
- La única forma de comunicar datos entre monitores o entre un proceso y un monitor es por medio de invocaciones al procedimiento del monitor del cual se quieren obtener (o enviar) los datos.
- No existen variables globales.
- En todos los ejercicios debe maximizarse la concurrencia.
- En todos los ejercicios debe aprovecharse al máximo la característica de exclusión mutua que brindan los monitores.
- Debe evitarse hacer busy waiting.
- En todos los ejercicios el tiempo debe representarse con la función delay.

---
### Ejercicio 1
Se dispone de un puente por el cual puede pasar un solo auto a la vez. Un auto pide permiso para pasar por el puente, cruza por el mismo y luego sigue su camino.

```C
Monitor Puente
	cond cola;
	int cant = 0;
	
	Procedure entrarPuente ()
		while (cant > 0) wait (cola);
		cant = cant + 1;
	end;
	
	Procedure salirPuente ()
		cant = cant – 1;
		signal(cola);
	end;
End Monitor;

Process Auto [a:1..M]
	Puente.entrarPuente();
	“el auto cruza el puente”
	Puente.salirPuente();
End Process;
```
#### a. ¿El código funciona correctamente? Justifique su respuesta.
El código es correcto. Como observación, hay que aclarar que puede no respetarse el orden de llegada. Si un auto queda en el `wait`, cuando lo despiertan con un `signal` vuelve a competir por el uso del monitor desde afuera contra los que recién llegan y no pasaron por el `wait`. Por esto es importante el uso del `while`, para reevaluar la condición (`cant > 0`) y que no haya dos autos "cruzando a la vez".
#### b. ¿Se podría simplificar el programa? ¿Sin monitor? ¿Menos procedimientos? ¿Sin variable condition? En caso afirmativo, rescriba el código.
Dado que en el enunciado no se solicita respetar el orden de llegada, puede hacerse así: 
```C
Monitor Puente
{
	Process Cruzar()
	{
		// cruzar el puente.
	}
}

Process Auto[id 0..A-1]
{
	Puente.Cruzar();
}
```
#### c. ¿La solución original respeta el orden de llegada de los vehículos? Si rescribió el código en el punto b), ¿esa solución respeta el orden de llegada?
Un auto que estaba en el `wait` de la variable condición y lo despiertan con un `signal` vuelve a competir por el uso del monitor dsde afuera, junto con los procesos que recién llegan y no pasaron por `wait`. Por esto puede pasar que no se respete el orden de llegada. Si otro proceso le gana el puesto al que estaba en el `wait` primero, puede llegar a cruzar el puente antes.
En b) tampoco se respeta. Cruza el proceso que gane el acceso al monitor.

---
### Ejercicio 2
Existen N procesos que deben leer información de una base de datos administrada por un motor que admite un número limitado de consultas simultáneas.

#### a) Analice el problema y defina qué procesos, recursos y monitores/sincronizaciones serán necesarios/convenientes para resolverlo.
#### b) Implemente el acceso a la base de datos por parte de los procesos, sabiendo que el motor de la base de datos puede atender a lo sumo 5 consultas de lectura simultáneas.

Sin respetar orden de llegada:
```C
Monitor BD
{
	cond espera;
	int cant = 0;
	
	Procedure Acceder
	{
		while (cant == 5)
			wait(espera);
		cant++;
	}
	
	Procedure Liberar
	{
		cant--;
		signal(espera);
	}
}

Process Proceso[id 0..N-1]
{
	BD.Acceder();
	// usar BD
	BD.Liberar();
}
```

Para respetar orden de llegada:
```C
Monitor BD
{
	bool libre = true;
	cond espera;
	int cant = 0; int enQ = 0;
	
	Procedure Acceder
	{
		if (not libre and cant == 5)
		{
			enQ++;
			wait(espera);
		}
		else
		{
			libre = false;
			cant++;
		}
	}
	
	Procedure Liberar
	{
		cant--;
		if (enQ == 0)
			libre = true;
		else
			signal(espera);
	}
}

Process Proceso[id 0..N-1]
{
	BD.Acceder();
	// usar BD
	BD.Liberar();
}
```
---
### Ejercicio 3
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas para resolver el problema. Luego, resuelva considerando las siguientes situaciones:
#### a) Implemente una solución suponiendo que no importa el orden de uso. Existe una función Fotocopiar() que simula el uso de la fotocopiadora.
```C
Monitor Fotocopiadora
{
	Procedure Usar()
	{
		Fotocopiar();
	}
}

Process Persona[id 0..N-1]
{
	Fotocopiadora.Usar();
}
```
#### b) Modifique la solución de (a) para el caso en que se deba respetar el orden de llegada.
```C
Monitor Fotocopiadora
{
	bool libre = true;
	int enQ = 0;
	cond espera;
	
	Procedure Acceder()
	{
		if (not libre)
		{
			enQ++;
			wait(espera);
		}
		else
			libre = false;
	}
	
	Procedure Retirarse()
	{
		if (enQ == 0)
			libre = true;
		else
		{
			enQ--;
			signal(espera);
		}
	}
}

Process Persona[id 0..N-1]
{
	Fotocopiadora.Acceder();
	Fotocopiar();
	Fotocopiadora.Retirarse();
}
```

#### c) Modifique la solución de (b) para el caso en que se deba dar prioridad de acuerdo con la edad de cada persona (cuando la fotocopiadora está libre, la debe usar la persona de mayor edad entre las que estén esperando para usarla).
```C
Monitor Fotocopiadora
{
	bool libre = true;
	cond[N] espera;
	colaOrdenada q;
	
	Procedure Acceder(int id, int edad)
	{
		if (not libre)
		{
			q.pushOrdenado(id, edad); // Ordena por edad de mayor a menor.
			wait(espera[id]);
		}
		else
			libre = false;
	}
	
	Procedure Retirarse()
	{
		if (q.IsEmpty())
			libre = true;
		else
		{
			int sig;
			q.pop(sig); // retorna el id
			signal(espera[sig]);
		}
	}
}

Process Persona[id 0..N-1]
{
	int edad = X;
	
	Fotocopiadora.Acceder(id, edad);
	Fotocopiar();
	Fotocopiadora.Retirarse();
}
```

#### d) Modifique la solución de (a) para el caso en que se deba respetar estrictamente el orden dado por el identificador del proceso (la persona X no puede usar la fotocopiadora hasta que no haya terminado de usarla la persona X-1).
```C
Monitor Fotocopiadora
{
	cond[N] espera;
	int sig = 0;
	
	Procedure Acceder(int id)
	{
		if (id != sig)
			wait(espera[id]);
	}
	
	Procedure Retirarse()
	{
		sig++;
		if (sig < N)
			signal(espera[sig]);
	}
}

Process Persona[id 0..N-1]
{
	Fotocopiadora.Acceder(id);
	Fotocopiar();
	Fotocopiadora.Retirarse();
}
```
#### e) Modifique la solución de (b) para el caso en que además haya un Empleado que le indica a cada persona cuándo debe usar la fotocopiadora.
```C
Monitor Fotocopiadora
{
	int enQ = 0;
	cond avisoLlegada; cond espera; cond avisoSalida;
	
	Procedure Acceder()
	{
		enQ++;
		signal(avisoLlegada);
		wait(espera);
	}
	
	Procedure Retirarse()
	{
		signal(avisoSalida);
	}
	
	Procedure Administrar()
	{
		if (enQ == 0)
			wait(avisoLlegada);
		
		// cuando pasa acá es porque alguien quiere usar la fotocopiadora.
		enQ--;
		signal(espera); // avisa a la persona que puede fotocopiar.
		wait(avisoSalida); // espera a que la persona termine.
	}
}
	
Process Empleado
{
	Procedure PedirFotocopiadora()
	{
		for int i = 1..N
		{
			Fotocopiadora.Administrar();
		}
	}
}

Process Persona[id 0..N-1]
{
	Fotocopiadora.Acceder();
	Fotocopiar();
	Fotocopiadora.Retirarse();
}
```
#### f) CORREGIR Modificar la solución (e) para el caso en que sean 10 fotocopiadoras. El empleado le indica a la persona qué fotocopiadora usar y cuándo hacerlo.
```C
Monitor Fotocopiadora
{
	cola qFC = {0, 1, 2, ..., 9}; // queue de fotocopiadoras libres.
	cola qP;
	int[N] fotocopiadoraAsignada;
	cond avisoLlegada; cond espera; cond avisoSalida;
	
	Procedure Acceder(int id, out int fotocopiadora)
	{
		qP.push(id);
		signal(avisoLlegada);
		wait(espera);
		fotocopiadora = fotocopiadoraAsignada[id];
	}
	
	Procedure Retirarse(int fc)
	{
		qFC.push(fc);
		signal(avisoSalida);
	}
	
	Procedure Administrar()
	{
		int idP, idFC;
		
		if (qP.IsEmpty())
			wait(avisoLlegada);
		// cuando pasa acá es porque hay al menos una persona que quiere usar la fotocopiadora.
		idP = qP.pop();
		
		if (qFC.IsEmpty())
			wait(avisoSalida);
		// cuando pasa acá es porque hay al menos una fotocopiadora libre.
		idFC = qFC.pop();
		
		fotocopiadoraAsignada[idP] = idFC;
		
		signal(espera); // avisa a la persona que puede pasar a fotocopiar.
	}
}
	
Process Empleado
{
	Procedure PedirFotocopiadora()
	{
		for int i = 1..N
		{
			Fotocopiadora.Administrar();
		}
	}
}

Process Persona[id 0..N-1]
{
	int fcAsignada;

	Fotocopiadora.Acceder(id, fcAsignada);
	Fotocopiar(fcAsignada);
	Fotocopiadora.Retirarse(fcAsignada);
}
```
---
### Ejercicio 4
Existen N vehículos que deben pasar por un puente de acuerdo con el orden de llegada. Considere que el puente no soporta más de 50000 kg y que cada vehículo cuenta con su propio peso (ningún vehículo supera el peso soportado por el puente).
```C
Monitor Puente
{
	CARGA_MAX = 50000; // constante
	cola q;
	float pesoEsperando[N];
	float cargaActual = 0;
	cond espera;
	
	Procedure Acceder(in int id, in float peso)
	{	
		// si hay autos en la q o se supera la capacidad, espera.
		if (not q.IsEmpty() or (cargaActual + peso) > CARGA_MAX)
		{
			q.push(id); // entra en la queue.
			pesoEsperando[id] = peso; // anota su peso.
			wait(espera);
		}
		else
			cargaActual += peso;
	}
	
	Procedure Salir(in float p)
	{
		cargaActual -= p;
		
		// q.peek() mira el id del primero en la q.
		// mientras haya alguien en la cola y su peso entre en el puente, lo dejo pasar.
		while (not q.IsEmpty() and (cargaActual + pesoEsperando[q.peek()] <= CARGA_MAX))
		{
			int sig = q.pop();
			cargaActual += pesoEsperando[sig];
			signal(espera);
		}
	}
}

Process Vehículo[id 0..N-1]
{
	float peso = X;
	
	Puente.Acceder(peso);
	// cruzar el puente
	Puente.Salir(peso);	
}
```
Nota: en este caso, considero que hay que usar una queue para mantener el orden de llegada (generalmente no haría falta usar una queue para el orden de llegada, ya que las variables condición cumplen esa función).
Se puede presentar el siguiente caso: el puente está con su capacidad de carga completa y llega un auto A que pesa 1000kg. Si este auto hace `if` sobre la capacidad del puente puede pasar que salga un auto X que pesa menos de 1000kg y hace signal a la variable condición, entonces el auto A podría ingresar al puente superando la capacidad máxima. Por lo tanto, cada auto debe ingresar a la queue y hacer un `while` sobre la capacidad del puente. Cuando la capacidad del puente lo permita, este auto podrá ingresar al puente.
El problema con usar `while` y el método `signal and continue`, es que puede no respetarse el orden de llegada. Un auto que ya se había quedado esperando para ingresar al puente, al recibir el signal pasa de nuevo por el `while` y si la carga disponible todavía no es suficiente para que este pase, vuelve a encolarse en `wait(variable_condicion)`, rompiendo el orden de llegada.
Solución: **passing the baton**.

---
### Ejercicio 5
En un corralón de materiales se debe atender a N clientes de acuerdo con el orden de llegada. Cuando un cliente es llamado para ser atendido, entrega una lista con los productos que comprará, y espera a que alguno de los empleados le entregue el comprobante de la compra realizada.
#### a) Resuelva considerando que el corralón tiene un único empleado.
```C
Monitor Corralón
{
	int enQ = 0;
	cond espera; cond esperaComprobante;
	cond avisoLlegada; cond avisoProductos;
	
	int idClienteActual;
	list productos;
	file[N] comprobantes;
	
	// el cliente llega al corralón.
	// espera a que le avisen que puede entrar.
	Procedure Ingresar()
	{
		enQ++;
		signal(avisoLlegada);
		wait(espera);
	}
	
	// el empleado le dice al cliente que puede pasar.
	// espera a que el cliente le entregue la lista de productos.
	// se lleva la lista de productos, dejando el monitor libre.
	Procedure Atender(out list p)
	{
		if (enQ == 0)
			wait(avisoLlegada);
		
		enQ--;
		signal(espera);
		wait(avisoProductos);
		
		p = productos;
	}
	
	// el cliente entrega su lista de productos y deja su id.
	// espera a que el empleado le de el comprobante.
	Procedure EntregarLista(int id, list p)
	{
		idClienteActual = id;
		productos = p;
		signal(avisoProductos);
		wait(esperaComprobante);
	}
	
	// deja el comprobante en el arreglo y despierta al cliente.
	Procedure EntregarComprobante(file c)
	{
		comprobantes[idClienteActual] = c;
		signal(esperaComprobante);
	}
	
	// el cliente toma el comprobante de su posición en el arreglo.
	Procedure Retirarse(int id, out file c)
	{
		c = comprobantes[id];
	}
}

Process Empleado
{
	list productos;
	file comprobante;
	
	for int i = 1..N
	{	
		Corralón.Atender(productos);
		
		for each Producto p in productos
			comprobante.add(p);
		
		Corralón.EntregarComprobante(comprobante);
	}
}

Process Cliente[id 0..N-1]
{
	list listaProductos;
	file comprobante;
	
	Corralón.Ingresar();
	Corralón.EntregarLista(id, listaProductos);
	Corralón.Retirarse(id, comprobante);
}
```
Nota: hago arreglo de comprobantes para que el empleado entregue un comprobante y ya pueda ir a atender a otro cliente, sin esperar a que el cliente anterior le avise que ya retiró su comprobante.

##### otra solución más concurrente con más monitores:
```C
Monitor Ingreso
{
	cola q;
	int enQ = 0;
	
	
	Procedure Ingresar(in int id, in list p)
	{
		enQ++;
		q.Push(id, p);
		wait(espera);
	}
}

Monitor Atención
{
}

Monitor Salida
{
}

Process Empleado
{
}

Process Cliente[id 0..N-1]
{
	list productos;
	Comprobante comprobante;
	
	Ingreso.Ingresar();
}
```
#### b) Resuelva considerando que el corralón tiene E empleados (E > 1). Los empleados no deben terminar su ejecución.
```C
Monitor Corralón
{
	cola q;
	cond espera[N]; cond[N] esperaComprobante;
	cond avisoLlegada; cond[N] avisoProductos;
	
	list[N] productos;
	file[N] comprobantes;
	
	// el cliente llega al corralón.
	// espera a que le avisen que puede entrar.
	Procedure Ingresar(in int id)
	{
		q.push(id);
		signal(avisoLlegada);
		wait(espera[id]);
	}
	
	// el empleado le dice al cliente que puede pasar.
	// espera a que el cliente le entregue la lista de productos.
	// se lleva la lista de productos, dejando el monitor libre.
	Procedure Atender(out int id, out list p)
	{
		while (q.IsEmpty())
			wait(avisoLlegada);
		
		id = q.pop();
		signal(espera[id]);
		wait(avisoProductos[id]);
		
		p = productos[id];
	}
	
	// el cliente entrega su lista de productos y deja su id.
	// espera a que el empleado le de el comprobante.
	Procedure EntregarLista(in int id, in list p)
	{
		productos[id] = p;
		signal(avisoProductos[id]);
		wait(esperaComprobante[id]);
	}
	
	// deja el comprobante en el arreglo y despierta al cliente.
	Procedure EntregarComprobante(in int id, in file c)
	{
		comprobantes[id] = c;
		signal(esperaComprobante[id]);
	}
	
	// el cliente toma el comprobante de su posición en el arreglo.
	Procedure Retirarse(in int id, out file c)
	{
		c = comprobantes[id];
	}
}

Process Empleado[id 0..E-1]
{
	list productos;
	file comprobante;
	int idCliente;
	
	while (true)
	{
		Corralón.Atender(idCliente, productos);
		
		for each Producto p in productos
			comprobante.add(p);
		
		Corralón.EntregarComprobante(idCliente, comprobante);
	}
}

Process Cliente[id 0..N-1]
{
	list listaProductos;
	file comprobante;
	
	Corralón.Ingresar(id);
	Corralón.EntregarLista(id, listaProductos);
	Corralón.Retirarse(id, comprobante);
}
```

#### c) Modifique la solución (b) considerando que los empleados deben terminar su ejecución cuando se hayan atendido todos los clientes.
```C
Monitor Corralón
{
	cola q;
	cond espera[N]; cond[N] esperaComprobante;
	cond avisoLlegada; cond[N] avisoProductos;
	
	list[N] productos;
	file[N] comprobantes;
	
	int clientesPendientes = N;
	
	// el cliente llega al corralón.
	// espera a que le avisen que puede entrar.
	Procedure Ingresar(in int id)
	{
		q.push(id);
		signal(avisoLlegada);
		wait(espera[id]);
	}
	
	// el empleado le dice al cliente que puede pasar.
	// espera a que el cliente le entregue la lista de productos.
	// se lleva la lista de productos, dejando el monitor libre.
	Procedure Atender(out int id, out list p, out bool seguir)
	{
		while (q.IsEmpty() and clientesPendientes > 0)
			wait(avisoLlegada);
		
		if (clientesPendientes == 0)
		{
			seguir = false;
			signal(avisoLlegada);
		}
		else
		{
			clientesPendientes--;
			id = q.pop();
			signal(espera[id]);
			wait(avisoProductos[id]);
			
			p = productos[id];
		}
	}
	
	// el cliente entrega su lista de productos y deja su id.
	// espera a que el empleado le de el comprobante.
	Procedure EntregarLista(in int id, in list p)
	{
		productos[id] = p;
		signal(avisoProductos[id]);
		wait(esperaComprobante[id]);
	}
	
	// deja el comprobante en el arreglo y despierta al cliente.
	Procedure EntregarComprobante(in int id, in file c)
	{
		comprobantes[id] = c;
		signal(esperaComprobante[id]);
	}
	
	// el cliente toma el comprobante de su posición en el arreglo.
	Procedure Retirarse(in int id, out file c)
	{
		c = comprobantes[id];
	}
}

Process Empleado[id 0..E-1]
{
	list productos;
	file comprobante;
	int idCliente;
	bool seguir = true;
	
	while (seguir)
	{
		Corralón.Atender(idCliente, productos, seguir);
		
		if (seguir)
		{
			for each Producto p in productos
				comprobante.add(p);
			
			Corralón.EntregarComprobante(idCliente, comprobante);
		}
	}
}

Process Cliente[id 0..N-1]
{
	list listaProductos;
	file comprobante;
	
	Corralón.Ingresar(id);
	Corralón.EntregarLista(id, listaProductos);
	Corralón.Retirarse(id, comprobante);
}
```
---
### Ejercicio 6
Existe una comisión de 50 alumnos que deben realizar tareas de a pares, las cuales son corregidas por un JTP. Cuando los alumnos llegan, forman una fila. Una vez que están todos en fila, el JTP les asigna un número de grupo a cada uno. Para ello, suponga que existe una función AsignarNroGrupo() que retorna un número “aleatorio” del 1 al 25. Cuando un alumno ha recibido su número de grupo, comienza a realizar su tarea. Al terminarla, el alumno le avisa al JTP y espera por su nota. Cuando los dos alumnos del grupo completaron la tarea, el JTP les asigna un puntaje (el primer grupo en terminar tendrá como nota 25, el segundo 24, y así sucesivamente hasta el último que tendrá nota 1).
Nota: el JTP no guarda el número de grupo que le asigna a cada alumno.
```C
Monitor Aula
{
	int contadorAlumnos = 0;
	cond[N] esperaAlumnos;
	int[N] asignacionGrupos;
	int[26] contadorTerminaron = ([26] 0);
	int[26] notaGrupos;
	cond[26] esperaGrupo;
	// los grupos van del num 1 al 25 por lo que dice la función.
	// para no tener que manipular el acceso restando/sumando uno
	// hago los arreglos de tamaño 26 y la posición 0 no la uso.
	cola qAlumnos; cola qGrupos;

	Procedure Llegada(in int id, out int nroGrupo)
	{
		qAlumnos.push(id);
		contadorAlumnos++;
		if (contadorAlumnos == 50)
			signal(avisoJTP);
		
		wait(esperaAlumnos[id]);
		
		nroGrupo = asignacionGrupos[id];
	}
	
	Procedure EsperarAlumnos()
	{
		if (contadorAlumnos < 50)
			wait(avisoJTP);
	}
	
	Procedure AsignarGrupo(in int nroGrupo)
	{
		int id = qAlumnos.pop();
		asignacionGrupos[id] = nroGrupo;
		signal(esperaAlumnos[id]);
	}
	
	Procedure TermineTarea(in int nroGrupo, out int nota)
	{
		contadorTerminaron[nroGrupo]++;
		if (contadorTerminaron[nroGrupo] == 2)
		{
			qGrupos.push(nroGrupo);
			signal(avisoJTP);
		}
		wait(esperaGrupo[nroGrupo]);
		
		nota = notaGrupos[nroGrupo];
	}
	
	Procedure AsignarNota(in int nota)
	{
		if (qGrupos.IsEmpty())
			wait(avisoJTP);
		
		int grupo = qGrupos.pop();
		notaGrupos[grupo] = nota;
		signal_all(esperaGrupo[grupo]);
	}	
}

Process JTP
{
	int nro;
	
	Aula.EsperarAlumnos();
	for int i = 0..49
	{
		nro = AsignarNroGrupo();
		Aula.AsignarGrupo(nro);
	}
	for int i = 25..1
	{
		Aula.AsignarNota(i);
	}
}

Process Alumno[id 0..49]
{
	int miGrupo; int miNota;
	
	Aula.Llegada(id, miGrupo);
	// realiza su tarea.
	Aula.TermineTarea(miGrupo, miNota);
}
```
---
### Ejercicio 7
Se debe simular una maratón con C corredores donde en la llegada hay UNA máquina expendedora de agua con capacidad para 20 botellas. Además, existe un repositor encargado de reponer las botellas de la máquina. Cuando los C corredores han llegado al inicio, comienza la carrera. Cuando un corredor termina la carrera, se dirige a la máquina expendedora, espera su turno (respetando el orden de llegada), saca una botella y se retira. Si encuentra la máquina sin botellas, le avisa al repositor para que cargue nuevamente la máquina con 20 botellas; espera a que se haga la recarga; saca una botella y se retira.
Nota: mientras se reponen las botellas, se debe permitir que otros corredores se encolen.
```C
Monitor Carrera
{
	int cantCorredores = 0;
	cond barrera;
	
	Procedure Llegada()
	{
		cantCorredores++;
		if (cantCorredores == C)
			signal_all(barrera);
		else
			wait(barrera);
	}
	
}

Monitor Máquina
{
	int enQ = 0;
	bool libre = true;
	cond avisoRepositor; cond esperaAgua; cond esperaRecarga;
	int botellas = 20;
	
	Procedure TomarBotella(out BotellaAgua botellaAgua)
	{
		if (not libre)
		{
			enQ++;
			wait(esperaAgua);
		}
		else
			libre = false;
			
		if (botellas == 0)
		{
			signal(avisoRepositor);
			wait(esperaRecarga);
		}
		
		botellaAgua = RetirarBotella(); // mock de agarrar una botella.
		botellas--;
		
		if (enQ > 0)
		{
			enQ--;
			signal(esperaAgua);
		}
		else
			libre = true;
	}
	
	Procedure EsperarQueFalten()
	{
		if (botellas > 0)
			wait(avisoRepositor);
	}
	
	Procedure AvisarRecarga()
	{
		botellas = 20;
		signal(esperaRecarga);
	}
}

Process Repositor
{
	while(true)
	{
		Máquina.EsperarQueFalten();
		// recarga las botellas.
		Máquina.AvisarRecarga();
	}
}

Process Corredor[id 0..C-1]
{
	BotellaAgua botella;

	Carrera.Llegada();
	// corre la carrera.
	Maquina.TomarBotella(botella);
}
```
---
### Ejercicio 8
En un entrenamiento de fútbol hay 20 jugadores que forman 4 equipos (cada jugador conoce el equipo al cual pertenece llamando a la función DarEquipo()). Cuando un equipo está listo (han llegado los 5 jugadores que lo componen), debe enfrentarse a otro equipo que también esté listo (los dos primeros equipos en juntarse juegan en la cancha 1, y los otros dos equipos juegan en la cancha 2). Una vez que el equipo conoce la cancha en la que juega, sus jugadores se dirigen a ella. Cuando los 10 jugadores del partido llegan a la cancha, comienza el partido; juegan durante 50 minutos y, al terminar, todos los jugadores del partido se retiran (no es necesario que esperen para salir).
```C
Monitor Equipo[id 0..3]
{
	int cantidad = 0;
	cond espera;
	int canchaAsignada;

	Procedure Llegada(out int nroCancha)
	{
		cantidad++;
		if (cantidad < 5)
			wait(espera);
		else
		{
			Entrenamiento.PedirCancha(canchaAsignada);
			signal_all(espera);
		}
		
		nroCancha = canchaAsignada;
	}
}

Monitor Entrenamiento
{
	int contador = 0; // para ver cuántas veces dio un nro de cancha.
	// acá sólo se esperan 4 llamados, uno por cada equipo.
	
	Procedure PedirCancha(out int nroCancha)
	{
		contador++;
		if (contador <= 2)
			nroCancha = 0; // 0 para los dos primeros
		else
			nroCancha = 1; // 1 para los dos últimos
	}
}

Monitor Cancha[id 0..1]
{
	int cantidad = 0;
	cond inicio; cond espera;
	
	Procedure Llegada()
	{
		cantidad++;
		if (cantidad == 10)
			signal(inicio);
		wait(espera);
	}
	
	Procedure Iniciar()
	{
		if (cant < 10)
			wait(inicio);
		signal_all(espera); // esto no va.
		// el partido se juega mientras los procesos están dormidos.
	}
	
	Procedure Terminar()
	{
		signal_all(espera);
	}
}

Process Partido[id 0..1]
{
	Cancha[id].Iniciar();
	delay(50mins) // se juega el partido.
	Cancha[id].Terminar();
}

Process Jugador [id 0..19]
{
	int nroCancha;
	int miEquipo = DarEquipo();
	
	Equipo[miEquipo].Llegada(nroCancha);
	Cancha[nroCancha].Llegada();
	// se retira.
}
```
Consultar: hace falta que los jugadores hagan llegada y salida y queden en wait, mientras un proceso "juega" el partido? (p. ej. un árbitro que comienza el partido, hace el delay y lo termina)

---
### Ejercicio 9
En un examen de la secundaria hay un preceptor y una profesora que deben tomar un examen escrito a 45 alumnos. El preceptor se encarga de darles el enunciado del examen a los alumnos cuando los 45 han llegado (es el mismo enunciado para todos). La profesora se encarga de ir corrigiendo los exámenes de acuerdo con el orden en que los alumnos van entregando. Cada alumno, al llegar, espera a que le den el enunciado, resuelve el examen y, al terminar, lo deja para que la profesora lo corrija y le envíe la nota.
Nota: maximizar la concurrencia; todos los procesos deben terminar su ejecución; suponga que la profesora tiene una función corregirExamen que recibe un examen y devuelve un entero con la nota.
```C
Monitor Aula
{
	int cant = 0;
	cond esperaEnunciado; cond avisoPreceptor;
	string enunciado;
	
	cola qExamenes;
	int[45] notas;
	cond avisoProfesora; cond esperaNota;

	Procedure Llegada(string out examen)
	{
		cant++;
		if (cant == 45)
			signal(avisoPreceptor);
			
		wait(esperaEnunciado);
		
		examen = enunciado;
	}
	
	Procedure DarEnunciado(in string e)
	{
		if (cant < 45)
			wait(avisoPreceptor);
			
		enunciado = e;
		signal_all(esperaEnunciado);
	}
	
	Procedure TerminoExamen(in string examen, in int id, out int nota)
	{
		qExamenes.push(id, examen);
		signal(avisoProfesora);
		wait(esperaNota);
		
		nota = notas[id];
	}
	
	Procedure Corregir(out int id, out string examen)
	{
		if (qExamenes.IsEmpty())
			wait(avisoProfesora);
		
		qExamenes.pop(id, examen);
	}
	
	Procedure EntregarNota(in int id, in int nota)
	{
		notas[id] = nota;
		signal(esperaNota);
	}
}

Process Preceptor
{
	string enunciado;
	Aula.DarEnunciado(enunciado);
}

Process Profesora
{
	int id;
	string examen;
	int nota;
	
	for int i = 1..45
	{
		Aula.Corregir(id, examen);
		nota = CorregirExamen(examen);
		Aula.EntregarNota(id, nota);
	}
}

Process Alumno[id 0..44]
{
	string examen;
	int nota;

	Aula.Llegada(examen);
	// RealizarExamen(examen);
	Aula.TerminoExamen(examen, id, nota);
}
```
Consultar: técnicamente entiendo que no haría falta separar en dos monitores para maximizar la concurrencia. El ejercicio se desarrolla en dos fases, primero la barrera con el preceptor y después el examen con la profesora. Sin embargo, usando dos monitores quedaría una solución más modularizada (y mínimamente más concurrente?). Se podría hacer con dos monitores? Cómo evalúan estos casos?

---
### Ejercicio 10
