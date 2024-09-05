{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de Informática y los almacene en una estructura de datos. La información que se lee es legajo, código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program Ej3;
const
    ANIOMIN = 2022;
    ANIOMAX = 2024;

    CANT_ALEATORIOS = 100;
type

    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: 2000..2024;
    end;

    recFinal_Old = record
        legajo: integer;
        codMateria: integer;
        fecha: recFecha;
        nota: integer;
    end;

    // -------------------- Arriba input, abajo nueva estructura ------------------------------------
    
    recFinal = record
        codMateria: integer;
        fecha: recFecha;
        nota: integer;
    end;

    listaFinales = ^nodoFinal;
    nodoFinal = record
        dato: recFinal;
        sig: listaFinales;
    end;

    recAlumno = record
        legajo: integer;
        lista_finales: listaFinales;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record
        dato: recAlumno;
        HI: arbol;
        HD: arbol;
    end;

procedure GenerarFecha(var f: recFecha);
begin
    f.dia := random(31) + 1;
    f.mes := random(12) + 1;
    f.anio := random(ANIOMAX - ANIOMIN + 1) + ANIOMIN;
end;

procedure GenerarFinal(var f: recFinal_Old);
begin
    f.legajo := random(101);
    // f.legajo := 0;
    if (f.legajo <> 0) then begin
        f.codMateria := random(40) + 1;
        GenerarFecha(f.fecha);
        f.nota := random(10) + 1;
    end
    else
        writeln('Carga finalizada.');
end;

procedure IngresarAlumno(var a: arbol; fin: recFinal; legajo: integer);

    procedure CargarFinalEnLista(var L: listaFinales; fin: recFinal);
    var
        nue: listaFinales;
    begin
        if (L = nil) then begin
            new(nue);
            nue^.dato := fin;
            L := nue;
            L^.sig := nil;
        end
        else
            CargarFinalEnLista(L^.sig, fin);
    end;

begin
    if (a = nil) then begin
        new(a);
        a^.dato.legajo := legajo;
        CargarFinalEnLista(a^.dato.lista_finales, fin);
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (a^.dato.legajo = legajo) then
            CargarFinalEnLista(a^.dato.lista_finales, fin) // Lista en el árbol y recFinal
        else
            if (a^.dato.legajo > legajo) then
                IngresarAlumno(a^.HI, fin, legajo)
            else
                IngresarAlumno(a^.HD, fin, legajo);
end;

procedure CopiarRegistro(var fin: recFinal; fo: recFinal_Old);
begin
    fin.codMateria := fo.codMateria;
    fin.fecha := fo.fecha;
    fin.nota := fo.nota;
end;

procedure GenerarArbol(var a: arbol);
var
    fo: recFinal_Old;
    fin: recFinal;
begin
    a := nil;
    GenerarFinal(fo);
    while (fo.legajo <> 0) do begin
        CopiarRegistro(fin, fo); // Se copia del registro viejo al registro nuevo que usa la lista para no tener un duplicado del legajo del alumno.
        IngresarAlumno(a, fin, fo.legajo); // Se envían el registro Final y el legajo por separados para poder usar la recursividad. Sino quedaba el proceso esperando un parámetro de tipo recFinal_Old.
        GenerarFinal(fo);
    end;
end;

procedure ImprimirArbolAlumnos(a: arbol);

    procedure ImprimirListaFinales(L: listaFinales);
    begin
        if (L <> nil) then begin
            writeln;
            write('        - ');
            write(' Cód.Materia: ', L^.dato.codMateria);
            write(' | Fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes, '/', L^.dato.fecha.anio);
            write(' | Nota: ', L^.dato.nota);
            ImprimirListaFinales(L^.sig);
        end;
    end;

    procedure ImprimirAlumno(alu: recAlumno);
    begin
        writeln;
        write('-> Legajo: ', alu.legajo);
        ImprimirListaFinales(alu.lista_finales);
    end;

begin
    if (a <> nil) then begin
        ImprimirArbolAlumnos(a^.HI);
        ImprimirAlumno(a^.dato);
        ImprimirArbolAlumnos(a^.HD);
    end;
end;

procedure AlumnosLegajoImpar(a: arbol);

    function Impar(a: arbol): integer;
    begin
        if (a = nil) then
            Impar := 0
        else begin
            if ((a^.dato.legajo mod 2) = 1) then
                Impar := 1
            else
                Impar := 0;
            Impar := Impar + Impar(a^.HI) + Impar(a^.HD);
        end;
    end;

begin
  writeln;
  writeln;
  writeln ('----- Cantidad de alumnos con legajo impar ----->');
  writeln;
  writeln ('Cantidad: ', Impar(a));
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AlumnosCantidadAprobados(a: arbol);

    function ContarFinales(L: listaFinales): integer;
    begin
        if (L <> nil) then begin
            if (L^.dato.nota >= 4) then
                ContarFinales := 1
            else
                ContarFinales := 0;
            ContarFinales := ContarFinales + ContarFinales(L^.sig);
        end
        else
            ContarFinales := 0;
    end;

    procedure ImprimirAlumno(alu: recAlumno);
    begin
        writeln;
        write('-> Legajo: ', alu.legajo);
        write(' | Finales aprobados: ', ContarFinales(alu.lista_finales));
    end;

    procedure FinalesPorAlumno(a: arbol);
    begin
        if (a <> nil) then begin
            FinalesPorAlumno(a^.HI);
            ImprimirAlumno(a^.dato);
            FinalesPorAlumno(a^.HD);
        end;
    end;

begin
  writeln;
  writeln;
  writeln ('----- Cantidad de finales aprobados por alumno ----->');
  writeln;
  FinalesPorAlumno(a);
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AlumnosPromedioMayorQue(a: arbol);

    function Promedio(var total, cantidad: integer; L: listaFinales): real;
    begin
        if (L <> nil) then begin
            total := total + L^.dato.nota;
            cantidad := cantidad + 1;
            Promedio := Promedio(total, cantidad, L^.sig);
        end
        else if (cantidad > 0) then
            Promedio := total / cantidad
        else
            Promedio := 0;
    end;

    procedure ImprimirPromedioAlumno(alu: recAlumno; valor: real);
    var
        total, cantidad: integer;
        prom: real;
    begin
        total := 0;
        cantidad := 0;
        prom := Promedio(total, cantidad, alu.lista_finales);
        if (prom > valor) then begin
            writeln;
            write('-> Legajo: ', alu.legajo);
            write(' | Promedio: ', prom:0:2);
        end;
    end;

    procedure RecorrerArbol(a: arbol; valor: real);
    begin
        if (a <> nil) then begin
            RecorrerArbol(a^.HI, valor);
            ImprimirPromedioAlumno(a^.dato, valor);
            RecorrerArbol(a^.HD, valor);
        end;
    end;

var
    valor: real;
begin
  writeln;
  writeln;
  writeln ('----- Alumnos con promedio mayor que ----->');
  writeln;
  write('Ingrese un valor: ');
  read(valor);
  RecorrerArbol(a, valor);
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


var
    a: arbol;
begin
    randomize;
    GenerarArbol(a);
    if (a = nil) then
        write('No se cargó ningún elemento.')
    else begin
        ImprimirArbolAlumnos(a);
        AlumnosLegajoImpar(a);
        AlumnosCantidadAprobados(a);
        AlumnosPromedioMayorQue(a);
    end;
end.