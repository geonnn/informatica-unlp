## 1. Resolver con SEMAFOROS el siguiente problema.
Para un experimento se tiene una red con 15 controladores de temperatura y dos módulos centrales. Los controladores cada cierto tiempo toman la temperatura mediante la función medir() y la envía para que alguna de las centrales le indique que debe hacer (número de 1 a 10), y luego realiza esa acción mediante la función actuar(). Las centrales atienden los pedidos de los controladores de acuerdo al orden de llegada, usando la función determinar() para determinar la acción que deberá hacer ese controlador (número de 1 a 10).
Nota: el tiempo que espera cada controlador para tomar nuevamente la temperatura empieza a contar después de haber ejecutado la función actuar().
```C
sem mutexQ = 1;
sem hayTemp = 0;
sem[15] espera = ([15] 0);
int[15] resultados;
cola qTemps;

Process Controlador[id 0..14]
{
	int temp;
	int res;
	
	while(true)
	{
		temp = medir();
		
		P(mutexQ);
		qTemps.Push(id, temp);
		V(mutexQ);
		V(hayTemp);
		
		P(espera[id]);
		res = resultados[id];
		actuar(res);
		
		delay(x);
	}
}

Process ModuloCentral[id 0..1]
{
	int temp;
	int id;
	int res;
	
	while(true)
	{
		P(hayTemp);
		
		P(mutexQ);
		qTemps.pop(id, temp);
		V(mutexQ);
		
		res = determinar(temp);
		resultados[id] = res;
		V(espera[id]);
	}
}
```
---
## Resolver con MONITORES el siguiente problema.
Hay una boletería virtual que vende en forma online E entradas para un partido de fútbol a P personas (P > E) de acuerdo con el orden de llegada. Cuando la boletería atiende a una persona, si aún quedan entradas disponibles le envía el número de entrada vendida, sino le indica que no hay más entradas.
Nota: suponga que existe la función vender() que simula la venta de la entrada.
```C
Monitor Boletería
{
	cond espera, avisoCompra;
	int[P] entradas;
	cola q;
	
	Procedure Comprar(in int id, out int entrada)
	{
		q.Push(id);
		signal(avisoCompra);
		wait(espera);
		
		entrada = entradas[id];
	}
	
	Procedure Atender(out int id)
	{
		if (q.IsEmpty())
			wait(avisoCompra);
		
		q.Pop(id);
	}
	
	Procedure EntregarEntrada(in int id, in int entrada)
	{
		entradas[id] = entrada;
		signal(espera);
	}
}

Process WorkerVirtual
{
	int idP;
	int entrada;
	int entradas = E;

	for int i = 1..P
	{
		Boletería.Atender(idP);
		if (entradas > 0)
		{
			entradas--;
			entrada = vender(); // otorga el número de entrada.
		}
		else
			entrada = -1; // no hay más entradas.
			
		Boletería.EntregarEntrada(idP, entrada);
	}
}

Process Persona[id 0..P-1]
{
	int entrada;
	
	Boletería.Comprar(id, entrada);
	if (entrada == -1)
		print("me quedé sin entrada");
}
```
---
## Resolver con MONITORES la siguiente situación
En un camino turístico hay un puente por donde puede pasar un vehículo a la vez. Hay N autos que deben pasar por él de acuerdo con el orden de llegada. Nota: sólo se pueden usar los procesos Autos (y los monitores que sean necesarios); suponga que existe la función pasar() que simula el paso del auto por el puente.