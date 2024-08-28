{5. a. Realizar un módulo que reciba un par de números (numA,numB) y retorne si numB es el doble de
numA.
b. Utilizando el módulo realizado en el inciso a., realizar un programa que lea secuencias de pares de
números hasta encontrar el par (0,0), e informe la cantidad total de pares de números leídos y la cantidad
de pares en las que numB es el doble de numA.
Ejemplo: si se lee la siguiente secuencia: (1,2) (3,4) (9,3) (7,14) (0,0) el programa debe informar los
valores 4 (cantidad de pares leídos) y 2 (cantidad de pares en los que numB es el doble de numA).}

program Ej5;
function esDoble(numA: integer; numB: integer):boolean;
begin
    esDoble := (numB = (numA * 2));
end;
var
    numA, numB, cantLeidos, cantDobles: integer;

begin
    cantDobles := 0;
    cantLeidos := 0;

    writeln('');
    writeln('////////////////////////////////////////////////////////');
    writeln('');

    writeln('Ingrese un par de números: ');
    read(numA, numB);

        while ((numA <> 0) and (numB <> 0)) do begin
            if esDoble(numA, numB) then
                cantDobles := cantDobles + 1;
            cantLeidos := cantLeidos + 1;
            writeln('Ingrese otro par de números: ');
            read(numA, numB);
        end;
    writeln('En ', cantDobles, ' pares B es el doble de A.');
    writeln('Se leyeron ', cantLeidos, ' números.');
end.