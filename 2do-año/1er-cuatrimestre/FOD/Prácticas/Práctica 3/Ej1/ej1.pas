{1. Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados), agregándole una opción para realizar bajas copiando el último registro del archivo en la posición del registro a borrar y luego truncando el archivo en la posición del último registro de forma tal de evitar duplicados.

3. Realizar un programa que presente un menú con opciones para: 
    a. Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado. De cada empleado se registra: número de empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido. 
    b. Abrir el archivo anteriormente generado y 
        i. Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado, el cual se proporciona desde el teclado.
        ii. Listar en pantalla los empleados de a uno por línea. 
        iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.

4. Agregar al menú del programa del ejercicio 3, opciones para:
    a. Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado. Tener en cuenta que no se debe agregar al archivo un empleado con un número de empleado ya registrado (control de unicidad). 
    b. Modificar la edad de un empleado dado. 
    c. Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”. 
    d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00). 
NOTA: Las búsquedas deben realizarse por número de empleado.}

program ej3;

uses Crt;

type
    recEmpleado = record
        idEmp: integer;
        ap: string;
        nom: string;
        edad: integer;
        dni: Int64;
    end;

    archivo = file of recEmpleado;

function Separador(st: string): string;
begin
    Separador := (#10'---------- ' + st + ' ----------'#10);
end;

procedure LeerEmpleado(var e: recEmpleado);
begin
    writeln;
    writeln('Ingrese apellido del empleado (fin para terminar): ');
    readln(e.ap);
    if (e.ap = 'fin') then
        writeln('Carga de empleados finalizada.')
    else begin
        writeln('Ingrese nombre del empleado: ');
        readln(e.nom);
        writeln('Ingrese id del empleado: ');
        readln(e.idEmp);
        writeln('Ingrese edad del empleado: ');
        readln(e.edad);
        writeln('Ingrese DNI del empleado: ');
        readln(e.dni);
    end;
end;

procedure ImprimirEmpleado(e: recEmpleado);
begin
    writeln('Apellido: ', e.ap, ' | Nombre: ', e.nom, ' | Edad: ', e.edad, ' | DNI: ', e.dni, ' | ID: ', e.idEmp);
end;

procedure TextoMenu;
begin
    writeln(Separador('Menú de opciones'));
    writeln('1. Crear archivo de empleados.');
    writeln('2. Operar con archivo existente.');
    writeln('3. Modificar archivo a operar.');
    writeln('0. Finalizar el programa.'); writeln;
    writeln('Seleccione una opción: ');
end;

procedure TextoMenuLeer;
begin
    writeln('1. Listar empleados por nombre o apellido.');
    writeln('2. Listar todos los empleados.');
    writeln('3. Listar empleados mayores a 70 años.');
    writeln('4. Agregar empleados.');
    writeln('5. Modificar edad de un empleado.');
    writeln('6. Exportar todos los empleados a un archivo de texto.');
    writeln('7. Exportar empleados que no tengan DNI cargado.');
    writeln('0. Salir.');
    writeln;
    writeln('Seleccione una opción: ');
end;

procedure VolverMenu;
begin
    writeln;
    writeln;
    writeln('Presione una tecla para volver al menú...');
    ReadKey;
end;

procedure ListarNomAp(var arch: archivo);
var
    e: recEmpleado;
    nomAp: string;
begin
    writeln('Ingrese un nombre o un apellido: ');
    readln(nomAp);
    writeln;
    while not EOF(arch) do begin
        read(arch, e);
        if (e.ap = nomAp) or (e.nom = nomAp) then
            ImprimirEmpleado(e);
    end;
    writeln;
end;

procedure ListarTodos(var arch: archivo);
var
    e: recEmpleado;
begin
    while not EOF(arch) do begin
        read(arch, e);
        ImprimirEmpleado(e);
    end;
    writeln;
end;

procedure ListarM70(var arch: archivo);
var
    e: recEmpleado;
begin
    while not EOF(arch) do begin
        read(arch, e);
        if (e.edad > 70) then
            ImprimirEmpleado(e);
    end;
    writeln;
end;

procedure AgregarEmpleado(var arch: archivo);

    function IDExiste(id: integer; var arch: archivo): boolean;
    var
        e: recEmpleado;
    begin
        reset(arch);
        while (not EOF(arch)) and (id <> e.idEmp) do
            read(arch, e);
        if (id = e.idEmp) then
            IDExiste := true
        else
            IDExiste := false;
    end;

var
    e: recEmpleado;
begin
    leerEmpleado(e);
    while (e.ap <> 'fin') do begin
        if not(IDExiste(e.idEmp, arch)) then begin
            write(arch, e);
            writeln;
            writeln('Empleado agregado exitosamente');
        end
        else begin
            writeln;
            writeln('El empleado con la id ingresada ya existe.');
        end;
        leerEmpleado(e);
    end;
end;

procedure ModificarEdad(var arch: archivo);
var
    id: integer;
    e: recEmpleado;
    edad: integer;
begin
    reset(arch);
    writeln('Ingrese id de un empleado para modificar su edad: ');
    readln(id);
    read(arch, e);
    while not (EOF(arch)) and (id <> e.idEmp) do
        read(arch, e);
    if (id = e.idEmp) then begin
        writeln('Ingrese la edad a asignarle al empleado: ');
        readln(edad);
        e.edad := edad;
        seek(arch, FilePos(arch)-1);
        write(arch, e);
    end
    else
        writeln('No se encontró el empleado con id ', id, '.');
end;

procedure ExportarTodos(var arch: archivo);
var
    archivoTexto: Text;
    e, eAux: recEmpleado;
begin
    assign(archivoTexto, 'todos_empleados.txt');
    rewrite(archivoTexto);
    while not EOF(arch) do begin
        read(arch, e);
        with eAux do
            writeln(archivoTexto, 'Apellido: ', e.ap, ' | Nombre: ', e.nom, ' | Edad: ', e.edad, ' | DNI: ', e.dni, ' | ID: ', e.idEmp);
    end;
    writeln('Archivo creado exitosamente.');
    close(archivoTexto);
end;

procedure ExportarSinDNI(var arch: archivo);
var
    archivoTexto: Text;
    e, eAux: recEmpleado;
begin
    assign(archivoTexto, 'faltaDNIEmpleado.txt');
    rewrite(archivoTexto);
    while not EOF(arch) do begin
        read(arch, e);
        with eAux do
            if (e.dni = 00) then
                writeln(archivoTexto, 'Apellido: ', e.ap, ' | Nombre: ', e.nom, ' | Edad: ', e.edad, ' | DNI: ', e.dni, ' | ID: ', e.idEmp);
    end;
    writeln('Archivo creado exitosamente.');
    close(archivoTexto);
end;

procedure CrearArchivo(var arch: archivo);
var
    e: recEmpleado;
begin
    writeln(Separador('Crear archivo'));
    rewrite(arch);
    writeln;

    LeerEmpleado(e);
    while (e.ap <> 'fin') do begin
        write(arch, e);
        LeerEmpleado(e);
    end;
    close(arch);
    VolverMenu;
end;

procedure BajaEmpleado(var arch: archivo);
var
    id, posBaja: integer;
    e, eLast: recEmpleado;
    encontrado: boolean;
begin    
    reset(arch);
    writeln('Ingrese id de un empleado para eliminar: ');
    readln(id);

    encontrado := false;
    while not (EOF(arch)) and (not encontrado) do begin
        read(arch, e);
        if (id = e.idEmp) then
            encontrado := true;
    end;
    if (encontrado) then begin
        // Guardar posición del empleado a dar de baja.
        posBaja := FilePos(arch) - 1;

        // Obtener el último empleado.
        seek(arch, FileSize(arch)-1);
        read(arch, eLast);

        // Reemplazar el empleado a dar de baja con el último.
        if (posBaja <> FileSize(arch)-1) then begin
            seek(arch, posBaja);
            write(arch, eLast);
        end;

        // Recortar el tamaño del archivo.
        seek(arch, FileSize(arch)-1);
        truncate(arch);

        writeln('Empleado id ', id, ' eliminado exitosamente.');
    end
    else
        writeln('No se encontró el empleado con id ', id, '.');
end;

procedure LeerArchivo(var archivo_logico: archivo);
var
    n: integer;
begin
    writeln(Separador('Leer archivo'));
    writeln;
    TextoMenuLeer;
    readln(n);
    writeln;
    reset(archivo_logico); // Se hace el reset acá para reiniciar el puntero antes de cada proceso de lectura del archivo.
    case (n) of
        1: ListarNomAp(archivo_logico);
        2: ListarTodos(archivo_logico);
        3: ListarM70(archivo_logico);
        4: AgregarEmpleado(archivo_logico);
        5: ModificarEdad(archivo_logico);
        6: ExportarTodos(archivo_logico);
        7: ExportarSinDNI(archivo_logico);
        8: BajaEmpleado(archivo_logico);
        0: ;
        else writeln('Ingrese una opción válida: ');
    end;
    close(archivo_logico);
    VolverMenu;
end;

procedure AsignarArchivo(var arch: archivo);
var
    nomArch: string;
begin
    writeln('Ingrese la ruta del archivo: ');
    readln(nomArch);
    assign(arch, nomArch);
end;

var
    m: integer;
    archivo_logico: archivo;
begin
    AsignarArchivo(archivo_logico);
    repeat
        ClrScr;
        TextoMenu;
        readln(m);
        case (m) of
            1: CrearArchivo(archivo_logico);
            2: LeerArchivo(archivo_logico);
            3: AsignarArchivo(archivo_logico);
            0: writeln(Separador('Programa finalizado'));
            else writeln('Ingrese una opción válida: ');
        end;
    until (m = 0);
end.