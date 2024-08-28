{4. Indicar los valores que imprimen los siguientes programas en Pascal. Justificar mediante prueba de escritorio.}

// a.
program punteros;
type
    cadena = string[50]; 
    puntero_cadena = ^cadena;
var
    pc: puntero_cadena;
begin
    pc^ := 'un nuevo texto';
    new(pc);
    writeln(pc^); // Error. El puntero debería crearse primero y depués darle valor.
end.


// b.
program punteros;
type
    cadena = string[50];
    puntero_cadena = ^cadena;
var
    pc: puntero_cadena;
begin
    new(pc);
    pc^:= 'un nuevo nombre';
    writeln(sizeof(pc^), ' bytes'); // 51 bytes.
    writeln(pc^); // un nuevo nombre
    dispose(pc);
    pc^:= 'otro nuevo nombre'; // Error. No hay un espacio de memoria asignado para el puntero.
end.


// c. 
program punteros;
type
    cadena = string[50];
    puntero_cadena = ^cadena;
procedure cambiarTexto(pun: puntero_cadena);
begin
    pun^:= 'Otro texto';
end;
var
    pc: puntero_cadena;
begin
    new(pc);
    pc^:= 'Un texto';
    writeln(pc^); // Un texto
    cambiarTexto(pc);
    writeln(pc^); // Otro texto
end.


// d.
program punteros;
type
    cadena = string[50];
    puntero_cadena = ^cadena;
procedure cambiarTexto(pun: puntero_cadena);
begin
    new(pun);
    pun^:= 'Otro texto';
end;
var
    pc: puntero_cadena;
begin
    new(pc);
    pc^:= 'Un texto';
    writeln(pc^); // Un texto
    cambiarTexto(pc);
    writeln(pc^); // Un texto. Pasa el puntero por valor al proceso, así que no puede modificar su dirección de memoria al hacer el new. De todas formas, el espacio de memoria que contiene "Otro texto" se creó y existe, pero se pierde al salir del proceso.
end.