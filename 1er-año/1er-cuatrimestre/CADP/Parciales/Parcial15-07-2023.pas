{CADP 2023 - Parcial TEMA 1
Tercera Fecha - 15/7/2023
Una revista deportiva dispone de información de los jugadores de fútbol participantes de la liga profesional 2022. De cada jugador se conoce código de jugador, apellido y nombres, código de equipo (1..28), año de nacimiento y la calificación obtenida para cada una de las 27 fechas del torneo ya finalizado. La calificación es numérica de 0 a 10, donde el valor 0 significa que el jugador no ha participado de la fecha.
Se solicita:
a. Informar para cada equipo la cantidad de jugadores mayores a 35 años.
b. Informar los códigos de los 2 jugadores con mejor calificación promedio en los partidos en los que participó. Solo deben considerarse los jugadores que participaron en más de 14 fechas.
c. (COMPLETO): Implementar e invocar a un módulo que genere una lista con los jugadores cuyo código posee exactamente 3 dígitos impares y haya nacido entre 1983 y 1990. La lista debe estar ordenada por código de jugador.}

program parcial
const
    ANIO_ACT = 2022;
type
    rangoCalificacion = 0..10;

    recJugador = record
        codJugador: integer;
        apynom: string;
        codEquipo: 1..28;
        anioNac: integer;
        calificacion: vecCalFechas;
    end;

    listaJugadores = ^nodo;
    nodo = record
        dato: recJugador;
        sig: listaJugadores;
    end;

    vecCalFechas = array[1..27] of rangoCalificacion;
    vecJpEquipo = array[1..28] of integer;

function Cumple(anioNac: integer): boolean
begin
    Cumple := ((ANIO_ACT - anioNac) > 35);
end

{function Cumple14Fechas(vCF: vecCalFechas);
var
    cantJugadas, i: integer;
begin
    i := 1;
    cantJugadas := 0;
    Cumple14Fechas := false;
    while (i < 27) and not Cumple14Fechas do begin
        if ((vCF[i]) <> 0) then
            cantJugadas := cantJugadas + 1;
        i := i + 1
        Cumple14Fechas := cantJugadas > 14;
    end;
end;

procedure PromedioJugador(vCF: vecCalFechas; var promJugador: real);
var
    i, partJugados, calificacionesJugador: integer
begin
    calificacionesJugador := 0;
    partJugados := 0;
    for i := 1 to 27 do begin
        if (vCF[i] <> 0) begin
            calificacionesJugador := calificacionesJugador + vCF[i];
            partJugados := partJugados + 1;
        end;
    end;
    promJugador := calificacionesJugador / partJugados;
end;}

{procedure RecorrerListaJugadores(L: listaJugadores; var vJE: vecJpEquipo);
var
    promJugador: real;
begin
    while (L <> nil) do begin
        if (Cumple(L^.dato.anioNac)) then
            vJE[L^.dato.codEquipo] := vJE[L^.dato.codEquipo] + 1;
        if (Cumple14Fechas(vCF)) then
            PromedioJugador(vCF, promJugador);
            PromedioCalMax(promJugador);
        L := L^.sig;
    end;
end;}

procedure PromedioJugador(vCF: vecCalFechas; var promJugador: real; var ok: boolean);
var
    i, cantJugadas, calificacionesJugador: integer;
begin
    ok := false;
    calificacionesJugador := 0;
    cantJugadas := 0;
    for i := 1 to 27 do begin
        if (vCF <> 0) then begin
            cantJugadas := cantJugadas + 1;
            calificacionesJugador := calificacionesJugador + vCF[i];
        end;
    end;
    if (cantJugadas >= 14) then begin
        ok := true;
        promJugador := calificacionesJugador / cantJugadas;
    end;
end;

procedure RecorrerListaJugadores(L: listaJugadores; var vJE: vecJpEquipo);
var
    promJugador: real; ok: boolean;
begin
    while (L <> nil) do begin
        if (Cumple(L^.dato.anioNac)) then
            vJE[L^.dato.codEquipo] := vJE[L^.dato.codEquipo] + 1;
        PromedioJugador(vCF, promJugador, ok);
        if (ok = true) then
            PromedioCalMax(promJugador);
        L := L^.sig;
    end;
end;

procedure CargarListaJugadores(var L: listaJugadores);
begin
    new(nue);
    nue^.dato := j; // (recJugador)
    nue^.sig := L;
    L := nue;
end;

var
begin
    L := nil;
    CargarVectorCalificaciones(vCF); // Se dispone.
    CargarListaJugadores(L);
    InicializarVJE(vJE);

    RecorrerListaJugadores(L);
end.