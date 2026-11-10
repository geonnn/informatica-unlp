# CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS:
1. NO SE PUEDE USAR VARIABLES COMPARTIDAS
2. Declaración de tareas
	- Especificación de tareas sin ENTRY’s (nadie le puede hacer llamados).
		```ADA
		TASK Nombre;
		TASK TYPE Nombre;
		```
	- Especificación de tareas con ENTRY’s (le puede hacer llamados). Los entry’s funcionan de manera semejante los procedimientos: solo pueden recibir o enviar información por medio de los parámetros del entry. NO RETORNAN VALORES COMO LAS FUNCIONES.
		```ADA
		TASK TYPE Nombre IS
			ENTRY e1;
			ENTRY e2 (p1: IN integer; p2: OUT char; p3: IN OUT float);
		END Nombre;
		```
		
	- Cuerpo de las tareas:
		```ADA
		TASK BODY Nombre IS
			Codigo que realiza la Tarea;
		END Nombre;
		```
3. Sincronización y comunicación entre tareas
	- Entry call para enviar información (o avisar algún evento).
		`NombreTarea.NombreEntry (parametros);`
	- Accept para atender un pedido de entry call sin cuerpo (sólo para recibir el aviso de un evento para sincronización). Lo usual es que no incluya parámetros, aunque podría tenerlos. En ese caso, son ignorados por no tener cuerpo presente.
		```ADA
		ACCEPT NombreEntry;
		ACCEPT NombreEntry (p1: IN integer; p3: IN OUT float);
		```
	- Accept para atender un pedido de entry call con cuerpo.
		```ADA
		ACCEPT NombreEntry (p1: IN integer; p3: IN OUT float) do
			Cuerpo del accept donde se puede acceder a los parámetros p1 y p3.
			Fuera del entry estos parámetros no se pueden usar.
		END NombreEntry;
		```
	- El accept se puede hacer en el cuerpo de la tarea que ha declarado el entry en su especificación. Los entry call se pueden hacer en cualquier tarea o en el programa principal.

4. Select para ENTRY CALL.
	 - Select ...OR DELAY: espera a lo sumo x tiempo a que la tarea correspondiente haga el accept del entry call realizado. Si pasó el tiempo entonces realiza el código opcional.
		```ADA
		SELECT
			NombreTarea.NombreEntry(Parametros);
			Sentencias;
		OR DELAY x
			Código opcional;
		END SELECT;
		```
		
	 - Select ...ELSE: si la tarea correspondiente no puede realizar el accept inmediatamente (en el momento que el procesador está ejecutando esa línea de código) entonces se ejecuta el código opcional.
		```ADA
		SELECT
			NombreTarea.NombreEntry(Parametros);
			Sentencias;
		ELSE
			Código opcional;
		END SELECT;
		```
	- En los select para entry call sólo puede ponerse un entry call y una única opción (OR DELAY o ELSE);

5. Select para ACCEPT.
	- En los select para los accept puede haber más de una alternativa de accept, pero no puede haber alternativas de entry call (no se puede mezclar accept con entries). Cada alternativa de ACCEPT puede ser o no condicional (uso de cláusula WHEN).
		```ADA
		SELECT
			ACCEPT e1 (parámetros);
			Sentencias1;
		OR
			ACCEPT e2 (parámetros) IS cuerpo; END e2;
		OR
			WHEN (condición) => ACCEPT e3 (parámetros) IS cuerpo; END e3;
			Sentencias3
		END SELECT;
		```
***Funcionamiento:*** Se evalúa la condición booleana del WHEN de cada alternativa (si no lo tiene se considera TRUE). Si todas son FALSAS se sale del select. En otro caso, de las alternativas cuya condición es verdadera se elige en forma no determinística una que pueda ejecutarse inmediatamente (es decir que tiene un entry call pendiente). Si ninguna de ellas se puede ejecutar inmediatamente el select se bloquea hasta que haya un entry call para alguna alternativa cuya condición sea TRUE.
	- Se puede poner una opción OR DELAY o ELSE (no las dos a la vez).
	- Dentro de la condición booleana de una alternativa (en el WHEN) se puede preguntar por la cantidad de entry call pendientes de cualquier entry de la tarea.
		  `NombreEntry’count`
	- Después de escribir una condición por medio de un WHEN siempre se debe escribir un accept.

