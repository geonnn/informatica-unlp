{7. Realizar un programa que lea números enteros desde teclado hasta que se ingrese el valor -1 (que no debe procesarse) e informe:
a. La cantidad de ocurrencias de cada dígito procesado.
b. El dígito más leído.
c. Los dígitos que no tuvieron ocurrencias.
Por ejemplo: si la secuencia que se lee es: 63 34 99 94 96 -1, el programa deberá informar:
Número 3: 2 veces
Número 4: 2 veces
Número 6: 2 veces
Número 9: 4 veces
El dígito más leído fue el 9.
Los dígitos que no tuvieron ocurrencias son: 0, 1, 2, 5, 7, 8}

program Ej7;
type
    vc = array[0..9] of integer;

procedure Inicializar(var v: vc);
var
    i: integer;
begin
    for i := 0 to 9 do
        v[i] := 0;
end;

procedure Descomponer(var v: vc; n: integer);
var
    dig: integer;
begin
    while (n <> 0) do begin
        dig := n MOD 10;
        v[dig] := v[dig] + 1;
        n := n DIV 10;
    end;
end;

procedure Informar(v: vc);
var
    i, max, digMax: integer;
begin
    max := -999;
    for i := 0 to 9 do begin
        writeln('Número ', i, ': ', v[i], '.');
        if (v[i] > max) then begin
            max := v[i];
            digMax := i;
        end;
        if (v[i] = 0) then
            writeln('El número ', i, ' no tuvo ocurrencias.');
    end;
    writeln('El dígito más leído fue el ', digMax, '.');
end;

var
    vec: vc;
    num: integer;
begin
    read(num);
    Inicializar(vec);
    while (num <> -1) do begin
        Descomponer(vec, num);
        read(num);
    end;
    Informar(vec);
end.