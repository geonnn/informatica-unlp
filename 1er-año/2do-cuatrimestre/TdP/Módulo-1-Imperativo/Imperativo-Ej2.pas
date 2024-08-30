{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program Ej2;
const
    C_OF = 300;
type
    recOficina = record
        codid: integer;
        dnipr: int64;
        valorexp: real;
    end;

    vector = array[1..C_OF] of recOficina;

procedure LeerOficina(var o: recOficina);
begin
    writeln('Ingrese código de identificación: ');
    readln(o.codid);
    if (o.codid = -1) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese DNI del propietario: ');
        readln(o.dnipr);
        writeln('Ingrese valor de la expensa: ');
        readln(o.valorexp);
    end;
end;

procedure CargarVector(var v: vector; var dimL: integer);
var
    o: recOficina;
begin
    LeerOficina(o);
    while (dimL < C_OF) and (o.codid <> -1) do begin
        dimL := dimL + 1;
        v[dimL] := o;
        LeerOficina(o);
    end;
end;

procedure ImprimirVector(v: vector; dimL: integer);
var
    i: integer;
begin
    for i := 1 to dimL do
        writeln('Código de oficina: ', v[i].codid)
end;

procedure Insercion(var v: vector; dimL: integer);
var
    i, j: integer;
    actual: recOficina;
begin
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;
        while (j > 0) and (v[j].codid > actual.codid) do begin
            v[j+1] := v[j];
            j := j - 1;
        end;
        v[j+1] := actual;
    end;
end;

procedure Seleccion(var v: vector; dimL: integer);
var
    i, j, pos: integer;
    item: recOficina;
begin
    for i := 1 to (dimL - 1) do begin
        pos := i;
        for j := i + 1 to dimL do
            if (v[j].codid < v[pos].codid) then
                pos := j;
        item := v[pos];
        v[pos] := v[i];
        v[i] := item;
    end;
end;

var
    v: vector;
    dimL: integer;
begin
    dimL := 0;
    CargarVector(v, dimL);
    ImprimirVector(v, dimL);
    writeln('');
    // Insercion(v, dimL);
    Seleccion(v, dimL);
    writeln('Post inserción/selección: ');
    writeln('');
    ImprimirVector(v, dimL);
end.