{7. Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice un programa que permita borrar especies de aves extintas. Este programa debe disponer de dos procedimientos: 
    a. Un procedimiento que dada una especie de ave (su código) marque la misma como borrada (en caso de querer borrar múltiples especies de aves, se podría invocar este procedimiento repetidamente). 
    b. Un procedimiento que compacte el archivo, quitando definitivamente las especies de aves marcadas como borradas. Para quitar los registros se deberá copiar el último registro del archivo en la posición del registro a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros duplicados. 
        i. Implemente una variante de este procedimiento de compactación del archivo (baja física) donde el archivo se trunque una sola vez. }

program ej7;

type
    recEspecieAve = record
        cod: integer;
        nombre: string;
        familia: string;
        desc: string;
        zonaGeog: string;
    end;

    maestro = file of recEspecieAve;

procedure BajaAve(var mae: maestro; cod: integer);
var
    e: recEspecieAve;
begin
    reset(mae);

    read(mae, e);
    while (not EOF(mae)) and (cod <> e.cod) do
        read(mae, e);
    
    if (cod = e.cod) then begin
        e.cod := -1;
        seek(mae, FilePos(mae)-1);
        write(mae, e);
    end;

    close(mae);
end;

procedure CompactarArchivo(var mae: maestro);
var
    e, eLast: recEspecieAve;
    posBaja: integer;
begin
    reset(mae);

    while (not EOF(mae)) do begin
        read(mae, e);
        if (e.cod < 0) then begin
            posBaja := FilePos(mae)-1;

            seek(mae, FileSize(mae)-1);
            read(mae, eLast);

            seek(mae, posBaja);
            write(mae, eLast);

            seek(mae, FileSize(mae)-1);
            truncate(mae);

            // Retornar el puntero a dónde estaba. No es posBaja + 1 porque si el último estaba marcado podría saltearse.
            seek(mae, posBaja);
        end;
    end;

    close(mae);
end;

procedure CompactarUnSoloTruncate(var mae: maestro);
var
    e, eLast: recEspecieAve;
    posBaja, posLast: integer;
begin
    reset(mae);
    posLast := FileSize(mae)-1;

    while (not EOF(mae)) do begin
        read(mae, e);
        if (e.cod < 0) then begin
            posBaja := FilePos(mae)-1;

            seek(mae, posLast);
            read(mae, eLast);

            seek(mae, posBaja);
            write(mae, eLast);

            posLast := posLast - 1;

            // Retornar el puntero a dónde estaba. No es posBaja + 1 porque si el último estaba marcado podría saltearse.
            seek(mae, posBaja);
        end;
    end;

    seek(mae, posLast+1);
    truncate(mae);

    close(mae);
end;

var
    mae: maestro;
begin
    assign(mae, 'maestro.dat');

    BajaAve(mae, 5);

    CompactarArchivo(mae);
end.
