program generar_maestro;

uses
  SysUtils;

const
  NOMBRE_ARCHIVO = 'maestro.dat';

type
  recFecha = record
    dia: 1..31;
    mes: 1..12;
    anio: integer;
  end;

  recCliente = record
    codCliente: integer;
    nom: string;
    ap: string;
  end;

  recVenta = record
    cliente: recCliente;
    fecha: recFecha;
    monto: real;
  end;

  ventas = file of recVenta;

procedure AgregarVenta(var mae: ventas; cod: integer; nom, ap: string; dia, mes, anio: integer; monto: real);
var
  v: recVenta;
begin
  v.cliente.codCliente := cod;
  v.cliente.nom := nom;
  v.cliente.ap := ap;
  v.fecha.dia := dia;
  v.fecha.mes := mes;
  v.fecha.anio := anio;
  v.monto := monto;
  write(mae, v);
end;

var
  mae: ventas;

begin
  assign(mae, NOMBRE_ARCHIVO);
  rewrite(mae);

  // Cliente 1: Ana Torres
  AgregarVenta(mae, 1001, 'Ana', 'Torres', 5, 1, 2024, 1500.00);
  AgregarVenta(mae, 1001, 'Ana', 'Torres', 10, 1, 2024, 2000.00);
  AgregarVenta(mae, 1001, 'Ana', 'Torres', 2, 3, 2024, 1800.00);
  AgregarVenta(mae, 1001, 'Ana', 'Torres', 12, 3, 2024, 2200.00);
  AgregarVenta(mae, 1001, 'Ana', 'Torres', 15, 12, 2024, 5000.00);

  // Cliente 2: Bruno Díaz
  AgregarVenta(mae, 1002, 'Bruno', 'Díaz', 20, 4, 2024, 750.00);
  AgregarVenta(mae, 1002, 'Bruno', 'Díaz', 21, 4, 2024, 1250.00);
  AgregarVenta(mae, 1002, 'Bruno', 'Díaz', 5, 5, 2024, 1000.00);

  // Cliente 3: Carla Méndez (con ventas en dos años)
  AgregarVenta(mae, 1003, 'Carla', 'Méndez', 3, 6, 2023, 3000.00);
  AgregarVenta(mae, 1003, 'Carla', 'Méndez', 4, 7, 2023, 1500.00);
  AgregarVenta(mae, 1003, 'Carla', 'Méndez', 10, 1, 2024, 4000.00);
  AgregarVenta(mae, 1003, 'Carla', 'Méndez', 15, 2, 2024, 3500.00);

  close(mae);
  writeln('Archivo maestro.dat generado exitosamente.');
end.
