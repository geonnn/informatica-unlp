{1. Se tiene información en un archivo de las horas extras realizadas por los empleados de una empresa en un mes. Para cada empleado se tiene la siguiente información: departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por división y, por último, por número de empleado. Presentar en pantalla un listado con el siguiente formato:

Departamento

División 
    Número de Empleado    Total de Hs.   Importe a cobrar
    ........              ..........     ............
    ........              ..........     ............

    Total de horas división:  ____
    Monto total por división: ____

División
    ........

Total de horas departamento:  ____
Monto total por departamento: ____

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el número de categoría.
}

program ej11;

const
    VALOR_ALTO_ST = 'ZZZZZ';
    CANT_CATEGORIAS = 15;

type
    recEmpleado = record
        depto: string;
        division: integer;
        numEmpleado: integer;
        categoria: 1..15;
        cantHorasExtra: real;
    end;

    maestro = file of recEmpleado;
    archivoHsExtra = Text;
    arrayValorHoraExtra = array[1..15] of real;

procedure CargarArregloHsExtra(var aVH: arrayValorHoraExtra; var hsExtra: archivoHsExtra);
var
    valorH: real;
    i: integer;
begin
    for i := 1 to 15 do begin
        read(hsExtra, valorH);
        aVH[i] := valorH;
    end;
end;

procedure Leer(var mae: maestro; var e: recEmpleado);
begin
    if (not EOF(mae)) then
        read(mae, e)
    else
        e.depto := VALOR_ALTO_ST;
end;

procedure ProcesarHorasExtra(var mae: maestro; aVH: arrayValorHoraExtra);
var
    deptoAct: string;
    divAct: integer;
    montoDepto, hsDepto, montoDiv, hsDiv, montoEmpleado: real;
    e: recEmpleado;

begin
    Leer(mae, e);
    while (e.depto <> VALOR_ALTO_ST) do begin
        deptoAct := e.depto;
        hsDepto := 0;
        montoDepto := 0;

        writeln('Departamento: ', deptoAct, '.');
        writeln;

        while (deptoAct = e.depto) do begin
            divAct := e.division;
            hsDiv := 0;
            montoDiv := 0;

            writeln('  División: ', divAct, '.');
            writeln;
            writeln('    Número de empleado  |  Total de hs.  |  Importe a cobrar');

            while (deptoAct = e.depto) and (divAct = e.division) do begin
                montoEmpleado := e.cantHorasExtra * aVH[e.categoria];
                writeln('    ', e.numEmpleado, '  |  ', e.cantHorasExtra:0:2, 'hs.  |  $', montoEmpleado:0:2);
                hsDiv := hsDiv + e.cantHorasExtra;
                montoDiv := montoDiv + montoEmpleado;
                Leer(mae, e);
            end;

            hsDepto := hsDepto + hsDiv;
            montoDepto := montoDepto + montoDiv;

            writeln;
            writeln('Total de horas división: ', hsDiv:0:2, 'hs.');
            writeln('Monto total división: $', montoDiv:0:2, '.');

            writeln;
            writeln('--------------- FIN DIVISIÓN ---------------');
            writeln;
        end;

        writeln;
        writeln('Total de horas departamento: ', hsDepto:0:2, 'hs.');
        writeln('Monto total departamento: $', montoDepto:0:2, '.');

        writeln;
        writeln('=============== FIN DEPARTAMENTO ===============');
        writeln;
    end;
end;

var
    aVH: arrayValorHoraExtra;
    hsExtra: archivoHsExtra;
    mae: maestro;
begin

    assign(hsExtra, 'valores_horas_extra.txt');
    reset(hsExtra);
    CargarArregloHsExtra(aVH, hsExtra);
    close(hsExtra);

    assign(mae, 'maestro.dat');
    reset(mae);

    ProcesarHorasExtra(mae, aVH);

    close(mae);
end.