{4. Realizar un programa que lea un número real X. Luego, deberá leer números reales hasta que se ingrese
uno cuyo valor sea exactamente el doble de X (el primer número leído).}

program P4;
var
    X, X2: real;

begin
    writeln ('Ingrese un número: ');
    read (X);
    X2 := (X * 2);
    while (X <> X2) do
        begin
            writeln ('Ingrese un número: ');
            read (X);
        end;
    writeln ('Se ha ingresado el doble del primer número.');
end.