---

## Ejercicio 1
Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso. El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2 unidades y cada camión 3 unidades. Suponga que hay una cantidad innumerable de vehículos (A autos, B camionetas y C camiones). Analice el problema y defina qué tareas, recursos y sincronizaciones serán necesarios/convenientes para resolverlo.
### a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.
```ADA
PROCEDURE ej1 IS

	TASK Puente IS
		ENTRY PasarAuto;
		ENTRY PasarCamioneta;
		ENTRY PasarCamión;
		ENTRY Salida(pesoSalida: IN integer);
	END Puente;
	
	TASK TYPE Auto;
	TASK TYPE Camioneta;
	TASK TYPE Camión;
	
	arrAutos: ARRAY(1..A) OF Auto;
	arrCamionetas: ARRAY(1..B) OF Camioneta;
	arrCamiones: ARRAY(1..C) OF Camión;
	
	TASK BODY Puente IS
		pesoActual: integer;
		pesoMax: integer;
	BEGIN
		pesoActual := 0;
		pesoMax := 5;
		
		loop --while true
			
			SELECT
				WHEN (Salida'count = 0 AND pesoActual + 1 <= pesoMax) =>
				ACCEPT PasarAuto;
					pesoActual := pesoActual + 1;
			OR
				WHEN (Salida'count = 0 AND pesoActual + 2 <= pesoMax) =>
				ACCEPT PasarCamioneta;
					pesoActual := pesoActual + 2;
			OR
				WHEN (Salida'count = 0 AND pesoActual + 3 <= pesoMax) =>
				ACCEPT PasarCamión;
					pesoActual := pesoActual + 3;
			OR
				ACCEPT Salida(pesoSalida: IN integer) do
					pesoActual := pesoActual - pesoSalida;
					-- va en el cuerpo del accept.
					-- se usa el parámetro directamente 
				END Salida;
			END SELECT;
			
		end loop;
	END Puente;
	
	TASK BODY Auto IS
		peso: integer;
	BEGIN
		peso := 1;
		
		Puente.PasarAuto;
		-- pasa por el puente
		Puente.Salida(peso);
	END Auto;
	
	TASK BODY Camioneta IS
		peso: integer;
	BEGIN
		peso := 2;
		
		Puente.PasarCamioneta;
		-- pasa por el puente
		Puente.Salida(peso);
	END Camioneta;
	
	TASK BODY Camión IS
		peso: integer;
	BEGIN
		peso := 3;
		
		Puente.PasarCamión;
		-- pasa por el puente
		Puente.Salida(peso);
	END Camión;

BEGIN
	null;
END ej1;
```
### b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los vehículos.
```ADA
PROCEDURE ej1 IS

	TASK Puente IS
		ENTRY PasarAuto;
		ENTRY PasarCamioneta;
		ENTRY PasarCamión;
		ENTRY Salida(pesoSalida: IN integer);
	END Puente;
	
	TASK TYPE Auto;
	TASK TYPE Camioneta;
	TASK TYPE Camión;
	
	arrAutos: ARRAY(1..A) OF Auto;
	arrCamionetas: ARRAY(1..B) OF Camioneta;
	arrCamiones: ARRAY(1..C) OF Camión;
	
	TASK BODY Puente IS
		pesoActual: integer;
		pesoMax: integer;
	BEGIN
		pesoActual := 0;
		pesoMax := 5;
		
		loop --while true
			
			SELECT
				WHEN (Salida'count = 0 AND PasarCamión'count = 0 AND pesoActual + 1 <= pesoMax) =>
				ACCEPT PasarAuto;
					pesoActual := pesoActual + 1;
			OR
				WHEN (Salida'count = 0 AND PasarCamión'count = 0 AND pesoActual + 2 <= pesoMax) =>
				ACCEPT PasarCamioneta;
					pesoActual := pesoActual + 2;
			OR
				WHEN (Salida'count = 0 AND pesoActual + 3 <= pesoMax) =>
				ACCEPT PasarCamión;
					pesoActual := pesoActual + 3;
			OR
				ACCEPT Salida(pesoSalida: IN integer) do
					pesoActual := pesoActual - pesoSalida;
					-- va en el cuerpo del accept.
					-- se usa el parámetro directamente 
				END Salida;
			END SELECT;
			
		end loop;
	END Puente;
	
	TASK BODY Auto IS
		peso: integer;
	BEGIN
		peso := 1;
		
		Puente.PasarAuto;
		-- pasa por el puente
		Puente.Salida(peso);
	END Auto;
	
	TASK BODY Camioneta IS
		peso: integer;
	BEGIN
		peso := 2;
		
		Puente.PasarCamioneta;
		-- pasa por el puente
		Puente.Salida(peso);
	END Camioneta;
	
	TASK BODY Camión IS
		peso: integer;
	BEGIN
		peso := 3;
		
		Puente.PasarCamión;
		-- pasa por el puente
		Puente.Salida(peso);
	END Camión;

BEGIN
	null;
END ej1;
```
---
## Ejercicio 2
Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de acuerdo con el orden de llegada.
### a) Implemente una solución donde los clientes llegan y se retiran sólo después de haber sido atendidos.
```ADA
PROCEDURE ej2 IS

	TASK Empleado IS
		ENTRY RealizarPago(pago: IN Pago; comprobante: OUT Comprobante);
	END Empleado;
	
	TASK TYPE Cliente;
	
	arrClientes: ARRAY(1..C) OF Cliente;
	
	TASK BODY Empleado IS
	BEGIN
		loop
			ACCEPT RealizarPago(pago: IN Pago; comprobante: OUT Comprobante) do
				comprobante := GenerarComprobante(pago);
			END RealizarPago;
		end loop;
	END Empleado;

	TASK BODY Cliente IS
		pago: Pago;
		comprobante: Comprobante;
		
	BEGIN
		Empleado.RealizarPago(pago, comprobante);
	END Cliente;

BEGIN
	null;
END ej2;
```
### b) Implemente una solución donde los clientes se retiran si esperan más de 10 minutos para realizar el pago.
```ADA
PROCEDURE ej2 IS

	TASK Empleado IS
		ENTRY RealizarPago(pago: IN Pago; comprobante: OUT Comprobante);
	END Empleado;
	
	TASK TYPE Cliente;
	
	arrClientes: ARRAY(1..C) OF Cliente;
	
	TASK BODY Empleado IS
	BEGIN
		loop
			ACCEPT RealizarPago(pago: IN Pago; comprobante: OUT Comprobante) do
				comprobante := GenerarComprobante(pago);
			END RealizarPago;
		end loop;
	END Empleado;

	TASK BODY Cliente IS
		pago: Pago;
		comprobante: Comprobante;
		
	BEGIN
		SELECT
			Empleado.RealizarPago(pago, comprobante);
		OR DELAY 600
			null;
		END SELECT;
	END Cliente;

BEGIN
	null;
END ej2;
```
### c) Implemente una solución donde los clientes se retiran si no son atendidos inmediatamente.
```ADA
PROCEDURE ej2 IS

	TASK Empleado IS
		ENTRY RealizarPago(pago: IN Pago; comprobante: OUT Comprobante);
	END Empleado;
	
	TASK TYPE Cliente;
	
	arrClientes: ARRAY(1..C) OF Cliente;
	
	TASK BODY Empleado IS
	BEGIN
		loop
			ACCEPT RealizarPago(pago: IN Pago; comprobante: OUT Comprobante) do
				comprobante := GenerarComprobante(pago);
			END RealizarPago;
		end loop;
	END Empleado;

	TASK BODY Cliente IS
		pago: Pago;
		comprobante: Comprobante;
		
	BEGIN
		SELECT
			Empleado.RealizarPago(pago, comprobante);
		ELSE
			null;
		END SELECT;
	END Cliente;

BEGIN
	null;
END ej2;
```
### d) Implemente una solución donde los clientes esperan a lo sumo 10 minutos para ser atendidos. Si pasado ese lapso no fueron atendidos, entonces solicitan atención una vez más y se retiran si no son atendidos inmediatamente.
```ADA
PROCEDURE ej2 IS

	TASK Empleado IS
		ENTRY RealizarPago(pago: IN Pago; comprobante: OUT Comprobante);
	END Empleado;
	
	TASK TYPE Cliente;
	
	arrClientes: ARRAY(1..C) OF Cliente;
	
	TASK BODY Empleado IS
	BEGIN
		loop
			ACCEPT RealizarPago(pago: IN Pago; comprobante: OUT Comprobante) do
				comprobante := GenerarComprobante(pago);
			END RealizarPago;
		end loop;
	END Empleado;

	TASK BODY Cliente IS
		pago: Pago;
		comprobante: Comprobante;
		
	BEGIN
		SELECT
			Empleado.RealizarPago(pago, comprobante);
		OR DELAY 600
			SELECT
				Empleado.RealizarPago(pago, comprobante);
			ELSE
				null;
			END SELECT;
		END SELECT;
	END Cliente;

BEGIN
	null;
END ej2;
```

