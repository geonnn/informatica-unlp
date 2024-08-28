{10. Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado por su número, en cuyo caso sale de la lista de espera. Se pide:
a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes en espera, asigna un número al cliente y retorna la lista de espera actualizada.
c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera, y retorna el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe eliminarse de la lista de espera.
d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se los atenderá de a uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no debe procesarse.}

program Ej10;
type
    str10 = string[10];
    recCliente = record
        DNI: integer;
        num: integer;
    end;
    listaEspera = ^nodo;
    nodo = record
        dato: recCliente;
        sig: listaEspera;
    end;

procedure RecibirCliente(var L, ult: listaEspera; var numCliente: integer; DNI: integer);
var
    nue: listaEspera;
begin
    new(nue);
    nue^.dato.DNI := DNI;
    numCliente := numCliente + 1;
    nue^.dato.num := numCliente;
    nue^.sig := nil;
    if (L = NIL) then
        L := nue
    else
        ult^.sig := nue;
    ult := nue;
end;

// Proceso que hizo el profe.
procedure RecibirClienteProfe(var L: listaEspera; DNI: integer);
var
    nue, aux: listaEspera;
begin
    new(nue);
    nue^.dato.DNI := DNI;
    nue^.sig := nil;
    if (L = NIL) then begin
        nue^.dato.num := 1;
        L := nue;
    end
    else begin
        aux := L;
        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        nue^.dato.num := aux^.dato.num + 1;
        aux^.sig := nue;
    end;
end;

procedure AtenderCliente(var L: listaEspera; var DNI: integer; var numCliente: integer);
var
    aux: listaEspera;
begin
    aux := L;
    DNI := aux^.dato.DNI;
    numCliente := aux^.dato.num;
    L := L^.sig;
    dispose(aux);
end;

var
    L: listaEspera;
    c: recCliente;
    DNIActual: integer;
    numClienteActual: integer;
begin
    L := nil;
    writeln('');
    writeln('Ingrese su número DNI: ');
    readln(c.DNI);
    while (c.DNI <> 0) do begin
        RecibirClienteProfe(L, c.DNI);
        writeln('Ingrese su número DNI: ');
        readln(c.DNI);
    end;
    AtenderCliente(L, DNIActual, numClienteActual);
    writeln('Cliente a ser atendido: Número ', numClienteActual, ' | DNI: ', DNIActual);
    while (L <> nil) do begin
        AtenderCliente(L, DNIActual, numClienteActual);
        writeln('Cliente a ser atendido: Número ', numClienteActual, ' | DNI: ', DNIActual);
    end;
end.