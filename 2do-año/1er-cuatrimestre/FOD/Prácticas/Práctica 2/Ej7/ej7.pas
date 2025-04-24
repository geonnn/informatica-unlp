{7. Se dispone de un archivo maestro con información de los alumnos de la Facultad de Informática. Cada registro del archivo maestro contiene: código de alumno, apellido, nombre, cantidad de cursadas aprobadas y cantidad de materias con final aprobado. El archivo maestro está ordenado por código de alumno.
Además, se tienen dos archivos detalle con información sobre el desempeño académico de los alumnos: un archivo de cursadas y un archivo de exámenes finales. El archivo de cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa si la cursada fue aprobada o desaprobada). Por su parte, el archivo de exámenes finales contiene información sobre los exámenes finales rendidos. Cada registro incluye: código de alumno, código de materia, fecha del examen y nota obtenida. Ambos archivos detalle están ordenados por código de alumno y código de materia, y pueden contener 0, 1 o más registros por alumno en el archivo maestro. Un alumno podría cursar una materia muchas veces, así como también podría rendir el final de una materia en múltiples ocasiones.
Se debe desarrollar un programa que actualice el archivo maestro, ajustando la cantidad de cursadas aprobadas y la cantidad de materias con final aprobado, utilizando la información de los archivos detalle. Las reglas de actualización son las siguientes:
● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas aprobadas.
● Si un alumno aprueba un examen final (nota >= 4), se incrementa en uno la cantidad de materias con final aprobado.
Notas:
● Los archivos deben procesarse en un único recorrido.
● No es necesario comprobar que no haya inconsistencias en la información de los archivos detalles. Esto es, no puede suceder que un alumno apruebe más de una vez la cursada de una misma materia (a lo sumo la aprueba una vez), algo similar ocurre con los exámenes finales.}

program ej7;

const
    VALOR_ALTO = maxInt;

type

    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recAlumno = record
        codAlumno: integer;
        nom: string[40];
        ap: string[40];
        cantCursadas: integer;
        cantFinales: integer;
    end;

    recCursada = record
        codAlumno: integer;
        codMateria: integer;
        anio: integer;
        aprobada: boolean;
    end;

    recFinal = record
        codAlumno: integer;
        codMateria: integer;
        fecha: recFecha;
        nota: 1..10;
    end;

maestro = file of recAlumno;
detalleCursadas = file of recCursada;
detalleFinales = file of recFinal;

procedure LeerCursada(var det: detalleCursadas; var r: recCursada);
begin
    if not EOF(det) then
        read(det, r)
    else
        r.codAlumno := VALOR_ALTO;
end;

procedure LeerFinal(var det: detalleFinal; var r: recFinal);
begin
    if not EOF(det) then
        read(det, r)
    else
        r.codAlumno := VALOR_ALTO;
end;

procedure ProcesarDetalles(var mae: maestro; var detC: detalleCursadas; var detF: detalleFinales);
var
    minC: recCursada;
    minF: recFinal;
    regm: recMaestro;
begin
    Minimo()
end;

var
    mae: maestro;
    detC: detalleCursadas;
    detF: detalleFinales;
begin
    assign(mae, 'maestro');
    assign(detC, 'cursadas.dat');
    assign(detF, 'finales.dat');
    reset(mae);
    reset(detC);
    reset(detF);

    ProcesarDetalles(mae, detC, detF);

    close(mae);
    close(detC);
    close(detF);
end.