---
## Ejercicio 3
Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se comunican continuamente. Se requiere modelar su funcionamiento considerando las siguientes condiciones:
- La central siempre comienza su ejecución tomando una señal del proceso 1; luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
- Los procesos periféricos envían señales continuamente a la central. La señal del proceso 1 será considerada vieja (se desecha) si en 2 minutos no fue recibida. Si la señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y vuelve a mandarla (no se desecha).

```ADA
PROCEDURE ej3 IS
	
	TASK Central IS
		ENTRY SeñalProceso1(s: IN Señal);
		ENTRY SeñalProceso2(s: IN Señal);
		ENTRY FinTimer;
	END Central;
	
	TASK Timer IS
		ENTRY IniciarTimer;
	END Timer;
	
	TASK Proceso1;
	TASK Proceso2;
	
	TASK BODY Central IS
		fin: boolean;
	BEGIN
		ACCEPT SeñalProceso1(s: IN Señal);
		
		LOOP
			SELECT
				ACCEPT SeñalProceso1(s: IN Señal);
			OR
				ACCEPT SeñalProceso2(s: IN Señal);
				Timer.IniciarTimer;
				fin := false;
				WHILE (not fin) LOOP
					SELECT
						WHEN (FinTimer'count = 0) =>
						ACCEPT SeñalProceso2(s: IN Señal);
					OR
						ACCEPT FinTimer;
						fin := true;
					END SELECT;
				END LOOP;
			END	SELECT;
		END LOOP;
		
	END Central;
	
	TASK BODY Timer IS
	BEGIN
		LOOP
			ACCEPT IniciarTimer;
			DELAY 180.0;
			Central.FinTimer;
		END LOOP;
	END Timer;
	
	TASK BODY Proceso1 IS
		s: Señal;
	BEGIN
		LOOP
			s := GenerarSeñal;
			SELECT
				Central.SeñalProceso1(s);
			OR DELAY 120.0;
				null;
			END SELECT;
		END LOOP;
	END Proceso1;
	
	TASK BODY Proceso2 IS
		s: Señal;
		enviada: boolean;
	BEGIN
		LOOP
			s := GenerarSeñal;
			enviada := false;
			WHILE (not enviada) LOOP
				SELECT
					Central.SeñalProceso2(s);
					enviada := true;
				ELSE
					DELAY 60.0;
				END SELECT;
			END LOOP;
		END LOOP;
	END Proceso2;

BEGIN
	null;
END ej3;
```

