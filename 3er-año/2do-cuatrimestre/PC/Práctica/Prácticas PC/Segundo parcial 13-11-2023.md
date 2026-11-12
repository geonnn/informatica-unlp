# 1. PMA
En una oficina existen 100 empleados que envían documentos para imprimir en 5 impresoras compartidas. Los pedidos de impresión son procesados por orden de llegada y se asignan a la primera impresora que se encuentre libre. Implemente un programa que permita resolver el problema anterior usando PASAJE DE MENSAJES ASINCRÓNICO (PMA).
```csharp
chan ColaImpresión(string);

Process Impresora[id 1..5]
{
	string doc;
	
	while (true)
	{
		receive ColaImpresión(doc);
		Imprimir(doc);
	}
}

Process Empleado[id 1..100]
{
	string doc;
	
	while (true)
	{
		doc = GenerarDocumento();
		send ColaImpresión(doc);
	}
}
```
---
# 2. PMS
Resuelva el mismo problema anterior pero ahora usando PASAJE DE MENSAJES SINCRÓNICO (PMS).
```csharp
Process Impresora[id 1..5]
{
	while (true)
	{
		Coordinador!ImpresoraLibre(id);
		Coordinador?SigDoc(doc);
		Imprimir(doc);
	}
}

Process Coordinador
{
	string doc;
	cola q;
	int idI;
	
	do Empleado[*]?Imprimir(doc) ->
		q.Push(doc);
		
	[] !q.IsEmpty(); Impresora[*]?ImpresoraLibre(idI) ->
	{
		q.Pop(doc);
		Impresora[idI]!SigDoc(doc);
	}
	end do;
}

Process Empleado[id 1..100]
{
	string doc;
	
	while (true)
	{
		doc = GenerarDocumento();
		Coordinador!Imprimir(doc);
	}
}
```
---
# 3. Ada
Resuelva con ADA el siguiente problema: la página web del Banco Central exhibe las diferentes cotizaciones del dólar oficial de 20 bancos del país, tanto para la compra como para la venta. Existe una tarea programada que se ocupa de actualizar la página en forma periódica y para ello consulta la cotización de cada uno de los 20 bancos. Cada banco dispone de una API, cuya única función es procesar las solicitudes de aplicaciones externas. La tarea programada consulta de a una API por vez, esperando a lo sumo 5 segundos por su respuesta. Si pasado ese tiempo no respondió, entonces se mostrará vacía la información de ese banco.
```vhdl
PROCEDURE BancoCentral IS
	
	TASK Actualizador;
	
	TASK TYPE Banco IS
		ENTRY Consulta(compra: IN real; venta: IN real);
	END Banco;
	
	TASK BODY Actualizador IS
		arrValores: ARRAY(1..20) OF (c: real; v: real);
		compra: real;
		venta: real;
	BEGIN
		loop
			for i in 1..20 loop
				SELECT
					Banco(i).Consulta(compra, venta);
					arrValores(i) := (compra, venta);
				OR DELAY 5.0;
					arrValores(i) := (null, null); -- info vacía.
				END SELECT;
			end loop;
		end loop;
	END Actualizador;
	
	TASK BODY Banco IS
		c: real;
		v: real;
		id: integer;
	BEGIN
		loop
		
			c := ObtenerValorCompra;
			v := ObtenerValorVenta;
			
			ACCEPT Consulta(compra: IN real; venta: IN real) do
				compra := c;
				venta := v;
			END Consulta;
			
		end loop;
	END Banco;
	
	arrBancos: ARRAY(1..20) OF Banco;
	
BEGIN
	null;
END BancoCentral;
```