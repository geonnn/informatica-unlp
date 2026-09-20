### Ejercicio 6

#### a)
```C
sem mutex = 1;
process Persona[id 0..N-1]
{
	P(mutex);
	Imprimir(documento);
	V(mutex);
}
```

#### b)
```C
sem espera[N] = ([N] = 0); sem mutex = 1;
cola Q; libre = true;

process Persona [id 0..N-1]
{	
	P(mutex);
	if(libre)
	{
		libre = false;
		V(espera[id]);
	}
	else
		Q.push(id);
	V(mutex);
	
	P(espera[id]);
	Imprimir(documento);
	
	P(mutex);
	if (not Q.empty())
		V(espera[Q.pop()]);
	else
		libre = true;
	V(mutex);
}
```

#### c)
```C
sem espera[N] = ([N] = 0); sem mutex = 1; int sig = 0;

process Persona [id 0..N-1]
{	
	P(mutex);
	if (sig != id)
	{
		V(mutex);
		P(espera[id]);
	}
	else
		V(mutex);
	
	Imprimir(documento);
	
	P(mutex)
	sig++;
	if (sig < N)
		V(espera[sig]);
	V(mutex)
}
```
#### c2) (otra opción)
```C
sem espera[N] = ([N] = 0); sem mutex = 1; int sig = 0;

process Persona [id 0..N-1]
{	
	P(mutex);
	if (sig == id)
	{
		V(espera[sig]);
	}
	V(mutex);
	
	P(espera[id]);
	Imprimir(documento);
	
	P(mutex)
	sig++;
	if (sig < N)
		V(espera[sig]);
	V(mutex)
}
```

#### d)
```C
sem espera[N] = ([N] = 0); sem mutexQ = 1; sem enQueue = 0;
cola Q; sem impresoraLibre = 1;

process Persona [id 0..N-1]
{	
	P(mutexQ);
	Q.push(id);
	V(mutexQ);
	V(enQueue);
	P(espera[id]);
	Imprimir(documento);
	V(impresoraLibre);
}

process Coordinador
{
	while(true) {
		P(impresoraLibre);
		P(enQueue);
		P(mutexQ);
		int sig = Q.pop()
		V(espera[sig]);
		V(mutexQ);
	}
}
```

#### e) CORREGIR
```C
sem espera[N] = ([N] = 0);
sem mutexQPersonas = 1; sem mutexQImpresoras = 1;
sem enQueue = 0; sem impresorasLibres = 5;
int[N] impresoraAUtilizar;
cola qPersonas; cola qImpresoras = {0, 1, 2, 3, 4};

process Persona [id 0..N-1]
{	
	int impresoraAsignada;
	
	P(mutexQPersonas);
	qPersonas.push(id);
	V(mutexQPersonas);
	V(enQueue);
	
	P(espera[id]);
	impresoraAsignada = impresoraAUtilizar[id];
	Imprimir(documento);
	
	P(mutexQImpresoras);
	qImpresoras.push(impresoraAsignada);
	V(mutexQImpresoras);
	V(impresorasLibres);
}

process Coordinador
{
	int sigPersona, sigImpresora;
	
	while(true) {
		P(impresorasLibres);
		P(enQueue);
		
		P(mutexQPersonas);
		sigPersona = qPersonas.pop();
		V(mutexQPersonas);
		
		P(mutexQImpresoras);
		sigImpresora = qImpresoras.pop();
		V(mutexQImpresoras);
		
		impresoraAUtilizar[sigPersona] = sigImpresora;
		V(espera[sigPersona]);
	}
}
```

--- 
### Ejercicio 7
Suponga que se tiene un curso con 50 alumnos. Cada alumno debe realizar una tarea y existen 10 enunciados posibles. Una vez que todos los alumnos eligieron su tarea, comienzan a realizarla. Cada vez que un alumno termina su tarea, le avisa al profesor y se queda esperando el puntaje del grupo (depende de todos aquellos que comparten el mismo enunciado). Cuando un grupo termina, el profesor les otorga un puntaje que representa el orden en que se terminó esa tarea de las 10 posibles.
***Nota:*** Para elegir la tarea, suponga que existe una función ***elegir*** que le asigna una tarea a un alumno (esta función asignará 10 tareas diferentes entre 50 alumnos, es decir, que 5 alumnos tendrán la tarea 1, otros 5 la tarea 2 y así sucesivamente para las 10 tareas).
```C
sem barrera = 0; sem esperaProfesor = 0; sem[10] esperaPuntaje = ([10] = 0);
sem mutex = 1; sem[10] mutexGrupo = ([10] = 1);
int contador = 0; int[10] contadorPorGrupo = ([10] = 0);
int[10] puntaje;
cola qGrupos;

process Alumno[id: 0..49]
{
	int numTarea = elegir();
	P(mutex);
	contador++;
	if (contador == 50)
	{
		for int i = 0..49
			V(barrera);
	}
	V(mutex);
	
	P(barrera);
	// realizar tarea
	
	P(mutexGrupo[numTarea]);
	contadorPorGrupo[numTarea]++;
	if (contadorPorGrupo[numTarea] == 5)
	{
		P(mutex);
		qGrupos.push(numTarea);
		V(mutex);
		V(esperaProfesor);
	}
	V(mutexGrupo[numTarea])
	
	P(esperaPuntaje[numTarea]);
	int calificacion = puntaje[numTarea];
}

process Profesor
{
	int grupoACalificar;
	bool fin = false;
	
	for int calificacion = 1..10
	{
		P(esperaProfesor);
		
		P(mutex);
		grupoACalificar = qGrupos.pop();
		V(mutex);
		
		puntaje[grupoACalificar] = calificacion;
		for int i = 0..4
			V(esperaPuntaje[grupoACalificar]);
	}
}
```