---
## Ejercicio 4
En una clínica existe un médico de guardia que recibe continuamente peticiones de atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la clínica ser atendidos.
Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del médico. Si no es atendida tres veces, se enoja y se retira de la clínica.
Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el momento que pueda (el pedido puede ser que el médico le firme algún papel). Cuando la petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, continúa trabajando y haciendo más peticiones.
El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos. Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto tiempo. Cuando está libre aprovecha a procesar las notas dejadas por las enfermeras.
```Ada
PROCEDURE ej4 IS
	
	TASK Medico IS
		ENTRY Guardia;
		ENTRY AtencionEnfermera;
		ENTRY Nota(n: IN string);
	END Medico;
	
	TASK TYPE Persona;
	TASK TYPE Enfermera;
	
	TASK Escritorio IS
		ENTRY DejarNota(n: IN string);
		ENTRY TomarNota(n: OUT string);
	END Escritorio;

	TASK PasaNotas;

	TASK BODY Medico IS
		nota: string;
	BEGIN
		loop
			SELECT
				ACCEPT Guardia do
					-- atiende al paciente.
				END Guardia;
			OR
				WHEN (Guardia'count = 0) =>
				ACCEPT AtencionEnfermera;
					-- procesa el pedido de la enfermera
			OR
				WHEN (Guardia'count = 0) AND (AtencionEnfermera'count = 0) =>
				ACCEPT Nota(n: IN string) do
					nota := n;
				END Nota;
					-- procesa la nota.
			END SELECT;
		end loop;
	END Medico;
	
	TASK BODY Persona IS
		i: integer;
	BEGIN
		for i in 1..3 loop
			SELECT
				Medico.Guardia;
				exit;
			OR DELAY 300.0;
				if (i < 3) then
					DELAY 600.0;
				end if;
			END SELECT;
		end loop;
		-- se retira
	END Persona;
	
	TASK BODY Enfermera IS
		n: string;
	BEGIN
		loop
			SELECT
				Medico.AtencionEnfermera;
			ELSE
				n := EscribirNota;
				Escritorio.DejarNota(n);
			END SELECT;
			-- continúa trabajando
		end loop;
	END Enfermera;
	
	TASK BODY Escritorio IS
		nota: string;
		q: queue;
	BEGIN
		loop
			SELECT
				ACCEPT DejarNota(n: IN string) do
					q.Push(n);
				END DejarNota;
			OR
				WHEN (not q.IsEmpty) =>
				ACCEPT TomarNota(n: OUT string) do
					q.Pop(n);
				END TomarNota;
			END SELECT;
		end loop;
	END Escritorio;
	
	TASK BODY PasaNotas IS
		n: string;
	BEGIN
		loop
			Escritorio.TomarNota(n);
			Medico.Nota(n);
		end loop;
	END PasaNotas;
	
	arrPersonas: ARRAY(1..P) OF Persona;
	arrEnfermeras: ARRAY(1..E) OF Enfermera;
	
BEGIN
	null;
END ej4;
```

