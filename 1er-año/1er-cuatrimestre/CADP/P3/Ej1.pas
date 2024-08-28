{1. Dado el siguiente programa:
a. Completar el programa principal para que lea información de alumnos (código, nombre, promedio) e
informe la cantidad de alumnos leídos. La lectura finaliza cuando ingresa un alumno con código 0, que
no debe procesarse. Nota: utilizar el módulo leer.
b. Modificar al programa anterior para que, al finalizar la lectura de todos los alumnos, se informe
también el nombre del alumno con mejor promedio.}


program Registros;

type 
    str20 = string[20];
    alumno = Record
        codigo: integer;
        nombre: str20;
        promedio: real;
    end;
procedure leer(Var alu : alumno);
begin
    writeln('Ingrese el código del alumno');
    readln(alu.codigo);
    if (alu.codigo <> 0) then
        begin
            writeln('Ingrese el nombre del alumno');
            readln(alu.nombre);
            writeln('Ingrese el promedio del alumno');
            readln(alu.promedio);
        end;
end;
procedure MaxProm(nombre: str20; promedio: real; var nomMax: str20; var promMax: real);
begin
    if (promedio > promMax) then begin
        promMax := promedio;
        nomMax := nombre;
    end;
end;
{ declaración de variables del programa principal }

var
    a: alumno;
    cantAlu: integer;
    nomMax: str20;
    promMax: real;
{ cuerpo del programa principal }
begin
    cantAlu := 0;
    leer(a);
    while (a.codigo <> 0) do begin
        cantAlu := cantAlu + 1;
        MaxProm(a.nombre, a.promedio, nomMax, promMax);
        leer(a);
    end;
    writeln('Se leyeron ', cantAlu, ' alumnos.');
    writeln('El alumno con promedio más alto es ', nomMax, ' con promedio ', promMax:0:2, '.');
end.
