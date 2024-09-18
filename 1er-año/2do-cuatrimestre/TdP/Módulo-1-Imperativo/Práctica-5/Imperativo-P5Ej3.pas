{3.Un supermercado requiere el procesamiento de sus productos. De cada producto se conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados.}

program Ej3;
const
    RUB = 10;

type

    recProducto = record
        codigo: integer;
        rubro: 1..RUB;
        stock: integer;
        precio_unit: real;
    end;

//--------------------------------------------

    recProductoParaArbol = record
        codigo: integer;
        stock: integer;
        precio_unit: real;
    end;

    arbol_productos = ^nodoArbol;
    nodoArbol = record
        dato: recProductoParaArbol;
        HI, HD: arbol_productos;
    end;

    vecRubro = array[1..RUB] of arbol_productos;

procedure ModuloA(var v: vecRubro);

    procedure GenerarProducto(var p: recProducto);
    begin
        p.codigo := random(1000);
        if (p.codigo = 0) then
            writeln('Carga finalizada.')
        else begin
            p.rubro := random(10) + 1;
            p.stock := random(50) + 1;
            p.precio_unit := (random(9999) + 1)/(random(10) + 1);
        end;
    end;
    
    procedure InicializarArboles(var v: vecRubro);
    var
        i: integer;
    begin
        for i := 1 to RUB do
            v[i] := nil;
    end;

    procedure CopiarDatos(var pa: recProductoParaArbol; p: recProducto);
    begin
        pa.codigo := p.codigo;
        pa.stock := p.stock;
        pa.precio_unit := p.precio_unit;
    end;

    procedure InsertarProducto(var a: arbol_productos; p: recProductoParaArbol);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato := p;
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (p.codigo > a^.dato.codigo) then
                InsertarProducto(a^.HD, p)
            else
                InsertarProducto(a^.HI, p);
    end;

    procedure ImprimirProducto(p: recProductoParaArbol);
    begin
        writeln;
        write('    - Código: ', p.codigo);
        write(' | Stock: ', p.stock);
        write(' | P.unit.: $', p.precio_unit:0:2);
    end;


    procedure ImprimirArbol(a: arbol_productos);
    begin
        if (a <> nil) then begin
            ImprimirArbol(a^.HI);
            ImprimirProducto(a^.dato);
            ImprimirArbol(a^.HD);
        end;
    end;

    procedure ImprimirVector(v: vecRubro);
    var
        i: integer;
    begin
        for i := 1 to RUB do begin
            writeln;
            writeln;
            writeln('-> Rubro ', i);
            ImprimirArbol(v[i]);
        end;
    end;

var
    pa: recProductoParaArbol;
    p: recProducto;
begin
    InicializarArboles(v);
    GenerarProducto(p);
    while (p.codigo <> 0) do begin
        CopiarDatos(pa, p);
        InsertarProducto(v[p.rubro], pa);
        GenerarProducto(p);
    end;
    ImprimirVector(v);
    writeln;
    writeln;
    writeln('////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloB(v: vecRubro);

    function BuscarProducto(a: arbol_productos; codInput: integer): boolean;
    begin
        if (a <> nil) then begin
            if (codInput = a^.dato.codigo) then
                BuscarProducto := true
            else
                if (codInput > a^.dato.codigo) then
                    BuscarProducto := BuscarProducto(a^.HD, codInput)
                else
                    BuscarProducto := BuscarProducto(a^.HI, codInput);
        end
        else
            BuscarProducto := false;
    end;

var
    rubInput, codInput: integer;
begin
    writeln;
    writeln('------ Buscar producto dentro de un rubro ------');
    writeln;
    write('Ingrese rubro (del 1 al 10): ');
    read(rubInput);
    while (rubInput < 1) or (rubInput > 10) do begin
        write('Ingrese rubro (¡¡¡¡del 1 al 10!!!!!): ');
        read(rubInput);
    end;
    write('Ingrese código de producto: ');
    read(codInput);
    if (BuscarProducto(v[rubInput], codInput)) then
        writeln('El producto existe.')
    else
        writeln('El producto NO existe.');
    writeln;
    writeln('////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloC(v: vecRubro);
{Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del producto con mayor código.}

    procedure ActualizarMaximo(var codMax, stockMax: integer; codNuevo, stockNuevo: integer);
    begin
        codMax := codNuevo;
        stockMax := stockNuevo;
    end;

    procedure ProdMaxCod(var codMax, stockMax: integer; a: arbol_productos);
    begin
        if (a <> nil) then
            if (codMax > a^.dato.codigo) then
                ProdMaxCod(codMax, stockMax, a^.HD)
            else begin
                ActualizarMaximo(codMax, stockMax, a^.dato.codigo, a^.dato.stock);
                ProdMaxCod(codMax, stockMax, a^.HD);
            end;
    end;

    procedure ImprimirVector(v: vecRubro);
    var
        i, codMax, stockMax: integer;
    begin
        for i := 1 to RUB do begin
            codMax := -1;
            writeln;
            writeln;
            writeln('-> Rubro ', i);
            ProdMaxCod(codMax, stockMax, v[i]);
            write('    - Código máximo: ', codMax);
            write(' | Stock: ', stockMax);
        end;
    end;

begin
    writeln;
    writeln('------ Stock producto mayor código ------');
    writeln;
    ImprimirVector(v);
    writeln;
    writeln;
    writeln('////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloD(v: vecRubro);
{Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados.}

    function CantProductos(a: arbol_productos; cod1, cod2: integer): integer;
    begin
        if (a <> nil) then
            if (a^.dato.codigo > cod1) then
                if (a^.dato.codigo < cod2) then
                    CantProductos := 1 + CantProductos(a^.HI, cod1, cod2) + CantProductos(a^.HD, cod1, cod2)
                else
                    CantProductos := CantProductos(a^.HI, cod1, cod2)
            else
                CantProductos := CantProductos(a^.HD, cod1, cod2)
        else
            CantProductos := 0;
    end;

    procedure ImprimirVector(v: vecRubro; cod1, cod2: integer);
    var
        i: integer;
    begin
        for i := 1 to RUB do begin
            writeln;
            writeln;
            writeln('-> Rubro ', i);
            writeln('Hay ', CantProductos(v[i], cod1, cod2), ' entre los valores ', cod1, ' y ', cod2, '.');
        end;
    end;

var
    cod1, cod2: integer;
begin
    writeln;
    writeln('------ Cantidad de productos entre dos valores ------');
    writeln;
    write('Ingrese un código: ');
    read(cod1);
    write('Ingrese otro código (mayor al anterior): ');
    read(cod2);
    ImprimirVector(v, cod1, cod2);
    writeln;
    writeln('////////////////////////////////////////////////');
    writeln;
end;


var
    vR: vecRubro;
begin
    randomize;
    ModuloA(vR);
    ModuloB(vR);
    ModuloC(vR);
    ModuloD(vR);
end.
