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

// ---------- Lista por ISBN y cant. préstamos (3 y 4) ---------- //

    recListaISBN = record
        isbn: integer;
        cant_prestamos: integer;
    end;

    listaISBN = ^nodoListaISBN;
    nodoListaISBN = record
        dato: recListaISBN;
        sig: listaISBN;
    end;

    recPunterosLista = record
        pri: listaISBN;
        ult: listaISBN;
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
            new(nue);
            CopiarDatos(nue^.dato, p);
            nue^.sig := L;
            L := nue;
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
        write('-> ISBN: ', p.isbn:3);
        write(' | Número de socio: ', p.numSocio:4);
        write(' | Fecha: ', p.fecha.dia:2, '/', p.fecha.mes:2);
        write(' | Duración: ', p.duracion:2, ' días.');
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
        while (L <> nil) do begin
            writeln;
            write('        - ');
            write('Número de socio: ', L^.dato.numSocio:4);
            write(' | Fecha: ', L^.dato.fecha.dia:2, '/', L^.dato.fecha.mes:2);
            write(' | Duración: ', L^.dato.duracion:2, ' días.');
            L := L^.sig;
        end;
    end;

    procedure ImprimirPrestamo(lib: recArbolISBN);
    begin
        writeln;
        write('-> ISBN: ', lib.isbn);
        ImprimirListaPrestamos(lib.lista_prestamos);
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

procedure ModuloB(a: arbol_prestamos);

    function Maximo(v1, v2: integer): integer;
    begin
        if (v1 > v2) then
            Maximo := v1
        else
            Maximo := v2;
    end;

    function ObtenerISBNMaximo(a: arbol_prestamos): integer;
    begin
        if (a <> nil) then
            ObtenerISBNMaximo := Maximo(a^.dato.isbn, ObtenerISBNMaximo(a^.HD))
        else
            ObtenerISBNMaximo := -1;
    end;

begin
    writeln;
    writeln ('----- ISBN más grande ----->');
    writeln;
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else
        writeln('El ISBN más grande es: ', ObtenerISBNMaximo(a), '.');
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloC(a: arbol_isbn);

    function Minimo(v1, v2: integer): integer;
    begin
        if (v1 < v2) then
            Minimo := v1
        else
            Minimo:= v2;
    end;

    function ObtenerISBNMinimo(a: arbol_isbn): integer;
    begin
        if (a <> nil) then
            ObtenerISBNMinimo := Minimo(a^.dato.isbn, ObtenerISBNMinimo(a^.HI))
        else
            ObtenerISBNMinimo := maxInt;
    end;

begin
    writeln;
    writeln ('----- ISBN más chico ----->');
    writeln;
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else
        writeln('El ISBN más chico es: ', ObtenerISBNMinimo(a), '.');
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloD(a: arbol_prestamos);

    procedure ObtenerPrestamosSocio(a: arbol_prestamos; numSocio: integer; var cantPrestamos: integer);
    begin
        if (a <> nil) then begin
            if (a^.dato.numSocio = numSocio) then
                cantPrestamos := cantPrestamos + 1;
            ObtenerPrestamosSocio(a^.HI, numSocio, cantPrestamos);
            ObtenerPrestamosSocio(a^.HD, numSocio, cantPrestamos);
        end;
    end;

var
    numSocio, cantPrestamos: integer;
begin
    writeln;
    writeln ('----- Cantidad de préstamos a un socio ----->');
    writeln;
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else begin
        cantPrestamos := 0;
        write('Ingrese número de socio: ');
        read(numSocio);
        ObtenerPrestamosSocio(a, numSocio, cantPrestamos);
        if (cantPrestamos = 0) then
            writeln('El socio número ', numSocio, ' no se encuentra cargado en el sistema.')
        else
            writeln('Al socio número ', numSocio, ' se le realizaron ', cantPrestamos, ' préstamos.');
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloE(a: arbol_isbn);

    procedure CantidadPrestamos(L: listaPrestamos; numSocio: integer; var cantPrestamos: integer);
    begin
        while (L <> nil) do begin
            if (L^.dato.numSocio = numSocio) then
                cantPrestamos := cantPrestamos + 1;
            L := L^.sig;
        end;
    end;

    procedure ObtenerPrestamosSocio(a: arbol_isbn; numSocio: integer; var cantPrestamos: integer);
    begin
        if (a <> nil) then begin
            CantidadPrestamos(a^.dato.lista_prestamos, numSocio, cantPrestamos);
            ObtenerPrestamosSocio(a^.HI, numSocio, cantPrestamos);
            ObtenerPrestamosSocio(a^.HD, numSocio, cantPrestamos);
        end;
    end;

