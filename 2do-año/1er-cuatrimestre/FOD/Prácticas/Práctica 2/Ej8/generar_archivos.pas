program generarDatosYerba;

uses SysUtils;

const
  N_PROVINCIAS = 10;
  N_DETALLES = 16;
  VALOR_MAX_KG = 3000;

type
  recMaestro = record
    codProv: integer;
    nomProv: string;
    cantHabitantes: Int64;
    cantYerbaConsumida: real;
  end;

  recRelevamiento = record
    codProv: integer;
    cantYerbaConsumida: real;
  end;

  maestro = file of recMaestro;
  detalle = file of recRelevamiento;

var
  mae: maestro;
  aD: array[1..N_DETALLES] of detalle;
  provincias: array[1..N_PROVINCIAS] of string = (
    'Buenos Aires', 'Cordoba', 'Santa Fe', 'Mendoza', 'Tucuman',
    'Salta', 'Misiones', 'Chaco', 'Corrientes', 'Entre Rios'
  );
  i, j, k: integer;
  rM: recMaestro;
  rD: recRelevamiento;

begin
  // Crear archivo maestro
  assign(mae, 'maestro.dat');
  rewrite(mae);
  for i := 1 to N_PROVINCIAS do begin
    rM.codProv := i;
    rM.nomProv := provincias[i];
    rM.cantHabitantes := 500000 + i * 100000; // habitantes variados
    rM.cantYerbaConsumida := 9000 + (i * 150); // algunos pasan los 10.000 tras actualizar
    write(mae, rM);
  end;
  close(mae);

  // Crear archivos de relevamiento
  Randomize;
  for i := 1 to N_DETALLES do begin
    assign(aD[i], 'relevamiento' + Format('%.2d', [i]) + '.dat');
    rewrite(aD[i]);
    // Insertar entre 2 y 5 registros por archivo
    for j := 1 to 2 + Random(4) do begin
      rD.codProv := 1 + Random(N_PROVINCIAS); // provincias aleatorias entre 1 y 10
      rD.cantYerbaConsumida := 100 + Random(VALOR_MAX_KG); // consumo entre 100 y 3100 kg
      write(aD[i], rD);
    end;
    close(aD[i]);
  end;

  writeln('Archivos de prueba generados correctamente.');
end.
