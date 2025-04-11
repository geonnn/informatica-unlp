program generarLogsOrdenados;

uses
  sysutils;

const
  CANT_PCS = 5;
  CANT_REGISTROS = 10;

type
  recFecha = record
    dia: 1..31;
    mes: 1..12;
    anio: integer;
  end;

  recLog = record
    cod_usuario: integer;
    fecha: recFecha;
    tiempo_sesion: real;
  end;

  archivoDetalle = file of recLog;
  vectorLogs = array[1..CANT_REGISTROS] of recLog;

procedure GenerarFechaAleatoria(var f: recFecha);
begin
  f.dia := 1 + Random(5);
  f.mes := 4;
  f.anio := 2025;
end;

function CompararLogs(a, b: recLog): integer;
begin
  if a.cod_usuario < b.cod_usuario then exit(-1);
  if a.cod_usuario > b.cod_usuario then exit(1);

  // cod_usuario igual, comparar por fecha
  if a.fecha.anio <> b.fecha.anio then
    exit(a.fecha.anio - b.fecha.anio)
  else if a.fecha.mes <> b.fecha.mes then
    exit(a.fecha.mes - b.fecha.mes)
  else
    exit(a.fecha.dia - b.fecha.dia);
end;

procedure OrdenarVector(var v: vectorLogs);
var
  i, j: integer;
  aux: recLog;
begin
  for i := 1 to CANT_REGISTROS - 1 do
    for j := i + 1 to CANT_REGISTROS do
      if CompararLogs(v[i], v[j]) > 0 then
      begin
        aux := v[i];
        v[i] := v[j];
        v[j] := aux;
      end;
end;

var
  f: archivoDetalle;
  nombreArchivo: string;
  logs: vectorLogs;
  i, j: integer;
begin
  Randomize;

  for i := 1 to CANT_PCS do
  begin
    // Generar vector de registros
    for j := 1 to CANT_REGISTROS do
    begin
      logs[j].cod_usuario := 1 + Random(3);
      GenerarFechaAleatoria(logs[j].fecha);
      logs[j].tiempo_sesion := 0.5 + Random * 4.5;
    end;

    // Ordenar registros antes de escribir
    OrdenarVector(logs);

    // Guardar en archivo
    nombreArchivo := 'log' + Format('%.2d', [i]) + '.dat';
    assign(f, nombreArchivo);
    rewrite(f);
    for j := 1 to CANT_REGISTROS do
      write(f, logs[j]);
    close(f);

    writeln('Archivo ordenado generado: ', nombreArchivo);
  end;
end.