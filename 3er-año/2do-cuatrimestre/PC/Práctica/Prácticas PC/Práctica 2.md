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

#### e)
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
	Imprimir(impresora[impresoraAsignada], documento);
	
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
	// pasó la barrera
	
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
	for int i = 1..E
		P(fin);
	int empleadoMaxPiezas = piezasFabricadasEmpleado
	s.max();
}
```

#### b)
Implemente una solución que contemple cualquier valor de T y E.
```C
```

---
### Ejercicio 9
Resolver el funcionamiento en una fábrica de ventanas con 7 empleados (4 carpinteros, 1 vidriero y 2 armadores) que trabajan de la siguiente manera:
- Los carpinteros continuamente hacen marcos (cada marco es armado por un único carpintero) y los dejan en un depósito con capacidad de almacenar 30 marcos.
- El vidriero continuamente hace vidrios y los deja en otro depósito con capacidad para 50 vidrios.
- Los armadores continuamente toman un marco y un vidrio (en ese orden) de los depósitos correspondientes y arman la ventana (cada ventana es armada por un único armador).
```C
sem depositoMarcos = 30; sem depositoVidrios = 50;
sem marcos = 0; sem vidrios = 0;
sem mutexDepositoMarcos = 1; sem mutex DepositoVidrios = 1;
cola qMarcos; cola qVidrios;

process Carpintero[id 0..3]
{	
	while (true)
	{
		recurso marco = hacerMarco(); // hace el marco.
		
		P(depositoMarcos); // ¿hay lugar para dejar un marco?
		
		P(mutexDepositoMarcos);
		qMarcos.push(marco); // deja el marco.
		V(mutexDepositoMarcos);
		
		V(marcos); // avisa que hay un marco más en el depósito.
	}
}

process Vidriero
{
	while (true)
	{
		recurso vidrio = hacerVidrio(); // hace el vidrio.
		
		P(depositoVidrios); // ¿hay lugar para dejar un vidrio?
		
		P(mutexDepositoVidrios);
		qVidrios.push(vidrio); // deja el vidrio.
		V(mutexDepositoVidrios);
		
		V(vidrios); // avisa que hay un vidrio más.
	}
}

process Armador[id 0..1]
{
	while (true)
	{
		P(marcos); // ¿hay un marco?
		P(vidrios); // ¿hay un vidrio?
		
		P(mutexDepositoMarcos);
		recurso marco = qMarcos.pop(); // se lleva un marco 
		V(mutexDepositoMarcos); // libera el recurso.
		V(depositoMarcos); // avisa que hay un lugar más para dejar un marco.
		
		// consultar: importa el orden de los últimos V()?
		// calculo que sí. Siempre liberar recurso de mutex primero.
		
		P(mutexDepositoVidrios);
		recurso vidrio = qVidrios.pop(); // se lleva un vidrio.
		V(mutexDepositoVidrios);
		V(depositoVidrios);
		
		// armar ventana.
	}
}
```
---
### Ejercicio 10
A una cerealera van T camiones a descargarse trigo y M camiones a descargar maíz. Sólo hay lugar para que 7 camiones a la vez descarguen, pero no pueden ser más de 5 del mismo tipo de cereal.
#### a)
Implemente una solución que use un proceso extra que actúe como coordinador entre los camiones. El coordinador debe atender a los camiones según el orden de llegada. Además, debe retirarse cuando todos los camiones han descargado.
```C#
sem lugarMaiz = 5; sem lugarTrigo = 5; sem lugarGral = 7;
cola qCamiones; sem mutexQ = 1;
sem[T] esperaTrigo = ([T] 0); sem[M] esperaMaiz = ([M] 0);
sem llegadas = 0;

process CamionTrigo[id 0..T-1]
{
	P(mutexQ);
	qCamiones.push(id, "trigo");
	V(mutexQ);
	
	V(llegada);
	P(esperaTrigo[id]):
	// dejar trigo.
	V(lugarTrigo);
	V(lugarGral);
}

