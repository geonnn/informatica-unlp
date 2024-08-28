{6. Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo
y otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva
ambas posiciones.}

program Ej6;
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

// procedure Intercambio(v: vector; numX, numY: integer);

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

procedure MaxMin(v: vector; dimL: integer; var vecMin, vecMax, numMin, numMax: integer);
var
    i: integer;
begin
    numMin := maxInt;
    numMax := -9999;
    for i := 1 to dimL do
        if (v[i] < numMin) then begin
            numMin := v[i];
            vecMin := i;
        end
        else
            if (v[i] > numMax) then begin
                numMax := v[i];
                vecMax := i;
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

    MaxMin(vec, dimL, vecMin, vecMax, numMin, numMax);
    writeln('Posición vector máximo: ', vecMax);
    writeln('Posición vector mínimo: ', vecMin);

    vec[vecMax] := numMin;
    vec[vecMin] := numMax;

    writeln('El elemento máximo ', numMax, ' que se encontraba en la posición ', vecMax, ' fue intercambiado con el elemento mínimo ', numMin, ' que se encontraba en la posición ', vecMin, '.');

    writeln('Orden actual:');
    writeln('Posición ', vecMax, ' número ', vec[vecMax], '.');
    writeln('Posición ', vecMin, ' número ', vec[vecMin], '.');
end.