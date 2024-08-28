{TEMA 2-CADP 2024
29/6/2024
Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con todas las compras realizadas, sin ningún orden en particular. De cada compra se conoce: código, año (entre 1980 y 2024), monto y DNI del cliente. Un cliente puede haber realizado más
de una compra.
Realizar un programa procese la información de las compras y:
a. Almacene en otra estructura de datos las compras realizadas entre los años 2010 y 2020. Esta estructura debe quedar ordenada por el DNI del cliente.
b. Una vez almacenada la estructura del inciso a, procesar estos datos e informar:
1. El año con menor facturación.
2. Los dos DNI de los clientes que realizaron mayor cantidad de compras.
3. COMPLETO: El monto total facturado de compras con código múltiplo de 10.}

program SupermercadoCompras;

type
  TDniCantidad = record
    dni: integer;
    cantidad: integer;
  end;

  TCompra = record
    codigo: integer;
    anio: integer;
    monto: real;
    dni: integer;
  end;

  PCompra = ^TCompraNode;
  TCompraNode = record
    data: TCompra;
    next: PCompra;
  end;

  PDniCantidad = ^TDniCantidadNode;
  TDniCantidadNode = record
    data: TDniCantidad;
    next: PDniCantidad;
  end;

procedure InsertarCompraOrdenado(var head: PCompra; nuevaCompra: TCompra);
var
  nuevoNodo, actual, anterior: PCompra;
begin
  new(nuevoNodo);
  nuevoNodo^.data := nuevaCompra;
  nuevoNodo^.next := nil;

  if (head = nil) or (nuevaCompra.dni < head^.data.dni) then
  begin
    nuevoNodo^.next := head;
    head := nuevoNodo;
  end
  else
  begin
    actual := head;
    anterior := nil;
    while (actual <> nil) and (actual^.data.dni < nuevaCompra.dni) do
    begin
      anterior := actual;
      actual := actual^.next;
    end;
    nuevoNodo^.next := actual;
    if anterior <> nil then
      anterior^.next := nuevoNodo;
  end;
end;

procedure InsertarDniCantidadOrdenado(var head: PDniCantidad; nuevoDniCantidad: TDniCantidad);
var
  nuevoNodo, actual, anterior: PDniCantidad;
begin
  new(nuevoNodo);
  nuevoNodo^.data := nuevoDniCantidad;
  nuevoNodo^.next := nil;

  if (head = nil) or (nuevoDniCantidad.dni < head^.data.dni) then
  begin
    nuevoNodo^.next := head;
    head := nuevoNodo;
  end
  else
  begin
    actual := head;
    anterior := nil;
    while (actual <> nil) and (actual^.data.dni < nuevoDniCantidad.dni) do
    begin
      anterior := actual;
      actual := actual^.next;
    end;
    nuevoNodo^.next := actual;
    if anterior <> nil then
      anterior^.next := nuevoNodo;
  end;
end;

procedure CargarCompras(var head: PCompra);
var
  nuevaCompra: TCompra;
begin
  writeln('Ingrese el código de la compra (-1 para finalizar): ');
  readln(nuevaCompra.codigo);
  while nuevaCompra.codigo <> -1 do
  begin
    writeln('Ingrese el año de la compra (entre 2010 y 2020): ');
    readln(nuevaCompra.anio);
    writeln('Ingrese el monto de la compra: ');
    readln(nuevaCompra.monto);
    writeln('Ingrese el DNI del cliente: ');
    readln(nuevaCompra.dni);
    InsertarCompraOrdenado(head, nuevaCompra);
    writeln('Ingrese el código de la compra (-1 para finalizar): ');
    readln(nuevaCompra.codigo);
  end;
end;

procedure InformarCompras(head: PCompra);
var
  actual: PCompra;
  anioActual, menorAnio, maxDni1, maxDni2, montoMultiplo10: integer;
  montoTotal, menorMonto: real;
  anios: array[2010..2020] of real;
begin
  for anioActual := 2010 to 2020 do
    anios[anioActual] := 0;

  actual := head;
  while actual <> nil do
  begin
    anios[actual^.data.anio] := anios[actual^.data.anio] + actual^.data.monto;
    actual := actual^.next;
  end;

  menorAnio := 2010;
  menorMonto := anios[2010];
  for anioActual := 2011 to 2020 do
  begin
    if anios[anioActual] < menorMonto then
    begin
      menorAnio := anioActual;
      menorMonto := anios[anioActual];
    end;
  end;

  writeln('El año con menor facturación es: ', menorAnio);

  actual := head;
  maxDni1 := -1;
  montoMultiplo10 := 0;
  while actual <> nil do
  begin
    if (actual^.data.dni mod 10 = 0) then
      montoMultiplo10 := montoMultiplo10 + actual^.data.monto;
    if (actual^.data.dni > maxDni1) then
    begin
      maxDni2 := maxDni1;
      maxDni1 := actual^.data.dni;
    end
    else if (actual^.data.dni > maxDni2) then
      maxDni2 := actual^.data.dni;
    actual := actual^.next;
  end;

  writeln('Los DNIs de los dos clientes con mayor cantidad de compras son: ', maxDni1, ' y ', maxDni2);
  writeln('El monto total facturado de compras con código múltiplo de 10 es: ', montoMultiplo10:0:2);
end;

var
  head: PCompra;
begin
  head := nil;
  CargarCompras(head);
  InformarCompras(head);
end.