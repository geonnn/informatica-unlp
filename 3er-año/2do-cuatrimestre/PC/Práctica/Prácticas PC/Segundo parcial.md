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