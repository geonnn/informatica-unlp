program ej3;
type
    recEmpleado = record
        idEmp: integer;
        ap: string;
        nom: string;
        edad: integer;
        dni: Int64;
    end;

    archivo = file of recEmpleado;

procedure LeerEmpleado(var e: recEmpleado);
begin
    writeln('Ingrese apellido del empleado: ');
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

procedure CrearArchivo;
var
    nomArch: string;
    archivo_logico: archivo;
    e: recEmpleado;
begin
    writeln('Ingrese la ruta del archivo: ');
    readln(nomArch);
    assign(archivo_logico, nomArch);
    rewrite(archivo_logico);
    writeln(' ');

    LeerEmpleado(e);
    while (e.ap <> 'fin') do begin
        write(archivo_logico, e);
        LeerEmpleado(e);
    end;
    close(archivo_logico);
end;

procedure ListarNomAp(var arch: archivo);
var
    e: recEmpleado;
    nomAp: string[40];
begin
    writeln('Ingrese un nombre o un apellido: ');
    readln(nomAp);
    writeln('');
    while not EOF(arch) do begin
        read(arch, e);
        if (e.ap = nomAp) or (e.nom = nomAp) then
            ImprimirEmpleado(e);
    end;
    writeln('');
end;

procedure ListarTodos(var arch: archivo);
var
    e: recEmpleado;
begin
    while not EOF(arch) do begin
        read(arch, e);
        ImprimirEmpleado(e);
    end;
    writeln('');
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
    writeln('');
end;

function Separador(st: string): string;
begin
    Separador := (#10'---------- ' + st + ' ----------'#10);
end;

procedure TextoMenu;
begin
    writeln(Separador('Menú de opciones'));
    writeln('1. Crear archivo de empleados.');
    writeln('2. Leer archivo existente.');
    writeln('3. Finalizar el programa.'); writeln('');
    writeln('Seleccione una opción: ');
end;

procedure TextoMenuLeer;
begin
    writeln('1. Listar empleados por nombre o apellido.');
    writeln('2. Listar todos los empleados.');
    writeln('3. Listar empleados mayores a 70 años.');
    writeln('4. Salir.');
    writeln('');
    writeln('Seleccione una opción: ');
end;

procedure LeerArchivo;
var
    nomArch: string;
    archivo_logico: archivo;
    n: integer;
begin
    writeln('Ingrese la ruta del archivo: ');
    readln(nomArch);
    assign(archivo_logico, nomArch);
    writeln(' ');

    TextoMenuLeer;
    read(n);
    writeln('');
    while (n <> 4) do begin
        while (n < 1) or (n > 4) do begin
            writeln('Ingrese una opción válida: ');
            readln(n);
        end;
        reset(archivo_logico); // Se hace el reset acá para reiniciar el puntero antes de cada proceso de lectura del archivo.
        case (n) of
            1: ListarNomAp(archivo_logico);
            2: ListarTodos(archivo_logico);
            3: ListarM70(archivo_logico);
        end;
        TextoMenuLeer;
        readln(n);
        writeln('');
    end;
    close(archivo_logico);
end;

var
    m: integer;
begin
    
    TextoMenu;
    readln(m);
    while (m <> 3) do begin
        while (m < 1) or (m > 3) do begin
            writeln('Ingrese una opción válida: ');
            readln(m);
        end;
        if (m = 1) then begin
            writeln(Separador('Crear archivo'));
            CrearArchivo;
        end
        else begin // (m = 2)
            writeln(Separador('Leer archivo'));
            LeerArchivo;
        end;
        TextoMenu;
        readln(m)
    end;
    writeln(Separador('Programa finalizado'));
end.