process CamionMaiz[id 0..M-1]
{
	P(mutexQ);
	qCamiones.push(id, "maiz");
	V(mutexQ);
	
	V(llegada);
	P(esperaMaiz[id]):
	// dejar maíz.
	V(lugarMaiz);
	V(lugarGral);
}

process Coordinador
{
	int camion; string tipo;
	for int i = 1..T+M
	{
		P(llegada);
		
		P(mutexQ);
		qCamiones.pop(camion, tipo);
		V(mutexQ);
		
		// filtro por tipo
		if (tipo == "trigo")
		{
			P(lugarTrigo);
			P(lugarGral);
			V(esperaTrigo[camion]);
		}
		else
		{
			P(lugarMaiz);
			P(lugarGral);
			V(esperaMaiz[camion]);
		}	
	}
}

```

**Filtro por tipo:** para administrar un recurso con restricciones que aplican a grupos y a subgrupos del primer grupo, primero P(subgrupo), después P(grupo). Si no, no se maximiza la concurrencia.
Si primero se hace P(grupo) y después P(subgrupo), en este caso, 5 camiones de un tipo podrían bloquear el acceso a camiones del otro tipo, cuando deberían poder ingresar.
#### b)
Implemente una solución que no use procesos adicionales (sólo camiones). No importa el orden de llegada para descargar. Nota: maximice la concurrencia.
```C
sem lugarMaiz = 5; sem lugarTrigo = 5; sem lugarGral = 7;

process CamionTrigo[id 0..T-1]
{
	P(lugarTrigo);
	P(lugarGral);
	// dejar trigo.
	V(lugarTrigo);
	V(lugarGral);
}

process CamionMaiz[id 0..M-1]
{
	P(lugarMaiz);
	P(lugarGral);
	// dejar maíz.
	V(lugarMaiz);
	V(lugarGral);
}
```
---
### Ejercicio 11
En un vacunatorio hay un empleado de salud para vacunar a 50 personas. El empleado de salud atiende a las personas de acuerdo con el orden de llegada y de a 5 personas a la vez. Es decir, que cuando está libre debe esperar a que haya al menos 5 personas esperando, luego vacuna a las 5 primeras personas, y al terminar las deja ir para esperar por otras 5. Cuando ha atendido a las 50 personas el empleado de salud se retira.
Nota: todos los procesos deben terminar su ejecución; suponga que el empleado tiene una función VacunarPersona() que simula que el empleado está vacunando a UNA persona.
```C
sem mutex = 1;
sem[50] espera = ([50] 0);
sem llegada = 0; sem esperaVacunados = 0;
cola q;

process Persona[id 0..49]
{
	P(mutex);
	q.push(id);
	V(mutex);
	
	V(llegada);
	P(espera[id]);
	// se vacuna.
	P(esperaVacunados); // espera que le avisen que se puede ir.
	// se retira.
}

process Empleado
{
	int idP;
		
	for int i = 1..10
	{
		// espera que haya al menos 5 personas.
		for int j = 1..5
		{
			P(llegada);
		}
		
		// vacuna a 5 personas.
		for int j = 1..5
		{
			idP = q.pop();
			V(espera[idP]);
			VacunarPersona(idP);
		}
		
		// avisa a los 5 vacunados que pueden retirarse.
		for int j = 1..5
		{
			V(esperaVacunados);
		}
	}
}
```
---
### Ejercicio 12
Simular la atención en una Terminal de Micros que posee 3 puestos para hisopar a 150 pasajeros. En cada puesto hay una Enfermera que atiende a los pasajeros de acuerdo con el orden de llegada al mismo. Cuando llega un pasajero, se dirige al Recepcionista, quien le indica qué puesto es el que tiene menos gente esperando. Luego se dirige al puesto y espera a que la enfermera correspondiente lo llame para hisoparlo. Finalmente, se retira.
Nota: suponga que existe una función Hisopar() que simula la atención del pasajero por parte de la enfermera correspondiente.
#### a) Implemente una solución considerando los procesos Pasajeros, Enfermera y Recepcionista.
```C
sem mutexQ = 1;
cola qP;
sem esperando = 0;
sem[150] espera = ([150] 0);

