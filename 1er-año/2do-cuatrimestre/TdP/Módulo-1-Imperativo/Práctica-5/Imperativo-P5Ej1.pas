{1.El administrador de un edificio de oficinas tiene la información del pago de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que administra. Se deben cargar, para cada oficina, el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando llega el código de identificación 0.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0. Luego el programa debe informar el DNI del propietario o un cartel indicando que no se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.}

program Ej1;
const
    dimF = 300;

type

    recOficina = record
        codigo: integer;
        DNIpropietario: int64;
        expensa: real;
    end;

    vectorOficinas = array[1..dimF] of recOficina;

procedure ImprimirVector(v: vectorOficinas; dimL: integer);
var
    i: integer;
begin
    for i := 1 to dimL do begin
        writeln;
        write(' -> Código: ', v[i].codigo:3);
        write(' | DNI Propietario: ', v[i].DNIpropietario:8);
        write(' | Valor expensa: $', v[i].expensa:5:2);
    end;
end;

procedure ModuloA(var vO: vectorOficinas; var dimL: integer);

    procedure GenerarOficina(var o: recOficina);
    begin
        o.codigo := random(301);
        //o.codigo := 0;
        if (o.codigo = 0) then
            writeln('Carga finalizada.')
        else begin
            o.DNIpropietario := random(98000000 - 10000000 + 1) + 10000000; // Siempre sale un DNI de 8 dígitos.
            o.expensa := (random(7000000 - 2000000 + 1) + 2000000) / 100; // [20000 - 70000]
        end;
    end;

    procedure CargarVector(var vO: vectorOficinas; var dimL: integer; o: recOficina);
    begin
        dimL := dimL + 1;
        vO[dimL] := o;
    end;

var
    o: recOficina;
begin
    dimL := 0;
    GenerarOficina(o);
    while (dimL < dimF) and (o.codigo <> 0) do begin
        CargarVector(vO, dimL, o);
        GenerarOficina(o);
        o.codigo := 0;
    end;

    writeln;
    writeln;
    writeln('----- Vector generado -----');
    writeln;
    ImprimirVector(vO, dimL);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////');
end;

procedure ModuloB(var v: vectorOficinas; dimL: integer);

    procedure OrdenarVector(var v: vectorOficinas; dimL: integer);
    var
        i, j, pos: integer;
        item: recOficina;
    begin
        for i := 1 to (dimL - 1) do begin
            pos := i;
            for j := (i + 1) to dimL do
                if (v[j].codigo < v[pos].codigo) then
                    pos := j;
            item := v[pos];
            v[pos] := v[i];
            v[i] := item;
        end;
    end;

begin
    writeln;
    writeln;
    writeln('----- Vector ordenado -----');
    writeln;
    OrdenarVector(v, dimL);
    ImprimirVector(v, dimL);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////');
end;

procedure ModuloC(v: vectorOficinas; dimL: integer);

    function Dicotomica(v: vectorOficinas; dimL, codInput: integer): integer;
    var
        inf, sup, medio: integer;
    begin
        inf := 1;
        sup := dimL;
        medio := (inf + sup) div 2;
        while (inf <= sup) and (codInput <> v[medio].codigo) do begin
            if (codInput < v[medio].codigo) then
                sup := medio - 1
            else
                inf := medio + 1;
        medio := (inf + sup) div 2;
        end;
        if (inf <= sup) and (codInput = v[medio].codigo) then
            Dicotomica := medio
        else
            Dicotomica := 0;
    end;

var
    codInput, pos: integer;
begin
    writeln;
    writeln;
    writeln('----- Búsqueda dicotómica -----');
    writeln;
    write('Ingrese un código de oficina para buscar: ');
    read(codInput);
    writeln;
    pos := Dicotomica(v, dimL, codInput);
    if (pos = 0) then
        writeln('No se encontró la oficina buscada.')
    else
        writeln('DNI del propietario de la oficina ', codInput, ': ', v[pos].DNIpropietario, '.');
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////');
end;

procedure ModuloD(v: vectorOficinas; dimL: integer);

    function MontoTotal(v: vectorOficinas; dimL: integer): real;
    begin
        if (dimL <> 0) then
            MontoTotal := MontoTotal(v, dimL - 1) + v[dimL].expensa
        else
            MontoTotal := 0;
    end;

begin
    writeln;
    writeln;
    writeln('----- Monto total de expensas -----');
    writeln;
    writeln('El monto total de expensas entre todas las oficinas es: $', MontoTotal(v, dimL):0:2, '.');
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////////////');
end;

var
    vO: vectorOficinas;
    dimL: integer;
begin
    randomize;
    ModuloA(vO, dimL);
    ModuloB(vO, dimL);
    //ModuloC(vO, dimL);
    ModuloD(vO, dimL);
end.