{5. Realizar un programa que lea y almacene la información de productos de un supermercado. De cada producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se ingresa el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular e informar:
a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
c. Código de los dos productos más económicos.}

program Ej5;
type
    str50 = string[50];
    producto = record
        codigo: integer;
        descripcion: str50;
        stockAct: integer;
        stockMin: integer;
        precio: real;
    end;
    lista = ^nodo;
    nodo = record
        dato: producto;
        sig: lista;
    end;

procedure cargarProducto(var p: producto);
begin
    writeln('Ingrese el código del producto: ');
    readln(p.codigo);
    if (p.codigo = -1) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese una descripción del producto: ');
        readln(p.descripcion);
        writeln('Ingrese el stock actual del producto: ');
        readln(p.stockAct);
        writeln('Ingrese el stock mínimo del producto: ');
        readln(p.stockMin);
        writeln('Ingrese el precio del producto: ');
        readln(p.precio);
    end;
end;

procedure cargarLista(var L: lista);
var
    p: producto;
    nue: lista;
begin
    cargarProducto(p);
    while (p.codigo <> -1) do begin
        new(nue);
        nue^.dato := p;
        nue^.sig := L;
        L := nue;
        cargarProducto(p);
    end;
end;

procedure prodsValorMin(var codMin1, codMin2: integer; var precioMin1, precioMin2: real; codigo: integer; precio: real);
begin
    if (precio < precioMin1) then begin
        precioMin2 := precioMin1;
        codMin2 := codMin1;
        precioMin1 := precio;
        codMin1 := codigo;
    end
    else
        if (precio < precioMin2) then begin
            precioMin2 := precio;
            codMin2 := codigo;
        end;
end;

procedure digPares(codigo: integer; desc: str50);
var
    cantPares, dig: integer;
begin
    cantPares := 0;
    while (codigo <> 0) and (cantPares < 3) do begin
        dig := codigo MOD 10;
        if ((dig MOD 2) = 0) then
            cantPares := cantPares + 1;
        codigo := codigo DIV 10;
    end;
    if (cantPares >= 3) then
        writeln('Descripción de producto con 3 o más dígitos pares: ', desc);
end;

procedure Recorrido1(L: lista; var porc: real; var codMin1, codMin2: integer);
var
    cantProdDebMin, cantProdTotal: integer;
    precioMin1, precioMin2: real;
begin
    precioMin1 := maxInt;
    precioMin2 := maxInt;
    cantProdDebMin := 0;
    cantProdTotal := 0;
    while (L <> nil) do begin
        if (L^.dato.stockAct < L^.dato.stockMin) then
            cantProdDebMin := cantProdDebMin + 1;
        digPares(L^.dato.codigo, L^.dato.descripcion);
        prodsValorMin(codMin1, codMin2, precioMin1, precioMin2, L^.dato.codigo, L^.dato.precio);
        cantProdTotal := cantProdTotal + 1;
        L := L^.sig;
    end;
    porc := (cantProdDebMin * 100) / cantProdTotal;
end;

var
    L: lista;
    porc: real;
    codMin1, codMin2: integer;
begin
    L := nil;
    cargarLista(L);
    Recorrido1(L, porc, codMin1, codMin2);
    writeln('Porcentaje de productos con stock actual por debajo de su stock mínimo: ', porc:0:2, '%.');
    writeln('Código de los dos productos más económicos: ', codMin1, ' | ', codMin2, '.');
end.