{5. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central. Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ej5;

uses sysutils;

const
    VALOR_ALTO = maxInt;
    CANT_PCS = 5;


type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recLog = record
        cod_usuario: integer;
        fecha: recFecha;
        tiempo_sesion: real;
    end;

    recLogMaestro = record
        cod_usuario: integer;
        fecha: recFecha;
        tiempo_total_de_sesiones_abiertas: real;
    end;

    detalle = file of recLog;
    maestro = file of recLogMaestro;

    arrayDetalles = array[1..CANT_PCS] of detalle;
    arrayLogs = array[1..CANT_PCS] of recLog;

procedure Leer(var det: detalle; var l: recLog);
begin
    if not EOF(det) then
        read(det, l)
    else
        l.cod_usuario := VALOR_ALTO;
end;

function SonFechasIguales(f1, f2: recFecha): boolean;
begin
    SonFechasIguales := true;
    if (f1.dia <> f2.dia) then
        SonFechasIguales := false
    else if (f1.mes <> f2.mes) then
        SonFechasIguales := false
    else if (f1.anio <> f2.anio) then
        SonFechasIguales := false;
end;

function EsMenor(r1, r2: recLog): boolean;
begin
    if (r1.cod_usuario < r2.cod_usuario) then
        EsMenor := true
    else if (r1.cod_usuario = r2.cod_usuario) then
    begin
        if (r1.fecha.anio < r2.fecha.anio) then
            EsMenor := true
        else if (r1.fecha.anio = r2.fecha.anio) and (r1.fecha.mes < r2.fecha.mes) then
            EsMenor := true
        else if (r1.fecha.anio = r2.fecha.anio) and (r1.fecha.mes = r2.fecha.mes) and (r1.fecha.dia < r2.fecha.dia) then
            EsMenor := true
        else
            EsMenor := false;
    end
    else
        EsMenor := false;
end;


procedure Minimo(var aD: arrayDetalles; var aL: arrayLogs; var min: recLog);
var
    i, posMin: integer;
begin
    min.cod_usuario := VALOR_ALTO;
    posMin := -1;

    for i := 1 to CANT_PCS do
        if EsMenor(aL[i], min) then begin
            min := aL[i];
            posMin := i;
        end;
    if (posMin <> -1) then
        Leer(aD[posMin], aL[posMin]);
end;

procedure GenerarMaestro(var mae: maestro; var aD: arrayDetalles; var aL: arrayLogs);
var
    min: recLog;
    regm: recLogMaestro;
begin

    Minimo(aD, aL, min);
    while (min.cod_usuario <> VALOR_ALTO) do begin
        regm.cod_usuario := min.cod_usuario;
        regm.fecha := min.fecha;
        regm.tiempo_total_de_sesiones_abiertas := 0;
        while(regm.cod_usuario = min.cod_usuario) and (SonFechasIguales(regm.fecha, min.fecha)) do begin
            regm.tiempo_total_de_sesiones_abiertas := regm.tiempo_total_de_sesiones_abiertas + min.tiempo_sesion;
            Minimo(aD, aL, min);
        end;
        write(mae, regm);
    end;
end;

procedure ImprimirMaestro(var mae: maestro);
var
    regm: recLogMaestro;
begin
    writeln('Cod Usuario | Fecha       | Tiempo Total de Sesiones Abiertas');
    writeln('-----------------------------------------------------------');
    while not EOF(mae) do begin
        read(mae, regm);
        with regm do begin
            writeln(cod_usuario:11, ' | ', 
                    fecha.dia:2, '/', fecha.mes:2, '/', fecha.anio:4, ' | ', 
                    tiempo_total_de_sesiones_abiertas:10:2);
        end;
    end;
end;

var
    aD: arrayDetalles;
    aL: arrayLogs;
    mae: maestro;
    i: integer;
begin
    mkdir('var');
    mkdir('var\log');
    assign(mae, 'var\log\maestro.dat');
    rewrite(mae);
    for i := 1 to CANT_PCS do begin
        assign(aD[i], 'log' + Format('%.2d', [i]) + '.dat'); // log01.dat, log02.dat ... log05.dat.
        reset(aD[i]);
        Leer(aD[i], aL[i]);
    end;

    GenerarMaestro(mae, aD, aL);
    close(mae);

    reset(mae);
    ImprimirMaestro(mae);
    close(mae);

    for i := 1 to CANT_PCS do
        close(aD[i]);
end.