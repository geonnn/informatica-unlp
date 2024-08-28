{7. Realizar un programa que lea desde teclado información de autos de carrera. Para cada uno de los autos se
lee el nombre del piloto y el tiempo total que le tomó finalizar la carrera. En la carrera participaron 100
autos. Informar en pantalla:
● Los nombres de los dos pilotos que finalizaron en los dos primeros puestos.
● Los nombres de los dos pilotos que finalizaron en los dos últimos puestos.}

program Ej7;
var
    nom, nomTop1, nomTop2, nomLast1, nomLast2: string;
    tiempo: integer;
    i, top1, top2, last1, last2: integer;
begin

    top1 := 9999;
    top2 := 9999;
    last1 := -9999;
    last2 := -9999;

    // Loop para 100 participantes.
    for i := 1 to 100 do begin
        writeln('Ingrese el nombre del piloto: ');
        readln(nom);
        writeln('Ingrese el tiempo del piloto: ');
        readln(tiempo);

        // Dos primeros puestos.
        if (tiempo < top1) then begin
            top2 := top1;
            nomTop2 := nomTop1;
            top1 := tiempo;
            nomTop1 := nom;
        end
        else
            if (tiempo < top2) then begin
                top2 := tiempo;
                nomTop2 := nom;
            end
        // Dos últimos puestos.
        if (tiempo > last1) then begin
            last2 := last1;
            nomLast2 := nomLast1;
            last1 := tiempo;
            nomLast1 := nom;
        end
        else
            if (tiempo > last2) then begin
                last2 := tiempo;
                nomLast2 := nom;
            end
    end;
    writeln('Top 1: ', nomTop1,' | ', top1)
    writeln('Top 2: ', nomTop2,' | ', top2)
    writeln('Last 2: ', nomLast2,' | ', last2)
    writeln('Last 1: ', nomLast1,' | ', last1)
end.