---
## Ejercicio 5
En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos de U Usuarios de a uno a la vez y de acuerdo con el orden en que se hacen los pedidos. Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la respuesta de este que le indica si está todo bien o hay algún error. Mientras haya algún error, vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le responde que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera a lo sumo 2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto y vuelve a intentarlo (usando el mismo documento).

```Ada
PROCEDURE ej5 IS
	
	TASK Servidor IS
		ENTRY Pedido(d: IN Documento; docOk: OUT boolean);
	END Servidor;
	
	TASK TYPE Usuario;
	
	arrUsuarios: ARRAY(1..U) OF Usuario;
	
	TASK BODY Servidor IS
		docsListos: integer;
	BEGIN
		docsListos := 0;
		while (docsListos < U) loop
			ACCEPT Pedido(d: IN Documento; docOk: OUT boolean) do
				docOk := AnalizarDocumento(d);
				-- retorna true si el documento no presenta errores, caso contrario retorna false.
				if (docOk) then
					docsListos := docsListos + 1;
				end if;
			END Pedido;
		end loop;	
	END Servidor;
	
	TASK BODY Usuario IS
		doc: Documento;
		docOk: boolean;
		enviado: boolean;
	BEGIN
		docOk := false;
		while (not docOk) loop
			doc := GenerarDocumento; -- genera/corrige el documento.
			enviado := false;
			while (not enviado) loop
				SELECT
					Servidor.Pedido(doc, docOk);
					enviado := true;
				OR DELAY 120.0;
					DELAY 60.0;
				END SELECT;
			end loop;
		end loop;
	END Usuario;

BEGIN
	null;	
END ej5;
```

