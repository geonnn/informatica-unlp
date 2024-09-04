{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio. Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la lista de las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el có digo de producto con mayor cantidad total de unidades vendidas.
c. Implemente un módulo que reciba el árbol generado en iii. y retorne el có digo de producto con mayor cantidad de ventas.}

program Ej2;
const
    ANIOMIN = 2020;
    ANIOMAX = 2024;
type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: 2000..2024;
    end;

    recVenta = record
        codProducto: integer;
        fecha: recFecha;
        cantUnidades: integer;
    end;

    // Árbol 1: cada nodo es una venta.
    arbol_ventas = ^nodoArbolVentas;
    nodoArbolVentas = record
        dato: recVenta;
        HI: arbol_ventas;
        HD: arbol_ventas;
    end;

    // Árbol 2: cada nodo tiene código y cantidad de unidades vendidas.
    recProducto = record
        codProducto: integer;
        cantVendidos: integer;
    end;
    //
    arbol_productos = ^nodoArbolProductos;
    nodoArbolProductos = record
        dato: recProducto;
        HI: arbol_productos;
        HD: arbol_productos;
    end;

    // Árbol 3: cada nodo tiene código y lista de ventas.
    listaVentas = ^nodoListaVentas;
    nodoListaVentas = record
        dato: recVenta;
        sig: listaVentas;
    end;
    //
    recProductoVentas = record
        codProducto: integer;
        lista_de_ventas_en_rec: listaVentas;
    end;
    //
    arbol_productos_listaVentas = ^nodoArbolProductosVentas;
    nodoArbolProductosVentas = record
        dato: recProductoVentas;
        HI: arbol_productos_listaVentas;
        HD: arbol_productos_listaVentas;
    end;

procedure GenerarFecha(var f: recFecha);
begin
    f.dia := random(31) + 1;
    f.mes := random(12) + 1;
    f.anio := random(ANIOMAX - ANIOMIN + 1) + ANIOMIN;
end;

procedure GenerarVenta(var v: recVenta);
begin
    v.codProducto := random(201);
    // v.codProducto := 0;
    if (v.codProducto <> 0) then begin
        GenerarFecha(v.fecha);
        v.cantUnidades := random(10) + 1; // máximo 10 unidades de c/ producto.
    end
    else
        writeln('Carga finalizada.');
end;

// --------------------------- ÁRBOL 1 ----------------------------------

// Ingresar ventas para árbol 1.
procedure IngresarVenta(var a: arbol_ventas; v: recVenta);
begin
    if (a = nil) then begin
        new(a);
        a^.dato := v;
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (v.codProducto >= a^.dato.codProducto) then
            IngresarVenta(a^.HD, v)
        else
            IngresarVenta(a^.HI, v);
end;

// Imprimir para árbol 1.
procedure ImprimirArbolVentas(a: arbol_ventas);

    procedure ImprimirVenta(v: recVenta);
    begin
        writeln;
        write('-> CodProd: ', v.codProducto);
        write(' | Fecha: ', v.fecha.dia, '/', v.fecha.mes, '/', v.fecha.anio);
        write(' | Cantidad de unidades: ', v.cantUnidades);
    end;

begin
    if (a <> nil) then begin
        ImprimirArbolVentas(a^.HI);
        ImprimirVenta(a^.dato);
        ImprimirArbolVentas(a^.HD);
    end;
end;
/////////////////////////////////////////////////////////////

// --------------------------- ÁRBOL 2 ----------------------------------

// Ingresar productos para árbol 2.
procedure IngresarProducto(var a: arbol_productos; v: recVenta);
begin
    if (a = nil) then begin
        new(a);
        a^.dato.codProducto := v.codProducto;
        a^.dato.cantVendidos := v.cantUnidades;
        a^.HI := nil;
        a^.HD := nil;
    end
    else
    if (v.codProducto = a^.dato.codProducto) then
        a^.dato.cantVendidos := a^.dato.cantVendidos + v.cantUnidades
    else
        if (v.codProducto > a^.dato.codProducto) then
            IngresarProducto(a^.HD, v)
        else
            IngresarProducto(a^.HI, v);
