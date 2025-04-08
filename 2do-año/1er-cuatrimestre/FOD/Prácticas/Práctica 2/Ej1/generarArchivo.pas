program crearArchivoOrigen;

type
    recComision = record
        cod: integer;
        nombre: string;
        monto: real;
    end;

    archivo = file of recComision;

var
    arch: archivo;
    c: recComision;

begin
    assign(arch, 'archivoOrigen');
    rewrite(arch);

    // Agregar datos de prueba (ordenados por código)
    c.cod := 1; c.nombre := 'Juan'; c.monto := 100.50; write(arch, c);
    c.cod := 1; c.nombre := 'Juan'; c.monto := 200.00; write(arch, c);
    c.cod := 2; c.nombre := 'Ana';  c.monto := 300.75; write(arch, c);
    c.cod := 3; c.nombre := 'Lis'; c.monto := 50.00;  write(arch, c);
    c.cod := 4; c.nombre := 'Sofía';c.monto := 500.00; write(arch, c);

    close(arch);
end.
