### Resolver con MONITORES el siguiente problema. 
Hay una boletería virtual que vende en forma online E entradas para un partido de fútbol a P personas (P > E) de acuerdo con el orden de llegada. 
Cuando la boletería atiende a una persona, si aún quedan entradas disponibles le envía el número de entrada vendida, sino le indica que no hay más entradas.
Nota: suponga que existe la función vender() que simula la venta de la entrada.

```C
Monitor Boletería
{
	int enQ = 0;
	int entradasAgotadas = false;
	int[P] entradaAsignada;
	int idClienteActual;
	cond espera; cond avisoLlegada; cond datoCliente;
	cond esperaEntrada; cond avisoSalida;
	
	Procedure Acceder(out bool hayEntradas)
	{
		if (!entradasAgotadas)
		{
			enQ++;
			signal(avisoLlegada);
			wait(espera);
		}
		
		hayEntradas = !entradasAgotadas;
	}
	
	Procedure AtenderCliente()
	{
		if (enQ == 0)
			wait(avisoLlegada);
		
		enQ--;
		signal(espera);
		wait(datoCliente);
	}
	
	Procedure Comprar(in int id)
	{
		idClienteActual = id;
		signal(datoCliente);
		wait(esperaEntrada);
	}
	
	Procedure EntregarEntrada(in int entrada)
	{
		entradaAsignada[idClienteActual] = entrada;
		signal(esperaEntrada);
	}
	
	Procedure RetirarEntrada(in int id, out int entrada)
	{
		entrada = entradaAsignada[id];
	}
	
	Procedure Cerrar()
	{
		entradasAgotadas = true;
		signal_all(espera);
	}
}

Process Vendedor
{
	for int i = 1..E
	{
		Boletería.AtenderCliente();
		// vender(?)
		Boletería.EntregarEntrada(i);
	}
	Boletería.Cerrar();
}

Process Persona[id 0..P-1]
{
	int miEntrada; bool hayEntradas;

	Boletería.Acceder(hayEntradas);
	if (hayEntradas)
	{
		Boletería.Comprar(id);
		Boletería.RetirarEntrada(id, miEntrada);
	}
}
```

```C
Monitor Boleteria
{
	cola C; cond hayPedido, espera; int res[P];

	Procedure Pedido (id: in int; R: out int)
	{
		push(C, id);
		signal(hayPedido);
	    wait(espera);
	    R = res[id];
	}
	
	Procedure Siguiente (id: out int)
	{
		if (empty(C)) wait(hayPedido);
		pop(C, id);
	}
	
	Procedure Resultado (id: in int; R: in int)
	{
		res[id] = R;
		signal(espera);
	}
}

Process Persona[id: 0..P-1]
{
	int entrada;
	Boleteria.Pedido(id, entrada);
	if (entrada == -1) "no consiguió entrada"
	else "tiene la entrada número 'entrada'";
}
	
Process Vendedor
{
	int i, id, cantidad, quedan = E;
	for i = 1..P {
	Boleteria.Siguiente(id);  //orden de llegada
	if (quedan > 0)
	{
		num = vender();
		quedan--;
	}
	else cantidad = -1;                      ← "no hay más entradas"
	Boleteria.Resultado(id, cantidad);
}
```
---
### Resolver con SEMAFOROS el siguiente problema.
La Clave Unica de Identificación Tributaria (CUIT) es una clave que se utiliza en el sistema tributario de la República Argentina para poder identificar correctamente a las personas fisicas jurídicas. Consta de un total de once (11) cifras numéricas, siendo la última un dígito verificador (del 0 al 9). Una empresa cuenta con una lista de CUITs que debe procesar, debiendo informar la cantidad de CUITs por dígito verificador. Para ello, dispone de un software que emplea 5 workers, los cuales trabajan colaborativamente procesando de a una CUIT por vez cada uno. Al finalizar el procesamiento, el último worker en terminar debe informar los resultados del procesamiento. Notas: la función obtenerDV(CUIT) retorna el digito verificador para la CUIT recibida como entrada. La lista de CUITs se almacena como una cola global y la solución debe maximizar la concurrencia.

