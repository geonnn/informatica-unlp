program generarArchivoMaestro;

uses
  SysUtils;

type
  recMesaElectoral = record
    codProv: integer;
    codLoc: integer;
    numMesa: integer;
    cantVotos: integer;
  end;

  maestro = file of recMesaElectoral;

procedure AgregarRegistro(var mae: maestro; codProv, codLoc, numMesa, cantVotos: integer);
var
  m: recMesaElectoral;
begin
  m.codProv := codProv;
  m.codLoc := codLoc;
  m.numMesa := numMesa;
  m.cantVotos := cantVotos;
  write(mae, m);
end;

var
  mae: maestro;
begin
  assign(mae, 'maestro.dat');
  rewrite(mae);

  { Provincia 1 }
  AgregarRegistro(mae, 1, 101, 1, 120);
  AgregarRegistro(mae, 1, 101, 2, 130);
  AgregarRegistro(mae, 1, 102, 3, 100);
  AgregarRegistro(mae, 1, 102, 4, 90);

  { Provincia 2 }
  AgregarRegistro(mae, 2, 201, 5, 150);
  AgregarRegistro(mae, 2, 201, 6, 160);
  AgregarRegistro(mae, 2, 202, 7, 170);
  AgregarRegistro(mae, 2, 202, 8, 180);

  { Provincia 3 }
  AgregarRegistro(mae, 3, 301, 9, 200);
  AgregarRegistro(mae, 3, 301, 10, 210);
  AgregarRegistro(mae, 3, 302, 11, 190);
  AgregarRegistro(mae, 3, 302, 12, 195);

  close(mae);
  writeln('Archivo maestro.dat generado correctamente.');
end.
