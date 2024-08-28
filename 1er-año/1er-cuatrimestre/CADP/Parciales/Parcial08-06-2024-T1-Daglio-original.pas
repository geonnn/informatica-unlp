program parcial;
const
    c_maxPaises = 200;
type
    recRepuesto = record
        codigo: integer;
        pais: integer;
        precio: real;
    end;

    listaRepuestos = ^nodo;
    nodo = record
        dato: recRepuesto;
        sig: listaRepuestos;
    end;

    vecPaises = array[1..c_maxPaises] of integer;

function TieneTresCeros(codigo: integer): boolean;
var
    count, digit: integer;
begin
    count := 0;
    while (codigo <> 0) do
    begin
        digit := codigo MOD 10;
        if (digit = 0) then
            count := count + 1;
        codigo := codigo DIV 10;
    end;
    TieneTresCeros := (count >= 3);
end;

procedure InsertarOrdenado(c: recRepuesto; var LR: listaRepuestos);
var
    act, ant, nue: listaRepuestos;
begin
    new(nue);
    nue^.dato := c;
    act := LR;
    ant := nil;
    while (act <> nil) and (c.codigo > act^.dato.codigo) do
    begin
        ant := act;
        act := act^.sig;
    end;
    if (ant = nil) then
        LR := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure CargarListaRepuestos(var LR: listaRepuestos);
var
    c: recRepuesto;
begin
    writeln('Ingrese codigo, pais (1 a 200) y precio. Ingrese codigo -1 para finalizar.');
    readln(c.codigo);
    while (c.codigo <> -1) do
    begin
        readln(c.pais, c.precio);
        InsertarOrdenado(c, LR);
        readln(c.codigo);
    end;
end;

procedure InicializarVecPaises(var vP: vecPaises);
var
    i: integer;
begin
    for i := 1 to c_maxPaises do
        vP[i] := 0;
end;

procedure RecorrerListaRepuestos(LR: listaRepuestos; var vP: vecPaises; var totalRepuestos: integer; var repuestosTresCeros: integer; var maxPrecio: real; var maxPais: integer);
begin
    totalRepuestos := 0;
    repuestosTresCeros := 0;
    maxPrecio := -1;
    maxPais := -1;
    while (LR <> nil) do
    begin
        vP[LR^.dato.pais] := vP[LR^.dato.pais] + 1;
        totalRepuestos := totalRepuestos + 1;
        if (TieneTresCeros(LR^.dato.codigo)) then
            repuestosTresCeros := repuestosTresCeros + 1;
        if (LR^.dato.precio > maxPrecio) then
        begin
            maxPrecio := LR^.dato.precio;
            maxPais := LR^.dato.pais;
        end;
        LR := LR^.sig;
    end;
end;

function CalcularPromedio(totalRepuestos: integer): real;
begin
    CalcularPromedio := totalRepuestos / c_maxPaises;
end;

procedure InformarResultados(vP: vecPaises; totalRepuestos, repuestosTresCeros: integer; maxPais: integer; maxPrecio: real);
var
    i: integer;
    promedio: real;
begin
    writeln('Cantidad de repuestos comprados por cada pais:');
    for i := 1 to c_maxPaises do
        writeln('Pais ', i, ': ', vP[i]);

    writeln('Cantidad de repuestos comprados con al menos 3 ceros en su codigo: ', repuestosTresCeros);

    writeln('Pais con el repuesto mas caro (Pais, Precio): ', maxPais, ', ', maxPrecio:0:2);

    promedio := CalcularPromedio(totalRepuestos);
    writeln('Promedio de repuestos comprados por pais: ', promedio:0:2);

    if (totalRepuestos < promedio) then
        writeln('La cantidad de repuestos comprados es menor que el promedio de repuestos comprados.');
end;

// programa principal.
var
    LR: listaRepuestos;
    vP: vecPaises;
    totalRepuestos: integer;
    repuestosTresCeros: integer;
    maxPais: integer;
    maxPrecio: real;
begin
    LR := nil;
    CargarListaRepuestos(LR);

    InicializarVecPaises(vP);

    RecorrerListaRepuestos(LR, vP, totalRepuestos, repuestosTresCeros, maxPrecio, maxPais);

    InformarResultados(vP, totalRepuestos, repuestosTresCeros, maxPais, maxPrecio);
end.