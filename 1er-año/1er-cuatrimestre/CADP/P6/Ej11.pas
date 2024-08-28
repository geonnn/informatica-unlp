{11. La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y el promedio obtenido durante toda su carrera.
Implementar un programa que:
a. Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
b. Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los egresados que recibirán el premio. La información debe imprimirse ordenada según el promedio del egresado (de mayor a menor).}

program Ej11;
type
    str30 = string[30];
    recEgresados = record
        nroAlu: longInt;
        apellido: str30;
        promedio: real;
    end;
    listaEgresados = ^nodo;
    nodo = record
        dato: recEgresados;
        sig: listaEgresados;
    end;

procedure CargarAlumno(var e: recEgresados);
begin
    writeln('Ingrese el número de alumno: ');
    readln(e.nroAlu);
    if (e.nroAlu = 0) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese el apellido del alumno: ');
        readln(e.apellido);
        writeln('Ingrese el promedio del alumno: ');
        readln(e.promedio);
        writeln('');
    end;
end;

procedure CargarLista(var L: listaEgresados);
var
    e: recEgresados;
    nue, act, ant: listaEgresados;
begin
    CargarAlumno(e);
    while (e.nroAlu <> 0) do begin
        new(nue);
        nue^.dato := e;
        ant := L;
        act := L;
        while (act <> nil) and (e.promedio < act^.dato.promedio) do begin
            ant := act;
            act := act^.sig;
        end;
        if (act = ant) then
            L := nue
        else
            ant^.sig := nue;
        nue^.sig := act;
        CargarAlumno(e);
    end;
end;

procedure ImprimirLista(L: listaEgresados);
var
    cont: integer;
begin
    cont := 0;
    while (L <> nil) and (cont < 10) do begin
        writeln('Nro de alumno: ', L^.dato.nroAlu, ' | Apellido: ', L^.dato.apellido, ' | Promedio: ', L^.dato.promedio:0:2);
        L := L^.sig;
        cont := cont + 1;
    end;
end;

var
    L: listaEgresados;

begin
    L := nil;
    CargarLista(L);
    writeln('');
    writeln('Alumnos con promedio más alto: ');
    writeln('');
    ImprimirLista(L);
end.