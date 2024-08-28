{6. Realizar un programa modularizado que lea datos de 100 productos de una tienda de ropa. Para cada
producto debe leer el precio, código y tipo (pantalón, remera, camisa, medias, campera, etc.). Informar:
● Código de los dos productos más baratos.
● Código del producto de tipo “pantalón” más caro.
● Precio promedio.}

program Ej6;

// Módulo para calcular los dos productos más baratos.
procedure Mins(cod: integer; precio: real; var cMin1, cMin2: integer; var pMin1, pMin2: real);
begin
    if (precio < pMin1) then begin
        pMin2 := pMin1; cMin2 := cMin1;
        pMin1 := precio; cMin1 := cod;
    end
    else
        if (precio < pMin2) then begin
            pMin2 := precio; cMin2 := cod;
        end;
end;

// Módulo para calcular el pantalón más caro.
procedure PantalonMasCaro(cod: integer; tipo: string; precio: real; var cMax: integer; var pMax: real);
begin
    if ((precio > pMax) and (tipo = 'pantalon')) then begin
        pMax := precio; cMax := cod;
    end;
end;

// Función para calcular promedio de precios.
function Prom(precios: real; totProds: integer): real;
begin
    Prom := (precios / totProds);
end;
const
    cantProductos = 100;
var
    codigo, i, codMin1, codMin2, codMax: integer;
    precio, preciosTotal, precioMin1, precioMin2, precioMax: real;
    tipo: string;

begin
    preciosTotal := 0;
    precioMin1 := maxInt;
    precioMin2 := maxInt;
    precioMax := -9999;

    writeln('');
    writeln('--------------------------------------------------------------');
    writeln('');

    for i := 1 to cantProductos do begin
        write('Ingrese el código del producto: ');
        readln(codigo);
        write('Ingrese el tipo de producto: ');
        readln(tipo);
        write('Ingrese el precio del producto: ');
        readln(precio);

        preciosTotal := preciosTotal + precio;
        Mins(codigo, precio, codMin1, codMin2, precioMin1, precioMin2);
        PantalonMasCaro(codigo, tipo, precio, codMax, precioMax);
    end;
    
    writeln('');
    writeln('--------------------------------------------------------------');
    writeln('');

    writeln('Los dos productos más baratos son: ');
    writeln('Producto ', codMin1, '.');
    writeln('Producto ', codMin2, '.');
    writeln('');
    writeln('El pantalón más caro es el producto ', codMax, '.');
    writeln('');
    writeln('El promedio de precios es de $', Prom(preciosTotal, cantProductos):0:2, '.');

    writeln('');
    writeln('--------------------------------------------------------------');
    writeln('');
end.