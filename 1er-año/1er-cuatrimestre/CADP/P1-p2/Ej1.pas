{1. Realizar un programa que lea 10 números enteros e informe la suma total de los números leídos.
a. Modifique el ejercicio 1 para que además informe la cantidad de números mayores a 5.}

program Ej1;
var
    i: integer;
    total, num, numsM5: integer;

begin
    total := 0;
    numsM5 := 0;
    for i := 1 to 10 do begin
        writeln('Ingrese un número: ');
        read(num);
        total := total + num;
        if (num > 5) then
            numsM5 := numsM5 + 1;
    end;
    writeln('La suma de todos los números es: ', total,'.');
    writeln(numsM5, ' números ingresados fueron mayores a 5.');
end.