program generarArchivos;

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

var
    mae: maestro;
    det: detalle;
    p: recProd;
    v: recVenta;

begin
    // Crear archivo maestro
    assign(mae, 'Productos');
    rewrite(mae);

    p.cod := 1; p.nom := 'Leche';     p.precio := 120.50; p.stAct := 50; p.stMin := 10; write(mae, p);
    p.cod := 2; p.nom := 'Harina';    p.precio := 90.00;  p.stAct := 25; p.stMin := 10; write(mae, p);
    p.cod := 3; p.nom := 'Arroz';     p.precio := 130.00; p.stAct := 15; p.stMin := 10; write(mae, p);
    p.cod := 4; p.nom := 'Fideos';    p.precio := 85.00;  p.stAct := 5;  p.stMin := 10; write(mae, p);
    p.cod := 5; p.nom := 'Aceite';    p.precio := 300.00; p.stAct := 20; p.stMin := 10; write(mae, p);

    close(mae);

    // Crear archivo detalle
    assign(det, 'Ventas');
    rewrite(det);

    v.codProd := 1; v.cantUV := 1; write(det, v);
    v.codProd := 1; v.cantUV := 1; write(det, v);
    v.codProd := 1; v.cantUV := 3; write(det, v);
    v.codProd := 1; v.cantUV := 2; write(det, v);
    v.codProd := 2; v.cantUV := 5;  write(det, v);
    v.codProd := 3; v.cantUV := 10; write(det, v);
    v.codProd := 4; v.cantUV := 2;  write(det, v);
    v.codProd := 4; v.cantUV := 2;  write(det, v);
    v.codProd := 4; v.cantUV := 2;  write(det, v);
    v.codProd := 5; v.cantUV := 15; write(det, v);
    v.codProd := 5; v.cantUV := 2; write(det, v);

    close(det);

    writeln('Archivos "Productos" y "Ventas" generados correctamente.');
end.
