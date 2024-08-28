{CADP 2023 - Parcial - Primera Fecha - 10/6/2023 - TEMA 2 -10:30 hs
Un teatro está analizando la información de los tickets vendidos durante el año 2022. Para ello, se dispone de una estructura de datos con la información de todos los tickets vendidos. De cada ticket se conoce el código del evento, dni del comprador, mes de la función (entre 1 y 12) y ubicación (1: Palco, 2: Pullman, 3: Platea alta, 4: Platea baja). La información se encuentra ordenada por código de evento.
Además, la empresa dispone de una estructura de datos con información del costo del ticket por ubicación.
Realizar un programa que procese la información de los tickets y:
A. Genere una lista que tenga por cada código de evento, la cantidad de tickets vendidos.
B. Informe el mes con mayor monto recaudado.
C. COMPLETO: Informe el promedio recaudado por cada evento entre todos sus tickets.}

program Parcial;
const
    maxMeses = 12;
    maxUbicaciones = 4;

type
    meses = 1..maxMeses;
    ubicaciones = 1..maxUbicaciones;

    recTickets = record
        codEvento: integer;
        dniComp: Int64;
        mesEvento: meses;
        ubicacion: ubicaciones;
    end;

    listaTickets = ^nodoT;
    nodoT = record
        dato: recTickets;
        sig: listaTickets;
    end;

    recEventos = record
        codEvento: integer;
        cantTVendidos: integer;
    end;

    listaEventos = ^nodoE;
    nodoE = record
        dato: recEventos;
        sig: listaEventos;
    end;

    vecCostos = array[ubicaciones] of real; // Se dispone.
    vecMontoMeses = array[meses] of real;

procedure CargarListaTickets(var L: listaTickets); // Se dispone.

procedure CargarVectorCostos(var vC: vecCostos); // Se dispone.

procedure InicializarVectorMontoMeses(var vMM: vecMontoMeses);
var
    i: integer;
begin
    for i := 1 to maxMeses do
        vMM[i] := 0;
end;

procedure AgregarAtras(var LE, LEult: listaEventos; e: recEventos); // La info viene ordenada por código de evento así que lo ordeno igual.
var
    nue: listaEventos;
begin
    new(nue);
    nue^.dato := e;
    nue^.sig := nil;
    if (LE = nil) then
        LE := nue
    else
        LEult^.sig := nue;
    LEult := nue;
end;

procedure CargarVectorMM(var vMM: vecMontoMeses; mes, ubicacion: integer; vC: vecCostos);
begin
    vMM[mes] := vMM[mes] + vC[ubicacion];
end;

procedure RecorrerListaTickets(var vMM: vecMontoMeses; var LE, LEult: listaEventos; LT: listaTickets; vC: vecCostos);
var
    e: recEventos;
    codEvActual: integer;
    montoPorEvento: real;
begin
    while (LT <> nil) do begin
        codEvActual := LT^.dato.codEvento;
        e.codEvento := codEvActual;
        e.cantTVendidos := 0;
        montoPorEvento := 0;
        while ((LT <> nil) and (codEvActual = LT^.dato.codEvento)) do begin
            e.cantTVendidos := e.cantTVendidos + 1;
            montoPorEvento := montoPorEvento + vC[LT^.dato.ubicacion];
            CargarVectorMM(vMM, LT^.dato.mesEvento, LT^.dato.ubicacion, vC);
            LT := LT^.sig;
        end;
        AgregarAtras(LE, LEult, e);
        writeln('Promedio recaudado por el evento ', codEvActual, ': ', (montoPorEvento / e.cantTVendidos):0:2, '.');
    end;
end;

procedure MesMayorMonto(var mesMontoMax: integer; var montoMax: real; mes: integer; monto: real);
begin
    if (monto > montoMax) then begin
        montoMax := monto;
        mesMontoMax := mes;
    end;
end;

procedure RecorrerVMM(vMM: vecMontoMeses);
var
    mesMontoMax: integer;
    montoMax: real;
    i: integer;
begin
    montoMax := -1;
    for i := 1 to maxMeses do
        MesMayorMonto(mesMontoMax, montoMax, i, vMM[i]);
    writeln('El mes con mayor monto recaudado fue el mes ', mesMontoMax, ' con un monto total de ', montoMax,'.');
end;

var
    LT: listaTickets;
    LE, LEult: listaEventos;
    vC: vecCostos;
    vMM: vecMontoMeses;
begin
    LT := nil;
    CargarListaTickets(LT); // Se dispone.
    CargarVectorCostos(vC); // Se dispone.

    LE := nil;
    InicializarVectorMontoMeses(vMM);
    RecorrerListaTickets(vMM, LE, LEult, LT, vC);
    RecorrerVMM(vMM);
end.