var
    numSocio, cantPrestamos: integer;
begin
    writeln;
    writeln ('----- Cantidad de préstamos a un socio ----->');
    writeln;
    cantPrestamos := 0;
    write('Ingrese número de socio: ');
    read(numSocio);
    If ( a = Nil) Then writeln ('Árbol vacío')
    Else begin
        ObtenerPrestamosSocio(a, numSocio, cantPrestamos);
        if (cantPrestamos = 0) then
            writeln('El socio número ', numSocio, ' no se encuentra cargado en el sistema.')
        else
            writeln('Al socio número ', numSocio, ' se le realizaron ', cantPrestamos, ' préstamos.');
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloF(var ptrs_L: recPunterosLista; a: arbol_prestamos);

    procedure AgregarAtras(var pri, ult: listaISBN; p: recPrestamo);
    var
        nue: listaISBN;
    begin
        new(nue);
        nue^.dato.isbn := p.isbn;
        nue^.dato.cant_prestamos := 1;
        nue^.sig := nil;
        if (pri = nil) then
            pri := nue
        else
            ult^.sig := nue;
        ult := nue;
    end;

    procedure CargarEnLista(var pri, ult: listaISBN; p: recPrestamo);
    begin
        if (ult = nil) or (p.isbn <> ult^.dato.isbn) then
            AgregarAtras(pri, ult, p)
        else
            ult^.dato.cant_prestamos := ult^.dato.cant_prestamos + 1;
    end;

    procedure RecorrerArbol1(var ptrs_L: recPunterosLista; a: arbol_prestamos);
    begin
        if (a <> nil) then begin
            RecorrerArbol1(ptrs_L, a^.HI);
            CargarEnLista(ptrs_L.pri, ptrs_L.ult, a^.dato);
            RecorrerArbol1(ptrs_L, a^.HD);
        end;
    end;

    procedure ImprimirLista(L: listaISBN);
    begin
        while (L <> nil) do begin
            write('-> ISBN: ', L^.dato.isbn:3);
            write(' | Cantidad de préstamos: ', L^.dato.cant_prestamos, '.');
            writeln;
            L := L^.sig;
        end;
    end;

begin
    writeln;
    writeln ('----- Generar lista L3 ----->');
    writeln;
    ptrs_L.pri := nil; 
    ptrs_L.ult := nil; // Se inicializa también ult en nil porque se usa para el if que agrega un isbn a la lista o suma un prestamo si ese isbn ya está cargado.
    If (a = Nil) Then writeln ('Árbol 1 vacío')
    Else begin
        RecorrerArbol1(ptrs_L, a);
        ImprimirLista(ptrs_L.pri);
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

// La dejo global porque la uso más adelante en otro proceso.
function ContarPrestamos(L: listaPrestamos): integer;
begin
    ContarPrestamos := 0;
    while (L <> nil) do begin
        ContarPrestamos := ContarPrestamos + 1;
        L := L^.sig;
    end;
end;

procedure ModuloG(var ptrs_L: recPunterosLista; a: arbol_isbn);


    procedure AgregarAtras(var pri, ult: listaISBN; lib: recArbolISBN);
    var
        nue: listaISBN;
    begin
        new(nue);
        nue^.dato.isbn := lib.isbn;
        nue^.dato.cant_prestamos := ContarPrestamos(lib.lista_prestamos); // El árbol ya tiene los isbn separados. Siempre es agregar atrás y con esta función recorro la lista de préstamos y los cuento.
        nue^.sig := nil;
        if (pri = nil) then
            pri := nue
        else
            ult^.sig := nue;
        ult := nue;
    end;

    procedure RecorrerArbol2(var ptrs_L: recPunterosLista; a: arbol_isbn);
    begin
        if (a <> nil) then begin
            RecorrerArbol2(ptrs_L, a^.HI);
            AgregarAtras(ptrs_L.pri, ptrs_L.ult, a^.dato);
            RecorrerArbol2(ptrs_L, a^.HD);
        end;
    end;

    procedure ImprimirLista(L: listaISBN);
    begin
        while (L <> nil) do begin
            write('-> ISBN: ', L^.dato.isbn:3);
            write(' | Cantidad de préstamos: ', L^.dato.cant_prestamos, '.');
            writeln;
            L := L^.sig;
        end;
    end;

    procedure ImprimirListaRecursivo(L: listaISBN);
    begin
        if (L <> nil) then begin
            write('-> ISBN: ', L^.dato.isbn:3);
            write(' | Cantidad de préstamos: ', L^.dato.cant_prestamos, '.');
            writeln;
            ImprimirListaRecursivo(L^.sig);
        end;
    end;