---
## Ejercicio 6
En una playa hay 5 equipos de 4 personas cada uno (en total son 20 personas donde cada una conoce previamente a que equipo pertenece). Cuando las personas van llegando esperan con los de su equipo hasta que el mismo esté completo (hayan llegado los 4 integrantes), a partir de ese momento el equipo comienza a jugar. El juego consiste en que cada integrante del grupo junta 15 monedas de a una en una playa (las monedas pueden ser de 1, 2 o 5 pesos) y se suman los montos de las 60 monedas conseguidas en el grupo. Al finalizar cada persona debe conocer el grupo que más dinero junto.
**Nota:** maximizar la concurrencia. Suponga que para simular la búsqueda de una moneda por parte de una persona existe una función *Moneda()* que retorna el valor de la moneda encontrada.

```Ada
PROCEDURE ej6 IS
	
	TASK TYPE Equipo IS
		ENTRY Id(ident: IN integer);
		ENTRY Llegada;
		ENTRY Barrera;
		ENTRY Parcial(parcial: IN integer);
		ENTRY EquipoGanador(e: OUT integer);
	END Equipo;
	
	TASK TYPE Persona;
	
	TASK Administrador IS
		ENTRY RecibirTotal(idE: IN integer; totEquipo: IN integer);
		ENTRY EquipoGanador(e: OUT integer);
	END Administrador;
	
	TASK BODY Administrador IS
		max: integer;
		maxId: integer;
	BEGIN
		max := -1;
		for i in 1..5 loop
			ACCEPT RecibirTotal(idE: IN integer; totEquipo: IN integer) do
				if (totEquipo > max) then
					max := totEquipo;
					maxId := idE;
				end if;
			END RecibirTotal;
		end loop;
		
		for i in 1..5 loop
			ACCEPT EquipoGanador(e: OUT integer) do
				e := maxId;
			END EquipoGanador;
		end loop;
	END Administrador;
	
	TASK BODY Equipo IS
		id: integer;
		total: integer;
		equipoGanador: integer;
	BEGIN
		total := 0;
		
		ACCEPT Id(ident: IN integer) DO
			id := ident;
		END Id;
		
		for i in 1..4 loop
			ACCEPT Llegada;
		end loop;
		-- llegaron todos
		for i in 1..4 loop
			ACCEPT Barrera;
		end loop;
		
		for i in 1..4 loop
			ACCEPT Parcial(parcial: IN integer) do
				total := total + parcial;
			END Parcial;
		end loop;
		
		Administrador.RecibirTotal(id, total);
		Administrador.EquipoGanador(equipoGanador);
		
		for i in 1..4 loop
			ACCEPT EquipoGanador(e: OUT integer) do
				e := equipoGanador;
			END EquipoGanador;
		end loop;
		
	END Equipo;
	
	TASK BODY Persona IS
		id: integer;
		equipo: integer;
		m: integer;
		parcial: integer;
		equipoGanador: integer;
	BEGIN
		equipo := GetMiEquipo; -- 1..4
		parcial := 0;
		
		arrEquipos(equipo).Llegada;
		arrEquipos(equipo).Barrera;
		
		for i in 1..15 loop
			m := Moneda;
			parcial := parcial + m;
		end loop;
		
		arrEquipos(equipo).Parcial(parcial);
		
		arrEquipos(equipo).EquipoGanador(equipoGanador);
		
	END Persona;
	
	arrEquipos: ARRAY(1..5) OF Equipo;
	arrPersonas: ARRAY(1..20) OF Persona;
	
BEGIN
	for i in 1..5 loop
		arrEquipos(i).Id(i);
	end loop;
END ej6;
```

