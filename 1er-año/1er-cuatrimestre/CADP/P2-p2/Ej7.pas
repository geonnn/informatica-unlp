{7. a. Realizar un módulo que reciba como parámetro un número entero y retorne la cantidad de dígitos que
posee y la suma de los mismos.
b. Utilizando el módulo anterior, realizar un programa que lea una secuencia de números e imprima la
cantidad total de dígitos leídos. La lectura finaliza al leer un número cuyos dígitos suman exactamente 10,
el cual debe procesarse.}

program Ej7;
procedure Digitos(num: integer; var cantDigitos, sumaDig: integer);
var
    digito: integer;5
begin
    while (num <> 0) do begin
        digito := num MOD 10;
        sumaDig := sumaDig + digito;
        cantDigitos := cantDigitos + 1;
        num := num DIV 10;
    end;
end;
var
    num, cantDig, sumaDig: integer;
begin
    cantDig := 0;
    sumaDig := 0;

    writeln('');
    writeln('--------------------------------------------------------------');
    writeln('');
    repeat
        write('Ingrese un número: ');
        read(num);
        Digitos(num, cantDig, sumaDig);
    until (num = 10);

    writeln('Se ingresaron ', cantDig, ' dígitos.');
    writeln('En total suman ', sumaDig, '.');
end.