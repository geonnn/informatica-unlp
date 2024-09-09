{TURNO D-TEMA 2
Módulo Imperativo
12/09/2023 IMPORTANTE: Cree un programa en Pascal. Utilice su apellido como nombre del programa y del archivo .pas, y guardelo en el Escritorio de su computadora.
Aerolíneas Argentinas necesita procesar los pasajes vendidos durante 2023. De cada pasaje se conoce el código de vuelo, código del cliente, código ciudad destino y monto del pasaje.
a) Implementar un módulo que lea pasajes, genere y retorne una estructura adecuada para la búsqueda por código de ciudad destino, donde para cada código de ciudad destino se almacenan juntos todos los pasajes (código de vuelo, código de cliente y monto del pasaje). La lectura finaliza con el monto de pasaje 0. Se sugiere utilizar el módulo leerPasaje().
b) Implementar un módulo que reciba la estructura generada en a) y un código de ciudad destino y retorne todos los pasajes hacia esa ciudad destino.
c) Realizar un módulo que reciba la estructura generada en a) y retorne el código de ciudad de destino con mayor cantidad de pasajes vendidos.
NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.}

program Parcial;

type

    recPasaje = record
        vuelo: integer;
        cliente: integer;
        destino: integer;
        monto: real;
    end;

//------------ Nueva estructura ----------------

    recVuelo = record
        vuelo: integer;
        cliente: integer;
        monto: real;
    end;

    listaVuelos = ^nodoLista;
    nodoLista = record
        dato: recVuelo;
        sig: listaVuelos;
    end;

    recCiudad = record
        codigo: integer;
        lista_vuelos: listaVuelos;
    end;

    arbol_ciudades = ^nodoArbol;
    nodoArbol = record
        dato: recCiudad;
        HI, HD: arbol_ciudades;
    end;

procedure ImprimirVuelos(L: listaVuelos);
begin
    while (L <> nil) do begin
        writeln;
        write('      -> Vuelo: ', L^.dato.vuelo);
        write(' | Cliente: ', L^.dato.cliente);
        write(' | Monto: ', L^.dato.monto:0:2);
        L := L^.sig;
    end;
end;

procedure ModuloA(var a: arbol_ciudades);

    procedure LeerPasaje(var p: recPasaje);
    begin
        p.monto := random(9999)/(random(10) + 1);
        if (p.monto = 0) then
            writeln('Carga finalizada.')
        else begin
            p.vuelo := random(7000);
            p.cliente := random(100) + 1;
            p.destino := random(500) + 1;
        end;
    end;

    procedure CopiarDatos(var v: recVuelo; p: recPasaje);
    begin
        v.vuelo := p.vuelo;
        v.cliente := p.cliente;
        v.monto := p.monto;
    end;

    procedure AgregarAdelante(var L: listaVuelos; v: recVuelo);
    var
        nue: listaVuelos;
    begin
        new(nue);
        nue^.dato := v;
        nue^.sig := L;
        L := nue;
    end;

    procedure InsertarPasaje(var a: arbol_ciudades; destino: integer; v: recVuelo);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato.codigo := destino;
            a^.dato.lista_vuelos := nil;
            AgregarAdelante(a^.dato.lista_vuelos, v);
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (a^.dato.codigo = destino) then
                AgregarAdelante(a^.dato.lista_vuelos, v)
            else
                if (destino > a^.dato.codigo) then
                    InsertarPasaje(a^.HD, destino, v)
                else
                    InsertarPasaje(a^.HI, destino, v);
    end;

    procedure ImprimirCiudad(c: recCiudad);
    begin
        writeln('-> Ciudad: ', c.codigo);
        ImprimirVuelos(c.lista_vuelos);
        writeln;
        writeln;
    end;

    procedure ImprimirArbol(a: arbol_ciudades);
    begin
        if (a <> nil) then begin
            ImprimirArbol(a^.HI);
            ImprimirCiudad(a^.dato);
            ImprimirArbol(a^.HD);
        end;
    end;

