{8. Se quiere optimizar la gestión del consumo de yerba mate en distintas provincias de Argentina. Para ello, se cuenta con un archivo maestro que contiene la siguiente información: código de provincia, nombre de la provincia, cantidad de habitantes y cantidad total de kilos de yerba consumidos históricamente.
Cada mes, se reciben 16 archivos de relevamiento con información sobre el consumo de yerba en los distintos puntos del país. Cada archivo contiene: código de provincia y cantidad de kilos de yerba consumidos en ese relevamiento. Un archivo de relevamiento puede contener información de una o varias provincias, y una misma provincia puede aparecer cero, una o más veces en distintos archivos de relevamiento. 
Tanto el archivo maestro como los archivos de relevamiento están ordenados por código de provincia.
Se desea realizar un programa que actualice el archivo maestro en base a la nueva información de consumo de yerba. Además, se debe informar en pantalla aquellas provincias (código y nombre) donde la cantidad total de yerba consumida supere los 10.000 kilos históricamente, junto con el promedio consumido de yerba por habitante. Es importante tener en cuenta tanto las provincias actualizadas como las que no fueron actualizadas.
Nota: cada archivo debe recorrerse una única vez.}

program ej8;

uses SysUtils;

const
    VALOR_ALTO = maxInt;
    N_DETALLES = 16;

type

    recMaestro = record
        codProv: integer;
        nomProv: string;
        cantHabitantes: Int64;
        cantYerbaConsumida: real;
    end;

    recRelevamiento = record
        codProv: integer;
        cantYerbaConsumida: real;
    end;

    maestro = file of recMaestro;
    detalle = file of recRelevamiento;

    arrayDetalles = array[1..N_DETALLES] of detalle;
    arrayRelevamientos = array[1..N_DETALLES] of recRelevamiento;

procedure Leer(var d: detalle; var r: recRelevamiento);
begin
    if (not EOF(d)) then
        read(d, r)
    else
        r.codProv := VALOR_ALTO;
end;

procedure Minimo(var aD: arrayDetalles; var aR: arrayRelevamientos; var min: recRelevamiento);
var
    i, posMin: integer;
begin
    posMin := -1;
    min.codProv := VALOR_ALTO;
    for i := 1 to N_DETALLES do begin
        if (aR[i].codProv < min.codProv) then begin
            min := aR[i];
            posMin := i;
        end;
    end;
    if (posMin <> -1) then
        Leer(aD[posMin], aR[posMin]);
end;

procedure InformarProv(m: recMaestro);
begin
    writeln('Código: ', m.codProv, ' | Nombre: ', m.nomProv, '.');
    writeln('Promedio de kg de yerba consumida por habitante: ', (m.cantYerbaConsumida / m.cantHabitantes):0:2, '.');
    writeln('');
end;

procedure Informar(var mae: maestro);
var
    m: recMaestro;
begin
    while (not EOF(mae)) do begin
        read(mae, m);
        writeln(m.nomProv, ': ' ,'cod: ', m.codProv, ' | habitantes: ', m.cantHabitantes, ' | kg yerba: ', m.cantYerbaConsumida:0:2, '.');
        writeln;
    end;
end;

procedure ProcesarDetalles(var mae: maestro; var aD: arrayDetalles; var aR: arrayRelevamientos);
var
    minR: recRelevamiento;
    recM: recMaestro;
    yerbaAcumulada: real;
begin
    Minimo(aD, aR, minR);
    // Recorrer todo el archivo maestro.
    while (not EOF(mae)) do begin
        read(mae, recM);
        yerbaAcumulada := 0;

        // Acumular yerba por provincia.
        while (recM.codProv = minR.codProv) do begin
            yerbaAcumulada := yerbaAcumulada + minR.cantYerbaConsumida;
            Minimo(aD, aR, minR);
        end;

        // Si el recM coincide con la provincia del relevamiento se termina de acumular la yerba de toda una provincia, ahora se actualiza el maestro.
        if (yerbaAcumulada > 0) then begin
            seek(mae, FilePos(mae)-1);
            recM.cantYerbaConsumida := recM.cantYerbaConsumida + yerbaAcumulada;
            write(mae, recM);
        end;

        if (recM.cantYerbaConsumida > 10000) then
            InformarProv(recM);
    end;
end;

var
    mae: maestro;
    aD: arrayDetalles;
    aR: arrayRelevamientos;
    i: integer;
begin
    assign(mae, 'maestro.dat');
    reset(mae);
    for i := 1 to N_DETALLES do begin
        assign(aD[i], 'relevamiento' + Format('%.2d', [i]) + '.dat');
        reset(aD[i]);
        Leer(aD[i], aR[i]);
    end;

    // para testear
    Informar(mae);
    reset(mae);

    ProcesarDetalles(mae, aD, aR);

    // para testear
    reset(mae);
    Informar(mae);
    reset(mae);

    for i := 1 to N_DETALLES do 
        close(aD[i]);
    close(mae);
end.