---
## Ejercicio 7
Se debe calcular el valor promedio de un vector de 1 millón de números enteros que se encuentra distribuido entre 10 procesos Worker (es decir, cada Worker tiene un vector de 100 mil números). Para ello, existe un Coordinador que determina el momento en que se debe realizar el cálculo de este promedio y que, además, se queda con el resultado.
**Nota:** maximizar la concurrencia; este cálculo se hace una sola vez.

```Ada
PROCEDURE ej7 IS
	
	TASK Coordinador IS
		ENTRY Comenzar;
		ENTRY PromedioParcial(p: IN real);
	END Coordinador;
	
	TASK TYPE Worker;
	
	TASK BODY Coordinador IS
		suma: real;
		promFinal: real;
	BEGIN
		
		DELAY x; -- el coordinador decide cuándo comenzar.
		
		for i in 1..10 loop
			ACCEPT Comenzar;
		end loop;
		
		suma := 0.0;
		
		for i in 1..10 loop
			ACCEPT PromedioParcial(p: IN real) do
				suma := suma + p;
			END PromedioParcial;
		end loop;
		
		promFinal := suma / 10.0;
		
	END Coordinador;
	
	TASK BODY Worker IS
		arr: ARRAY(1..100_000) OF integer;
		suma: integer;
		promParcial: real;
	BEGIN
		suma := 0;
		Coordinador.Comenzar;
		
		for i in 1..100_000 loop
			suma := suma + arr(i);
		end loop;
		
		promParcial := suma / 100_000.0;
		Coordinador.PromedioParcial(promParcial);
		
	END Worker;
	
	arrWorkers: ARRAY(1..10) OF Worker;
	
BEGIN
	null;
END ej7;
```

---
## Ejercicio 8
Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 Servidores para realizar el reconocimiento, cada uno de ellos trabajando con una Base de Datos propia; a su vez hay un Especialista que utiliza indefinidamente. El sistema funciona de la siguiente manera: el Especialista toma una imagen de una huella (TEST) y se la envía a los servidores para que cada uno de ellos le devuelva el código y el valor de similitud de la huella que más se asemeja a TEST en su BD; al final del procesamiento, el especialista debe conocer el código de la huella con mayor valor de similitud entre las devueltas por los 8 servidores. Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo.
**Nota:** suponga que existe una función Buscar(test, código, valor) que utiliza cada Servidor donde recibe como parámetro de entrada la huella test, y devuelve como parámetros de salida el código y el valor de similitud de la huella más parecida a test en la BD correspondiente. Maximizar la concurrencia y no generar demora innecesaria.
```Ada
PROCEDURE ej8 IS
	
	TASK Especialista IS
		ENTRY Huella(h: OUT Huella);
		ENTRY Resultado(c: IN integer; sim: IN real);
		ENTRY Barrera;
	END Especialista;
	
	TASK TYPE Servidor;
	
	TASK BODY Especialista IS
		huella: Huella;
		codigoMax: integer;
		simMax: real;
	BEGIN
		loop
			huella := TEST;
			simMax := -999.0;
			
			for i in 1..16 loop
				SELECT
					ACCEPT Huella(h: OUT Huella) do
						h := huella;
					END Huella;
				OR
					ACCEPT Resultado(c: IN integer; sim: IN real) do
						if (sim > simMax) then
							codigoMax := c;
							simMax := sim;
						end if;
					END Resultado;
				END SELECT;
			end loop;
			
			for i in 1..8 loop
				ACCEPT Barrera;
			end loop;
		end loop;
	END Especialista;
	
	TASK BODY Servidor IS
		huella: Huella;
		cod: integer;
		sim: real;
	BEGIN
		loop
			Especialista.Huella(huella);
			Buscar(huella, cod, sim);
			Especialista.Resultado(cod, sim);
			Especialista.Barrera;
		end loop;
	END Servidor;
	
	arrServidores: ARRAY(1..8) OF Servidor;
	
BEGIN
	null;
END ej8;
```

