{2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros “random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}

program Ej2;
const
    MAX = 200;
    MIN = 100;

type
    lista = ^nodo;
    nodo = record
        dato: integer;
        sig: lista;
    end;

procedure GenerarLista(var L: lista);
var
    num: integer;
    nue: lista;
begin
    num := random(MAX - MIN + 1) + MIN;
    if (num <> 100) then begin
        new(nue);
        nue^.dato := num;
        L := nue;
        GenerarLista(nue^.sig);
    end;
end;

procedure ImprimirLista(L: lista);
begin
    if (L <> nil) then begin
        writeln(L^.dato);
        L := L^.sig;
        ImprimirLista(L);
    end;
end;

procedure ImprimirListaInverso(L: lista);
begin
    if (L^.sig <> nil) then
        ImprimirListaInverso(L^.sig);
    writeln(L^.dato);
end;

function ObtenerMinimo(L: lista): integer;
var
    minimo: integer;
begin
    if (L^.sig = nil) then
        ObtenerMinimo := L^.dato
    else begin
        minimo := ObtenerMinimo(L^.sig);
        if (L^.dato < minimo) then
            ObtenerMinimo := L^.dato
        else
            ObtenerMinimo := minimo;
    end;
end;

function BuscarValor(L: lista; valor: integer): boolean;
begin
    if (L^.sig = nil) then
        BuscarValor := false
    else
        if (L^.dato = valor) then
            BuscarValor := true
        else
            BuscarValor := BuscarValor(L^.sig, valor);
end;

var
    L: lista;
    encontre: boolean;
    valor: integer;
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