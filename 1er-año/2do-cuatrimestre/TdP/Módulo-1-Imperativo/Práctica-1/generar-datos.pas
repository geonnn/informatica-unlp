program generar_datos;
const
    CANT = 300;
type
    vector = array[1..CANT] of integer;

procedure GenerateRandomNumbers(var v: vector);
var
    i, j, temp: Integer;
begin
    // Inicializar el arreglo con números del 1 al 100
    for i := 1 to CANT do
        v[i] := i;
    // Barajar el arreglo usando el algoritmo de Fisher-Yates
    for i := CANT downto 2 do begin
        j := Random(i) + 1;  // Selecciona un índice al azar
        temp := v[i];
        v[i] := v[j];
        v[j] := temp;
    end;
end;

procedure GenerarRandoms(var v: vector);
var
    dimL, num, cmp, i: integer;
begin
    dimL := 0;
    num := random(CANT) + 1;
    v[1] := num;
    while (dimL < (CANT - 1)) do begin
        num := random(CANT) + 1;
        cmp := 0;
        dimL := dimL + 1;
        for i := 1 to dimL do begin
            if (num <> v[i]) then
                cmp := cmp + 1
        end;
        if (cmp = dimL) then
            v[dimL] := num
        else
            dimL := dimL - 1;
    end;
end;

var
    v: vector;
    i, valor: integer;
    valor_real: real;
begin
    randomize;
    // GenerarRandoms(v);
    GenerateRandomNumbers(v);
    for i := 1 to CANT do begin
        //valor := random(CANT) + 1;
        //writeln(valor);
        valor_real := (random(100000 - 50000 + 1) + 50000) / 100;
        writeln(valor_real:0:2); // precio
        writeln(v[i]); // cod prod
        valor := random(8) + 1;
        writeln(valor); // cod rubro
    end;
end.