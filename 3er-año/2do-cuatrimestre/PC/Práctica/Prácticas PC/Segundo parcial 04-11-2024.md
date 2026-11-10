  
# 1. PMA
Las unidades postales (UP) son sucursales de correo que se ocupan habitualmente de recibir y entregar paquetes. En particular, la UP 16 sólo se ocupa de entregar paquetes a las personas que se presentan a retirarlos. Los clientes son atendidos por orden de llegada por el primer empleado que se encuentre libre. Al solicitar atención, el cliente le muestra un código QR al empleado que lo atiende, el cual le entrega el paquete como respuesta. Implemente un programa que permita modelar el funcionamiento de la UP 16 usando PMA, asumiendo que hay N clientes que retiran un único paquete y 3 empleados para atenderlos. Además, asuma que no habrá códigos QR erróneos ni paquetes faltantes.
Notas: la función obtenerQR(idCliente) retorna el código QR asociado al identificador de cliente recibido como entrada. De forma similar, obtenerPaquete(qr) retorna el paquete asociado al QR recibido como entrada.
```csharp
chan llegada(int, QR);
chan[N] paquete(Paquete);

Process Empleado[id 0..2]
{
	int idC;
	QR qr;
	Paquete p;
	
	while (true)
	{
		receive llegada(idC, qr);
		p = obtenerPaquete(qr);
		send paquete[idC](p);
	}
}

Process Cliente[id 0..N-1]
{
	QR qr = obtenerQR(id);
	Paquete paq;
	
	send llegada(id, qr);
	receive paquete[id](paq);
}
```
---
# 2. PMS
Resolver lo mismo usando PMS.
```csharp
Process Empleado[id 0..2]
{
	int idC;
	QR qr;
	Paquete paq;
	
	while (true)
	{
		Coordinador!libre(id);
		Coordinador?sigCliente(idC);
		Cliente[idC]!atencion(id);
		Cliente[idC]?mostrarQR(qr);
		paq = obtenerPaquete(qr);
		Cliente[idC]!paquete(paq);
	}
}

Process Coordinador
{
	cola q;
	int idC;
	int idE;
	
	do Cliente[*]?llegada(idC) ->
		q.Push(idC);
	[] !q.IsEmpty(); Empleado[*]?libre(idE) ->
	{
		q.Pop(idC);
		Empleado[idE]!sigCliente(idC);
	}
	end do;
}

Process Cliente[id 0..N-1]
{
	QR qr = obtenerQR(id);
	Paquete paq;
	int idE;
	
	Coordinador!llegada(id);
	Empleado[*]?atencion(idE);
	Empleado[idE]!mostrarQR(qr);
	Empleado[idE]?paquete(paq);
}
```
---
# 3. Ada
El problema WordCount consiste en calcular la cantidad de veces que aparece una palabra determinada en una porción, documento o archivo de texto. Implemente una solución a WordCount en ADA, considerando que se cuenta con una base de datos de texto distribuida en N partes. Además, existe un administrador que determina la palabra que se desea buscar y se la envía a las N tareas contadoras para que la busquen en la parte de la base de texto que poseen. Finalmente, el administrador calcula la cantidad total de apariciones.
Notas: las tareas contadoras cuentan con la función contarPalabras (pal), la cual retorna la cantidad de veces que aparece la palabra pal en su parte de la base de datos. El administrador cuenta con la función obtenerPalabra() que retorna la palabra a buscar. El problema se resuelve una única vez y su solución debe maximizar la concurrencia.
```vhdl
PROCEDURE ej3 IS
	
	TASK Administrador IS
		ENTRY Comenzar(pal: OUT string);
		ENTRY Resultado(cant: IN integer);
	END Administrador;
	
	TASK TYPE Worker;
	
	TASK BODY Administrador IS
		palabra: string;
		count: integer;
	BEGIN
		palabra := obtenerPalabra;
		count := 0;
		
		for i in 1..(N*2) loop
			SELECT
				ACCEPT Comenzar(pal: OUT string) do
					pal := palabra
				END Comenzar;
			OR
				ACCEPT Resultado(cant: IN integer) do
					count := count + cant;
				END Resultado;
			END SELECT;
		end loop
	END Administrador;
	
	TASK BODY Worker IS
		pal: string;
		cant: integer;
	BEGIN
		Administrador.Comenzar(pal);
		cant := contarPalabras(pal);
		Administrador.Resultado(cant);
	END Worker;
	
	arrWorkers: ARRAY(1..N) OF Worker;
	
BEGIN
	null;
end ej3;
```