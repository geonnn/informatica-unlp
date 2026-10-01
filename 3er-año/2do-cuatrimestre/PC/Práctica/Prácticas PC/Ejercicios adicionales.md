
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
	else cantidad = -1;                          ← "no hay más entradas"
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