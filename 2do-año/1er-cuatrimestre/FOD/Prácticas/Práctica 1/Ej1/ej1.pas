program ej1;
type
    archivo = file of integer;

var
    n: integer;
    archivo_logico: archivo;
    nomArch: string;
begin
    writeln('Ingrese ruta del archivo: ');
    readln(nomArch);
    assign(archivo_logico, nomArch);
    rewrite(archivo_logico);

    writeln('Ingrese un número entero: ');
    readln(n);
    while (n <> 30000) do begin
        write(archivo_logico, n);
        writeln('Ingrese otro número entero: ');
        read(n);
    end;
    close(archivo_logico);
end.