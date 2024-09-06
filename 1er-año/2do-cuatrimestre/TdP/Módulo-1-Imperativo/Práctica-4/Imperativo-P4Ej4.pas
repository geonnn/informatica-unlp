{4.Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN. (prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos).}

program Ej4;

type

    recFecha = record
        dia: 1..31;
        mes: 1..12;
    end;

// ---------- Árbol Prestamos (1) ---------- //

    recPrestamo = record
        isbn: integer;
        numSocio: integer;
        fecha: recFecha;
        duracion: integer;
    end;

    arbol_prestamos = ^nodoArbolPrestamos;
    nodoArbolPrestamos = record
        dato: recPrestamo;
        HI: arbol_prestamos;
        HD: arbol_prestamos;
    end;

// ---------- Árbol por ISBN (2) ---------- //

    recPrestamoParaLista = record
        numSocio: integer;
        fecha: recFecha;
        duracion: integer;
    end;

    listaPrestamos = ^nodoListaPrestamos;
    nodoListaPrestamos = record
        dato: recPrestamoParaLista;
        sig: listaPrestamos;
    end;

    recArbolISBN = record
        isbn: integer;
        lista_prestamos: listaPrestamos;
    end;

    arbol_isbn = ^nodoArbolISBN;
    nodoArbolISBN = record
        dato: recArbolISBN;
        HI: arbol_isbn;
        HD: arbol_isbn;
    end;
    
procedure ModuloA(var a1: arbol_prestamos; var a2: arbol_isbn);

    procedure GenerarFecha(var f: recFecha);
    begin
        f.dia := random(31) + 1;
        f.mes := random(12) + 1;
    end;

    procedure GenerarPrestamo(var p: recPrestamo);
    begin
        p.isbn := random(101);
        if (p.isbn = 0) then
            writeln('Carga finalizada.')
        else begin
            p.numSocio := (random(50) + 1) * 100;
            GenerarFecha(p.fecha);
            p.duracion := random(90) + 1; // máximo 90 días. 
        end;
    end;

    procedure InsertarPrestamoArbolPrestamos(var a: arbol_prestamos; p: recPrestamo);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato := p;
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (a^.dato.isbn > p.isbn) then
                InsertarPrestamoArbolPrestamos(a^.HI, p)
            else
                InsertarPrestamoArbolPrestamos(a^.HD, p);
    end;

    procedure CargarPrestamoEnLista(var L: listaPrestamos; p: recPrestamo);

        procedure CopiarDatos(var ppl: recPrestamoParaLista; p: recPrestamo);
        begin
            ppl.numSocio := p.numSocio;
            ppl.fecha := p.fecha;
            ppl.duracion := p.duracion;
        end;

    var
        nue: listaPrestamos;
    begin
        if (L = nil) then begin
            new(nue);
            CopiarDatos(nue^.dato, p);
            L := nue;
            L^.sig := nil;
        end
        else
            CargarPrestamoEnLista(L^.sig, p);
    end;

    procedure InsertarPrestamoArbolISBN(var a: arbol_isbn; p: recPrestamo);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato.isbn := p.isbn;
            a^.dato.lista_prestamos := nil;
            CargarPrestamoEnLista(a^.dato.lista_prestamos, p);
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (a^.dato.isbn = p.isbn) then
                CargarPrestamoEnLista(a^.dato.lista_prestamos, p)
            else
                if (a^.dato.isbn > p.isbn) then
                    InsertarPrestamoArbolISBN(a^.HI, p)
                else
                    InsertarPrestamoArbolISBN(a^.HD, p);
    end;


var
    p: recPrestamo;
begin
    writeln;
    writeln ('----- Ingreso de préstamos y armado de árboles ----->');
    writeln;
    a1 := nil;
    a2 := nil;
    GenerarPrestamo(p);
    while (p.isbn <> 0) do begin
        InsertarPrestamoArbolPrestamos(a1, p);
        InsertarPrestamoArbolISBN(a2, p);
        GenerarPrestamo(p);
    end;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure InformarArbolPrestamos(a: arbol_prestamos);

    procedure ImprimirPrestamo(p: recPrestamo);
    begin
        writeln;
        write('-> ISBN: ', p.isbn);
        write(' | Número de socio: ', p.numSocio);
        write(' | Fecha: ', p.fecha.dia, '/', p.fecha.mes);
        write(' | Duración: ', p.duracion, ' días.');
    end;

    procedure ImprimirArbol(a: arbol_prestamos);
    begin
        if (a <> nil) then begin
            ImprimirArbol(a^.HI);
            ImprimirPrestamo(a^.dato);
            ImprimirArbol(a^.HD);
        end;
    end;

begin
    writeln;
    writeln ('----- Árbol prestamos ----->');
    writeln;
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else ImprimirArbol(a);
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure InformarArbolISBN(a: arbol_isbn);

    procedure ImprimirListaPrestamos(L: listaPrestamos);
    begin
        if (L <> nil) then begin
            writeln;
            write('        - ');
            write('Número de socio: ', L^.dato.numSocio);
            write(' | Fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes);
            write(' | Duración: ', L^.dato.duracion, ' días.');
            ImprimirListaPrestamos(L^.sig);
        end;
    end;

    procedure ImprimirPrestamo(lib: recArbolISBN);
    begin
        writeln;
        write('-> ISBN: ', lib.isbn);
        ImprimirListaPrestamos(lib.lista_prestamos)
    end;

    procedure ImprimirArbol(a: arbol_isbn);
    begin
        if (a <> nil) then begin
            ImprimirArbol(a^.HI);
            ImprimirPrestamo(a^.dato);
            ImprimirArbol(a^.HD);
        end;
    end;

begin
    writeln;
    writeln ('----- Árbol por ISBN ----->');
    writeln;
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else ImprimirArbol(a);
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

// procedure InformarArbolISBN(a: arbol);

//     procedure ImprimirListaFinales(L: listaFinales);
//     begin
//         if (L <> nil) then begin
//             writeln;
//             write('        - ');
//             write(' Cód.Materia: ', L^.dato.codMateria);
//             write(' | Fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes, '/', L^.dato.fecha.anio);
//             write(' | Nota: ', L^.dato.nota);
//             ImprimirListaFinales(L^.sig);
//         end;
//     end;

//     procedure ImprimirAlumno(alu: recAlumno);
//     begin
//         writeln;
//         write('-> Legajo: ', alu.legajo);
//         ImprimirListaFinales(alu.lista_finales);
//     end;

// begin
//     if (a <> nil) then begin
//         InformarArbol(a^.HI);
//         Imprimir(a^.dato);
//         InformarArbol(a^.HD);
//     end;
// end;

var
    a1: arbol_prestamos;
    a2: arbol_isbn;
begin
    randomize;
    ModuloA(a1, a2);
    InformarArbolPrestamos(a1);
    InformarArbolISBN(a2);
    // ModuloB(a);
    // ModuloC(a);
    // ModuloD(a);
    // ModuloE(a);
    // ModuloF(a);
    // ModuloG(a);
    // ModuloH(a);
    // ModuloI(a);
    // ModuloJ(a);
end.