program generarValoresHorasExtra;

uses
  SysUtils;

var
  f: TextFile;
  i: integer;
  valor: real;
begin
  Assign(f, 'valores_horas_extra.txt');
  Rewrite(f);

  for i := 1 to 15 do
  begin
    valor := 100 + i * 5; // valores de ejemplo: 105, 110, ..., 175
    writeln(f, valor:0:2);
  end;

  Close(f);
  writeln('Archivo valores_horas_extra.txt generado correctamente.');
end.
