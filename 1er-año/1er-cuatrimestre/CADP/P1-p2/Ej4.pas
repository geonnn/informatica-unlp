{4. Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son los dos
números mínimos leídos.
a. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer el
número 0, el cual debe procesarse.
b. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer el
número 0, el cual no debe procesarse.}

program Ej4;
var
    i: integer;
    num, min1, min2: integer;

begin

    min1 := 9999;
    min2 := 9999;

    for i := 1 to 1000 do begin
        read(num);
        if (num < min1) then begin
            min2 := min1;
            min1 := num;
        end
        else
            if (num < min2) then
                min2 := num;
    end;
    writeln('Mínimo 1: ', min1, ' | Mínimo 2: ', min2);
end.


{program Ej4a;
var
    num, min1, min2: integer;

begin

    min1 := 9999;
    min2 := 9999;

    repeat
        read(num);
        if (num < min1) then begin
            min2 := min1;
            min1 := num;
        end
        else
            if (num < min2) then
                min2 := num;
    until (num = 0);
    writeln('Mínimo 1: ', min1, ' | Mínimo 2: ', min2);
end.}


{program Ej4b;
var
    num, min1, min2: integer;

begin

    min1 := 9999;
    min2 := 9999;
    
    read(num);
    while (num <> 0) do begin
        if (num < min1) then begin
            min2 := min1;
            min1 := num;
        end
        else
            if (num < min2) then
                min2 := num;
        read(num);
    end;
    writeln('Mínimo 1: ', min1, ' | Mínimo 2: ', min2);
end.}