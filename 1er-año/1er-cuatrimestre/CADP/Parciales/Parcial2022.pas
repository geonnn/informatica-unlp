{Evaluación
Un comercio necesita procesar la información de los pedidos realizados. El comercio dispone de la información de sus 2000 productos. De cada producto se almacena nombre, marca y número de rubro (1 a 15) al que pertenece.

Implementar un programa que:
a) Invoque a un módulo que lea la información de los pedidos y la procese. De cada pedido se lee número de pedido, fecha y todos los productos pedidos en el pedido. De cada producto pedido se lee código de producto (1 a 2000) y cantidad comprada. La lectura de la información de los pedidos finaliza con el número -999 y, para cada pedido, la lectura de sus productos pedidos finaliza con el código de producto -999. El módulo debe:
i-Retornar, en una estructura adecuada, la cantidad de productos pedidos para cada rubro.
ii- Retornar, en una estructura adecuada, los números de pedidos junto a su cantidad de productos pedidos, para los pedidos que tengan más de 10 productos pedidos.
iii-Informar la cantidad total de productos pedidos al comercio.

b) Lea un valor, e invoque a un módulo que reciba el valor leído y la estructura retornada en a) que corresponda para imprimir los números de pedidos que tengan la misma cantidad de dígitos pares e impares y cuyo cantidad total de productos pedidos sea menor al valor recibido.

c) Invoque a un módulo que reciba la estructura retornada en a) que corresponda para retornar el número de rubro con mayor cantidad de productos pedidos. El programa debe informar el valor retornado por el módulo.}

program Parcial2022;
const
    PRODUCTOS = 2000;
type
    str50 = string[50];

    recProductos = record  // Registro para los productos de los que se dispone.
        nombre: str50;
        marca: str50;
        nroRubro: integer;
    end;

    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recProdsPedidos = record 
        codProd: integer;
        cantProd: integer;
    end;

    recPedidos = record // pe
        nroPedido: integer;
        fechaPedido: recFecha;
        prodsP: recProdsPedidos;
    end;

    vecRubro = array[1..15] of integer;
    vecProductos = array[1..PRODUCTOS] of recProductos; // Se dispone.

    recPedidosLista = record //pel
        nroPedido: integer;
        cantProdsPedidos: integer;
    end;

    listaPedidos = ^nodo;
    nodo = record
        dato: recPedidosLista;
        sig: listaPedidos;
    end;

procedure InicializarVector(var vR: vecRubro);
var
    i: integer;
begin
    for i := 1 to 15 do
        vR[i] := 0;
end;

procedure LeerProducto(var prodsPorPedido, prodsTotal: integer; var prod: recProdsPedidos);
begin
    writeln('Ingrese código de producto: ');
    readln(prod.codProd);
    if (prod.codProd = -999) then
        writeln('Pedido finalizado.')
    else begin
        writeln('Ingrese cantidad del producto: ');
        readln(prod.cantProd);
        prodsTotal := prodsTotal + prod.cantProd;
        prodsPorPedido := prodsPorPedido + prod.cantProd;
    end;
end;

procedure LeerProductoInfo(var prod: recProductos); // Se dispone.
begin
    writeln('Ingrese nombre de producto: ');
    readln(prod.nombre);
    writeln('Ingrese la marca del producto: ');
    readln(prod.marca);
    writeln('Ingrese el rubro del producto: ');
    readln(prod.nroRubro);
end;

procedure CargarInfoProductos(var vP: vecProductos); // Se dispone.
var
    i: integer;
    p: recProductos;
begin
    for i := 1 to PRODUCTOS do begin
        LeerProductoInfo(p);
        vP[i] := p;
    end;
end;

procedure LeerFecha(var f: recFecha);
begin
    writeln('Ingrese el día: ');
    readln(f.dia);
    writeln('Ingrese el mes: ');
    readln(f.mes);
    writeln('Ingrese el año: ');
    readln(f.anio);
end;

procedure LeerPedido(var prodsPorPedido, prodsTotal: integer; var pe: recPedidos);
var
    f: recFecha;
    prod: recProdsPedidos;
begin
    writeln('Ingrese número de pedido: ');
    readln(pe.nroPedido);
    if (pe.nroPedido = -999) then
        writeln('Carga total finalizada.')
    else begin
        writeln('Fecha del pedido: ');
        LeerFecha(f);
        writeln('Productos pedidos: ');
        LeerProducto(prodsPorPedido, prodsTotal, prod);
        while (prod.codProd <> -999) do
            LeerProducto(prodsPorPedido, prodsTotal, prod);
    end;
end;

procedure CrearListaPedidos(var LP, LPult: listaPedidos; pel: recPedidosLista); // Lista de pedidos con método fila (agregar atrás), porque son pedidos. El que llega primero sale primero.
var
    nue: listaPedidos;
begin
    new(nue);
    nue^.dato := pel;
    nue^.sig := nil;
    if (LP = nil) then
        LP := nue
    else
        LPult^.sig := nue;
    LPult := nue;
end;

procedure Pedidos(var vR: vecRubro; var LP, LPult: listaPedidos);
var
    prodsPorPedido, prodsTotal: integer;
    pe: recPedidos;
    vP: vecProductos;
    pel: recPedidosLista;
begin
    prodsTotal := 0;
    prodsPorPedido := 0;    // * Para cada bucle del while, o sea, para cada pedido.
    LeerPedido(prodsPorPedido, prodsTotal, pe); // *
    while (pe.nroPedido <> -999) do begin
        if (prodsPorPedido > 10) then begin
            pel.nroPedido := pe.nroPedido;
            pel.cantProdsPedidos := prodsPorPedido;
            CrearListaPedidos(LP, LPult, pel);
        end;
        vR[vP[pe.prodsP.codProd].nroRubro] := vR[vP[pe.prodsP.codProd].nroRubro] + prodsPorPedido;
        prodsPorPedido := 0; // *
        LeerPedido(prodsPorPedido, prodsTotal, pe); // *
    end;
    writeln('En total se pidieron ', prodsTotal, ' productos.')
end;

procedure ImprimirVector(vR: vecRubro);
var
    i: integer;
begin
    for i := 1 to 15 do
        if (vR[i] <> 0) then
            writeln('Rubro ', i, ': ', vR[i], ' productos.');
end;

procedure ImprimirNodo(pel: recPedidosLista);
begin
    writeln('Nro. de pedido: ', pel.nroPedido, '.');
    writeln('Cantidad de productos: ', pel.cantProdsPedidos, '.');
end;

procedure ImprimirLista(LP: listaPedidos);
begin
    while (LP <> nil) do begin
        ImprimirNodo(LP^.dato);
        LP := LP^.sig;
    end;
end;

var
    LP, LPult: listaPedidos;
    vR: vecRubro;
    vP: vecProductos;
begin
    CargarInfoProductos(vP); // Se dispone.
    InicializarVector(vR);
    LP := nil;

    Pedidos(vR, LP, LPult);
    ImprimirVector(vR);
    ImprimirLista(LP);
end.