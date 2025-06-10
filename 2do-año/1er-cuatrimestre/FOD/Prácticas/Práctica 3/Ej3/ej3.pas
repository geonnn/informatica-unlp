{3. Realizar un programa que genere un archivo de novelas filmadas durante el presente año. De cada novela se registra: código, género, nombre, duración, director y precio. 
El programa debe presentar un menú con las siguientes opciones:
    a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se utiliza la técnica de lista invertida para recuperar espacio libre en el archivo. Para ello, durante la creación del archivo, en el primer registro del mismo se debe almacenar la cabecera de la lista. Es decir un registro ficticio, inicializando con el valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay espacio libre dentro del archivo
    b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el inciso a), se utiliza lista invertida para recuperación de espacio. En particular, para el campo de “enlace”  de la lista (utilice el código de novela como enlace), se debe especificar los números de registro referenciados con signo negativo. Una vez abierto el archivo, brindar operaciones para:
        i. Dar de alta una novela leyendo la información desde teclado. Para esta operación, en caso de ser posible, deberá recuperarse elespacio libre. Es decir, si en el campo correspondiente al código denovela del registro cabecera hay un valor negativo, por ejemplo -5,se debe leer el registro en la posición 5, copiarlo en la posición 0(actualizar la lista de espacio libre) y grabar el nuevo registro en laposición 5. Con el valor 0 (cero) en el registro cabecera se indicaque no hay espacio libre.
        ii. Modificar los datos de una novela leyendo la información desdeteclado. El código de novela no puede ser modificado.
        iii. Eliminar una novela cuyo código es ingresado por teclado. Porejemplo, si se da de baja un registro en la posición 8, en el campocódigo de novela del registro cabecera deberá figurar -8, y en elregistro en la posición 8 debe copiarse el antiguo registro cabecera.
    c. Listar en un archivo de texto todas las novelas, incluyendo las borradas,que representan la lista de espacio libre. El archivo debe llamarse "novelas.txt".
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser proporcionado por el usuario.}

program ej3;

uses
    Clr;

type
    recNovela = record
        cod: integer;
        genero: string;
        nombre: string;
        duracion: real;
        director: string;
        precio: real;
    end;

    archivo = file of recNovela;

procedure LeerNovela(var n: recNovela);
begin
    writeln('Ingrese código: ');
    readln(n.cod);
    if (n.cod = -1) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese género: ');
        readln(n.genero);
        writeln('Ingrese nombre: ');
        readln(n.nombre);
        writeln('Ingrese duración: ');
        readln(n.duracion);
        writeln('Ingrese director: ');
        readln(n.director);
        writeln('Ingrese precio: ');
        readln(n.precio);
    end;
end;

procedure CrearArchivo(var a: archivo);
var
    n: recNovela;
begin
    rewrite(a);
    n.cod := 0;
    write(a, n);

    LeerNovela(n);
    while (n.cod <> -1) do begin
        write(a, n);
        LeerNovela(n);
    end;

    close(a);
end;

procedure AltaNovela(var a: archivo);
var
    n, cabecera, libre: recNovela;
begin
    read(a, cabecera);

    LeerNovela(n);

    if (cabecera.cod = 0) then begin
        seek(a, FileSize(a));
        write(a, n);
    end
    else begin
        seek(a, -(cabecera.cod));
        read(a, libre);
        seek(a, 0);
        write(a, libre);
        seek(a, -(cabecera.cod));
        write(a, n);
    end;
end;

procedure ModificarNovela(var a: archivo);
var
    n, nuevo: recNovela;
    encontrado: boolean;
begin
    LeerNovela(nuevo);
    encontrado := false;

    while (not EOF(a)) and (not encontrado) do begin
        read(a, n);
        if (n.cod = nuevo.cod) then
            encontrado := true;
    end;

    if (encontrado) then begin
        seek(a, FilePos(a)-1);
        write(a, nuevo);
        writeln('Novela modificada exitosamente.')
    end
    else
        writeln('La novela que se quiere modificar no existe.');
end;

procedure EliminarNovela(var a: archivo);
var
    cod, posBaja: integer;
    nCabecera, nBaja: recNovela;
    encontrado: boolean;
begin
    encontrado := false;
    writeln('Ingrese código de novela a eliminar: ');
    readln(cod);

    while (not EOF(a)) and (not encontrado) do begin
        read(a, nBaja);
        if (nBaja.cod = cod) then
            encontrado := true;
    end;

    if (encontrado) then begin
        posBaja := FilePos(a) - 1;

        // Leer cabecera actual.
        seek(a, 0);
        read(a, nCabecera);

        // Copiar cabecera en la posición a eliminar.
        seek(a, posBaja);
        write(a, nCabecera);

        // Actualizar cabecera con la última posición borrada
        nCabecera.cod := -posBaja;
        seek(a, 0);
        write(a, nCabecera);

        writeln('Novela eliminada exitosamente.');
    end
    else
        writeln('Novela no encontrada.');
end;

procedure OperarArchivo(var a: archivo);
var
    m: integer;
begin
    repeat
        ClrScr;
        writeln;
        writeln('Seleccione una opción: ');
        writeln('1. Cargar novela.');
        writeln('2. Modificar novela.');
        writeln('3. Eliminar novela.');
        writeln('0. Volver al menú principal.');
        read(m);
        writeln;
        reset(a);
        case (m) of
            1: AltaNovela(a);
            2: ModificarNovela(a);
            3: EliminarNovela(a);
            0: ;
    until (m = 0);

    close(a);
end;

procedure ListarNovelas(var a: archivo);
var
    n: recNovela;
    arch_txt: Text;
begin

    reset(a);

    assign(arch_txt, 'novelas.txt');
    rewrite(arch_txt);

    while (not EOF(a)) do begin
        read(a, n);
        if (n.cod <= 0) then
            writeln(arch_txt, 'Espacio libre en la posición: ', -n.cod, '.')
        else begin
            writeln(arch_txt, n.cod);
            writeln(arch_txt, n.genero);
            writeln(arch_txt, n.nombre);
            writeln(arch_txt, n.duracion:0:2);
            writeln(arch_txt, n.director);
            writeln(arch_txt, n.precio:0:2);
        end;
    end;

    close(arch_txt);
    close(a);
end;

var
    a: archivo;
    ruta: string;
    m: integer;
begin
    writeln('Ingrese ruta del archivo: ');
    read(ruta);
    assign(a, ruta);
    repeat
        ClrScr;
        writeln;
        writeln('Seleccione una opción: ');
        writeln('1. Crear archivo y cargarlo.');
        writeln('2. Operar sobre el archivo.');
        writeln('3. Listar novelas en novelas.txt.');
        writeln('0. Salir.');
        read(m);
        case (m) of
            1: CrearArchivo(a);
            2: OperarArchivo(a);
            3: ListarNovelas(a);
            0: ;
            else writeln('Ingrese una opción válida.');
    until (m = 0);
    
end;