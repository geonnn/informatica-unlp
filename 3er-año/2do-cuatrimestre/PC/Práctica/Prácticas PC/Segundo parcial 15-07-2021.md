# 1. PMS
Resolver el siguiente problema con Pasaje de Mensajes Sincrónicos (PMS). En una excursión hay una tirolesa que debe ser usada por 20 turistas. Para esto hay un guía y un empleado. El empleado espera a que todos los turistas hayan llegado para darles una charla explicando las medidas de seguridad. Cuando termina la charla los turistas piden usar la tirolesa y esperan a que el guía les vaya dando el permiso de tirarse. El guía deja usar la tirolesa a un cliente a la vez y de acuerdo al orden en que lo van solicitando.
Nota: todos los procesos deben terminar; suponga que el empleado tienen una función DarCharla() que simula que el empleado está dando la charla, y los turistas tienen una función UsarTirolesa() que simula que está usando la tirolesa.
```csharp
Process Empleado
{
	for int i = 1..20
		Turista?[*]Llegada();
	
	DarCharla();
	
	for int i = 1..20
		Turista?[*]FinCharla();
}

Process Guía
{
	int idT;
	cola q;
	bool libre = true;
	
	for int i = 1..40
	{
		if Turista[*]PedirTirolesa(idT) ->
		{
			if (libre)
			{
				Turista[idT]!AccesoTirolesa();
				libre = false;
			}
			else
				q.Push(idT);
				
		}
		[] Turista[*]LiberarTirolesa() ->
		{
			if (!q.IsEmpty())
			{
				q.Pop(idT);
				Turista[idT]!AccesoTirolesa();
			}
			else
				libre = true;
		}
		end if;
	}
}

Process Turista[id 0..19]
{
	
	Empleado!Llegada();
	Empleado!FinCharla();
	
	
	Guía!PedirTirolesa(id);
	Guía?AccesoTirolesa();
	UsarTirolesa();
	Guía!LiberarTirolesa();
}
```
# Ada
Resolver el siguiente problema con ADA. En un negocio hay un empleado para atender los pedidos de clientes de N clientes; algunos clientes son ancianos o embarazadas. El empleado atiende los pedidos de acuerdo a la siguiente prioridad: primero las embarazadas, luego los ancianos, y por último el resto. Cada cliente hace sólo un pedido de la siguiente manera: en el caso de las embarazadas, si no son atendidas inmediatamente se retiran; en el caso de los ancianos, esperan a los sumo 5 minutos a ser atendidos, y si no se retira; cualquier otro cliente espera si o si hasta ser atendido. El empleado atiende a los clientes de acuerdo al orden de llegada pero manteniendo las siguientes prioridades: primero las embarazadas, luego los ancianos y luego el resto. Nota: suponga que existe una función AtenderPedido() que simula que el empleado está atendiendo a un cliente.