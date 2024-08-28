{2. Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de escritorio.}

program punteros;
type
    cadena = string[9];
    producto = record
        codigo: integer;
        descripcion: cadena;
        precio: real;
    end;
    puntero_producto = ^producto;
var
    p: puntero_producto;
    prod: producto;
begin
    writeln(sizeof(p), ' bytes'); // 4 bytes.
    writeln(sizeof(prod), ' bytes'); // 2 + 10 + 4 = 16 bytes. Por alguna razón imprime 24.
    new(p);
    writeln(sizeof(p), ' bytes'); // 4 bytes.
    p^.codigo := 1;
    p^.descripcion := 'nuevo producto';
    writeln(sizeof(p^), ' bytes'); // 16 bytes. El peso del registro no cambia.
    p^.precio := 200;
    writeln(sizeof(p^), ' bytes'); // 16 bytes. El peso del registro no cambia.
    prod.codigo := 2;
    prod.descripcion := 'otro nuevo producto';
    writeln(sizeof(prod), ' bytes'); // 16 bytes. El peso del registro no cambia.
end.