program generarMaestro;

type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recAcceso = record
        fecha: recFecha;
        idUsuario: integer;
        tiempoAcceso: real;
    end;

    maestro = file of recAcceso;

var
    mae: maestro;
    r: recAcceso;
begin
    assign(mae, 'maestro.dat');
    rewrite(mae);

    // Datos para año 2023
    r.fecha.anio := 2023;
    r.fecha.mes := 1;
    r.fecha.dia := 1;
    r.idUsuario := 101;
    r.tiempoAcceso := 1.5;
    write(mae, r);

    r.idUsuario := 102;
    r.tiempoAcceso := 2.0;
    write(mae, r);

    r.fecha.dia := 2;
    r.idUsuario := 101;
    r.tiempoAcceso := 1.0;
    write(mae, r);

    r.fecha.mes := 2;
    r.fecha.dia := 1;
    r.idUsuario := 101;
    r.tiempoAcceso := 3.2;
    write(mae, r);

    r.idUsuario := 103;
    r.tiempoAcceso := 0.8;
    write(mae, r);

    // Datos para año 2024
    r.fecha.anio := 2024;
    r.fecha.mes := 1;
    r.fecha.dia := 1;
    r.idUsuario := 201;
    r.tiempoAcceso := 4.5;
    write(mae, r);

    r.idUsuario := 202;
    r.tiempoAcceso := 2.5;
    write(mae, r);

    close(mae);
    writeln('Archivo maestro.dat generado con éxito.');
end.
