program probar_ej6;
uses
    SysUtils;

const
    N_MUNICIPIOS = 10;

type
    recDetalle = record
        codLocalidad: integer;
        codCepa: integer;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;

    recMaestro = record
        codLocalidad: integer;
        nomLocalidad: string[40];
        codCepa: integer;
        nomCepa: string[40];
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;

    detalle = file of recDetalle;
    maestro = file of recMaestro;

procedure CrearMaestro;
var
    mae: maestro;
    r: recMaestro;
    i: integer;
begin
    assign(mae, 'maestro');
    rewrite(mae);
    for i := 1 to 5 do begin
        r.codLocalidad := i;
        r.nomLocalidad := 'Localidad' + IntToStr(i);
        r.codCepa := i;
        r.nomCepa := 'Cepa' + IntToStr(i);
        r.cantActivos := 10 * i;
        r.cantNuevos := 5 * i;
        r.cantRecuperados := 3 * i;
        r.cantFallecidos := 2 * i;
        write(mae, r);
    end;
    close(mae);
end;

procedure CrearDetalles;
var
    det: detalle;
    r: recDetalle;
    i, j: integer;
    nombre: string;
begin
    for i := 1 to N_MUNICIPIOS do begin
        nombre := Format('municipio%.2d.dat', [i]);
        assign(det, nombre);
        rewrite(det);
        for j := 1 to 5 do begin
            r.codLocalidad := j;
            r.codCepa := j;
            r.cantActivos := 10 + i; // valores distintos por archivo
            r.cantNuevos := 5 + i;
            r.cantRecuperados := 2 + i;
            r.cantFallecidos := 1 + i;
            write(det, r);
        end;
        close(det);
    end;
end;

begin
    CrearMaestro;
    CrearDetalles;
    writeln('Archivos de prueba creados. Ejecutá el programa principal para probar la actualización.');
end.