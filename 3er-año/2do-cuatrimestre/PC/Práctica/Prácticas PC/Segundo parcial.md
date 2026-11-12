# PMS
Resolver con Pasaje de Mensajes Sincrónicos (PMS) el siguiente problema. En un torneo de programación hay 1 organizador, N competidores y S supervisores. El organizador comunica el desafío a resolver a cada competidor. Cuando un competidor cuenta con el desafío a resolver, lo hace y lo entrega para ser evaluado. A continuación, espera a que alguno de los supervisores lo corrija y le indique si está bien. En caso de tener errores, el competidor debe corregirlo y volver a entregar, repitiendo la misma metodología hasta que llegue a la solución esperada. Los supervisores corrigen las entregas respetando el orden en que los competidores van entregando.
Nota: maximizar la concurrencia y no generar demora innecesaria.
```csharp
Process Supervisor[id 0..S-1]
{
	int idC;
	string resol;
	bool result;
	
	while (true)
	{
		Organizador!libre(id);
		Organizador?sig(idC, resol);
		result = Corregir(resol);
		Competidor[idC]resultado(result);
	}
}

Process Organizador
{
	int idC;
	int idS;
	string resol;
	cola q;
	
	string e = GenerarEnunciado();
	
	do Competidor[*]?pedirEnunciado(idC) ->
		Competidor[idC]!enunciado(e);
	[] Competidor[*]?resolucion(idC, resol) ->
		q.Push(idC, resol);
	[] !q.IsEmpty(); Supervisor[*]?libre(idS) ->
	{
		q.Pop(idC, resol);
		Supervisor[idS]!sig(idC, resol);
	}
	end do;
}

Process Competidor[id 0..N-1]
{
	string e;
	string resol;
	bool ok = false;
	
	Organizador!pedirEnunciado(id);
	Organizador?enunciado(e);
	
	resol = ResolverDesafío(e);
	
	while (!ok)
	{
		Organizador!resolucion(id, resol);
		Supervisor[*]?resultado(ok);
		if (!ok)
			resol = Corregir(resol);
	}
}
```
---
# Ada
Resolver con ADA el siguiente problema. Una empresa de venta de calzado cuenta con S sedes. En la oficina central de la empresa se utiliza un sistema que permite controlar el stock de los diferentes modelos, ya que cada sede tiene una base de datos propia. El sistema de control de stock funciona de la siguiente manera: dado un modelo determinado, lo envía a las sedes para que cada una le devuelva la cantidad disponible en ellas; al final del procesamiento, el sistema informa el total de calzados disponibles de dicho modelo. Una vez que se completó el procesamiento de un modelo, se procede a realizar lo mismo con el siguiente modelo.
Nota: suponga que existe una función DevolverStock(modelo,cantidad) que utiliza cada sede donde recibe como parámetro de entrada el modelo de calzado y retorna como parámetro de salida la cantidad de pares disponibles. Maximizar la concurrencia y no generar demora innecesaria.
```vhdl
PROCEDURE empresa IS
	
	TASK Central IS
		ENTRY ModeloABuscar(m: OUT integer);
		ENTRY Resultado(cant: IN integer);
		ENTRY Barrera;
	END Central;
	
	TASK TYPE Sede;
	
	TASK BODY Central IS
		modelo: integer;
		total: integer;
	BEGIN
		loop
			modelo := ObtenerModelo;
			total := 0;
			
			for i in 1..(S*2) loop
				SELECT
					ACCEPT ModeloABuscar(m: OUT integer) do
						m := modelo;
					END ModeloABuscar;
				OR
					ACCEPT Resultado(cant: IN integer) do
						total := total + cant;
					END Resultado;
				END SELECT;
			end loop;
			
			print(f"se vendieron {total} productos del modelo {modelo}.");
			
			for i in 1..S loop
				ACCEPT Barrera;
			end loop;
			
		end loop;
	END Central;
	
	TASK BODY Sede IS
		modelo: integer;
		cant: integer;
	BEGIN
		loop
			Central.ModeloABuscar(modelo);
			DevolverStock(modelo, cant);
			Central.Resultado(cant);
			Central.Barrera;
		end loop;
	END Sede;
	
	arrSedes: ARRAY(1..S) OF Sede;
	
BEGIN
	null;
END empresa;
```
---
# Ada
Resolver el siguiente problema con ADA. Hay un sitio web para identificación genética que resuelve pedidos de N clientes. Cada cliente trabaja continuamente de la siguiente manera: genera la secuencia de ADN, la envía al sitio web para evaluar y espera el resultado; después de esto puede comenzar a generar la siguiente secuencia de ADN. Para resolver estos pedidos el sitio web cuenta con 5 servidores idénticos que atienden los pedidos de acuerdo al orden de llegada (cada pedido es atendido por un único servidor).
Nota: maximizar la concurrencia. Suponga que los servidores tienen una función ResolverAnálisis() que recibe la secuencia de ADN y devuelve un entero con el resultado.
```vhdl
PROCEDURE EjAda IS
	
	TASK TYPE Servidor;
	
	TASK Admin IS
		ENTRY Secuencia(idC: IN integer; sec: IN SecuenciaADN);
		ENTRY PedidoServidor(idCl: OUT integer; secu: OUT SecuenciaADN);
	END Admin;
	
	TASK TYPE Cliente IS
		ENTRY Identificar(idC: IN integer);
		ENTRY Resultado(res: IN integer);
	END Cliente;
	
	TASK BODY Servidor IS
		idC: integer;
		sec: SecuenciaADN;
		res: integer;
	BEGIN
		loop
			Admin.PedidoServidor(idC, sec);
			res := ResolverAnálisis(sec);
			Cliente(idC).Resultado(res);
		end loop;
	END Servidor;
	
	TASK BODY Admin IS
	BEGIN
		loop
			ACCEPT Secuencia(idC: IN integer; sec: IN SecuenciaADN) do
				ACCEPT PedidoServidor(idCl: OUT integer; secu: OUT integer) do
					secu := sec;
					idCl := idC;
				END PedidoServidor;
			END Secuencia;
		end loop;
	END Admin;
	
	TASK BODY Cliente IS
		id: integer
		sec: SecuenciaADN;
		result: integer;
	BEGIN
		ACCEPT Identificar(idC: IN integer) do
			id := idC;
		END Identificar;
		
		loop
			sec := GenerarSecuenciaADN;
			Admin.Secuencia(id, sec);
			ACCEPT Resultado(res: OUT integer) do
				result := res;
			END Resultado;
		end loop;
	END Cliente;
	
	arrServidor: ARRAY(1..5) OF Servidor;
	arrClientes: ARRAY(1..N) OF Cliente;
	
BEGIN
	for i in 1..N loop
		Cliente(i).Identificar(i);
	end loop;
END EjAda;
```