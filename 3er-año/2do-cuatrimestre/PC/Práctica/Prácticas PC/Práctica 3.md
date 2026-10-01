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
### Ejercicio 4 CORREGIR
Existen N vehículos que deben pasar por un puente de acuerdo con el orden de llegada. Considere que el puente no soporta más de 50000 kg y que cada vehículo cuenta con su propio peso (ningún vehículo supera el peso soportado por el puente).
```C
Monitor Puente
{
	CARGA_MAX = 50000; // constante
	cola q;
	bool libre = true;
	float pesoEsperando[N];
	float cargaActual = 0;
	cond espera[N];
	
	Procedure Acceder(in int id, in float peso)
	{	
		// si hay autos en la q o se supera la capacidad, espera.
		if (not q.IsEmpty() or (cargaActual + peso) > CARGA_MAX)
		{
			q.push(id); // entra en la queue.
			pesoEsperando[id] = peso; // anota su peso.
			wait(espera[id]);
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
			signal(espera[sig]);
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
#### b) Resuelva considerando que el corralón tiene E empleados (E > 1). Los empleados no deben terminar su ejecución.
```C
Monitor Corralón
{
}

Process Empleado[id 0..E-1]
```

#### c) Modifique la solución (b) considerando que los empleados deben terminar su ejecución cuando se hayan atendido todos los clientes.