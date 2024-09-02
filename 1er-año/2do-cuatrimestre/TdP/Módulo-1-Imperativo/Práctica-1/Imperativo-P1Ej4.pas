{4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).}

program Ej4;
type
    recProducto = record
        codProd: integer;
        codRubro: 1..8;
        precio: real;
    end;

    listaProductos = ^nodo;
    nodo = record
        dato: recProducto;
        sig: listaProductos;
    end;

    vecListas = array[1..8] of listaProductos;
    vecRub3 = array[1..30] of recProducto;

procedure LeerProducto(var p: recProducto);
begin
    writeln('Ingrese precio del producto: ');
    readln(p.precio);
    if (p.precio = 0) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese código del producto: ');
        readln(p.codProd);
        writeln('Ingrese código de rubro (del 1 al 8): ');
        readln(p.codRubro);
    end;
end;

procedure InsertarOrdenado(p: recProducto; var L: listaProductos);
var
    act, nue, ant: listaProductos;
begin
    new(nue);
    nue^.dato := p;
    act := L;
    while (act <> nil) and (p.codProd > act^.dato.codProd) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = L) then
        L := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

// Hay una lista en cada posición del vector. Se envía por parámetro a InsertarOrdenado la lista que está en la posición del vector correspondiente al rubro del producto que ingresa.
procedure CargarVecL(var vL: vecListas);
var
    p: recProducto;
begin
    LeerProducto(p);
    while (p.precio <> 0) do begin
        InsertarOrdenado(p, vL[p.codRubro]);
        LeerProducto(p);
    end;
end;

procedure InicializarVecL(var vL: vecListas);
var
    i: integer;
begin
    for i := 1 to 8 do
        vL[i] := nil;
end;

procedure CargarVecR3(p: recProducto; var vR3: vecRub3; var vR3_dimL: integer);
begin
    vR3_dimL := vR3_dimL + 1;
    vR3[vR3_dimL] := p;
end;

procedure RecorrerLista(L: listaProductos; r3: boolean; var vR3: vecRub3; var vR3_dimL: integer);
begin
    if (r3) then // si r3 es verdadero se carga el vector y se imprime, sino, sólo se imprime.
        while (L <> nil) do begin // Entra al while y se verifica el vector con un if después. Poniendo la condición del if en el while cuando se llene el vector dejaría de imprimir los productos restantes del rubro 3.
            if (vR3_dimL < 30) then // El vector sólo puede cargar hasta 30 productos. 
                CargarVecR3(L^.dato, vR3, vR3_dimL);
            writeln(L^.dato.codProd);
            L := L^.sig;
        end
    else
        while (L <> nil) do begin
            writeln(L^.dato.codProd);
            L := L^.sig;
        end;
end;

procedure RecorrerVecL(vL: vecListas; var vR3: vecRub3; var vR3_dimL: integer);
var
    i: integer;
    r3: boolean;
begin
    for i := 1 to 8 do begin
        r3 := false;
        if (i = 3) then // Para no recorrer dos veces la lista: si es el rubro 3 se pone r3 en true.
            r3 := true;
        writeln('');
        writeln('Rubro ', i, ':');
        RecorrerLista(vL[i], r3, vR3, vR3_dimL); // Se envía por valor r3.
        writeln('');
    end;
end;

procedure OrdenarVecR3(var vR3: vecRub3; vR3_dimL: integer);
var
    i, j, pos: integer;
    item: recProducto;
begin
    for i := 1 to (vR3_dimL - 1) do begin
        pos := i;
        for j := i + 1 to vR3_dimL do
            if (vR3[j].precio < vR3[pos].precio) then
                pos := j;
        item := vR3[pos];
        vR3[pos] := vR3[i];
        vR3[i] := item;
    end;
end;

procedure ImprimirVector(vR3: vecRub3; vR3_dimL: integer; var promRub3: real);
var
    i: integer;
    total: real;
begin
    total := 0;
    writeln('Productos rubro 3 ordenados por precio:');
    for i := 1 to vR3_dimL do begin
        writeln(i, '. ', 'Código ', vR3[i].codProd, ':   $', vR3[i].precio:0:2);
        total := total + vR3[i].precio;
    end;
    writeln('total: ', total:0:2);
    promRub3 := (total / vr3_diml);
end;

var
    vR3: vecRub3;
    vL: vecListas;
    vR3_dimL: integer;
    promRub3: real;
begin
    promRub3 := 0;
    vR3_dimL := 0;
    InicializarVecL(vL);
    CargarVecL(vL);
    RecorrerVecL(vL, vR3, vR3_dimL);
    OrdenarVecR3(vR3, vR3_dimL);
    writeln('');
    ImprimirVector(vR3, vR3_dimL, promRub3);
    writeln('');
    writeln('vr3_diml: ', vr3_diml);
    writeln('');
    writeln('Promedio de precios rubro 3: ', promRub3:0:2);
end.