end;

// Imprimir para árbol 2.
procedure ImprimirArbolProductos(a: arbol_productos);
    
    procedure ImprimirProducto(p: recProducto);
    begin
        writeln;
        write('-> CodProd: ', p.codProducto);
        write(' | Cantidad de vendidos: ', p.cantVendidos);
    end;

begin
    if (a <> nil) then begin
        ImprimirArbolProductos(a^.HI);
        ImprimirProducto(a^.dato);
        ImprimirArbolProductos(a^.HD);
    end;
end;
/////////////////////////////////////////////////////////////

// --------------------------- ÁRBOL 3 ----------------------------------

// Ingresar productos y lista de ventas para árbol 3.
procedure IngresarProductoListaVentas(var a: arbol_productos_listaVentas; v: recVenta);

    procedure CargarVentaEnLista(var L: listaVentas; v: recVenta);
    var
        nue: listaVentas;
    begin
        if (L = nil) then begin // CASO BASE: Se busca el fondo de la lista y se carga la nueva venta.
            new(nue);
            nue^.dato := v;
            L := nue;
            L^.sig := nil;
        end
        else
            CargarVentaEnLista(L^.sig, v)
    end;

begin
    if (a = nil) then begin
        new(a);
        a^.dato.codProducto := v.codProducto;
        a^.dato.lista_de_ventas_en_rec := nil; // Inicializo la lista. En este punto se sabe que el producto no está cargado, por lo tanto tampoco habrá una lista de ventas del mismo.
        CargarVentaEnLista(a^.dato.lista_de_ventas_en_rec, v); // Se llama a un proceso para cargar la lista. Acá se envía L = nil. Va al if del proceso.
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (v.codProducto = a^.dato.codProducto) then
            CargarVentaEnLista(a^.dato.lista_de_ventas_en_rec, v) // En este punto L <> nil. Va directo al else del proceso.
        else
            if (v.codProducto > a^.dato.codProducto) then
                IngresarProductoListaVentas(a^.HD, v)
            else
                IngresarProductoListaVentas(a^.HI, v);
end;