var
    p: recPasaje;
    v: recVuelo;
begin
    a := nil;
    writeln;
    writeln('----- Generar Árbol -----');
    writeln;
    LeerPasaje(p);
    while (p.monto <> 0) do begin
        CopiarDatos(v, p);
        InsertarPasaje(a, p.destino, v);
        LeerPasaje(p);
    end;
    ImprimirArbol(a);
    writeln;
    writeln('///////////////////////////////////////////////');
    writeln;
end;

procedure ModuloB(a: arbol_ciudades);

    procedure BuscarCiudad(a: arbol_ciudades; destInput: integer);
    begin
        if (a <> nil) then
            if (a^.dato.codigo = destInput) then
                ImprimirVuelos(a^.dato.lista_vuelos)
            else
                if (destInput > a^.dato.codigo) then
                    BuscarCiudad(a^.HD, destInput)
                else
                    BuscarCiudad(a^.HI, destInput)
        else
            writeln('No se encontró la ciudad.');
    end;

var
    destInput: integer;
begin
    writeln;
    writeln('----- Imprimir vuelos para ciudad destino -----');
    writeln;
    write('Ingrese código de destino: ');
    read(destInput);
    writeln;
    writeln('Vuelos para ciudad código ', destInput,': ');
    if (a = nil) then
        writeln('Árbol vacío')
    else
        BuscarCiudad(a, destInput);
    writeln;
    writeln;
    writeln('///////////////////////////////////////////////');
    writeln;
end;

procedure ModuloC(a: arbol_ciudades);
{Realizar un módulo que reciba la estructura generada en a) y retorne el código
de ciudad de destino con mayor cantidad de pasajes vendidos.}

    procedure ImprimirVuelos(L: listaVuelos);
    begin
        while (L <> nil) do begin
            writeln;
            write('-> Vuelo: ', L^.dato.vuelo);
            write(' | Cliente: ', L^.dato.cliente);
            write(' | Monto: ', L^.dato.monto:0:2);
            L := L^.sig;
        end;
    end;

    function Cantidad(L: listaVuelos): integer;
    begin
        Cantidad := 0;
        while (L <> nil) do begin
            Cantidad := Cantidad + 1;
            L := L^.sig;
        end;
    end;

    procedure ActualizarMaximo(var codMax, pasajesMax: integer; codNuevo: integer; L: listaVuelos);
    var
        pasajesNuevo: integer;
    begin
        pasajesNuevo := Cantidad(L);
        if (pasajesNuevo > pasajesMax) then begin
            pasajesMax := pasajesNuevo; 
            codMax := codNuevo;
        end;
    end; 

    procedure ObtenerCiudadMaxPasajes(var codMax, pasajesMax: integer; a: arbol_ciudades);
    begin
        if (a <> nil) then begin
            ActualizarMaximo(codMax, pasajesMax, a^.dato.codigo, a^.dato.lista_vuelos); 
            ObtenerCiudadMaxPasajes(codMax, pasajesMax, a^.HI);
            ObtenerCiudadMaxPasajes(codMax, pasajesMax, a^.HD);
        end;
    end;

var
    codMax, pasajesMax: integer;
begin
    pasajesMax := -1;
    writeln;
    writeln('----- Ciudad destino con más pasajes vendidos -----');
    writeln;
    if (a = nil) then
        writeln('Árbol vacío')
    else
        ObtenerCiudadMaxPasajes(codMax, pasajesmax, a);
    writeln('Ciudad código: ', codMax, ' con ', pasajesMax, ' pasajes vendidos.');
    writeln;
    writeln('///////////////////////////////////////////////');
    writeln;
end;

var
    a: arbol_ciudades;
begin
    randomize;
    ModuloA(a);
    ModuloB(a);
    ModuloC(a);
end.