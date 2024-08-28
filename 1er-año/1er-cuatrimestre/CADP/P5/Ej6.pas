{6. Realizar un programa que ocupe 50 KB de memoria en total. Para ello:
a. El programa debe utilizar sólo memoria estática.
b. El programa debe utilizar el 50% de memoria estática y el 50% de memoria dinámica.
c. El programa debe minimizar tanto como sea posible el uso de la memoria estática (a lo sumo, 4 bytes).}

// a.
program Ej6a;
type
    vector = array[1..50000] of char;

var
    v: vector;
begin
    writeln(sizeof(v));
end.


// b.
program Ej6b;
type
    vector = array[1..12500] of integer;
    vector2 = array[1..12498] of integer;
    ptr = ^vector2;
var
    v: vector;
    p: ptr;
begin
    new(p);
    writeln(sizeof(v));
    writeln(sizeof(p^));
    writeln(sizeof(p));

    writeln(sizeof(v) + sizeof(p^) + sizeof(p));
end.

// c.
program Ej6c;
type
    vector = array[1..24998] of integer;
    ptr = ^vector;
var
    p: ptr;
begin
    new(p);
    writeln(sizeof(p));
    writeln(sizeof(p^));

    writeln(sizeof(p) + sizeof(p^));
end.