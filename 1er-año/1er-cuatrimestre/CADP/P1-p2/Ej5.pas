{Realizar un programa que lea números enteros desde teclado. La lectura debe finalizar cuando se ingrese el
número 100, el cual debe procesarse. Informar en pantalla:
● El número máximo leído.
● El número mínimo leído.
● La suma total de los números leídos.}

program Ej5;
var
    num, min, max, result: integer;

begin

    min := 9999;
    max := -9999;

    repeat
        read(num);
        if (num < min) then
            min := num
        else
            if (num > max) then
                max := num;
        result := result + num;
    until (num = 100);
    writeln('Mínimo: ', min, ' | Máximo: ', max, ' | Resultado: ', result);
end.