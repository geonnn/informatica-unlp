{10. Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo
sumo 300 empleados). La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando
se completa el vector. Una vez finalizada la carga de datos se pide:
a. Realizar un módulo que incremente el salario de cada empleado en un 15%. Para ello, implementar
un módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión
lógica y retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.
b. Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa.}

program Ej10;

const
    dimF = 300;
    incremento = 1.15;

type
    vSalarios = array[1..dimF] of real;

procedure IncrementarSalario(var v: vSalarios; dimL: integer; X: real);
var
    i: integer;
begin
    for i := 1 to dimL do
        v[i] := (v[i] * X);
end;

procedure SueldoPromedio(v: vSalarios; dimL: integer);
var
    i: integer;
    salariosTotal: real;
begin
    salariosTotal := 0;
    for i := 1 to dimL do
        salariosTotal := salariosTotal + v[i];
    writeln('El promedio de salarios es: ', (salariosTotal / dimL):0:2, '.');
end;

procedure LeerSalariosDesdeArchivo(var v: vSalarios; var dimL: integer; dimF: integer);
var
    ArchivoSalarios: Text;
    salario: real;
begin
    Assign(ArchivoSalarios, 'Ej10SalariosLista.txt');
    Reset(ArchivoSalarios);
    readln(ArchivoSalarios, salario);
    while (not EOF(ArchivoSalarios)) and (dimL < dimF) and (salario <> 0) do begin
        dimL := dimL + 1;
        v[dimL] := salario;
        readln(ArchivoSalarios, salario);
    end;
    Close(ArchivoSalarios);
end;

var
    v: vSalarios;
    dimL: integer;
begin
    dimL := 0;
    LeerSalariosDesdeArchivo(v, dimL, dimF);
    SueldoPromedio(v, dimL);
    IncrementarSalario(v, dimL, incremento);
    writeln('Salarios con aumento: ');
    SueldoPromedio(v, dimL);
end.
