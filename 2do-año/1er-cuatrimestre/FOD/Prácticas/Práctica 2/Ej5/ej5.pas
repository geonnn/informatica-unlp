{5. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central. Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ej5;

const
    VALOR_ALTO = maxInt;
    CANT_PCS = 5;

uses sysutils;

type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;

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
    else begin
        l.cod_usuario := VALOR_ALTO;
        l.fecha.anio := VALOR_ALTO;
    end;
end;

procedure Minimo(var aD: arrayDetalles; var aL: arrayLogs; var min: recLog);
var
    i, posMin: integer;
begin
    min.cod_usuario := VALOR_ALTO;
    posMin := -1;

    for i := 1 to CANT_PCS do
        if (aL[i].cod_usuario < min.cod_usuario) then begin
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
        while(regm.cod_usuario = min.cod_usuario) do begin
            regm.tiempo_total_de_sesiones_abiertas
            Minimo(aD, aL, min);
        end;
    end;
end;

var
    aD: arrayDetalles;
    aL: arrayLogs;
    mae: maestro;
    i: integer;
begin
    assign(mae, '/var/log/maestro.dat');
    rewrite(mae);
    for i := 1 to CANT_PCS do begin
        assign(aD[i], 'log' + Format('%.2d', [i]) + '.dat'); // log01.dat, log02.dat ... log05.dat.
        reset(aD[i]);
        Leer(aD[i], aL[i]);
    end;

    GenerarMaestro(mae, aD, aL);

    for i := 1 to CANT_PCS do
        close(aD[i]);
    close(mae);
end.