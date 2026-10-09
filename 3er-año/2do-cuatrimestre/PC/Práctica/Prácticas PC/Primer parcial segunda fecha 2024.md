# Resolver con SEMAFOROS el siguiente problema.
La Clave Unica de Identificacién Tributaria (CUIT) es una clave que se utiliza en el sistema tributario de la Republica Argentina para poder identificar correctamente a las personas físicas o jurídicas. Consta de un total de once (11) cifras numéricas, siendo la última un dígito verificador (del 0 al 9). Una empresa cuenta con una lista de CUITs que debe procesar, debiendo informar la cantidad de CUITs por dígito verificador. Para ello, dispone de un software que emplea 5 workers, los cuales trabajan colaborativamente procesando de a un CUIT por vez cada uno. Al finalizar el procesamiento, el último worker en terminar debe informar los resultados del procesamiento. Notas: la función obtenerDV(CUIT) retorna el dígito verificador para la CUIT recibida como entrada. La lista de CUITs se almacena como una cola global y la solución debe maximizar la concurrencia.
```C
sem mutexQ = 1;
cola qCUITs;

sem[10] mutexDVs = ([10] 1);
int[10] totalDVs = ([10] 0);

sem mutexFin = 1;
int contFin = 0;

process Worker[id 0..4]
{
	int[10] cantDVs = ([10] 0);
	int cuit;
	int dv;

	P(mutexQ);
	while (not qCUITs.IsEmpty())
	{
		qCUITs.Pop(cuit);
		V(mutexQ);
		dv = obtenerDV(cuit);
		cantDVs[dv]++;
		P(mutexQ);
	}
	V(mutexQ);
	
	for int i = 0..9
	{
		P(mutexDVs[i]);
		totalDVs[i] += cantDVs[i];
		V(mutexDVs[i]);
	}
	
	P(mutexFin);
	contFin++;
	if (contFin == 5)
		print(totalDVs); // imprime todo el arreglo.
	V(mutexFin);
}
```
# Resolver con MONITORES la siguiente situación.
En un negocio hay UN empleado que diseña tarjetas digitales. El empleado debe atender los pedidos de C clientes, de acuerdo con el orden en que se hacen los pedidos. El cliente envía las indicaciones, y el empleado en base a eso diseña la tarjeta y se la envía al cliente.
Notas: maximizar la concurrencia; existe una función HacerTarjeta(indicaciones) que simula el armado de la tarjeta porparte del empleado; todos los procesos deben terminar su ejecución.
```C
Monitor Atencion
{
	cond avisoPedido;
	cond esperaTarjeta;
	cola q;
	
	Tarjeta[C] tarjetas;

	Procedure Pedido(in int id, in string indicaciones, out Tarjeta tarjeta)
	{
		q.Push(id, indicaciones);
		signal(avisoPedido);
		wait(esperaTarjeta);
		
		tarjeta = tarjetas[id];
	}
	
	Procedure TomarPedido(out int id, out string indicaciones)
	{
		if (q.IsEmpty())
			wait(avisoPedido);
			
		q.Pop(id, indicaciones);
	}
	
	Procedure EntregarTarjeta(in int id, in Tarjeta tarjeta)
	{
		tarjetas[id] = tarjeta;
		signal(esperaTarjeta);
	}
}

Process Empleado
{
	string indicaciones;
	Tarjeta t;
	int id;

	for int i = 1..C
	{
		Atencion.TomarPedido(id, indicaciones);
		t = HacerTarjeta(indicaciones);
		Atencion.EntregarTarjeta(id, t);
	}
}

Process Cliente[id 0..C-1]
{
	string indicaciones;
	Tarjeta t;
	
	Atencion.Pedido(id, indicaciones, t);
}
```