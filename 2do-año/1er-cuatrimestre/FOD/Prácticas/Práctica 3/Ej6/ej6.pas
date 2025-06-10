{6. Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con la información correspondiente a las prendas que se encuentran a la venta. De cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la información de las prendas a la venta. Para ello se deberá utilizar una estructura auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas que no están marcadas como borradas. Al finalizar este proceso de compactación del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro original.}

program ej6;

const
    VALOR_ALTO = maxInt;

type
    recPrenda = record
        codPrenda: integer;
        desc: string;
        colores: string;
        tipoPrenda: string;
        stock: integer;
        pUnit: real;
    end;

    maestro = file of recPrenda;
    obsoletas = file of integer;

procedure LeerP(var mae: maestro; var p: recPrenda);
begin
    if (not EOF(mae)) then
        read(mae, p)
    else
        p.codPrenda := VALOR_ALTO;
end;

procedure LeerC(var obs: obsoletas; var cod: integer);
begin
    if (not EOF(obs)) then
        read(obs, cod)
    else
        cod := VALOR_ALTO;
end;

procedure BajaLogica(var mae: maestro; var obs: obsoletas);
var
    cod: integer;
    recM: recPrenda;
begin
    reset(obs);
    reset(mae);

    LeerC(obs, cod);
    while (cod <> VALOR_ALTO) do begin
        // archivos no ordenados, pero todo lo que esté en obsoletas, estará en maestro.
        seek(mae, 0);
        read(mae, recM);
        while (not EOF(mae)) and (cod <> recM.codPrenda) do
            read(mae, recM);

        if (recM.codPrenda = cod) then begin
            recM.stock := -1;
            seek(mae, FilePos(mae)-1);
            write(mae, recM);
        end;
        
        LeerC(obs, cod);
    end;

    close(obs);
    close(mae);
end;

procedure BajaFisica(var mae, maeN: maestro);
var
    p: recPrenda;
begin
    reset(mae);
    rewrite(maeN);

    read(mae, p);
    while (not EOF(mae)) do begin
        if (p.stock >= 0) then
            write(maeN, p);
        read(mae, p);
    end;

    close(mae);
    close(maeN);

    rename(mae, 'maestro_old.dat');
    rename(maeN, 'maestro.dat');
end;


var
    mae, maeN: maestro;
    obs: obsoletas;
begin
    assign(mae, 'maestro.dat');
    assign(obs, 'obsoletas.dat');

    BajaLogica(mae, obs);

    assign(maeN, 'maestroN.dat');
    BajaFisica(mae, maeN);
end.
    