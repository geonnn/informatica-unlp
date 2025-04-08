program ej1;
type
    recComision = record
        cod: integer;
        nombre: string;
        monto: real;
    end;

    archivo = file of recComision;
    const VALOR_ALTO = maxInt;

procedure Leer(var archivo: archivo; var c: recComision);
begin
    if not EOF(archivo) then
        read(archivo, c)
    else
        c.cod := VALOR_ALTO;
end;

procedure Imprimir(c: recComision);
begin
    writeln('cod: ', c.cod);
    writeln('nombre: ', c.nombre);
    writeln('monto: ', c.monto:0:2);
end;

procedure ImprimirArchivo(var archivo: archivo);
var
    c: recComision;
begin
    while not EOF(archivo) do begin
        read(archivo, c);
        Imprimir(c);
        writeln();
    end;
end;

procedure Compactar(var origen: archivo; var nuevo: archivo);
var
    c, aux: recComision;
    mTot: real;
begin
    Leer(origen, c);
    while (c.cod <> VALOR_ALTO) do begin
        aux := c;
        mTot := 0;
        while (c.cod = aux.cod) do begin
            mTot := mTot + c.monto;
            Leer(origen, c);
        end;
        aux.monto := mTot;
        write(nuevo, aux);
    end;
end;

var
    origen, nuevo: archivo;
begin
    assign(origen, 'archivoOrigen');
    reset(origen);

    assign(nuevo, 'empleadosNuevo');
    rewrite(nuevo);

    Compactar(origen, nuevo);

    close(origen);
    close(nuevo);

    reset(nuevo);
    ImprimirArchivo(nuevo);
    close(nuevo);
end.