---
## Ejercicio 9
Una empresa de limpieza se encarga de recolectar residuos en una ciudad por medio de 3 camiones. Hay P personas que hacen reclamos continuamente hasta que uno de los camiones pase por su casa. Cada persona hace un reclamo y espera a lo sumo 15 minutos a que llegue un camión; si no pasa, vuelve a hacer el reclamo y a esperar a lo sumo 15 minutos a que llegue un camión; y así sucesivamente hasta que el camión llegue y recolecte los residuos. Sólo cuando un camión llega, es cuando deja de hacer reclamos y se retira. Cuando un camión está libre la empresa lo envía a la casa de la persona que más reclamos ha hecho sin ser atendido.
**Nota:** maximizar la concurrencia.
```Ada
PROCEDURE ej9 IS
	
	TASK Empresa IS
		ENTRY Reclamo(id: IN integer);
		ENTRY CamiónLibre(idP: OUT integer);
	END Empresa;
	
	TASK TYPE Camión;
	
	TASK TYPE Persona IS
		ENTRY Id(identificador: IN integer);
		ENTRY LlegaCamión;
	END Persona;
	
	TASK BODY Empresa IS
		arrCantReclamos: ARRAY(1..P) OF integer;
		maxReclamos: integer;
		idMaxReclamos: integer;
	BEGIN
		for i in 1..P loop
			arrCantReclamos(i) := 0;
		end loop;
		
		loop
			maxReclamos := 0;
			idMaxReclamos := -1; -- lo asigno en -1 y si no se modifica es que no hay reclamos.
			
			for i in 1..P loop
				if (arrCantReclamos(i) > maxReclamos) then
					maxReclamos := arrCantReclamos(i);
					idMaxReclamos := i;
				end if;
			end loop;
			
			SELECT
				WHEN (idMaxReclamos <> -1) =>
				ACCEPT CamiónLibre(idP: OUT integer) do
					idP := idMaxReclamos;
				END CamiónLibre;
					arrCantReclamos(idMaxReclamos) := 0;
			OR
				ACCEPT Reclamo(id: IN integer) do
					arrCantReclamos(id) := arrCantReclamos(id) + 1;
				END Reclamo;
			END SELECT;
		end loop;
	END Empresa;
	
	TASK BODY Camión IS
		idP: integer;
	BEGIN
		loop
			Empresa.CamiónLibre(idP);
			Recolectar(idP); -- va a recolectar a la casa de la persona con id = idP.
			arrPersonas(idP).LlegaCamión;
		end loop;
	END Camión;
	
	TASK BODY Persona IS
		id: integer;
		atendido: boolean;
	BEGIN
		atendido := false;
		
		ACCEPT Id(identificador: IN integer) do
			id := identificador;
		END Id;
		
		while (not atendido) loop
			Empresa.Reclamo(id);
			SELECT
				ACCEPT LlegaCamión;
				atendido := true;
			OR DELAY 900.0;
				null;
			END SELECT;
		end loop;
	END Persona;
	
	arrCamiones: ARRAY(1..3) OF Camión;
	arrPersonas: ARRAY(1..P) OF Persona;
	
BEGIN
	for i in 1..P loop
		arrPersonas(i).Id(i);
	end loop;
END ej9;
```