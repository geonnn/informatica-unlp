{13. El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares, obtiene un promedio anual. Este relevamiento se viene realizando desde hace 50 años, y con todos los datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos.
Realizar un programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la información se ingresa ordenada por año). Una vez finalizada la carga de la información, obtener:
a. El año con mayor temperatura promedio a nivel mundial.
b. El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.}

program Ej13;
const
    CANT_LUGARES = 100;
    ANIO_ACTUAL = 2024;
    ANIO_INICIAL = ANIO_ACTUAL - 50;
type
    RANGO = ANIO_INICIAL..ANIO_ACTUAL;
    vLugares = array[1..CANT_LUGARES] of real;
    vAnios = array[RANGO] of vLugares;

procedure TempMax(var anioMax: integer; var tMax: real; anio: integer; temp: real);
begin
    if (temp > tMax) then begin
        tMax := temp;
        anioMax := anio;
    end;
end;

procedure PromTAnioMax(var promTAnioMax: real; var anioMaxTempProm: integer; promTAnio: real; anio: integer);
begin
    if (promTAnio > promTAnioMax) then begin
        promTAnioMax := promTAnio;
        anioMaxTempProm := anio;
    end;
end;

var
    vL: vLugares;
    vA: vAnios;
    i, j: integer;
    temp: real;
    tMax: real;
    tempTotalPAnio: real;
    pTAnio, pTAnioMax: real;
    anioMax, anioMaxTProm: integer;
begin
    tMax := -999;
    pTAnioMax := -999;
    for i := ANIO_INICIAL to ANIO_ACTUAL do begin
        tempTotalPAnio := 0;
        writeln('Año ', i, '.');
        for j := 1 to CANT_LUGARES do begin
            writeln('Ingrese temperatura para la localización ', j, '.');
            read(temp);
            vL[j] := temp;
            tempTotalPAnio := tempTotalPAnio + temp;
            TempMax(anioMax, tMax, i, temp);
        end;
        pTAnio := tempTotalPAnio / CANT_LUGARES;
        writeln('El promedio de temperatura del año ', i, ' es ', pTAnio:0:2, '.');
        PromTAnioMax(pTAnioMax, anioMaxTProm, pTAnio, i);
        vA[i] := vL;
    end;
    writeln('');
    writeln('El año con máxima temperatura promedio es el año ', anioMaxTProm, ' con un promedio de ', pTAnioMax, '.');
    writeln('Se detectó la mayor temperatura en el año ', anioMax, ' con temperatura ', tMax:0:2, '.');
end.