sem[3] mutexQPuesto = ([3] 1);
cola[3] qsPuestos;
int[150] puestoAsignado;

sem[3] esperandoHisopado = 0;

Process Pasajero[id 0..149]
{
	int puesto;
	
	P(mutexQ);
	qP.push(id);
	V(mutexQ);
	
	V(esperando);
	P(espera[id]);
	
	puesto = puestoAsignado[id];
	P(mutexArregloQsPuestos);
	P(mutexQPuesto[puesto]);
	qsPuestos[puesto].push(id);
	V(mutexQPuesto[puesto]);
	V(mutexArregloQsPuestos);
	
	V(esperandoHisopado[puesto]);
	P(espera[id]);
	// se hace el hisopado
	P(espera[id]);
}

Process Recepcionista
{
	int id; int puesto;
	int min; int cant;

	for int i = 1..150
	{
		P(esperando);
		P(mutexQ);
		qP.pop(id);
		V(mutexQ);
		
		min = 99999;
		// saca el puesto con menos gente
		// bloqueo todo el arreglo para sacar una "foto" y poder obtener un mínimo real.
		P(mutexArregloQsPuestos);
		for int j in 0..2
		{
			cant = qsPuestos[j].size();
			if (cant < min)
			{
				min = cant;
				puesto = j;
			}
		}
		V(mutexArregloQsPuestos);
		
		puestoAsignado[id] = puesto;
		V(espera[id]);
	}
}

Process Enfermera[id 0..2]
{
	int idP;
	
	while(true)
	{
		P(esperandoHisopado[id]);
		
		P(mutexQPuesto[id]);
		qsPuestos.pop(idP);
		V(mutexQPuesto[id]);
		
		V(espera[idP]); // lo hace pasar
		Hisopado(idP);
		V(espera[idP]); // le permite retirarse.
	}
}
```

#### b) Modifique la solución anterior para que sólo haya procesos Pasajeros y Enfermera, siendo los pasajeros quienes determinan por su cuenta qué puesto tiene menos personas esperando.
```C
sem mutex = 1;
sem[150] espera = ([150] 0);
sem[3] mutexQPuesto = ([3] 1);
sem[3] esperandoHisopado = ([3] 0);

cola[3] qsPuesto;
bool libre = true;
cola qP;

process Pasajero[id 0..149]
{
	int puesto; int min = 99999;
	int sig; int cant;
	
	P(mutex);
	if (not libre)
	{
		qP.push(id);
		V(mutex);
		P(espera[id]);
	}
	else
	{
		libre = false;
		V(mutex);
	}
	
	// saca el puesto con menos gente
	for int i in 0..2
	{
		P(mutexQPuesto[i]);
		cant = qsPuestos[i].size();
		V(mutexQPuesto[i]);
		if (cant < min)
		{
			min = cant;
			puesto = i;
		}
	}
	
	P(mutexQPuesto[puesto]);
	qsPuestos[puesto].push(id);
	V(mutexQPuesto[puesto]);
	
	P(mutex);
	if (not qP.IsEmpty())
	{
		qP.pop(sig);
		V(espera[sig]);
	}
	else
		libre = true;
	V(mutex);
	
	V(esperandoHisopado[puesto]);
	P(espera[id]);
	// se hace el hisopado
	P(espera[id]);
}

process Enfermera[id 0..2]
{
	int idP;
	
	while(true)
	{
		P(esperandoHisopado[id]);
		
		P(mutexQPuesto[id]);
		qsPuestos.pop(idP);
		V(mutexQPuesto[id]);
		
		V(espera[idP]); // lo hace pasar
		Hisopado(idP);
		V(espera[idP]); // le permite retirarse.
	}
}
```