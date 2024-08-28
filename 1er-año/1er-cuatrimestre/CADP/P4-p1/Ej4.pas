{4. Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
a. posicion: dado un número X y el vector de números, retorna la posición del número X en dicho
vector, o el valor -1 en caso de no encontrarse.
b. intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo
vector donde se intercambiaron los valores de las posiciones x e y.
c. sumaVector: retorna la suma de todos los elementos del vector.
d. promedio: devuelve el valor promedio de los elementos del vector.
e. elementoMaximo: retorna la posición del mayor elemento del vector
f. elementoMinimo: retorna la posicion del menor elemento del vector}

// Se asume que el vector tiene dimL = dimF = 100. Podría ser que el vector tenga dimF > 100 y la dimL = 100.

program Ej4;
const
    dimF = 10;

type
    vector = array[1..dimF] of integer;

procedure Posicion(v: vector; dimF, num: integer; var r: integer);
begin
    if (num < 1) or (num > dimF) then
        r := -1
    else
        r := v[num];
end;

// procedure Intercambio(v: vector; numx, numy: integer);

procedure SumaVector(v: vector; dimF: integer; var suma: integer);
var
    i: integer;
begin
    suma := 0;
    for i:= 1 to dimF do
        suma := suma + v[i];
end;

procedure Promedio(v: vector; dimF: integer; var prom: real);
var
    suma: integer;
begin
    SumaVector(v, dimF, suma);
    prom := suma / dimF;
end;

procedure ElementoMaximo(v: vector; dimF: integer; var vecMax: integer);
var
    i: integer; numMax: integer; 
begin
    numMax := -9999;
    for i := 1 to dimF do
        if (v[i] > numMax) then begin
            numMax := v[i];
            vecMax := i;
        end;
end;

procedure ElementoMinimo(v: vector; dimF: integer; var vecMin: integer);
var
    i: integer; numMin: integer; 
begin
    numMin := maxInt;
    for i := 1 to dimF do
        if (v[i] < numMin) then begin
            numMin := v[i];
            vecMin := i;
        end;
end;

var
    vec: vector;
    i, r, num, suma: integer;
    vecMin, vecMax: integer;
    prom: real;

begin

    for i:= 1 to dimF do
        read(vec[i]);
{    read(num);
    Posicion(vec, dimF, num, r);
    writeln(r);

    SumaVector(vec, dimF, suma);
    writeln(suma);
    
    Promedio(vec, dimF, prom);
    writeln(prom:0:2);}

    ElementoMaximo(vec, dimF, vecMax);
    writeln('Posición vector máximo: ', vecMax);

    ElementoMinimo(vec, dimF, vecMin);
    writeln('Posición vector mínimo: ', vecMin);
end.