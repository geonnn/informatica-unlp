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
    writeln('0. Finalizar el programa.'); writeln;
    writeln('Seleccione una opción: ');
end;

procedure TextoMenuLeer;
begin
    writeln('1. Listar empleados por nombre o apellido.');
    writeln('2. Listar todos los empleados.');
    writeln('3. Listar empleados mayores a 70 años.');
    writeln('4. Agregar empleados.');
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

procedure AgregarEmpleado(var arch: archivo); // No funciona todavía.

    function IDExiste(id: integer; var arch: archivo): boolean;
    var
        archAux: archivo;
        e: recEmpleado;
        nom: string;
    begin
        nom := 'empleados';
        assign(archAux, nom);
        reset(archAux);
        while not EOF(archAux) and (id <> e.idEmp) do
            read(archAux, e);
        if (id = e.idEmp) then
            IDExiste := false
        else
            IDExiste := true;
    end;

var
    e: recEmpleado;
begin
    reset(arch);
    seek(arch, FileSize(arch));
    leerEmpleado(e);
    while (e.ap <> 'fin') do begin
        if not(IDExiste(e.idEmp, arch)) then
            write(arch, e);
        leerEmpleado(e);
    end;
    close(arch);
end;

procedure CrearArchivo;
var
    nomArch: string;
    archivo_logico: archivo;
    e: recEmpleado;
begin
    writeln(Separador('Crear archivo'));
    writeln('Ingrese la ruta del archivo: ');
    readln(nomArch);
    assign(archivo_logico, nomArch);
    rewrite(archivo_logico);
    writeln;

    LeerEmpleado(e);
    while (e.ap <> 'fin') do begin
        write(archivo_logico, e);
        LeerEmpleado(e);
    end;
    close(archivo_logico);
    VolverMenu;
end;

procedure LeerArchivo;
var
    nomArch: string;
    archivo_logico: archivo;
    n: integer;
begin
    writeln(Separador('Leer archivo'));
    writeln('Ingrese la ruta del archivo: ');
    readln(nomArch);
    assign(archivo_logico, nomArch);
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
        else writeln('Ingrese una opción válida: ');
    end;
    close(archivo_logico);
    VolverMenu;
end;

var
    m: integer;
begin
    
    repeat
        ClrScr;
        TextoMenu;
        readln(m);
        case (m) of
            1: CrearArchivo;
            2: LeerArchivo;
            0: writeln(Separador('Programa finalizado'));
            else writeln('Ingrese una opción válida: ');
        end;
    until (m = 0);
end.