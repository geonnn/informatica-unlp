{6. Se desea modelar la información necesaria para un sistema de recuentos de casos de covid para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad, nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que requiera para la actualización solicitada e informe cantidad de localidades con más de 50 casos activos (las localidades pueden o no haber sido actualizadas).}

program ej6;

uses SysUtils;

const
    VALOR_ALTO = maxInt;
    N_MUNICIPIOS = 10;

type
    recDetalle = record
        codLocalidad: integer;
        codCepa: integer;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;

    recMaestro = record
        codLocalidad: integer;
        nomLocalidad: string[40];
        codCepa: integer;
        nomCepa: string[40];
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;

detalle = file of recDetalle;
maestro = file of recMaestro;

arrayDetalles = array [1..N_MUNICIPIOS] of detalle;
arrayRecsDetalle = array [1..N_MUNICIPIOS] of recDetalle;

procedure Leer(var det: detalle; var r: recDetalle);
begin
    if not EOF(det) then
        read(det, r)
    else
        r.codLocalidad := VALOR_ALTO;
end;

procedure Minimo(var aD: arrayDetalles; var aR: arrayRecsDetalle; var min: recDetalle);
var
    i, posMin: integer;
begin
    posMin := -1;
    min.codLocalidad := VALOR_ALTO;
    for i := 1 to N_MUNICIPIOS do begin
        if (aR[i].codLocalidad < min.codLocalidad) or 
        ((aR[i].codLocalidad = min.codLocalidad) and (aR[i].codCepa < min.codCepa)) then begin
            min := aR[i];
            posMin := i;
        end;
    end;
    if (posMin <> -1) then
        Leer(aD[posMin], aR[posMin]);
end;

procedure ImprimirMaestro(var mae: maestro);
var
    regm: recMaestro;
begin
    while not EOF(mae) do begin
        read(mae, regm);
        writeln('Código Localidad: ', regm.codLocalidad);
        writeln('Nombre Localidad: ', regm.nomLocalidad);
        writeln('Código Cepa: ', regm.codCepa);
        writeln('Nombre Cepa: ', regm.nomCepa);
        writeln('Casos Activos: ', regm.cantActivos);
        writeln('Casos Nuevos: ', regm.cantNuevos);
        writeln('Casos Recuperados: ', regm.cantRecuperados);
        writeln('Casos Fallecidos: ', regm.cantFallecidos);
        writeln('-----------------------------');
    end;
end;

procedure ActualizarMaestro(var m: recMaestro; min: recDetalle);
begin
    m.cantActivos := min.cantActivos;
    m.cantNuevos := min.cantNuevos;
    m.cantFallecidos := m.cantFallecidos + min.cantFallecidos;
    m.cantRecuperados := m.cantRecuperados + min.cantRecuperados;
end;

procedure ProcesarDetalles(var mae: maestro; var aD: arrayDetalles; var aR: arrayRecsDetalle);
var
    min: recDetalle;
    regm: recMaestro;
begin
    Minimo(aD, aR, min);

    while (min.codLocalidad <> VALOR_ALTO) do begin
        read(mae, regm);
        while(min.codLocalidad <> regm.codLocalidad) do
            read(mae, regm);
        while(regm.codLocalidad = min.codLocalidad) and (regm.codCepa = min.codCepa) do begin
            ActualizarMaestro(regm, min);
            seek(mae, FilePos(mae)-1);
            write(mae, regm);
            Minimo(aD, aR, min);
        end;
    end;
end;

var
    mae: maestro;
    aD: arrayDetalles;
    aR: arrayRecsDetalle;
    i: integer;
begin
    assign(mae, 'maestro');
    reset(mae);
    for i := 1 to N_MUNICIPIOS do begin
        assign(aD[i], 'municipio' + Format('%.2d', [i]) + '.dat');
        reset(aD[i]);
        Leer(aD[i], aR[i]);
    end;

    ProcesarDetalles(mae, aD, aR);

    for i := 1 to N_MUNICIPIOS do begin
        close(aD[i]);
    end;
    close(mae);

    reset(mae);
    ImprimirMaestro(mae);
    close(mae);
end.