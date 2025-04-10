{2. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. De cada producto se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se genera un archivo detalle donde se registran todas las ventas de productos realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.}

program ej2;

uses Crt, sysutils;

const VALOR_ALTO = maxInt;

type
    recProd = record
        cod: integer;
        nom: string;
        precio: real;
        stAct: integer;
        stMin: integer;
    end;

    recVenta = record
        codProd: integer;
        cantUV: integer;
    end;

    maestro = file of recProd;
    detalle = file of recVenta;

procedure Leer(var det: detalle; var v: recVenta);
begin
    if not EOF(det) then
        read(det, v)
    else
        v.codProd := VALOR_ALTO;
end;

function Separador(st: string): string;
begin
    Separador := (#10'---------- ' + st + ' ----------'#10);
end;

procedure TextoMenu;
begin
    writeln(Separador('Menú de opciones'));
    writeln('1. Actualizar archivo maestro.');
    writeln('2. Listar productos con stock por debajo del mínimo.');
    writeln('0. Finalizar el programa.'); writeln;
    writeln('Seleccione una opción: ');
end;

procedure VolverMenu;
begin
    writeln;
    writeln;
    writeln('Presione una tecla para volver al menú...');
    ReadKey;
end;

procedure EscribirMaestro(var mae: maestro; v: recVenta);
var
    p: recProd;
begin
    read(mae, p);
    while (p.cod <> v.codProd) do begin
        read(mae, p);
    end;
    p.stAct := p.stAct - v.cantUV;
    seek(mae, FilePos(mae)-1);
    write(mae, p);
end;

procedure ActualizarMaestro(var mae: maestro; var det: detalle);
var
    v, vAux: recVenta;
    totalUV: integer;
begin
    reset(mae);
    reset(det);

    Leer(det, v);
    while (v.codProd <> VALOR_ALTO) do begin
        vAux := v;
        totalUV := 0;
        while (v.codProd = vAux.codProd) do begin
            totalUV := totalUV + vAux.cantUV;
            Leer(det, v);
        end;
        vAux.cantUV := totalUV;
        EscribirMaestro(mae, vAux);
    end;

    close(mae);
    close(det);
end;

procedure ListarStockBajo(var mae: maestro);
var
    archTxt: Text;
    p: recProd;
begin
    reset(mae);
    assign(archTxt, 'stock_minimo.txt');
    rewrite(archTxt);

    while not EOF(mae) do begin
        read(mae, p);
        if (p.stAct < p.stMin) then
            writeln(archTxt, 'Código: ', p.cod, ', Nombre: ', p.nom, ', Precio: ', p.precio:0:2, 
            ', Stock Actual: ', p.stAct, ', Stock Mínimo: ', p.stMin);
    end;

    close(mae);
    close(archTxt);
end;

var
    mae: maestro;
    det: detalle;
    m: integer;
begin
    assign(mae, 'Productos');
    assign(det, 'Ventas');
    repeat
        ClrScr;
        TextoMenu;
        readln(m);
        writeln;
        case (m) of
            1: ActualizarMaestro(mae, det);
            2: ListarStockBajo(mae);
            0: writeln(Separador('Programa finalizado'));
        else writeln('Ingrese una opción válida.');
        end;
        if (m <> 0) then
            VolverMenu; // Espera input para volver al menu.
    until (m = 0);
end.