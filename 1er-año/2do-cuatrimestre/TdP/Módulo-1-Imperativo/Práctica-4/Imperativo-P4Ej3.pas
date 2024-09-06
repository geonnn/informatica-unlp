{3.Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada producto deben quedar almacenados su código, la cantidad total de unidades vendidas y el monto total. De cada venta se lee código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.}

program Ej3;

type

    recVenta = record
        codVenta: integer;
        codProd: integer;
        unidadesVendidas: integer;
        precioUnitario: real;
    end;

    recProducto = record
        codigo: integer;
        totalVendidos: integer;
        montoTotal: real;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record
        dato: recProducto;
        HI: arbol;
        HD: arbol;
    end;

procedure ModuloA(var a: arbol);

    procedure GenerarVenta(var v: recVenta);
    begin
        v.codVenta := (random(51) * 10) - 1;
        if (v.codVenta = -1) then
            writeln('Carga finalizada.')
        else begin
            v.codProd := (random(100) + 1) * 10;
            v.unidadesVendidas := random(10) + 1;
            v.precioUnitario := (100 + random(100))/2;
        end;
    end;

    procedure ArmarProducto(var p: recProducto; v: recVenta);
    begin
        p.codigo := v.codProd;
        p.totalVendidos := v.unidadesVendidas;
        p.montoTotal := v.unidadesVendidas * v.precioUnitario;
    end;

    procedure InsertarProducto(var a: arbol; p: recProducto);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato := p;
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (a^.dato.codigo = p.codigo) then begin
                a^.dato.totalVendidos := a^.dato.totalVendidos + p.totalVendidos;
                a^.dato.montoTotal := a^.dato.montoTotal + p.montoTotal;
            end
            else if (p.codigo <= a^.dato.codigo) then  // Repetidos a la izq.
                InsertarProducto(a^.HI, p)
            else
                InsertarProducto(a^.HD, p);
    end;

var
    v: recVenta;
    p: recProducto;
begin
    writeln;
    writeln ('----- Ingreso de ventas y armado de arbol de productos ----->');
    writeln;
    a := nil;
    GenerarVenta(v);
    while (v.codVenta <> -1) do begin
        ArmarProducto(p, v);
        InsertarProducto(a, p);
        GenerarVenta(v);
    end;
    writeln;
    writeln ('-----------------------------------------------');
    writeln;
end;

procedure ModuloB(var a: arbol);

    procedure ImprimirProductosOrdenCreciente(a: arbol);
    begin
        if (a <> nil) then begin
            ImprimirProductosOrdenCreciente(a^.HI);
            writeln ('-> CodProd: ', a^.dato.codigo, ' | Total vendidos: ', a^.dato.totalVendidos, ' | Monto total: ', a^.dato.montoTotal:0:2);
            ImprimirProductosOrdenCreciente(a^.HD);
        end;
    end;

begin
    writeln;
    writeln ('----- Productos ordenados por código ----->');
    writeln;
    ImprimirProductosOrdenCreciente(a);
    writeln;
    writeln ('-----------------------------------------------');
    writeln;
end;

procedure ModuloC(var a: arbol);

    procedure ActualizarMaximo(var maxNum, maxElem: integer; nuevoNum, nuevoElem: integer);
    begin
        if (nuevoNum > maxNum) then begin
            maxNum := nuevoNum;
            maxElem := nuevoElem;
        end;
    end;

    procedure ObtenerProductoMayorUnidadesVendidas(a: arbol; var maxVendidos, maxCod: integer);
    begin
        if (a <> nil) then begin
            actualizarMaximo(maxVendidos, maxCod, a^.dato.totalVendidos, a^.dato.codigo);
            ObtenerProductoMayorUnidadesVendidas(a^.HI, maxVendidos, maxCod);
            ObtenerProductoMayorUnidadesVendidas(a^.HD, maxVendidos, maxCod);
        end;
    end;

var
    maxVendidos, maxCod: integer;
begin
    writeln;
    writeln ('----- Producto con mayor número de unidades vendidas ----->');
    writeln;
    maxVendidos := -1;
    ObtenerProductoMayorUnidadesVendidas(a, maxVendidos, maxCod);
    if (maxVendidos = -1) then
        writeln('Árbol sin elementos.')
    else
        writeln('El código del producto con más unidades vendidas es: ', maxCod, '.');
    writeln;
    writeln ('-----------------------------------------------');
    writeln;
end;

procedure ModuloD(var a: arbol);

    function CantidadDeCodigosMenores(a: arbol; num: integer): integer;
    begin
        if (a <> nil) then begin
            if (a^.dato.codigo < num) then
                CantidadDeCodigosMenores := 1
            else
                CantidadDeCodigosMenores := 0;
            CantidadDeCodigosMenores := CantidadDeCodigosMenores + CantidadDeCodigosMenores(a^.HI, num) + CantidadDeCodigosMenores(a^.HD, num);
        end
        else
            CantidadDeCodigosMenores := 0;
    end;

var
    num: integer;
begin
    writeln;
    writeln ('----- Productos menores a ----->');
    writeln;
    write('Ingrese un código: ');
    read(num);
    writeln('Existen ', CantidadDeCodigosMenores(a, num), ' códigos menores a ', num, '.');
    writeln;
    writeln ('-----------------------------------------------');
    writeln;
end;

procedure ModuloE(var a: arbol);

    function ObtenerCantidadEntreDosCodigos(a: arbol; num1, num2: integer): integer;
    begin
        if (a <> nil) then begin
            if (a^.dato.codigo > num1) and (a^.dato.codigo < num2) then
                ObtenerCantidadEntreDosCodigos := 1
            else
                ObtenerCantidadEntreDosCodigos := 0;
            ObtenerCantidadEntreDosCodigos := ObtenerCantidadEntreDosCodigos + ObtenerCantidadEntreDosCodigos(a^.HI, num1, num2) + ObtenerCantidadEntreDosCodigos(a^.HD, num1, num2);
        end
        else
            ObtenerCantidadEntreDosCodigos := 0;
    end;

var
    num1, num2, cantidad: integer;
begin
    writeln;
    writeln ('----- Productos entre dos valores ----->');
    writeln;
    write('Ingrese un código: ');
    read(num1);
    write('Ingrese otro código (mayor al anterior): ');
    read(num2);
    cantidad := ObtenerCantidadEntreDosCodigos(a, num1, num2);
    if (cantidad = 0) 
        then writeln ('No hay códigos de producto entre ', num1, ' y ', num2)
    else begin
        writeln;
        writeln ('Entre el código ', num1, ' y el ', num2, ' existen: ', cantidad, ' códigos de producto.'); 
        writeln;
    end;
    writeln;
    writeln ('-----------------------------------------------');
    writeln;
end;

var
    a: arbol;
begin
    randomize;
    ModuloA(a);
    ModuloB(a);
    ModuloC(a);
    ModuloD(a);
    ModuloE(a);
end.