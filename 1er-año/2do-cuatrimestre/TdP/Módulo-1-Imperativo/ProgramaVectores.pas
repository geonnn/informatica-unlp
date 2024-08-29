program Listas;
const
	C_MAX = 50;
type
	vector = array[1..C_MAX] of integer;

procedure CargarVector(var v: vector; var dimL: integer; min, max: integer);
var
	num: integer;
begin
	num := random(max - min + 1) + min;
	while (dimL < 50) and (num <> 0) do begin
		dimL := dimL + 1;
		v[dimL] := num;
		num := random(max - min + 1) + min;
	end;	
end;

procedure ImprimirVector(v: vector; dimL: integer);
var
	i: integer;
begin
	for i := 1 to dimL do
		writeln('Nro. ', i, ':    ', v[i]);
end;
var
	v: vector;
	dimL, min, max: integer;
begin
	read(min, max);
	randomize;
	dimL := 0;
	CargarVector(v, dimL, min, max);
	ImprimirVector(v, dimL);
end.
