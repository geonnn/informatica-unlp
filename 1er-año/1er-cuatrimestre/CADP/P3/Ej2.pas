{2. El registro civil de La Plata ha solicitado un programa para analizar la distribución de casamientos durante el
año 2019. Para ello, cuenta con información de las fechas de todos los casamientos realizados durante ese
año.
a. Analizar y definir un tipo de dato adecuado para almacenar la información de la fecha de cada
casamiento.
b. Implementar un módulo que lea una fecha desde teclado y la retorne en un parámetro cuyo tipo es el
definido en el inciso a.
c. Implementar un programa que lea la fecha de todos los casamientos realizados en 2019. La lectura
finaliza al ingresar el año 2020, que no debe procesarse, e informe la cantidad de casamientos
realizados durante los meses de verano (enero, febrero y marzo) y la cantidad de casamientos
realizados en los primeros 10 días de cada mes. Nota: utilizar el módulo realizado en b) para la lectura
de fecha.}

program Ej2;
type
    fechas_cas = record
        dia: 1..31;
        mes: 1..12;
        anio: 2019..2020;
    end;
procedure LeerFecha(var f: fechas_cas);
begin
    writeln('Ingrese el año: ');
    readln(f.anio);
    if (f.anio = 2020) then

    else begin
        writeln('Ingrese el mes: ');
        readln(f.mes);
        writeln('Ingrese el día: ');
        readln(f.dia);
    end;
end;

// Programa principal ↓.

var
    cantVerano, cantP10Dias: integer;
    f: fechas_cas;

begin
    cantVerano := 0; cantP10Dias := 0;

    writeln('Fechas de casamiento año 2019.');
    writeln('');
    LeerFecha(f);
    while (f.anio <> 2020) do begin
        if (f.mes >= 1) and (f.mes <= 3) then
            cantVerano := cantVerano + 1;
        if (f.dia >= 1) and (f.dia <= 10) then
            cantP10Dias := cantP10Dias + 1;
        LeerFecha(f);
    end;

    writeln('Durante el verano se realizaron ', cantVerano, ' casamientos.');
    writeln('Durante los primeros diez días de cada mes se realizaron ', cantP10Dias, ' casamientos.');
end.