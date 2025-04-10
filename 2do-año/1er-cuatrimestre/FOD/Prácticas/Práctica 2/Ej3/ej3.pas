{3. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle pueden venir 0, 1 ó más registros por cada provincia.}

program ej3;

const
    VALOR_ALTO = 'ZZZZ';

type
    recMaestro = record
        prov: string;
        cantAlf: integer;
        totalEnc: integer;
    end;

    recDetalles = record
        prov: string;
        codLoc: integer;
        cantAlf: integer;
        totalEnc: integer;
    end;

    maestro = file of recMaestro;
    detalle = file of recDetalles;

procedure Leer(var det: detalle; var d: recDetalles);
begin
    if not EOF(det) then
        read(det, d)
    else
        d.prov := VALOR_ALTO;
end;

procedure Minimo(var det1, det2: detalle; var r1, r2, min: recDetalles);
begin
    if (r1.prov <= r2.prov) then begin
        min := r1;
        Leer(det1, r1);
    end
    else begin
        min := r2;
        Leer(det2, r2);
    end;
end;

procedure ActualizarMaestro(var mae: maestro; var det1, det2: detalle);
var
    regm: recMaestro;
    regd1, regd2, min: recDetalles;
begin
    reset(mae);
    reset(det1);
    reset(det2);

    Leer(det1, regd1);
    Leer(det2, regd2);
    Minimo(det1, det2, regd1, regd2, min);
    while (min.prov <> VALOR_ALTO) do begin
        read(mae, regm);
        while (regm.prov <> min.prov) do
            read(mae, regm);
        while (regm.prov = min.prov) do begin
            regm.cantAlf := regm.cantAlf + min.cantAlf;
            regm.totalEnc := regm.totalEnc + min.totalEnc;
            Minimo(det1, det2, regd1, regd2, min);
        end;
        seek(mae, FilePos(mae)-1);
        write(mae, regm);
    end;

    close(mae);
    close(det1);
    close(det2);
end;

procedure ImprimirMaestro(var mae: maestro);
var
    r: recMaestro;
begin
    reset(mae);
    while not EOF(mae) do begin
        read(mae, r);
        writeln('Provincia: ', r.prov);
        writeln('Cantidad de Alfabetizados: ', r.cantAlf);
        writeln('Total Encuestados: ', r.totalEnc);
        writeln('-------------------------');
    end;
    close(mae);
end;

var
    mae: maestro;
    det1, det2: detalle;
begin
    assign(mae, 'maestro');
    assign(det1, 'detalle1');
    assign(det2, 'detalle2');
    writeln('maestro sin actualizar: '); writeln;
    ImprimirMaestro(mae);
    ActualizarMaestro(mae, det1, det2);
    writeln('maestro actualizado: '); writeln;
    ImprimirMaestro(mae);
end.