{4. Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de consumo ilimitados (clientes que pagan por lo que consumen). Para cada cliente se conoce su código de cliente y cantidad de líneas a su nombre. De cada línea se tiene el número de teléfono, la cantidad de minutos consumidos y la cantidad de MB consumidos en el mes. Se pide implementar un programa que lea los datos de los clientes de la compañía e informe el monto total a facturar para cada uno. Para ello, se requiere:
a. Realizar un módulo que lea la información de una línea de teléfono.
b. Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el módulo desarrollado en el inciso a y retorne la cantidad total de minutos y la cantidad total de MB a facturar del cliente.
Nota: para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.}

program Ej4;
const
    CANT_CLIENTES = 3;
type
    recLinea = record
        numero: string;
        cantMins: real;
        cantMB: integer;
    end;
    recCliente = record
        codigo: integer;
        cantLineas: integer;
    end;

procedure LeerLinea(var l: recLinea);
begin
    writeln('Ingrese número de línea: ');
    readln(l.numero);
    writeln('Ingrese cantidad de minutos consumidos: ');
    readln(l.cantMins);
    writeln('Ingrese la cantidad de MB consumidos: ');
    readln(l.cantMB);
end;

procedure Calcular(var MinsAFact: real; var MBAFact: real; cantMins: real; cantMB: integer);
begin
    MinsAFact := MinsAFact + (cantMins * 3.40);
    MBAFact := MBAFact + (cantMB * 1.35);
end;

procedure LeerCliente(var MinsAFact: real; var MBAFact: real);
var
    i: integer;
    l: recLinea;
    c: recCliente;
begin
    MinsAFact := 0;
    MBAFact := 0;
    writeln('');
    writeln('Ingrese el código de cliente: ');
    readln(c.codigo);
    writeln('Ingrese la cantidad de líneas a su nombre: ');
    readln(c.cantLineas);
    for i := 1 to c.cantLineas do begin
        LeerLinea(l);
        Calcular(MinsAFact, MBAFact, l.cantMins, l.cantMB);
    end;
end;

var
    MinsAFact, MBAFact: real;
    i: integer;
begin
    for i := 1 to CANT_CLIENTES do begin
        LeerCliente(MinsAFact, MBAFact);
        writeln('El cliente ', i, ' debe pagar ', MinsAFact:0:2, ' de minutos y ', MBAFact:0:2, ' de MBs.');
    end;
end.