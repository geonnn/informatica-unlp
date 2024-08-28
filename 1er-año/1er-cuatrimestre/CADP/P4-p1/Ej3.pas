{3. Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
a. Realizar un módulo que imprima el vector desde la primera posición hasta la última.
b. Realizar un módulo que imprima el vector desde la última posición hasta la primera.
c. Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y
desde la mitad más uno hacia la última posición.
d. Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde
la posición X hasta la Y. Asuma que tanto X como Y son menores o iguales a la dimensión lógica. Y
considere que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o
hacia atrás.
e. Utilizando el módulo implementado en el inciso anterior, vuelva a realizar los incisos a, b y c.}

program Ej3;
const
    dimF = 10;
type
    vector = array[1..dimF] of integer;

procedure PuntoA(v: vector; dimL: integer);
var
    i: integer;
begin
    for i := 1 to dimL do
        writeln(v[i]);
end;

procedure PuntoB(v: vector; dimL: integer);
var
    i: integer;
begin
    for i := dimL downto 1 do
        writeln(v[i]);
end;

procedure PuntoC(v: vector; dimL: integer);
var
    i: integer;
begin
    for i := (dimL DIV 2) downto 1 do
        writeln(v[i]);
    for i := ((dimL DIV 2) + 1) to dimL do
        writeln(v[i]);
end;

procedure PuntoD(v: vector; x, y: integer);
var
    i: integer;
begin
    if (x >= y) then begin
        for i := x downto y do
            writeln(v[i]);
    end
    else
        for i := x to y do
            writeln(v[i]);
end;

var
    v: vector;
    i: integer;
    x, y: integer;
begin
    x := 7; y := 3;
    for i := 1 to dimF do
        read(v[i]);
    PuntoD(v, x, y);
end.