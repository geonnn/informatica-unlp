{14. Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para: 
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento disponible. 
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que tengan menos de una cantidad específica de asientos disponibles. La misma debe ser ingresada por teclado. 
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}

program ej14;

const
    VALOR_ALTO_ST = 'ZZZZZ';
    VALOR_ALTO = maxInt;

type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recHora = record
        hs: 00..23;
        mins: 00..59;
    end;

    recVuelo = record
        destino: string;
        fecha: recFecha;
        hsSalida: recHora;
        asientos: integer; // asientos disp para el maestro, asientos comprados para el detalle.
    end;

    listaVuelos = ^nodo;

    nodo = record
        dato: recVuelo;
        sig: listaVuelos;
    end;

    archivo = file of recVuelo;

procedure Leer(var arch: archivo; var r: recVuelo);
begin
    if (not EOF(arch)) then
        read(arch, r)
    else
        r.destino := VALOR_ALTO_ST;
end;

function EsMenor(r1, r2: recVuelo): boolean;
begin
    // Destino
    if (r1.destino <> r2.destino) then
        EsMenor := (r1.destino < r2.destino)

    // Fecha
    else if (r1.fecha.anio <> r2.fecha.anio) then
        EsMenor := (r1.fecha.anio < r2.fecha.anio)
    else if (r1.fecha.mes <> r2.fecha.mes) then
        EsMenor := (r1.fecha.mes < r2.fecha.mes)
    else if (r1.fecha.dia <> r2.fecha.dia) then
        EsMenor := (r1.fecha.dia < r2.fecha.dia)

    // Hora de salida
    else if (r1.hsSalida.hs <> r2.hsSalida.hs) then
        EsMenor := (r1.hsSalida.hs < r2.hsSalida.hs)
    else
        EsMenor := (r1.hsSalida.mins < r2.hsSalida.mins);
end;

procedure Minimo(var det1, det2: archivo; var recD1, recD2, minD: recVuelo);
begin
    // if recD1 < recD2
    if (EsMenor(recD1, recD2)) then begin
        minD := recD1;
        Leer(det1, recD1);
    end
    else begin
        minD := recD2;
        Leer(det2, recD2);
    end;
end;

function SonElMismoVuelo(r1, r2: recVuelo): boolean;
begin
    SonElMismoVuelo := (
        (r1.destino = r2.destino) and
        (r1.fecha.anio = r2.fecha.anio) and
        (r1.fecha.mes = r2.fecha.mes) and
        (r1.fecha.dia = r2.fecha.dia) and
        (r1.hsSalida.hs = r2.hsSalida.hs) and
        (r1.hsSalida.mins = r2.hsSalida.mins)
    );
end;

procedure Agregar(var L: listaVuelos; r: recVuelo);
var
    nue: listaVuelos;
begin
    new(nue);
    nue^.dato := r;
    nue^.sig := L;
    L := nue;
end;

procedure ProcesarVuelos(var mae, det1, det2: archivo; var lista: listaVuelos; n: integer);
var
    recM, recD1, recD2, minD: recVuelo;
    actualizar: boolean;
begin
    Leer(det1, recD1);
    Leer(det2, recD2);
    Minimo(det1, det2, recD1, recD2, minD);
    while (not EOF(mae)) do begin
        read(mae, recM);
        if (SonElMismoVuelo(recM, minD)) then begin
            while (minD.destino <> VALOR_ALTO_ST) and (SonElMismoVuelo(recM, minD)) do begin
                recM.asientos := recM.asientos - minD.asientos;
                Minimo(det1, det2, recD1, recD2, minD);
            end;
            // Actualizar maestro.
            seek(mae, FilePos(mae)-1);
            write(mae, recM);
        end;

        if (recM.asientos < n) then
            Agregar(lista, recM);
    end;
end;

var
    mae, det1, det2: archivo;
    asientosInput: integer;
    L: listaVuelos;
begin
    L := nil;
    assign(mae, 'maestro.dat');
    assign(det1, 'detalle1.dat');
    assign(det2, 'detalle2.dat');

    reset(mae);
    reset(det1);
    reset(det2);

    writeln('Generar lista de vuelos con asientos disponibles menores a: ');
    readln(asientosInput);

    ProcesarVuelos(mae, det1, det2, L, asientosInput);

    close(mae);
    close(det1);
    close(det2);
end.