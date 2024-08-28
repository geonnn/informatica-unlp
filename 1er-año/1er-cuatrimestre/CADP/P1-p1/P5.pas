{5. Modifique el ejercicio anterior para que, luego de leer el número X, se lean a lo sumo 10 números reales.
La lectura deberá finalizar al ingresar un valor que sea el doble de X, o al leer el décimo número, en cuyo
caso deberá informarse: No se ha ingresado el doble de X}

program P5;
var
    X, X2: real;
    aux: integer;
    
begin

    {lee el primer número X y asigna el doble de X a X2}
    writeln ('Ingrese un número X: ');
    read (X);
    X2 := (X * 2);
    aux := 0;
    
    {utilizando la misma variable X, se entra en loop hasta que su valor sea igual a X2 o se ingresen 10 números}
    while (X <> X2) and (aux < 10) do
        begin
            writeln ('Ingrese un número: ');
            read (X);
            aux := aux + 1;
        end;
        
    if (X = X2) then
        writeln ('Se ha ingresado el doble de X.')
    else
        writeln ('No se ha ingresado el doble de X.')
        
end.