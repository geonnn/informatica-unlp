program ej5;

uses Crt, sysutils;

type
    recCelular = record
        cod: integer;
        nom: string;
        desc: string;
        marca: string;
        precio: real;
        stMin: integer;
        stDisp: integer;
    end;

    archivo = file of recCelular;

// function CelToString(c: recCelular): string;
// begin
//     CelToString := ('Código: ' + IntToStr(c.cod) + 
//                     ' | Precio: $' + FloatToStr(c.precio) + 
//                     ' | Marca: ' + c.marca +
//                     ' | Stock disp.: ' + IntToStr(c.stDisp) +
//                     ' | Stock mín.: ' + IntToStr(c.stMin) + 
//                     ' | Desc.: ' + c.desc +
//                     ' | Nombre: ' + c.nom);
// end;

procedure PrintCelular(c: recCelular);
begin
    writeln('Código: ', c.cod,
            ' | Precio: $', c.precio:0:2,
            ' | Marca: ', c.marca,
            ' | Stock disp.: ', c.stDisp,
            ' | Stock mín.: ', c.stMin,
            ' | Desc.: ', c.desc,
            ' | Nombre: ', c.nom);
end;

function Separador(st: string): string;
begin
    Separador := (#10'---------- ' + st + ' ----------'#10);
end;

procedure LeerCelular(var c: recCelular);
begin
    writeln;
    writeln('Ingrese código del celular (-1 para terminar): ');
    readln(c.cod);
    if (c.cod = -1) then
        writeln('Carga de celulares finalizada.')
    else begin
        writeln('Ingrese precio del celular: ');
        readln(c.precio);
        writeln('Ingrese marca del celular: ');
        readln(c.marca);
        writeln('Ingrese stock disponible del celular: ');
        readln(c.stDisp);
        writeln('Ingrese stock mínimo del celular: ');
        readln(c.stMin);
        writeln('Ingrese descripción del celular: ');
        readln(c.desc);
        writeln('Ingrese nombre del celular: ');
        readln(c.nom);
    end;
end;

procedure TextoMenu;
begin
    writeln(Separador('Menú de opciones'));
    writeln('1. Crear archivo binario de celulares (a partir de celulares.txt).');
    writeln('2. Listar celulares con stock por debajo del mínimo.');
    writeln('3. Listar según descripción.');
    writeln('4. Exportar a celulares.txt.');
    writeln('5. Añadir celular.');
    writeln('6. Modificar stock de un celular.');
    writeln('7. Exportar celulares sin stock.');
    writeln('0. Finalizar el programa.'); writeln;
    writeln('Seleccione una opción: ');
end;

procedure VolverMenu;
begin
    writeln;
    writeln;
    writeln('Presione una tecla para volver al menú...');
    ReadKey;
end;

procedure AsignarArchivo(var arch: archivo);
var
    nomArch: string;
begin
    writeln('Ingrese la ruta del archivo a crear: ');
    readln(nomArch);
    assign(arch, nomArch);
    //rewrite(arch);
end;

procedure CrearArchivo(var arch: archivo);
var
    carga: Text;
    c: recCelular;
begin
    assign(carga, 'celulares.txt');
    reset(carga);
    rewrite(arch);
    while not EOF(carga) do begin
        readln(carga, c.cod, c.precio, c.marca);
        c.marca := Trim(c.marca);
        
        readln(carga, c.stDisp, c.stMin, c.desc);
        c.desc := Trim(c.desc);

        readln(carga, c.nom);

        write(arch, c);
    end;
    writeln('Archivo creado correctamente.');
    close(carga);
end;

procedure ListarStockBajo(var arch: archivo);
var
    c: recCelular;
begin
    while not EOF(arch) do begin
        read(arch, c);
        if (c.stDisp < c.stMin) then
            PrintCelular(c);
    end;
end;

procedure ListarDesc(var arch: archivo);
var
    c: recCelular;
    desc: string;
begin
    writeln('Ingrese la descripción deseada: ');
    readln(desc);
    writeln;
    while not EOF(arch) do begin
        read(arch, c);
        if (c.desc = desc) then
            PrintCelular(c);
    end;
end;

procedure EscribirEnTexto(c: recCelular; var arch_texto: Text);
begin
    writeln(arch_texto, c.cod, ' ', c.precio:0:2, ' ', c.marca);
    writeln(arch_texto, c.stDisp, ' ', c.stMin, ' ', c.desc);
    writeln(arch_texto, c.nom);
end;

procedure Exportar(var arch: archivo);
var
    c: recCelular;
    arch_texto: Text;
begin
    assign(arch_texto, 'celulares.txt');
    rewrite(arch_texto);
    while not EOF(arch) do begin
        read(arch, c);
        EscribirEnTexto(c, arch_texto);
    end;
    writeln('Archivo exportado correctamente.');
    close(arch_texto);
end;

procedure AgregarCelular(var arch: archivo);

    function CodExiste(cod: integer; var arch: archivo): boolean;
    var
        c: recCelular;
    begin
        seek(arch, 0);
        while (not EOF(arch)) and (cod <> c.cod) do
            read(arch, c);
        if (cod = c.cod) then
            CodExiste := true
        else
            CodExiste := false;
    end;

var
    c: recCelular;
begin
    LeerCelular(c);
    while (c.cod <> -1) do begin
        if not CodExiste(c.cod, arch) then begin
            write(arch, c);
            writeln;
            writeln('Celular añadido correctamente.');
        end
        else begin
            writeln;
            writeln('El celular con el código ingresado ya existe.');
        end;
        LeerCelular(c)
    end;

end;

procedure ModificarStockDisp(var arch: archivo);
var
    c: recCelular;
    stock: integer;
    nom: string;
begin
    writeln('Ingrese nombre de celular para modificar su stock: ');
    readln(nom);
    read(arch, c);
    while (not EOF(arch)) and (nom <> c.nom) do
        read(arch, c);
    if (nom = c.nom) then begin
        writeln('Ingrese nuevo valor de stock para el celular: ');
        readln(stock);
        c.stDisp := stock;
        seek(arch, FilePos(arch)-1);
        write(arch, c);
        writeln('Stock modificado correctamente.');
    end
    else
        writeln('No se encontró el celular ', nom, '.');
end;

procedure ExportarSinStock(var arch: archivo);
var
    c: recCelular;
    sinStock: Text;
begin
    assign(sinStock, 'SinStock.txt');
    rewrite(sinStock);
    while not EOF(arch) do begin
        read(arch, c);
        if (c.stDisp = 0) then
            EscribirEnTexto(c, sinStock);
    end;
    writeln('Archivo exportado correctamente.');
    close(sinStock);
end;

var
    m: integer;
    archivo_logico: archivo;
begin
    AsignarArchivo(archivo_logico);
    repeat
        ClrScr;
        TextoMenu;
        reset(archivo_logico);
        readln(m);
        writeln;
        case (m) of
            1: CrearArchivo(archivo_logico);
            2: ListarStockBajo(archivo_logico);
            3: ListarDesc(archivo_logico);
            4: Exportar(archivo_logico);
            5: AgregarCelular(archivo_logico);
            6: ModificarStockDisp(archivo_logico);
            7: ExportarSinStock(archivo_logico);
            0: writeln(Separador('Programa finalizado'));
        else writeln('Ingrese una opción válida.');
        end;
        if (m <> 0) then
            VolverMenu; // Espera input para volver al menu.
        close(archivo_logico);
    until (m = 0);
end.