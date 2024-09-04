// Programa para probar algoritmos recursivos.
program Recursivos;
const
    dimF = 200;
    MAX = 200;
    MIN = 100;

type
    lista = ^nodo;
    nodo = record
        dato: integer;
        sig: lista;
    end;

    vector = array[1..dimF] of integer;

procedure CargarVector(var v: vector; dimL: integer);
var
    num: integer;
begin
    if (dimL <= dimF) then begin
        num := random(MAX - MIN + 1) + MIN;
        v[dimL] := num;
        CargarVector(v, dimL + 1);
    end;
    // CASO BASE: dimL = dimF + 1. No entra al if y no hace nada. ¿Si hubiera que hacer algo en la última pos del vector?
end;

procedure ImprimirVector(v: vector; dimL: integer);
begin
    if (dimL <= dimF) then begin
        writeln(dimL, '. ', v[dimL]);
        ImprimirVector(v, dimL + 1);
    end;
    // CASO BASE: dimL = dimF + 1. No entra al if y no hace nada. ¿Si hubiera que hacer algo en la última pos del vector?
end;

procedure GenerarLista(var L: lista);
var
    num: integer;
    nue: lista;
begin
    num := random(MAX - MIN + 1) + MIN;
    // num := 100; // Forzar el 100 para pruebas.
    if (num <> 100) then begin
        new(nue);
        nue^.dato := num;
        L := nue;
        L^.sig := nil;
        GenerarLista(L^.sig);
    end;
    // Si hubiera que hacer algo en el caso base iría acá (en un else?).
end;

procedure ImprimirLista(L: lista);
begin
    if (L <> nil) then begin
        writeln(L^.dato);
        ImprimirLista(L^.sig);
    end;
    // Si hubiera que hacer algo en el caso base iría acá (en un else?).
end;

procedure ImprimirListaInverso(L: lista);
begin
    if (L <> nil) then begin
        ImprimirListaInverso(L^.sig);
        writeln(L^.dato);
    end;
    // Si hubiera que hacer algo en el caso base iría acá (en un else?).
end;

function ObtenerMinimo(L: lista): integer;
// cáscara ^
function Minimo(valor1, valor2: integer): integer;
begin
    if (valor1 < valor2) then
        Minimo := valor1
    else
        Minimo := valor2;
end;
//
begin
    if (L <> nil) then
        ObtenerMinimo := Minimo(L^.dato, ObtenerMinimo(L^.sig))
    else
        ObtenerMinimo := maxInt; // Caso base. Inicializa en el dato de tipo integer más grande posible.
end;

function ObtenerMaximo(L: lista): integer;
// cáscara ^
function Maximo(valor1, valor2: integer): integer;
begin
    if (valor1 > valor2) then
        Maximo := valor1
    else
        Maximo := valor2;
end;
//
begin
    if (L <> nil) then
        ObtenerMaximo := Maximo(L^.dato, ObtenerMaximo(L^.sig))
    else
        ObtenerMaximo := -maxInt; // Caso base. Inicializa en el dato de tipo integer más chico posible.
end;

function BuscarValor(L: lista; valor: integer): boolean;
begin
    if (L <> nil) then begin
        if (L^.dato = valor) then
            BuscarValor := true
        else
            BuscarValor := BuscarValor(L^.sig, valor);
    end
    else
        BuscarValor := false; // Caso base.
end;


var
    L: lista;
    valor: integer;
    encontre: boolean;
begin
    randomize;
    L := nil;
    GenerarLista(L);
    writeln;
    writeln;
    writeln('Imprimir lista: ');
    writeln;
    ImprimirLista(L);
    writeln;
    writeln;
    writeln('Imprimir lista inverso: ');
    writeln;
    ImprimirListaInverso(L);
    writeln;
    writeln;
    writeln('Mínimo: ', ObtenerMinimo(L));
    writeln('Máximo: ', ObtenerMaximo(L));
    writeln;
    writeln;
    write ('Ingrese un valor a buscar: ');
    read (valor);
    encontre := BuscarValor(L, valor);
    writeln;
    writeln;
    If (encontre) Then
        writeln('El ', valor, ' está en la lista.')
    Else
        writeln('El ', valor, ' NO está en la lista.');
end.