# 1. PMA
Resolver con PASAJE DE MENSAJES ASINCRÓNICOS (PMA) el siguiente problema. Hay E estudiantes que rinden un examen final y un profesor que cuando todos los estudiantes han llegado les entrega el enunciado. Luego el profesor va corrigiendo los exámenes y enviando la nota de acuerdo con orden en que se van entregando. Cada alumno realiza el examen, lo entrega y espera a que el profesor le indique la nota.
Nota: maximizar la concurrencia; no realizar busy waiting; todos los procesos deben terminar.
```csharp
chan llegada(string);
chan finExamen(int, string);
chan nota(int);
chan barrera();

Process Profesor
{
	string enunciado;
	int idE;
	string examen;
	int nota;
	
	for int i = 1..E
	{
		receive barrera();
	}
	
	for int i = 1..E
	{
		send recibirEnunciado(enunciado);
	}
	
	for int i = 1..E
	{
		receive(idE, examen);
		nota = Corregir(examen);
		send nota[idE](nota);
	}
	
}

Process Estudiante[id 0..E-1]
{
	string enunciado;
	string examen;
	int nota;
	
	send barrera();
	receive recibirEnunciado(enunciado);
	examen = ResolverExamen(enunciado);
	send finExamen(id, examen);
	receive nota[id](nota);
}
```
---
# 2. PMS
Resolver con PASAJE DE MENSAJES SINCRÓNICOS (PMS) el siguiente problema. En un consultorio hay un médico para atender a 15 pacientes de acuerdo con el orden de llegada. Cada paciente al llegar espera a que el médico lo atiende y le indique su tratamiento. Nota: existe la función atender() que simula que el médico está atendiendo a un paciente; todos los procesos deben terminar.
```csharp
Process Medico
{
	for int i = 1..15
	{
		Coordinador!libre();
		Coordinador?sigPaciente(idP);
		Paciente[idP]!atencion();
		atender(idP);
		Paciente[idP]!retirarse();
	}
}

Process Coordinador
{
	int idP;
	
	for int i = 1..30
	{
		if Paciente[*]?llegada(id) ->
			q.Push(idP);
		[] !q.IsEmpty(); Medico?libre() ->
		{			
			q.Pop(idP);
			Medico!sigPaciente(idP);
		}	
	}
}

Process Paciente[id 0..14]
{
	Coordinador!llegada(id);
	Medico?atencion()
	// lo atiende el médico.
	Medica?retirarse();
}
```
---
# 3. Ada
Resolver con ADA el siguiente problema. En una competencia de programadores hay P participantes y UN coordinador. El coordinador entrega el problema a resolver a los participantes y recibe las resoluciones para corregir. Cada participante debe conocer el resultado de su trabajo y el orden en que entregó su resolución.
Nota: maximizar la concurrencia.
```vhdl
PROCEDURE ej3 IS
	
	TASK Coordinador IS
		ENTRY Enunciado(e: OUT string);
		ENTRY Resolucion(r: IN string; orden OUT integer; result OUT integer);
	END Coordinador;
	
	TASK TYPE Participante;
	
	TASK BODY Coordinador IS
		enunciado: string := ObtenerEnunciado;
		count: integer := 1;
	BEGIN
		loop
			SELECT
				ACCEPT Enunciado(e: OUT string) do
					e := enunciado;
				end Enunciado;
			OR
				ACCEPT Resolucion(r: IN string; orden OUT integer; result OUT integer) do
					result := Corregir(r);
					orden := count;
				END Resolucion;
				count := count + 1;
		end loop;
	END Coordinador;
	
	TASK BODY Participante IS
		enunciado: string;
		resolucion: string;
		ord: integer;
		resultado: integer;
	BEGIN
		Coordinador.Enunciado(enunciado);
		resolucion := ResolverProblema(enunciado);
		Coordinador.Resolucion(resolucion, ord, resultado);
	END Participante;
	
	arrParticipantes: ARRAY(1..P) OF Participante;
BEGIN
	null;
END ej3;
```