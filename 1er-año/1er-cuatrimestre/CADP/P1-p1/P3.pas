{3. Realizar un programa que lea 3 números enteros y los imprima en orden descendente. Por ejemplo: si se
ingresan los valores 4, -10 y 12, deberá imprimir: 12 4 -10}

program P3;
var
    num1, num2, num3: integer;
    texto: string;

begin

    texto := 'Los números ordenados de forma descendente son: ';

    writeln ('Ingrese el primer número:');
    read (num1);
    
    writeln ('Ingrese el segundo número:');
    read (num2);
    
    writeln ('Ingrese el tercer número:');
    read (num3);
    
    {ver imagen de algoritmo para entender lo siguiente}
    
    if (num1 > num2) then
        if (num1 > num3) then
            if (num2 > num3) then
                writeln (texto, num1,', ', num2,', ', num3)
            else
                writeln (texto, num1,', ', num3,', ', num2)
        else
            writeln (texto, num3,', ', num1,', ', num2)
    else
        if (num2 > num3) then
            if (num1 > num3) then
                writeln (texto, num2,', ', num1,', ', num3)
            else
                writeln (texto, num2,', ', num3,', ', num1)
        else
            writeln (texto, num3,', ', num2,', ', num1)
end.