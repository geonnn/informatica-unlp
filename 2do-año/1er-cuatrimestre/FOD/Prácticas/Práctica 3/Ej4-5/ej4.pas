{4. Dada la siguiente estructura:

    type 
        reg_flor = record 
            nombre: String[45]; 
            codigo: integer; 
        end;
        tArchFlores = file of reg_flor;

Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido. 
a. Implemente el siguiente módulo:
// Abre el archivo y agrega una flor, recibida como parámetro manteniendo la política descrita anteriormente
procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que considere necesario para obtener el listado.

5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo: 
// Abre el archivo y elimina la flor recibida como parámetro manteniendo la política descripta anteriormente
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);}

program ej4;

type 
    reg_flor = record 
        nombre: string; 
        codigo: integer; 
    end;

    tArchFlores = file of reg_flor;

procedure CrearArchivo(var a: tArchFlores);
var
    cab: reg_flor;
begin
    rewrite(a);

    cab.nombre := '';
    cab.codigo := 0;

    write(a, cab);  

    close(a);
end;

procedure AgregarFlor(var a: tArchFlores; nombre: string; codigo: integer);
var
    flor, cabecera, espacioLibre: reg_flor;
begin
    reset(a);
    read(a, cabecera);

    flor.nombre := nombre;
    flor.codigo := codigo;

    if (cabecera.codigo = 0) then begin
        seek(a, FileSize(a));
        write(a, flor);
    end
    else begin
        // Se obtiene el registro en el espacio libre indicado por la cabecera.
        seek(a, -(cabecera.codigo));
        read(a, espacioLibre);

        // Se actualiza la cabecera con el registro indicado por la anterior cabecera.
        seek(a, 0);
        write(a, espacioLibre);

        // Se hace el alta del registro entrante.
        seek(a, -(cabecera.codigo));
        write(a, flor);
    end;

    close(a);
end;

procedure ListarFlores(var a: tArchFlores);
var
    f: reg_flor;
begin
    reset(a);

    while (not EOF(a)) do begin
        read(a, f);
        if (f.codigo > 0) then begin
            writeln('Flor ', f.nombre, '.');
            writeln('código ', f.codigo, '.');
            writeln;
        end;
    end;
    close(a);
end;

procedure EliminarFlor(var a: tArchFlores; flor: reg_flor);
var
    encontrada: boolean;
    f, cab: reg_flor;
    posBaja: integer;
begin
    reset(a);
    encontrada := false;

    while (not EOF(a)) and (not encontrada) do begin
        read(a, f);
        if (f.codigo = flor.codigo) then
            encontrada := true;
    end;

    if (encontrada) then begin
        posBaja := FilePos(a)-1;

        seek(a, 0);
        read(a, cab);

        seek(a, posBaja);
        write(a, cab);

        cab.codigo := -posBaja;
        cab.nombre := '';
        seek(a, 0);
        write(a, cab);

        writeln('Flor eliminada exitosamente.');
    end
    else
        writeln('Flor no encontrada.');

    close(a);
end;

var
    fl: tArchFlores;
    florEliminar: reg_flor;
begin
    assign(fl, 'flores.dat');

    CrearArchivo(fl);

    AgregarFlor(fl, 'Rosa', 101);
    AgregarFlor(fl, 'Tulipán', 102);
    AgregarFlor(fl, 'Girasol', 103);

    writeln('Antes de eliminar:');
    ListarFlores(fl);

    // Ahora eliminamos la flor con código 102
    florEliminar.codigo := 102;
    florEliminar.nombre := 'Tulipán';
    EliminarFlor(fl, florEliminar);

    writeln('Después de eliminar:');
    ListarFlores(fl);
end.