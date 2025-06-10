{8. Se cuenta con un archivo con información de las diferentes distribuciones de linux existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida. Escriba la definición de las estructuras de datos necesarias y los siguientes procedimientos:
    a. BuscarDistribucion: módulo que recibe por parámetro el archivo, un nombre de distribución y devuelve la posición dentro del archivo donde se encuentra el registro correspondiente a la distribución dada (si existe) o devuelve -1 en caso de que no exista.. 
    b. AltaDistribucion: módulo que recibe como parámetro el archivo y el registro que contiene los datos de una nueva distribución, y se encarga de agregar la distribución al archivo reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que se quiere agregar ya exista se debe informar “ya existe la distribución”. 
    c. BajaDistribucion: módulo que recibe como parámetro el archivo y el nombre de una distribución, y se encarga de dar de baja lógicamente la distribución dada. Para marcar una distribución como borrada se debe utilizar el campo cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar que la distribución a borrar exista debe utilizar el módulo BuscarDistribucion. En caso de no existir se debe informar “Distribución no existente”.}

program ej8;

type
    recDistro = record
        nombre: string;
        anio: integer;
        numKernel: integer;
        cantDevs: integer;
        desc: string;
    end;

    maestro = file of recDistro;


function BuscarDistribucion(var mae: maestro; nom: string): integer;
var
    d: recDistro;
begin
    reset(mae);
    BuscarDistribucion := -1;

    // saltear cabecera
    read(mae, d);

    while (not EOF(mae)) and (BuscarDistribucion = -1) do begin
        read(mae, d);
        if (d.nombre = nom) then
            BuscarDistribucion := FilePos(mae)-1;
    end;

    close(mae);
end;

procedure AltaDistribucion(var mae: maestro; d: recDistro);
var
    cab, libre: recDistro;
    posLibre: integer;
begin

    if (BuscarDistribucion(mae, d.nombre) <> -1) then
        writeln('Ya existe la distribución')
    else begin
        reset(mae);
        read(mae, cab);
        if (cab.cantDevs = 0) then begin
            // No hay lugar, va al final.
            seek(mae, FileSize(mae));
            write(mae, d);
        end
        else begin
            // Hay lugar disponible

            // absoluto de cantDevs.
            posLibre := abs(cab.cantDevs);

            // Obtener siguiente en la lista invertida.
            seek(mae, posLibre);
            read(mae, libre);
            // Ocupar espacio libre.
            seek(mae, posLibre);
            write(mae, d);

            // Actualizar cabecera.
            cab.cantDevs := libre.cantDevs;
            seek(mae, 0);
            write(mae, cab);
        end;
    end;

    close(mae);
end;

procedure BajaDistribucion(var mae: maestro; nom: string);
var
    d, cab: recDistro;
    encontrado: boolean;
    posBaja: integer;
begin
    posBaja := BuscarDistribucion(mae, nom);
    if (posBaja = -1) then
        writeln('Distribución no existente.')
    else begin
        // La distro existe.
        reset(mae);

        // Cabecera.
        read(mae, cab);

        // Registro a eliminar.
        seek(mae, posBaja);
        read(mae, d);
        d.cantDevs := cab.cantDevs;
        seek(mae, posBaja);
        write(mae, d);

        // Actualizar cabecera.
        seek(mae, 0);
        cab.cantDevs := -posBaja;
        write(mae, cab);
    end;

    close(mae);
end;

var
    mae: maestro;
begin
    assign(mae, 'maestro.dat');
end.