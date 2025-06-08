{10. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de 
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa. 
Presentar en pantalla un listado como se muestra a continuación: 

Código de Provincia 
Código de Localidad             Total de Votos 
...................         ...................... 
...................         ...................... 
Total de Votos Provincia: ____

Código de Provincia 
Código de Localidad             Total de Votos 
...................         ...................... 
...................         ...................... 
Total de Votos Provincia: ____ 
.................................................................... 
Total General de Votos: ___

NOTA: La información está ordenada por código de provincia y código de localidad. }

program ej10;

uses
  SysUtils;

const
  VALOR_ALTO = maxInt;

type
  recMesaElectoral = record
    codProv: integer;
    codLoc: integer;
    numMesa: integer;
    cantVotos: integer;
  end;

  maestro = file of recMesaElectoral;

procedure Leer(var mae: maestro; var m: recMesaElectoral);
begin
  if (not EOF(mae)) then
    read(mae, m)
  else
    m.codProv := VALOR_ALTO;
end;

procedure ProcesarMesas(var mae: maestro);
var
  m: recMesaElectoral;
  codProvActual, codLocActual, votosLoc, votosProv, totalVotos: integer;

begin
  Leer(mae, m);
  totalVotos := 0;
  while (m.codProv <> VALOR_ALTO) do begin
    codProvActual := m.codProv;
    votosProv := 0;

    writeln('Provincia ', codProvActual, ':');

    while (codProvActual = m.codProv) do begin
      codLocActual := m.codLoc;
      votosLoc := 0;

      write(' Localidad ', codLocActual);

      while (codProvActual = m.codProv) and (codLocActual = m.codLoc) do begin
        votosLoc := votosLoc + m.cantVotos;
        Leer(mae, m);
      end;

      votosProv := votosProv + votosLoc;

      writeln('    ', votosLoc, ' votos.');
    end;
    totalVotos := totalVotos + votosProv;
    writeln('Total de votos provincia: ', votosProv, ' votos.');
    writeln;
    writeln('--------------- FIN PROVINCIA ---------------');
    writeln;
  end;
  writeln;
  writeln('--------------- FIN MESAS ---------------');
  writeln;
  writeln('Total general de votos: ', totalVotos, ' votos.');
end;

var
  mae: maestro;
begin
  assign(mae, 'maestro.dat');
  reset(mae);

  ProcesarMesas(mae);

  close(mae);
end.