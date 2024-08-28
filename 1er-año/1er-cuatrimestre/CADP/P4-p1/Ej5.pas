{5. Utilizando los módulos implementados en el ejercicio 4, realizar un programa que lea números enteros desde teclado (a lo sumo 100) y los almacene en un vector. La carga finaliza al leer el número 0. Al finalizar la carga, se debe intercambiar la posición del mayor elemento por la del menor elemento, e informe la operación realizada de la siguiente manera: “El elemento máximo ... que se encontraba en la posición ... fue intercambiado con el elemento mínimo ... que se encontraba en la posición ...”. 2}

// (Ej4): Se asume que el vector tiene dimL = dimF = 100. Podría ser que el vector tenga dimF > 100 y la dimL = 100.
// Ahora para el ej 5 uso dimL.

program Ej5;
const
    dimF = 100;

type
    vector = array[1..dimF] of integer;

procedure Posicion(v: vector; dimL, num: integer; var r: integer);
begin
    if (num < 1) or (num > dimL) then
        r := -1
    else
        r := v[num];
end;

// procedure Intercambio(v: vector; numx, numy: integer);

procedure SumaVector(v: vector; dimL: integer; var suma: integer);
var
    i: integer;
begin
    suma := 0;
    for i:= 1 to dimL do
        suma := suma + v[i];
end;

procedure Promedio(v: vector; dimL: integer; var prom: real);
var
    suma: integer;
begin
    SumaVector(v, dimL, suma);
    prom := suma / dimL;
end;

procedure ElementoMaximo(v: vector; dimL: integer; var vecMax, numMax: integer);
var
    i: integer;
begin
    numMax := -9999;
    for i := 1 to dimL do
        if (v[i] > numMax) then begin
            numMax := v[i];
            vecMax := i;
        end;
end;

procedure ElementoMinimo(v: vector; dimL: integer; var vecMin, numMin: integer);
var
    i: integer; 
begin
    numMin := maxInt;
    for i := 1 to dimL do
        if (v[i] < numMin) then begin
            numMin := v[i];
            vecMin := i;
        end;
end;

var
    vec: vector;
    i, r, num, suma, dimL: integer;
    vecMin, vecMax, numMax, numMin: integer;
    prom: real;

begin

    dimL := 0;
    writeln('Ingrese un número: ');
    read(num);
    while (num <> 0) and (dimL < dimF) do begin
        dimL := dimL + 1;
        vec[dimL]:= num;
        read(num);
    end;

    ElementoMaximo(vec, dimL, vecMax, numMax);
    writeln('Posición vector máximo: ', vecMax);

    ElementoMinimo(vec, dimL, vecMin, numMin);
    writeln('Posición vector mínimo: ', vecMin);

    vec[vecMax] := numMin;
    vec[vecMin] := numMax;

    writeln('El elemento máximo ', numMax, ' que se encontraba en la posición ', vecMax, ' fue intercambiado con el elemento mínimo ', numMin, ' que se encontraba en la posición ', vecMin, '.');

    writeln('Orden actual:');
    writeln('Posición ', vecMax, ' número ', vec[vecMax], '.');
    writeln('Posición ', vecMin, ' número ', vec[vecMin], '.');
end.