begin
    writeln;
    writeln ('----- Generar lista L4 ----->');
    writeln;
    ptrs_L.pri := nil; 
    ptrs_L.ult := nil; // Se inicializa también ult en nil porque se usa para el if que agrega un isbn a la lista o suma un prestamo si ese isbn ya está cargado.
    If (a = Nil) Then writeln ('Árbol 2 vacío')
    Else begin
        RecorrerArbol2(ptrs_L, a);
        // ImprimirLista(ptrs_L.pri);
        ImprimirListaRecursivo(ptrs_L.pri); // Módulo H.
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloI(a: arbol_prestamos);

    procedure ObtenerPrestamosRango(var cantPrestamos: integer; bn1, bn2: integer; a: arbol_prestamos);
    begin
        if (a <> nil) then begin
            if (a^.dato.isbn >= bn1) then
                if (a^.dato.isbn <= bn2) then begin
                    cantPrestamos := cantPrestamos + 1;
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HI);
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HD);
                end
                else
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HI)
            else
                ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HD);
        end;
    end;

var
    cantPrestamos, bn1, bn2: integer;
begin
    writeln;
    writeln ('----- Cantidad de préstamos entre valores ISBN ----->');
    writeln;
    If (a = Nil) Then writeln ('Árbol 1 vacío')
    Else begin
        write('Ingrese un valor ISBN: ');
        read(bn1);
        write('Ingrese otro valor ISBN (mayor al anterior): ');
        read(bn2);
        cantPrestamos := 0;
        ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a);
        writeln;
        writeln('Se realizaron ', cantPrestamos, ' préstamos dentro de ese rango.')
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloJ(a: arbol_isbn);

    procedure ObtenerPrestamosRango(var cantPrestamos: integer; bn1, bn2: integer; a: arbol_isbn);
    begin
        if (a <> nil) then begin
            if (a^.dato.isbn >= bn1) then
                if (a^.dato.isbn <= bn2) then begin
                    cantPrestamos := cantPrestamos + ContarPrestamos(a^.dato.lista_prestamos);
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HI);
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HD);
                end
                else
                    ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HI)
            else
                ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a^.HD);
        end;
    end;

var
    cantPrestamos, bn1, bn2: integer;
begin
    writeln;
    writeln ('----- Cantidad de préstamos entre valores ISBN ----->');
    writeln;
    If (a = Nil) Then writeln ('Árbol 2 vacío')
    Else begin
        write('Ingrese un valor ISBN: ');
        read(bn1);
        write('Ingrese otro valor ISBN (mayor al anterior): ');
        read(bn2);
        cantPrestamos := 0;
        ObtenerPrestamosRango(cantPrestamos, bn1, bn2, a);
        writeln;
        writeln('Se realizaron ', cantPrestamos, ' préstamos dentro de ese rango.')
    end;
    writeln;
    writeln;
    writeln ('//////////////////////////////////////////////////////////');
    writeln;
end;

var
    a1: arbol_prestamos;
    a2: arbol_isbn;
    ptrs_L3, ptrs_L4: recPunterosLista;
begin
    randomize;
    ModuloA(a1, a2);
    InformarArbolPrestamos(a1);
    InformarArbolISBN(a2);
    ModuloB(a1);
    ModuloC(a2);
    ModuloD(a1);
    ModuloE(a2);
    ModuloF(ptrs_L3, a1);
    ModuloG(ptrs_L4, a2);
    // ModuloH adentro de Módulo G.
    ModuloI(a1);
    ModuloJ(a2);
end.