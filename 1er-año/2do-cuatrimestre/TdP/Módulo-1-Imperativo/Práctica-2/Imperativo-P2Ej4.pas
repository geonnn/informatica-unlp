{4.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa el número 0 (cero).
Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.}

program Ej4;

procedure Binario(num: integer);
begin
    if (num <> 0) then begin
        Binario(num div 2);
        write(num mod 2);
    end;
end;

procedure LeerNumero(num: integer);
begin
    if (num > 1) then
        Binario(num)
    else
        write(num); // El número es 1. El 0 ingresado para finalizar no entra a la función LeerNumero.
end;


var
    num: integer;
begin
    write('Ingrese un número para pasar a binario: ');
    read(num);
    while (num <> 0) do begin
        write('El número ', num, ' en binario es: ');
        LeerNumero(num);
        writeln;
        write('Ingrese un número para pasar a binario: ');
        readln(num);
    end;
end.