```C
sem mutexFin = 1;
int termine = 0;
int[10] cantDVs = ([10] 0);
cola q;
sem mutexQ = 1;
sem[10] mutexDVs = ([10] 1);

Process Worker[id 0..4]
{
	int[10] DVs = ([10] 0);

	P(mutexQ);
	while (not q.IsEmpty())
	{
		int cuit = q.pop();
		V(mutexQ);
		
		DVs[obtenerDV(cuit)]++;
		
		P(mutexQ);
	}
	V(mutexQ);
	
	for int i = 0..9
	{
		P(mutexDVs[i]);
		cantDVs[i] += DVs[i];
		V(mutexDVs[i]);
	}
	
	P(mutexFin);
	termine++;
	if (termine == 5)
		for int i = 0..9
			print(cantDVs[i]);
	V(mutexFin);
}
```
---
### Resolver con SEMÁFOROS.
Existe una sala de cine 3D, a las que asisten N personas a ver una película. Antes de entrar a la sala, los asistentes deben retirar los anteojos 3D en la maquina repartidora que se encuentra en la entrada. Se debe simular el uso de la máquina repartidora de anteojos 3D, con capacidad para A anteojos (A < N). Además, existe un repositor encargado de reponer los anteojos en la máquina cuando se agotan. Los usuarios usan la maquina según el orden de llegada. Cuando les toca usarla, sacan un par de anteojos y luego se dirigen a la sala. En caso de que la máquina se quede sin anteojos, entonces le debe avisar al repositor para que cargue nuevamente la máquina en forma completa. Luego de la recarga, saca un par de anteojos y se retira. Implemente un programa que permita resolver el problema anterior usando SEMÁFOROS.
Nota: maximizar la concurrencia; la reposición de anteojos no debe impedir que otros asistentes puedan agregarse a la fila.
```C
bool libre = true;
int anteojosRestantes = A;
cola q;
sem[N] espera = 0;
sem mutexQ = 1;
sem esperarRepositor = 0;
sem avisoReponer = 0;

process Persona[id 0..N-1]
{
	P(mutexQ)
	if (libre)
	{
		libre = false;
		V(espera[id]);
	}
	else
		q.push(id);
	
	V(mutexQ);
	
	P(espera[id]);
	
	if (anteojosRestantes == 0)
	{
		V(avisoReponer);
		P(esperarRepositor);
	}
	anteojosRestantes--;
	
	P(mutexQ);
	if (q.IsEmpty())
		libre = true;
	else
	{
		int sig = q.pop();
		V(espera[sig]);
	}
	V(mutexQ);
}

process Repositor
{
	while (true)
	{
		P(avisoReponer);
		anteojosRestantes = A;
		V(esperarRepositor);
	}
}
```
---
### SEMÁFOROS
Se debe simular el uso de un sistema virtual de venta de entradas para un evento musical.
El sistema cuenta con C cajeros virtuales que atienden indefinidamente. Sin embargo, como la venta de entradas comienza a una hora determinada, sólo atienden a partir del aviso de un Timer. Una vez que reciben dicho aviso, los cajeros atienden de acuerdo con el orden de llegada de los compradores. La atención consiste en recibir la solicitud del comprador (datos para el pago) y responderle si pudo comprar (o no) junto al comprobante de la operación. Para este evento se cuenta con E entradas y N compradores, donde cada comprador puede solicitar a lo suma una entrada.
```C
cola c;
int entradas = E;
bool[N] operacion;
sem inicio = 0;
sem MUTEX = 1;
sem HayPersona = 0;
sem[N] respuesta = ([N] 0);

process cajero [id:0..C-1]
{
	int comprador;

	P(inicio);
	while(true)
	{
		P(HayPersona);
		P(MUTEX);
		c.pop(comprador);
		if (entradas>0)
		{
			entradas--;
			operacion[comprador]=true;
		}
		else
		{
			operacion[comprador]=false;
		}
		V(MUTEX);
		V(respuesta[comprador]);
	}
}

process timer(n in int)
{
	delay(n);
	for (int i = 0; i < C; i++)
		V(inicio);
}

process comprador[id:0..n-1]
{
	int aux;
	P(MUTEX);
	c.push(id);
	V(MUTEX);
	V(HayPersona);
	P(respuesta[id]);
	if (operacion[id])
		"compré";
	else
		"soy un gil";
}
```
---
### MONITORES
Resolver con MONITORES el siguiente problema. La FIA tiene 3 circuitos diferentes para probar 50 autos de las categorías F1 y F2 (22 de F1 y 28 de F2). Cada auto conoce en qué circuito debe hacer sus pruebas, cuando lo tiene a su disposición lo usa durante 3 hs. En cada circuito no puede haber más de un auto a la vez haciendo sus pruebas, y para usarlos tienen prioridad los de F1 por sobre los de F2 (entre los autos de la misma categoría se respeta el orden de llegada).
Nota: maximizar la concurrencia; los únicos procesos que se pueden usar son los que representan a los autos; suponga que existe la función USAR() que simula el uso del circuito por parte de un auto.
```C
Monitor Circuito[id 0..2]
{
	bool libre = true;
	colaPrioridad q;
	cond[50] espera;

	Procedure Llegada(in int id, in int categoria)
	{
		if (not libre)
		{
			q.Insert(id, categoria); // se inserta con prioridad por cat.
			wait(espera[id]);
		}
		else
			libre = false;
	}
	
	Procedure Retirarse()
	{
		int sig;
		
		if (not q.IsEmpty())
		{
			q.Pop(sig);
			signal(espera[sig]);
		}
		else
			libre = true
	}
}

Process Auto[id 0..49]
{
	int circuito = x;
	int categoria = y;
	
	Circuito[circuito].Llegada(id, categoria);
	USAR();
	Circuito[circuito].Retirarse();
}
```

