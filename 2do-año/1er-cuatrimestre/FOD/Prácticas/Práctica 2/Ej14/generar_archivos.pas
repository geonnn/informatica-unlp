program GenerarArchivosPrueba;

type
  recFecha = record
    dia: 1..31;
    mes: 1..12;
    anio: integer;
  end;

  recHora = record
    hs: 0..23;
    mins: 0..59;
  end;

  recVuelo = record
    destino: string;
    fecha: recFecha;
    hsSalida: recHora;
    asientos: integer;  // maestro: disponibles, detalle: comprados
  end;

  archivo = file of recVuelo;

procedure CrearArchivo(var arch: archivo; datos: array of recVuelo);
var
  i: integer;
begin
  rewrite(arch);
  for i := 0 to High(datos) do
    write(arch, datos[i]);
  close(arch);
end;

var
  mae: archivo;
  det1: archivo;
  det2: archivo;

  maeDatos: array[0..3] of recVuelo = (
    (destino: 'Buenos Aires'; fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 9; mins: 30); asientos: 100),
    (destino: 'Cordoba';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 11; mins: 0); asientos: 150),
    (destino: 'Mendoza';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 13; mins: 45); asientos: 120),
    (destino: 'Rosario';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 15; mins: 15); asientos: 130)
  );

  det1Datos: array[0..2] of recVuelo = (
    (destino: 'Buenos Aires'; fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 9; mins: 30); asientos: 30),
    (destino: 'Cordoba';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 11; mins: 0); asientos: 40),
    (destino: 'Mendoza';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 13; mins: 45); asientos: 20)
  );

  det2Datos: array[0..1] of recVuelo = (
    (destino: 'Buenos Aires'; fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 9; mins: 30); asientos: 10),
    (destino: 'Rosario';      fecha: (dia: 10; mes: 6; anio: 2025); hsSalida: (hs: 15; mins: 15); asientos: 50)
  );

begin
  assign(mae, 'maestro.dat');
  assign(det1, 'detalle1.dat');
  assign(det2, 'detalle2.dat');

  CrearArchivo(mae, maeDatos);
  CrearArchivo(det1, det1Datos);
  CrearArchivo(det2, det2Datos);

  writeln('Archivos creados correctamente.');
end.
