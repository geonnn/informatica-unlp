# 1. PMA
Resolver con PMA el siguiente problema. Para una aplicación de venta de pasaje se tienen 3 servidores replicados para mejorar la eficiencia en la atención. Existen N clientes que hacen alguna de estas dos solicitudes: compra de un pasaje o devolución de un pasaje. Las solicitudes se deben atender dando prioridad a las solicitudes de compra.
Nota: suponga que cada cliente llama a la función TipoSolicitud() que le devuelve el tipo de solicitud a realizar. Maximizar la concurrencia.
```csharp
chan aviso();
chan comprarPasaje(int);
chan devolverPasaje(int);
chan[N] result();
chan[3] sigSolicitud(int);

Process Servidor[id 0..2]
{
	int idC;
	Result r;
	
	while (true)
	{
		send servidorLibre(id);
		receive sigSolicitud(idC);
		r = ProcesarSolicitud()
		send result[idC](r);
	}
}

Process Coordinador
{
	int idS;
	int idC;
	
	while(true)
	{
		receive aviso();
		
		if (!empty(comprarPasaje))
			receive comprarPasaje(idC);
		else
			receive devolverPasaje(idC);
			
		receive servidorLibre(idS);
		send sigSolicitud[idS](idC);
	}
}

Process Cliente[id 0..N-1]
{
	Pasaje p;
	string solicitud = TipoSolicitud();
	
	if (solicitud == "compra")
		send comprarPasaje(id);
	else
		send devolverPasaje(id);
	
	send aviso();
	
	receive result[id]();
}
```

---
# 2. PMS
Resolver con Pasaje de Mensajes Sincrónicos (PMS) el siguiente problema. En un comedor estudiantil hay un horno microondas que debe ser usado por E estudiantes de acuerdo con el orden de llegada. Cuando el estudiante accede al horno, lo usa y luego se retira para dejar al siguiente. Nota: cada Estudiante una sólo una vez el horno.
```csharp
Process Admin
{
	int idE;
	cola q;
	bool libre = true;
	
	do Estudiante[*]?pedirMicroondas ->
	{
		if (libre)
		{
			Estudiante!accesoMicroondas(idE);
			libre = false
		}
		else
			q.Push(id)
	}
	[] Estudiante[*]?liberarMicroondas ->
	{
		if (!q.IsEmpty())
		{
			q.Pop(idE);
			Estudiante[idE]!accesoMicroondas();
		}
		else
			libre = true;
	}
}

Process Estudiante[id 0..E-1]
{
	Admin!pedirMicroondas(id);
	Admin?accesoMicroondas();
	// usar microondas
	Admin!liberarMicroondas();
}
```
---
# 3. Ada
Resolver con ADA el siguiente problema. Se debe controlar el acceso a una base de datos. Existen L procesos Lectores y E procesos Escritores que trabajan indefinidamente de la siguiente manera:
- Escritor: intenta acceder para escribir, si no lo logra inmediatamente, espera 1 minuto y vuelve a intentarlo de la misma manera.
- Lector: intenta acceder para leer, si no lo logro en 2 minutos, espera 5 minutos y vuelve a intentarlo de la misma manera.
Un proceso Escritor podrá acceder si no hay ningún otro proceso usando la base de datos; al acceder escribe y sale de la BD. Un proceso Lector podrá acceder si no hay procesos Escritores usando la base de datos; al acceder lee y sale de la BD. Siempre se le debe dar prioridad al pedido de acceso para escribir sobre el pedido de acceso para leer.
```vhdl
PROCEDURE bd IS
	
	TASK Admin IS
		ENTRY Leer;
		ENTRY Escribir;
		ENTRY SalidaLector;
		ENTRY SalidaEscritor;
	END Admin;
	
	TASK TYPE Escritor IS
	END Escritor;
	
	TASK TYPE Lector IS
	END Lector;
	
	TASK BODY Admin IS
		hayEscritor: boolean;
		lectores: integer;
	BEGIN
		hayEscritor := false;
		lectores := 0;
		
		loop
			SELECT
				WHEN (not hayEscritor AND lectores == 0) =>
				ACCEPT Escribir;
				hayEscritor := true;
			OR
				WHEN (not hayEscritor AND Escribir'count == 0) =>
				ACCEPT Leer;
				lectores := lectores + 1;
			OR
				ACCEPT SalidaEscritor;
				hayEscritor := false;
			OR
				ACCEPT SalidaLector;
				lectores := lectores - 1;
			END SELECT;
		end loop;
	END Admin;
	
	TASK BODY Escritor IS
	BEGIN
		loop
			SELECT
				Admin.Escribir;
				-- escribe en la bd
				Admin.SalidaEscritor;
			OR ELSE
				DELAY 60.0;
			END SELECT;
		end loop;
	END Escritor;
	
	TASK TYPE Lector IS
	BEGIN
		loop
			SELECT
				Admin.Leer;
				-- lee en la bd.
				Admin.SalidaLector;
			OR DELAY 120.0
				DELAY 300.0
			END SELECT;
		end loop;
	END Lector;
	
	arrEscritor: ARRAY(1..E) OF Escritor;
	arrLector: ARRAY(1..L) OF Lector;
	
BEGIN
	null;
END bd;
```