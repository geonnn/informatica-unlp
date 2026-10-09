## 1. Resolver con SEMAFOROS el siguiente problema.
En un laboratorio de genética trabajan 20 empleados que deben usar un pirosecuenciador de a uno a la vez, de acuerdo con el orden de llegada. Nota: sólo se pueden usar los procesos
que representen a los empleados; cada empleado usa sólo una vez el pirosecuenciador; suponga que existe la función USAR() que simula el uso de este instrumento por parte del empleado.
```C
sem mutex = 1; sem[20] espera = ([20] 0);
bool libre = true;
cola q;

Process Empleado[id 0..19]
{
	P(mutex);
	if (not libre)
	{
		q.push(id);
		V(mutex);
		P(espera[id]);
	}
	else
	{
		libre = false;
		V(mutex);
	}
		
	USAR();
	
	P(mutex);
	if (q.IsEmpty())
		libre = true;
	else
	{
		int sig = q.pop();
		V(espera[sig]);
	}
	V(mutex);
}
```

## 2. Resolver con SEMAFOROS el siguiente problema.
Se tiene un vector A de 1.000.000 de números, del cual se debe obtener la suma de todos los valores utilizando 5 procesos Worker. Al terminar todos los procesos deben imprimir el resultado final. Nota: maximizar concurrencia; unicamente pueden usar los 5 procesos Worker.
```C
int[1.000.000] nums;
sem mutexNums = 1; sem mutexFin = 1;
sem barrera = 0;
int total = 0;
int actual = 0;
int terminaron = 0;

Process Worker[id 0..4]
{
	int suma = 0;
	int numero;
	
	P(mutexNums);
	while (actual < 1.000.000)
	{
		numero = nums[actual];
		actual++;
		V(mutexNums);
		suma += numero;
		P(mutexNums);
	}
	V(mutexNums);
	
	P(mutexFin);
	total += suma;
	terminaron++;
	if (terminaron == 5)
	{
		for int i = 1..5
			V(barrera);
	}
	V(mutexFin);
	
	P(barrera);
	
	print(total);
}
```

## 3. Resolver con MONITORES el siguiente problema.
En una oficina hay un supervisor, un empleado y 50 personas que solicitan por mail una operación. El empleado sólo atiende CONSULTAS, mientras que el supervisor sólo atiende
TRÁMITES; cada uno atiende sus pedidos de acuerdo con el orden de llegada. Cada persona envia UNA solicitud que puede ser para un TRÁMITE o para una CONSULTA, y luego espera a que le envíen el resultado. Nota: maximizar concurrencia; la persona sabe de qué tipo es la consulta, el empleado y el supervisor NO deben terminar su ejecución.

```C
Monitor Oficina[id 0..1] // 0 para trámites, 1 para consultas.
{
	cond espera; cond avisoLlegada;
	string[50] resultados;
	cola qSolicitudes;
	
	Procedure Solicitud(in int id, in string solicitud, out string resultado)
	{
		qSolicitudes.push(id, solicitud);
		signal(avisoLlegada);
		wait(espera);
		
		resultado = resultados[id];	
	}
	
	Procedure Atender(out int id, out string solicitud)
	{
		if (qSolicitudes.IsEmpty())
			wait(avisoLlegada);
		
		qSolicitudes.pop(id, solicitud);
	}
	
	Procedure EnviarResultado(in int id, in string resultado)
	{
		resultados[id] = resultado;
		signal(espera);
	}
}

Process Supervisor
{
	int id;
	string solicitud;
	string resultado;
	while(true)
	{
		Oficina[0].Atender(id, solicitud);
		resultado = GenerarResultado(solicitud);
		Oficina[0].EnviarResultado(id, resultado);
	}
}

Process Empleado
{
	// lo mismo que el supervisor pero con Oficina[1].
}

Process Persona[id 0..49]
{
	string solicitud = CrearSolicitud();
	int tipoConsulta = X;
	
	Oficina[tipoConsulta].Solicitud(id, solicitud, resultado);
}
```