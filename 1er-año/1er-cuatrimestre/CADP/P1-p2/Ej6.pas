{6. Realizar un programa que lea información de 200 productos de un supermercado. De cada producto se lee
código y precio (cada código es un número entre 1 y 200). Informar en pantalla:
● Los códigos de los dos productos más baratos.
● La cantidad de productos de más de 16 pesos con código par.}

program Ej6;
type
    codigo = 1..200;
var
    i: integer;
    codmin1, codmin2, min1, min2, precio, cantM16yPar: integer;
    cod: codigo;

begin

    min1 := 9999;
    min2 := 9999;
    cantM16yPar := 0;

    for i := 1 to 200 do begin
        read(cod);
        read(precio);
        if (precio < min1) then begin
            min2 := min1;
            codmin2 := codmin1;
            min1 := precio;
            codmin1 := cod;
        end
        else
            if (precio < min2) then begin
                min2 := precio;
                codmin2 := cod;
            end;
        if ((cod MOD 2) = 0) and (precio > 16) then
            cantM16yPar := cantM16yPar + 1;
    end;
    writeln('Mínimo 1: Producto N°', codmin1, ', precio: $', min1);
    writeln('Mínimo 2: Producto N°', codmin2, ', precio: $', min2);
    writeln('Productos de código par con valor mayor a $16: ', cantM16yPar);
end.