Otra solución (sin q y una variable condición para cada tipo):
```C
Monitor Admin[0..2]
{
	cond esperaF1; cond esperaF2;
	int cantF1 = 0; int cantF2 = 0;
	
	Procedure Llegada(in int categoria)
	{
		if (not libre)
		{
			if (categoria == "F1")
			{
				cantF1++;
				wait(esperaF1);
			}
			else
			{
				cantF2++;
				wait(esperaF2);
			}
		}
		else
			libre = false;
	}
	
	Procedure Retirarse()
	{
		if (esperaF1 > 0)
		{
			esperaF1--;
			signal(esperaF1);
		}
		else if (esperaF2 > 0)
		{
			esperaF2--;
			signal(esperaF2);
		}
		else
			libre = true;
	}
}
	
Process Auto[id 0..49]
{
	int circuito = x;
	int categoria = y;
	
	Admin[circuito].Llegada(id, categoria);
	USAR();
	Admin[circuito].Retirarse();
}
```
---
### Resolver con SEMÁFOROS el siguiente problema
En una planta verificadora de vehículos existe un puesto de atención para atender a 20 vehiculos que deben hacer su verificación. En el puesto de atención hay un empleado que atiende a los vehículos de acuerdo con el orden de llegada, realiza la verificación y le entrega el comprobante; luego espera que el vehículo abandone el puesto para poder atender al siguiente.
Nota: existe la función verificar(ID) que simula que el empleado está verificando al vehículo ID; todos los procesos deben terminar.
```C
sem mutexQ = 1;
sem hayVehiculos = 0;
sem[20] espera = ([20] 0);
sem salida = 0;
string comprobanteAct;
cola q;

Process Vehículo[id 0..19]
{
	string comprobante;

	P(mutexQ);
	q.Push(id);
	V(mutexQ);
	V(hayVehiculos);
	
	P(espera[id]);
	
	comprobante = comprobanteAct;
	V(salida);
}

Process Empleado
{
	int id;

	for int i = 1..20
	{	
		P(hayVehiculos);
		P(mutexQ);
		q.Pop(id);
		V(mutexQ);
		
		comprobanteAct = Verificar(id);
		V(espera[id]);
		P(salida);
	}
}
```
---
### MONITORES
En el Registro de la Propiedad se pueden realizar 4 tramites administrativos diferentes. Para cada tramite, hay un puesto de atención específico. Existen 100 personas que se dirigen a la oficina para resolver un trámite particular. La persona deja su trámite en el puesto correspondiente y espera a que le entreguen el resultado. El puesto atiende a las personas que le corresponden de acuerdo con el orden de llegada. Implemente un programa que permita resolver el problema anterior usando MONITORES.
Notas: maximizar la concurrencia; todos los procesos deben terminar; la función obtenerPuesto() retorna el número de puesto al que la persona debe dirigirse para su trámite; la función obtenerTrámite() retorna el trámite a realizar; la función procesarTrámite(t) procesa el trámite recibido como entrada y retorna su resultado.
```C
Monitor Puesto[id 0..3]
{
	cola q;
	cond espera;
	cond avisoLlegada;
	string[100] resultados;
	bool fin = false;
	
	Procedure EntregarTramite(in int id, in Tramite tramite, out string res)
	{
		q.Push(id, tramite);
		Oficina.Llegada(id);
		signal(avisoLlegada);
		wait(espera);
		
		res = resultados[id];
	}
	
	Procedure Atender(out int id, out Tramite tramite, out bool seguir)
	{
		if (q.IsEmpty() && !fin)
			wait(avisoLlegada);
		
		if (q.IsEmpty() && fin)
		{
			seguir = false;
		}
		else
		{
			q.Pop(id, tramite);
			seguir = true;
		}
	}
	
	Procedure EntregarResultado(in int id, in string res)
	{
		resultados[id] = res;
		signal(espera);
	}
	
	Procedure NotificarFin()
	{
		fin = true;
		signal(avisoLlegada);
	}
}

Monitor Oficina
{
	int cantidadClientes = 0;

	Procedure Llegada(in int puesto)
	{
		cantidadClientes++;
		if (cantidadClientes == 100)
		{
			for int i = 0..3
				Puesto[i].NotificarFin();
		}
	}
}

Process Empleado[id 0..3]
{
	bool seguir;
	int idP; Tramite t;
	string res;
	
	while (seguir)
	{
		Puesto[id].Atender(idP, t, seguir);
		
		if (seguir)
		{
			res = ProcesarTramite(t);
			Puesto[id].EntregarTramite(idP, res);
		}
	}
}

Process Persona[id 0..99]
{
	Tramite t;
	string res;
	
	int puesto = obtenerPuesto();
	
	Puesto[puesto].EntregarTramite(id, t, res);
}
```