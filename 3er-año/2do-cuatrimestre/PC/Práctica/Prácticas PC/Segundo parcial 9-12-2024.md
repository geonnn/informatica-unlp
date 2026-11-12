# PMS
Existe un médico que debe auditar los estudios médicos de 15 pacientes que tienen un turno asignado con él. Los pacientes son atendidos de a uno por vez (nunca hay dos pacientes al mismo tiempo en el consultorio) y el orden de atención lo define su ID (1..15). El proceso de atención consiste en que el paciente entrega el estudio y el médico le responde con el resultado luego de revisarlo. Implemente un programa que permita resolver el problema anterior usando PMS. Notas: la función obtenerEstudio() retorna el estudio a revisar para el paciente que la invoca; la función revisarEstudio(estudio) retorna el resultado de revisar el estudio recibido como entrada.
```csharp
Process Médico
{
	Estudio e;
	string res;
	
	for i in 1..15
	{
		Paciente[i]?Atención(e);
		res = Revisar(e);
		Paciente[i]!Resultado(res);
	}
}

Process Paciente[id 1..15]
{
	string res;
	Estudio e = ObtenerEstudio();
	
	Médico!Atención(e);
	Médico?Resultado(res);
}
```
# Ada
La UNLP está organizando su maratón anual y P personas que deben pasar a retirar su remera y chip antes de la carrera. Para ello, los corredores deben dirigirse al edificio de Rectorado, donde habrá un organizador que los atenderá. Los corredores son atendidos de acuerdo con el orden de llegada, teniendo prioridad los corredores ancianos sobre los jóvenes y adultos. Adicionalmente, los corredores con discapacidad tienen prioridad sobre todos los anteriores. Para ser atendidos, los corredores entregan su DNI al organizador, quien como respuesta les entrega la remera oficial y el chip asociado. Implemente un programa que permita resolver el problema anterior usando ADA.
Notas: para conocer su prioridad, cada corredor puede llamar a la función obtenerPrioridad(), la cual retorna 0 si la persona tiene alguna discapacidad, 1 si es anciana, o 2 en otro caso; las funciones obtenerRemera(dni) y obtenerChip(dni) retornan la remera y el chip asociado para el DNI recibido como entrada, respectivamente; la función obtenerDNI() retorna el DNI para el corredor que la invoca; todas las tareas deben terminar.
```vhdl
PROCEDURE maratón IS
	
	TASK Organizador IS
		ENTRY PrioridadDiscapacidad(dni: IN string; c: OUT Chip; r: OUT Remera);
		ENTRY PrioridadAnciana(dni: IN string; c: OUT Chip; r: OUT Remera);
		ENTRY NoPrioridad(dni: IN string; c: OUT Chip; r: OUT Remera);
	END Organizador;
	
	TASK TYPE Persona;
	
	TASK BODY Organizador IS
	BEGIN
		for i in 1..P loop
			SELECT
				ACCEPT PrioridadDiscapacidad(dni: IN string; c: OUT Chip; r: OUT Remera) do
					r := ObtenerRemera(dni);
					c := ObtenerChip(dni);
				end PrioridadDiscapacidad;
			OR
				WHEN (PrioridadDiscapacidad'count = 0) =>
				ACCEPT PrioridadAnciana(dni: IN string; c: OUT Chip; r: OUT Remera) do
					r := ObtenerRemera(dni);
					c := ObtenerChip(dni);
				end PrioridadAnciana;
			OR
				WHEN (PrioridadDiscapacidad'count = 0 AND PrioridadAnciana'count = 0) =>
				ACCEPT NoPrioridad(dni: IN string; c: OUT Chip; r: OUT Remera) do
					r := ObtenerRemera(dni);
					c := ObtenerChip(dni);
				end NoPrioridad;
			END SELECT;
		end loop;
	END Organizador;
	
	TASK BODY Persona
		prioridad: integer;
		dni: string;
		chip: Chip;
		remera: Remera;
	BEGIN
		dni := ObtenerDNI;
		prioridad := ObtenerPrioridad;
		
		if (prioridad = 0) then
			Organizador.PrioridadDiscapacidad(dni, chip, remera);
		else if (prioridad = 1) then
			Organizador.PrioridadAnciana(dni, chip, remera);
		else
			Organizador.NoPrioridad(dni, chip, remera);
		
	END Persona;
	
	arrPersonas: ARRAY(1..P) OF Persona;
	
BEGIN
	null;
END maratón;
```