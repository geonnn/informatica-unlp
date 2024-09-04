{3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros "random" mayores a 300 y menores a 1550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.}

program Ej3;
const
    dimF = 20;
    MAX = 1550;
    MIN = 300;

type
    indice = 1..dimF;
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
    // CASO BASE: dimL = dimF + 1. No entra al if y no hace nada.
end;

procedure ImprimirVector(v: vector; dimL: integer);
begin
    if (dimL <= dimF) then begin
        writeln(dimL, '. ', v[dimL]);
        ImprimirVector(v, dimL + 1);
    end;
    // CASO BASE: dimL = dimF + 1. No entra al if y no hace nada.
end;

procedure OrdenarVectorSeleccion(var v: vector; dimL: integer);
var
    i, j, pos, item: integer;
begin
    for i := 1 to (dimL - 1) do begin
        pos := i;
        for j := i + 1 to dimL do 
            if (v[j] < v[pos]) then
                pos := j;
        item := v[pos];
        v[pos] := v[i];
        v[i] := item;
    end;
            
end;

Procedure busquedaDicotomica(v: vector; ini, fin: indice; dato: integer; var pos: indice);
var
    medio: integer;
begin
    
end;

var
    dimL: integer;
    v: vector;
begin
    randomize;
    dimL := 1;
    CargarVector(v, dimL);
    ImprimirVector(v, dimL);
    writeln;
    writeln;
    OrdenarVectorSeleccion(v, dimF);
    writeln('Vector ordenado: ');
    writeln;
    ImprimirVector(v, dimL);
    writeln;
    writeln;
end.