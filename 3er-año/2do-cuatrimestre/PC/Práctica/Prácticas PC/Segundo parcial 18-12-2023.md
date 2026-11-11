# PMA
Resolver con PASAJE DE MENSAJES ASINCRÓNICO (PMA) el siguiente problema. En un negocio de cobros digitales hay P personas que deben pasar por la única caja de cobros para realizar el pago de sus boletas. Las personas son atendidas de acuerdo con el orden de llegada teniendo prioridad aquellos que deben pagar menos de 5 boletas de los que pagan mas. Adicionalmente, las personas embarazadas tienen prioridad sobre los dos casos anteriores. Las personas entregan sus boletas al cajero y el dinero de pago; el cajero les devuelve el vuelto y los recibos de pago.
```csharp
chan PagoSinPrioridad(int id, Boletas[] boletas, float dinero);
chan PagoEmbarazada(int id, Boletas[] boletas, float dinero);
chan PagoMenosDeCinco(int id, Boletas[] boletas, float dinero);

chan[P] VueltoYRecibo(float, Recibo);

Process Caja
{
	int idP;
	Boletas[] boletas;
	float dinero;
	
	Recibo recibo;
	float vuelto;
	
	while (true)
	{
		receive aviso();
		
		if (not empty(PagoEmbarazada))
			receive PagoEmbarazada(idP, boletas, dinero);
		else if (not empty(PagoMenosDeCinco))
			receive PagoMenosDeCinco(idP, boletas, dinero);
		else
			receive PagoSinPrioridad(idP, boletas, dinero);
			
		ProcesarPago(boletas, dinero, vuelto, recibo);
		send VueltoYRecibo[id](vuelto, recibo);
	}
}

Process Persona[id 0..P-1]
{
	bool embarazada;
	Boletas[] boletas;
	float dinero;
	
	float vuelto;
	Recibo recibo;
	
	if (embarazada)
		send PagoEmbarazada(id, boletas, dinero);
	else if (boletas.size() < 5)
		send PagoMenosDeCinco(id, boletas, dinero);
	else
		send PagoSinPrioridad(id, boletas, dinero);
	
	send aviso();
	
	receive VueltoYRecibo[id](vuelto, recibo);
}
```
# ADA
Resolver con ADA el siguiente problema. La oficina central de una empresa de venta de indumentaria debe calcular cuántas veces fue vendido cada uno de los articulos de su catálogo. La empresa se compone de 100 sucursales y cada una de ellas maneja su propia base de datos de ventas. La oficina central cuenta con una herramienta que funciona de la siguiente manera: ante la consulta realizada para un artículo determinado, la herramienta envía el identificador del artículo a cada una de las sucursales, para que cada uno de éstas calcule cuántas veces fue vendido en ella. Al final del procesamiento, la herramienta debe conocer cuántas veces fue vendido en total, considerando todas las sucursales. Cuando ha terminado de procesar un artículo comienza con el siguiente (suponga que la herramienta tiene una función generarArtículo que retorna el siguiente ID a consultar).
Nota: maximizar la concurrencia. Supongo que existe una función ObtenerVentas(ID) que retorna la cantidad de veces que fue vendido el artículo con identificador ID en la base de datos de la sucursal que la llama.
```vhdl
PROCEDURE Ada IS
	
	TASK TYPE Central IS
		ENTRY SigArticulo(a: OUT integer);
		ENTRY CantVentas(v: IN integer);
		ENTRY Barrera;
	END Central;
	
	TASK TYPE Sucursal IS
	END Sucursal;
	
	TASK BODY Central IS
		art: integer;
		ventasArt := integer;
	BEGIN
		loop
			art := generarArtículo;
			ventasArt := 0;
			for i in 1..200
				SELECT
					ACCEPT SigArticulo(a: OUT integer) do
						a := art;
					END SigArticulo;
				OR
					ACCEPT CantVentas(v: IN integer) do
						ventasArt := ventasArt + v;
					END CantVentas;
				END SELECT;
			end loop;
			
			for i in 1..100
				ACCEPT Barrera;
			end loop;
			
		end loop;
	END Central;
	
	TASK BODY Sucursal IS
		art: integer;
		ventasArt: integer;
	BEGIN
		loop
			Central.SigArticulo(art);
			ventasArt := ObtenerVentas(art);
			Central.CantVentas(ventasArt);
			
			Central.Barrera;
		end loop;
	END Sucursal;

	arrSucursales: ARRAY(1..100) OF Sucursal;
	
BEGIN
	null;
END Ada;
```
