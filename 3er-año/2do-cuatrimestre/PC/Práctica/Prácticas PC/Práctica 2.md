### Ejercicio 6
Existen N personas que deben imprimir un trabajo cada una. Resolver cada ítem usando semáforos:

#### a)
Implemente una solución suponiendo que existe una única impresora compartida por todas las personas, y las mismas la deben usar de a una persona a la vez, sin importar el orden. Existe una función Imprimir(documento) llamada por la persona que simula el uso de la impresora. Sólo se deben usar los procesos que representan a las Personas.
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
Modifique la solución de (a) para el caso en que se deba respetar el orden de llegada.
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
Modifique la solución de (a) para el caso en que se deba respetar estrictamente el orden dado por el identificador del proceso (la persona X no puede usar la impresora hasta que no haya terminado de usarla la persona X-1).
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
	);
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
Modifique la solución de (b) para el caso en que además hay un proceso Coordinador que le indica a cada persona que es su turno de usar la impresora.
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
Modificar la solución (d) para el caso en que sean 5 impresoras. El coordinador le indica a la persona cuándo puede usar una impresora, y cual debe usar.
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
No respeta el enunciado -> *"Cada vez que un alumno termina su tarea, le avisa al profesor."*
Solución correcta:
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
	
	P(mutex);
	qGrupos.push(numTarea);
	V(mutex);
	V(esperaProfesor);
	
	P(esperaPuntaje[numTarea]);
	int miPuntaje = puntaje[numTarea];
}

process Profesor
{
	int grupoACalificar;
	int p = 1;
	
	for int i = 0..49 {
		P(esperaProfesor);
		P(mutex);
		grupoACalificar = qGrupos.pop();
		V(mutex);
		contadorPorGrupo[grupoACalificar]++;
		if (contadorPorGrupo[grupoACalificar] == 5) {
			puntaje[grupoACalificar] = puntaje;
			puntaje++;
			for int j = 0..4
				V(esperaPuntaje[grupoACalificar]);
		}
	}
}
```

---
### Ejercicio 8
Una fábrica de piezas metálicas debe producir T piezas por día. Para eso, cuenta con E empleados que se ocupan de producir las piezas de a una por vez. La fábrica empieza a producir una vez que todos los empleados llegan. Mientras haya piezas por fabricar, los empleados tomarán una y la realizarán. Cada empleado puede tardar distinto tiempo en fabricar una pieza. Al finalizar el día, se debe conocer cuál es el empleado que más piezas fabricó.

#### a)
Implemente una solución asumiendo que T > E.
```C
sem mutex = 1; sem espera = 0; sem fin = 1;
int contador = 0;
int piezas = 0;
int[E] piezasFabricadasEmpleados = ([E] = 0);

process Empleado[id 0..E-1]
{
	int piezasFabricadas = 0;
	
	// llegada con barrera
	P(mutex);
	contador++;
	if (contador == E)
		for int i = 0..E-1
			V(espera);
	V(mutex);
	P(espera);
	
	P(mutex);
	while (piezas < T) {
		piezas++;
		V(mutex);
		// fabricar pieza.
		piezasFabricadasEmpleados[id]++;
		P(mutex)
	}
	V(mutex);
	
	V(fin);
}

process Fabrica
{
	// con que termine uno ya alcanza porque si terminó uno es que se terminaron las piezas.
	P(fin);
	int empleadoMaxPiezas = piezasFabricadasEmpleado
	s.max();
}
```

#### b)
Implemente una solución que contemple cualquier valor de T y E.