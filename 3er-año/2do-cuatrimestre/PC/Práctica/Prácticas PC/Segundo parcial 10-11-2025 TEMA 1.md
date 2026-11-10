# 1. PMA
En un estadio de fútbol se dará un recital al que asistirán P personas. Para ello, cada asistente debe retirar su entrada por alguna de las 3 boleterías del estadio presentando su DNI (cada persona retira una única entrada). Los asistentes son atendidos por orden de llegada por alguno de los 3 empleados del club (cada empleado atiende una boletería). Implemente una solución usando **PMA**, considerando que los empleados atienden infinitamente.
**Notas:** maximizar la concurrencia. La función obtenerEntrada(dni) le retorna al empleado la entrada para el DNI provisto por argumento; la función obtenerDNI() retorna el DNI para la persona que la invoca.
```csharp
chan comprarEntrada(int, string);
chan[3] siguienteDNI(int, string);
chan boleteríaLibre(int);
chan[P] entrada(Entrada);

Process Boletería[id 0..2]
{
	int idP;
	string dni;
	Entrada e;
	
	while (true)
	{
		send boleteríaLibre(id);
		
		receive siguienteDNI[id](idP, dni);
		e = obtenerEntrada(dni);
		send entrada[idP](e);
	}
}

Process Coordinador
{
	int idP;
	string dni;
	int idB;
	
	while (true)
	{	
		receive comprarEntrada(idP, dni);
		receive boleteríaLibre(idB);
		
		send siguienteDNI[idB](idP, dni);
	}
}

Process Persona[id 0..P-1]
{	
	Entrada entrada;
	string dni = obtenerDNI();
	
	send comprarEntrada(id, dni);
	receive entrada[idP](entrada);
}
```
---
# 2. PMS
En un gimnasio hay una bicicleta de alta gama (que sólo puede ser usada por una persona a la vez) y un entrenador que controla su uso. También hay P deportistas que deben usar la bicicleta una única vez. Implemente una solución usando PMS considerando que el entrenador da acceso según el orden de llegada.
```csharp
Process Entrenador
{
	int idP;
	
	while (true)
	{
		Coordinador!BiciLibre();
		Coordinador?SigDeportista(idP);
		Deportista[idP]!AccederABicicleta();
		Deportista[*]?LiberarBicicleta();
	}
}

Process Coordinador
{
	cola q;

	do Deportista[*]?PedirBicicleta(id) ->
		q.Push(id);
	[] !q.IsEmpty(); Entrenador?BiciLibre() ->
	{
		q.Pop(id);
		Entrenador!SigDeportista(id);
	}
}

Process Deportista[id 0..P-1]
{
	Coordinador!PedirBicicleta(id);
	Entrenador?AccederABicicleta();
	// usa la bicicleta
	Entrenador!LiberarBicicleta();
}
```
**otra solución sin coordinador:**
```csharp
Process Entrenador
{
	int id;
	bool libre = true;
	
	do Deportista[*]?PedirBicicleta(id) ->
	{
		if (libre)
		{
			Deportista[id]!AccesoBicicleta();
			libre = false;
		}
		else
			q.Push(id);
	}
	[] Deportista[*]?LiberarBicicleta() ->
	{
		if (!q.IsEmpty())
		{
			q.Pop(id);
			Deportista[id]!AccesoBicicleta();
		}
		else
			libre = true;
	}
}

Process Deportista[id 0..P-1]
{
	Entrenador!PedirBicicleta(id);
	Entrenador?AccesoBicicleta();
	// usa la bici
	Entrenador!LiberarBicicleta();
}
```
---
# 3. Ada
Implemente una solución para el siguiente problema usando ADA. En la farmacia de un hospital hay una única ventanilla para dispensar medicamentos. Los pacientes internados deben retirar sus medicamentos presentando una receta (un único retiro por persona). Los pacientes son atendidos en el orden de llegada, pero con prioridad de atención: los pacientes de urgencia tienen prioridad sobre los de internación general, y ambos tienen prioridad sobre los pacientes ambulatorios. Cada paciente entrega su receta y recibe la medicación correspondiente.
Notas: la función obtenerPrioridad() le permite al paciente conocer su prioridad (retorna 0 si el paciente es de urgencia, 1 si es internado general, o 2 si es ambulatorio). La función obtenerReceta() retorna la receta para el paciente que la invoca mientras que dispensarMedicamento(receta) le retorna al empleado el medicamento para la receta indicada. El empleado atiende de a un paciente por vez, según la prioridad indicada. Todas las tareas deben finalizar.
```Ada
PROCEDURE ej3 IS
	
	TASK Farmacia IS
		ENTRY RetirarMedicamentoUrgencia(r: IN string; m: OUT Medicamento);
		ENTRY RetirarMedicamentoInternado(r: IN string; m: OUT Medicamento);
		ENTRY RetirarMedicamentoAmbulatorio(r: IN string; m: OUT Medicamento);
	END Farmacia;
	
	TASK TYPE Paciente;
	
	TASK BODY Farmacia IS
	BEGIN
		for i in 1..P loop
			SELECT
				ACCEPT RetirarMedicamentoUrgencia(r: IN string; m: OUT Medicamento) do
					m := dispensarMedicamento(r);
				END RetirarMedicamentoUrgencia;
			OR
				WHEN (RetirarMedicamentoUrgencia'count = 0) =>
				ACCEPT RetirarMedicamentoInternado(r: IN string; m: OUT Medicamento) do
					m := dispensarMedicamento(r);
				END RetirarMedicamentoInternado;
			OR
				WHEN (RetirarMedicamentoUrgencia'count = 0 AND RetirarMedicamentoInternado'count = 0) =>
				ACCEPT RetirarMedicamentoAmbulatorio(r: IN string; m: OUT Medicamento) do
					m := dispensarMedicamento(r);
				END RetirarMedicamentoAmbulatorio;
			END SELECT;
		end loop;
	END Farmacia;
	
	TASK BODY Paciente IS
		prioridad: integer;
		receta: string;
		medicamento: Medicamento;
	BEGIN
		prioridad := obtenerPrioridad;
		receta := obtenerReceta;
		
		if (prioridad = 0) then
			Farmacia.RetirarMedicamentoUrgencia(receta, medicamento);
		else if (prioridad = 1)
			Farmacia.RetirarMedicamentoInternado(receta, medicamento);
		else
			Farmacia.RetirarMedicamentoAmbulatorio(receta, medicamento);
		end if;
	END Paciente;
	
	arrPacientes: ARRAY(1..P) OF Paciente;

BEGIN
	null;
END ej3;
```