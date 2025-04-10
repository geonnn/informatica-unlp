program generar_archivos;

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

var
    mae: maestro;
    det1, det2: detalle;
    regm: recMaestro;
    regd: recDetalles;

begin
    // Crear archivo maestro
    assign(mae, 'maestro');
    rewrite(mae);
    regm.prov := 'Buenos Aires'; regm.cantAlf := 100; regm.totalEnc := 200;
    write(mae, regm);
    regm.prov := 'Cordoba'; regm.cantAlf := 50; regm.totalEnc := 120;
    write(mae, regm);
    regm.prov := 'Santa Fe'; regm.cantAlf := 70; regm.totalEnc := 150;
    write(mae, regm);
    close(mae);

    // Crear archivo detalle1
    assign(det1, 'detalle1');
    rewrite(det1);
    regd.prov := 'Buenos Aires'; regd.codLoc := 1; regd.cantAlf := 10; regd.totalEnc := 20;
    write(det1, regd);
    regd.prov := 'Cordoba'; regd.codLoc := 2; regd.cantAlf := 5; regd.totalEnc := 10;
    write(det1, regd);
    regd.prov := 'Cordoba'; regd.codLoc := 2; regd.cantAlf := 5; regd.totalEnc := 10;
    write(det1, regd);
    regd.prov := 'Cordoba'; regd.codLoc := 2; regd.cantAlf := 5; regd.totalEnc := 10;
    write(det1, regd);
    close(det1);

    // Crear archivo detalle2
    assign(det2, 'detalle2');
    rewrite(det2);
    regd.prov := 'Buenos Aires'; regd.codLoc := 3; regd.cantAlf := 15; regd.totalEnc := 30;
    write(det2, regd);
    regd.prov := 'Buenos Aires'; regd.codLoc := 3; regd.cantAlf := 15; regd.totalEnc := 30;
    write(det2, regd);
    regd.prov := 'Santa Fe'; regd.codLoc := 4; regd.cantAlf := 7; regd.totalEnc := 15;
    write(det2, regd);
    regd.prov := 'Santa Fe'; regd.codLoc := 4; regd.cantAlf := 7; regd.totalEnc := 15;
    write(det2, regd);
    regd.prov := 'Santa Fe'; regd.codLoc := 4; regd.cantAlf := 7; regd.totalEnc := 15;
    write(det2, regd);
    close(det2);

    writeln('Archivos maestro, detalle1 y detalle2 generados correctamente.');
end.