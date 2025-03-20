program ej2;
type
    archivo = file of integer;

var
    n, numsMen, total: integer;
    archivo_logico: archivo;
    nomArch: string;
begin
    writeln('Ingrese ruta del archivo a leer: ');
    readln(nomArch); // ..\Ej1\numeros_enteros
    assign(archivo_logico, nomArch);
    reset(archivo_logico);
    numsMen := 0;
    total := 0;

    read(archivo_logico, n);
    while not EOF(archivo_logico) do begin
        if (n < 1500) then
            numsMen := numsMen + 1;
        total := total + n;
        read(archivo_logico, n);
    end;
    writeln('Cantidad de números menores a 1500: ', numsMen);
    writeln('Promedio: ', (total / FileSize(archivo_logico)):0:2);
    close(archivo_logico);
end.