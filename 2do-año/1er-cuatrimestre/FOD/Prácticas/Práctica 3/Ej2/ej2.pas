{2. Definir un programa que genere un archivo con registros de longitud fija conteniendo información de asistentes a un congreso a partir de la información obtenida por teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del archivo de datos generado, elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000. 
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo String a su elección. Ejemplo: ‘@Saldaño’.}

program ej2;

type
    recAsistente = record
        nroAsistente: integer;
        apellido: string;
        nombre: string;
        email: string;
        tel: string;
        dni: string;
    end;

    archivo: file of recAsistente;

procedure LeerAsistente(var a: recAsistente);
begin
    writeln('Ingresar asistente:');
    writeln;
    writeln('Ingrese nro de asistente (-1 para finalizar).');
    readln(a.nroAsistente);
    if (a.nroAsistente = -1) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese apellido:');
        readln(a.apellido);
        writeln('Ingrese nombre:');
        readln(a.nombre);
        writeln('Ingrese email:');
        readln(a.email);
        writeln('Ingrese teléfono:');
        readln(a.tel);
        writeln('Ingrese dni:');
        readln(a.dni);
    end;
end;

procedure AlmacenarAsistentes(var arch: archivo);
var
    a: recAsistente;
begin
    rewrite(arch);

    LeerAsistente(a);
    while (a.nroAsistente <> -1) do begin
        write(arch, a);
        LeerAsistente(a);
    end;

    close(arch);
end;

procedure EliminarAsistentes(var arch: archivo; n: integer);
var
    a: recAsistente;
begin
    reset(arch);

    while (not EOF(arch)) do begin
        read(arch, a);
        if (a.nroAsistente < n) then begin
            a.apellido := ('@' + a.apellido);
            seek(arch, FilePos(arch)-1);
            write(arch, a);
        end;
    end;

    close(arch);
end;

var
    arch: archivo;
begin
    assign(arch, 'asistentes.dat');

    AlmacenarAsistentes(arch);

    EliminarAsistentes(arch, 1000);
end.