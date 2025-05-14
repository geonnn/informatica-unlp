program generarArchivosPrueba;

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

var
  mae: maestro;
  detC: detalleCursadas;
  detF: detalleFinales;
  i: integer;
  rAlumno: recAlumno;
  rCursada: recCursada;
  rFinal: recFinal;

begin
  // Crear archivo maestro
  assign(mae, 'maestro');
  rewrite(mae);
  for i := 1 to 5 do
  begin
    rAlumno.codAlumno := i;
    str(i, rAlumno.nom);
    rAlumno.nom := 'Nombre' + rAlumno.nom;
    rAlumno.ap := 'Apellido' + rAlumno.nom;
    rAlumno.cantCursadas := 0;
    rAlumno.cantFinales := 0;
    write(mae, rAlumno);
  end;
  close(mae);

  // Crear archivo de cursadas
  assign(detC, 'cursadas.dat');
  rewrite(detC);
  // Alumno 1 aprueba 2 materias, desaprueba 1
  rCursada.codAlumno := 1;
  rCursada.codMateria := 101;
  rCursada.anio := 2023;
  rCursada.aprobada := true;
  write(detC, rCursada);

  rCursada.codMateria := 102;
  rCursada.aprobada := true;
  write(detC, rCursada);

  rCursada.codMateria := 103;
  rCursada.aprobada := false;
  write(detC, rCursada);

  // Alumno 2 aprueba 1 materia
  rCursada.codAlumno := 2;
  rCursada.codMateria := 104;
  rCursada.anio := 2022;
  rCursada.aprobada := true;
  write(detC, rCursada);

  // Alumno 4 desaprueba 2 materias
  rCursada.codAlumno := 4;
  rCursada.codMateria := 105;
  rCursada.aprobada := false;
  write(detC, rCursada);

  rCursada.codMateria := 106;
  write(detC, rCursada);

  close(detC);

  // Crear archivo de finales
  assign(detF, 'finales.dat');
  rewrite(detF);
  // Alumno 1 aprueba 1 final, desaprueba 1
  rFinal.codAlumno := 1;
  rFinal.codMateria := 101;
  rFinal.fecha.dia := 10;
  rFinal.fecha.mes := 3;
  rFinal.fecha.anio := 2024;
  rFinal.nota := 8;
  write(detF, rFinal);

  rFinal.codMateria := 103;
  rFinal.nota := 2;
  write(detF, rFinal);

  // Alumno 2 aprueba 1 final
  rFinal.codAlumno := 2;
  rFinal.codMateria := 104;
  rFinal.nota := 7;
  write(detF, rFinal);

  // Alumno 3 desaprueba 1 final
  rFinal.codAlumno := 3;
  rFinal.codMateria := 108;
  rFinal.nota := 3;
  write(detF, rFinal);

  // Alumno 5 aprueba 1 final
  rFinal.codAlumno := 5;
  rFinal.codMateria := 110;
  rFinal.nota := 10;
  write(detF, rFinal);

  close(detF);

  writeln('Archivos maestro, cursadas y finales generados correctamente.');
end.
