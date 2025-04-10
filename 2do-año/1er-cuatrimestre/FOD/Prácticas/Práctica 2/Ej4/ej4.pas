{4. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. De cada producto se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro. La información que se recibe en los detalles es: código de producto y cantidad vendida. Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo procedimiento de actualización, o realizarlo en un procedimiento separado (analizar ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle puede venir 0 o N registros de un determinado producto.}

program ej4;
const
    VALOR_ALTO = maxInt;
    CANT_DETALLES = 30;

type
    recProd = record
        cod: integer;
        nom: string[20];
        desc: string[40];
        stDisp: integer;
        stMin: integer;
        precio: real;
    end;

    recVenta = record
        codProd: integer;
        cantUV: integer;
    end;

    maestro = file of recProd;
    detalle = file of recVenta;

    arrayDetalles = array[1..CANT_DETALLES] of detalle;
    arrayRecsVenta = array[1..CANT_DETALLES] of recVenta;

procedure Leer(var det: detalle; var v: recVenta);
begin
    if not EOF(det) then
        read(det, v)
    else
        v.codProd := VALOR_ALTO;
end;

procedure Minimo(var aD: arrayDetalles; var aV: arrayRecsVenta; var min: recVenta);
var
    i, posMin: integer;
begin
    posMin := -1;
    min.codProd := VALOR_ALTO;

    for i := 1 to CANT_DETALLES do
        if (aV[i].codProd < min.codProd) then begin
            min := aV[i];
            posMin := i;
        end;
    if (posMin <> -1) then
        Leer(aD[posMin], aV[posMin]);
end;

procedure AsignarDetalles(var aD: arrayDetalles; var aV: arrayRecsVenta);
var
    i: integer;
begin
    for i := 1 to CANT_DETALLES do begin
        assign(aD[i], 'detalle' + i);
        // Esto no compila pero la lógica sería iterar sobre el nombre de archivos:
        // aD[1], detalle1 | aD[2], detalle2 | ... | aD[N], detalleN.
        //
        reset(aD[i]);
        Leer(aD[i], aV[i]);
    end;
end;

procedure ProcesarDetalles(var mae: maestro; var aD: arrayDetalles; var aV: arrayRecsVenta; var archTxt: Text);
var
    i: integer;
    regm: recProd;
    min: recVenta;
begin
    reset(mae);
    rewrite(archTxt);
    
    Minimo(aD, aV, min);
    while (min.codProd <> VALOR_ALTO) do begin
        read(mae, regm);
        while (regm.cod <> min.codProd) do
            read(mae, regm);
        while (regm.cod = min.codProd) do begin
            regm.stDisp := regm.stDisp - min.cantUV;
            Minimo(aD, aV, min);
        end;
        seek(mae, FilePos(mae)-1);
        write(mae, regm);
        
        // Exportar stocks bajos a archivo de texto.
        if (regm.stDisp < regm.stMin) then
            writeln(archTxt, regm.nom, ' ', regm.desc, ' ', regm.stDisp, ' ', regm.precio:0:2);
    end;

    for i := 1 to CANT_DETALLES do
        close(aD[i]);

    close(archTxt);    
    close(mae);
end;

var
    mae: maestro;
    arrDets: arrayDetalles;
    arrVentas: arrayRecsVenta;
    archTxt: Text;
begin
    AsignarDetalles(arrDets, arrVentas);
    assign(mae, 'maestro');
    assign(archTxt, 'stock_minimo.txt');
    ProcesarDetalles(mae, arrDets, arrVentas, archTxt);
end.