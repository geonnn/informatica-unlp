program generarMaestroHorasExtra;

uses
  SysUtils;

type
  recEmpleado = record
    depto: string;
    division: integer;
    numEmpleado: integer;
    categoria: 1..15;
    cantHorasExtra: real;
  end;

  maestro = file of recEmpleado;

procedure Agregar(var mae: maestro; depto: string; division, num, cat: integer; hs: real);
var
  e: recEmpleado;
begin
  e.depto := depto;
  e.division := division;
  e.numEmpleado := num;
  e.categoria := cat;
  e.cantHorasExtra := hs;
  write(mae, e);
end;

var
  mae: maestro;
begin
  Assign(mae, 'maestro.dat');
  Rewrite(mae);

  // Departamento A
  Agregar(mae, 'A', 1, 1001, 3, 10.5);
  Agregar(mae, 'A', 1, 1002, 5, 8.0);
  Agregar(mae, 'A', 2, 1003, 2, 12.0);
  Agregar(mae, 'A', 2, 1004, 4, 9.0);

  // Departamento B
  Agregar(mae, 'B', 1, 2001, 1, 7.5);
  Agregar(mae, 'B', 1, 2002, 6, 11.0);
  Agregar(mae, 'B', 2, 2003, 3, 6.5);

  Close(mae);
  writeln('Archivo maestro.dat generado correctamente.');
end.