// Imprimir para árbol 3.
procedure ImprimirArbolProductosListaVentas(a: arbol_productos_listaVentas);

    procedure ImprimirLista(L: listaVentas);
    begin
        if (L <> nil) then begin
            writeln;
            write('        - ');
            write(' Fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes, '/', L^.dato.fecha.anio);
            write(' | Cantidad de unidades: ', L^.dato.cantUnidades);
            ImprimirLista(L^.sig);
        end;
    end;

    procedure ImprimirProductoVentas(pv: recProductoVentas);
    begin
        writeln;
        write('-> CodProd: ', pv.codProducto);
        ImprimirLista(pv.lista_de_ventas_en_rec);
    end;

begin
    if (a <> nil) then begin
        ImprimirArbolProductosListaVentas(a^.HI);
        ImprimirProductoVentas(a^.dato);
        ImprimirArbolProductosListaVentas(a^.HD);
    end;
end;
/////////////////////////// FIN ÁRBOLES ////////////////////////////////

procedure GenerarArboles(var a1: arbol_ventas; var a2: arbol_productos; var a3: arbol_productos_listaVentas);
var
    v: recVenta;
begin
    GenerarVenta(v);
    while (v.codProducto <> 0) do begin
        IngresarVenta(a1, v);
        IngresarProducto(a2, v);
        IngresarProductoListaVentas(a3, v);
        GenerarVenta(v);
    end;
end;

procedure LeerFecha(var f: recFecha);
begin
    writeln('Búsqueda de productos vendidos por fecha.');
    writeln;
    write('Ingrese el día: ');
    readln(f.dia);
    write('Ingrese el mes: ');
    readln(f.mes);
    write('Ingrese el año: ');
    readln(f.anio);
end;

function ProductosVendidosPorFecha(a: arbol_ventas; f: recFecha): integer;

    function CompararFechas(f1, f2: recFecha): boolean;
    begin
        if (f1.dia <> f2.dia) or (f1.mes <> f2.mes) or (f1.anio <> f2.anio) then
            CompararFechas := false
        else
            CompararFechas := true;
    end;

begin
    if (a <> nil) then begin
        if (CompararFechas(a^.dato.fecha, f)) then
            ProductosVendidosPorFecha := a^.dato.cantUnidades
        else
            ProductosVendidosPorFecha := 0;
        ProductosVendidosPorFecha := ProductosVendidosPorFecha + ProductosVendidosPorFecha(a^.HI, f) + ProductosVendidosPorFecha(a^.HD, f);
    end
    else
        ProductosVendidosPorFecha := 0;
end;

procedure ActualizarMaximo(var valorMax, codMax: integer; valorNuevo, codNuevo: integer);
begin
    if (valorNuevo > valorMax) then begin
        valorMax := valorNuevo;
        codMax := codNuevo;
    end;
end;

procedure ObtenerMaximoUnidadesVendidas(a: arbol_productos; var cMax: integer);

    procedure CodigoMaxUnidadesVendidas(a: arbol_productos; var vMax, cMax: integer);
    begin
        if (a <> nil) then begin
            ActualizarMaximo(vMax, cMax, a^.dato.cantVendidos, a^.dato.codProducto);
            CodigoMaxUnidadesVendidas(a^.HI, vMax, cMax);
            CodigoMaxUnidadesVendidas(a^.HD, vMax, cMax);
        end;
    end;
var
    valor_max_unidades_vendidas: integer;
begin
    valor_max_unidades_vendidas := -1;
    CodigoMaxUnidadesVendidas(a, valor_max_unidades_vendidas, cMax);
end;

procedure ObtenerMaximoVentas(a: arbol_productos_listaVentas; var cMax: integer);

    procedure ContarVentasEnLista(L: listaVentas; var cantVentas: integer);
    begin
        if (L <> nil) then begin
            cantVentas := cantVentas + 1;
            ContarVentasEnLista(L^.sig, cantVentas);
        end;
    end;

    procedure CodigoMaxVentas(a: arbol_productos_listaVentas; var vMax, cMax: integer);
    var
        cantVentas: integer;
    begin
        if (a <> nil) then begin
            cantVentas := 0;
            ContarVentasEnLista(a^.dato.lista_de_ventas_en_rec, cantVentas);
            ActualizarMaximo(vMax, cMax, cantVentas, a^.dato.codProducto);
            CodigoMaxVentas(a^.HI, vMax, cMax);
            CodigoMaxVentas(a^.HD, vMax, cMax);
        end
    end;

var
    valor_max_ventas: integer;
begin
    valor_max_ventas := -1;
    CodigoMaxVentas(a, valor_max_ventas, cMax);
end;

var
    a1: arbol_ventas;
    a2: arbol_productos;
    a3: arbol_productos_listaVentas;
    v: recVenta;
    f: recFecha;
    codigo_max_unidades_vendidas: integer;
    codigo_max_ventas: integer;
begin
    randomize;
    GenerarArboles(a1, a2, a3);
    writeln;
    writeln('----- ARBOL VENTAS (1) ------');
    ImprimirArbolVentas(a1);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////////////////');
    writeln;
    writeln;
    writeln('----- ARBOL PRODUCTOS (2) ------');
    ImprimirArbolProductos(a2);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////////////////');
    writeln;
    writeln;
    writeln('----- ARBOL PRODUCTOS Y LISTA DE VENTAS (3) ------');
    ImprimirArbolProductosListaVentas(a3);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////////////////');
    writeln;
    //LeerFecha(f);
    writeln('En ese día se vendieron: ', ProductosVendidosPorFecha(a1, f), ' productos.');
    writeln;
    ObtenerMaximoUnidadesVendidas(a2, codigo_max_unidades_vendidas);
    writeln('El código del producto más vendido es: ', codigo_max_unidades_vendidas, '.');
    writeln;
    ObtenerMaximoVentas(a3, codigo_max_ventas);
    writeln('El código del producto con mayor cantidad de ventas es: ', codigo_max_ventas, '.');
    writeln;
end.