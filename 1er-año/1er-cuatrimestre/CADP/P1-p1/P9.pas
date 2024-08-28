{9. Realizar un programa que lea un carácter, que puede ser “+” (suma) o “-” (resta); si se ingresa otro carácter,
debe informar un error y finalizar. Una vez leído el carácter de suma o resta, deberá leerse una secuencia
de números enteros que finaliza con 0. El programa deberá aplicar la operación leída con la secuencia de
números, e imprimir el resultado final.
Por ejemplo:
○ Si se lee el carácter “-” y la secuencia 4 3 5 -6 0 , deberá imprimir: 2 (4 – 3 – 5 - (-6) )
○ Si se lee el carácter “+” y la secuencia -10 5 6 -1 0, deberá imprimir: 0 (-10 + 5 + 6 + (-1))}

program P9;
var
    car: char;
    resultado: integer;
    num: integer;
    
begin
    resultado := 0;

    writeln('Ingrese "+" ó "-".');
    readln(car);
    
    if (car = '+') or (car = '-') then begin
        if (car = '+') then begin
            writeln('Ingrese un número entero. Ingrese "0" para finalizar.');
            read(num);
            while (num <> 0) do begin
                resultado := resultado + num;
                writeln('Ingrese un número entero. Ingrese "0" para finalizar.');
                read(num);
            end;
        end
        else begin
            writeln ('Ingrese un número entero. Ingrese "0" para finalizar.');
            read (num);
            while (num <> 0) do begin
                resultado := resultado - num;
                writeln ('Ingrese un número entero. Ingrese "0" para finalizar.');
                read (num);
            end;
        end;
    end
    else
        writeln('Error: el carácter ingresado debe ser "+" ó "-".');
    writeln('El resultado es: ', resultado);
end.