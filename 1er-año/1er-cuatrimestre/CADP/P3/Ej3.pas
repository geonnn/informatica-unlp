{3. El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs.
As, con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO
para el año 2015 (1 docente cada 23,435 alumnos). Para ello, se cuenta con información de: CUE (código único
de establecimiento), nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad. Se
pide implementar un programa que procese la información y determine:
● Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por
UNESCO.
● CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.
El programa debe utilizar:
a. Un módulo para la lectura de la información de la escuela.
b. Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la
cantidad de alumnos y la cantidad de docentes).}

program Ej3;
type
    str30 = string[30];
    escuela = record
        cue: integer;
        nombre: str30;
        docentes: integer;
        alumnos: integer;
        localidad: str30;
    end;
procedure LeerEscuela(var e: escuela);
begin
    writeln('Ingrese el código único de establecimiento: ');
    readln(e.cue);
    writeln('Ingrese el nombre del establecimiento: ');
    readln(e.nombre);
    writeln('Ingrese la cantidad de docentes del establecimiento: ');
    readln(e.docentes);
    writeln('Ingrese la cantidad de alumnos del establecimiento: ');
    readln(e.alumnos);
    writeln('Ingrese la localidad del establecimiento: ');
    readln(e.localidad);
end;
procedure RelDocAl(cantDoc: integer; cantAlu: integer; var promedio: real);
begin
    promedio := cantAlu / cantDoc;
end;
procedure MaxRelDocAl(promActual: real; cue: integer; nombre: str30; var promMax1, promMax2: real; var cueMax1, cueMax2: integer; var nomMax1, nomMax2: str30);
begin
    if (promActual < promMax1) then begin
        promMax2 := promMax1;
        nomMax2 := nomMax1;
        cueMax2 := cueMax1;

        promMax1 := promActual;
        nomMax1 := nombre;
        cueMax1 := cue;
    end
    else begin
        if (promActual < promMax2) then begin
            promMax2 := promActual;
            nomMax2 := nombre;
            cueMax2 := cue;
        end;
    end;
end;

// Programa principal ↓.
const
    promUNESCO = 23435;
var
    e: escuela;
    i: integer;
    promActual: real;
    cantEscuelasPromSup: integer;
    promMax1, promMax2: real;
    cueMax1, cueMax2: integer;
    nomMax1, nomMax2: str30;

begin
    cantEscuelasPromSup := 0;
    promMax1 := maxInt;
    promMax2 := maxInt;

    for i := 1 to 2400 do begin
        LeerEscuela(e);

        // Verificar si la relación docente alumno es mayor que la de la UNESCO para escuelas de La Plata.
        RelDocAl(e.docentes, e.alumnos, promActual);
        if (promActual < promUNESCO) and (e.localidad = 'La Plata') then
          cantEscuelasPromSup := cantEscuelasPromSup + 1;

        MaxRelDocAl(promActual, e.cue, e.nombre, promMax1, promMax2, cueMax1, cueMax2, nomMax1, nomMax2);
    end;
    writeln('En La Plata existe(n) ', cantEscuelasPromSup, ' escuela(s) que superan la relacion docente / alumno determinada por la UNESCO.');
    writeln('');
    writeln('Las dos escuelas con mejor relación docente / alumno son: ');
    writeln('1°: Escuela ', nomMax1, ', CUE: ', cueMax1, '. Con una relación docente / alumno de 1 docente cada ', promMax1:0:2, ' alumnos.');
    writeln('2°: Escuela ', nomMax2, ', CUE: ', cueMax2, '. Con una relación docente / alumno de 1 docente cada ', promMax2:0:2, ' alumnos.');
end.