{1. Realizar un programa que lea 2 números enteros desde teclado e informe en pantalla cuál de los dos
números es el mayor. Si son iguales debe informar en pantalla lo siguiente:
Los números leídos son iguales}

program P1;
var
    num1: integer;
    num2: integer;
begin
    write ('Ingrese el primer valor:');
    read (num1);
    write ('Ingrese el segundo valor:');
    read (num2);
    if num1 > num2 then
        writeln ('El primer valor es mayor al segundo')
    else
        if num1 = num2 then
            writeln ('Los números leídos son iguales')
        else
            writeln ('El segundo valor es mayor al primero');
end.