{6. a. Realice un módulo que lea de teclado números enteros hasta que llegue un valor negativo. Al finalizar la lectura el módulo debe imprimir en pantalla cuál fue el número par más alto.
b. Implemente un programa que invoque al módulo del inciso a.}

program Ej6;
function NumerosPares: integer;
var
    num: integer;
begin

    NumerosPares := -1;

    writeln('Ingrese un número: ');
    readln(num);
    while (num >= 0) do begin
        if (num > NumerosPares) then
            NumerosPares := num;
        writeln('Ingrese un número: ');
        readln(num);
    end;
    writeln('El número par más alto es ', NumerosPares)
end;
begin
    NumerosPares;
end.