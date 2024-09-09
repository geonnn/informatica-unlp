{Taller de Programación. Programación Imperativa.
12-10-2023
El teatro Musicalísimo ofrece sus instalaciones para que bandas de música puedan dar sus recitales. De cada recital se conoce: el nombre de la banda, la fecha del recital, la cantidad de canciones tocadas y el monto recaudado por la venta de entradas.
a. Implemente un módulo que lea registros de recitales de manera sucesiva hasta que se ingrese "ZZZ" como nombre de banda. Los recitales se pueden leer en cualquier orden. Todos los recitales leídos deben almacenarse en una estructura que permita el recorrido óptimo por monto recaudado.
b. Implemente un módulo que reciba la estructura cargada y dos valores (ej: 200 y 500) y devuelva una lista con todos los recitales cuyo monto recaudado se encuentra entre esos dos valores leídos (ambos inclusive). La lista resultante debe estar ordenada por monto de mayor a menor.
c. Implemente un módulo recursivo que reciba la lista creada en b) y devuelva la cantidad de recitales que tocaron más de 12 canciones.}

program Parcial;

type
    
    recFecha = record
        dia: 1..31;
        mes: 1..12;
    end;

    recRecital = record
        banda: string;
        fecha: recFecha;
        cant_canciones: integer;
        monto_entradas: real;
    end;

    arbol_recitales = ^nodoArbol;
    nodoArbol = record
        dato: recRecital;
        HI, HD: arbol_recitales;
    end;

    listaRecitales = ^nodoLista;
    nodoLista = record
        dato: recRecital;
        sig: listaRecitales;
    end;

procedure ImprimirRecital(r: recRecital);
begin
    writeln;
    write('-> Banda: ', r.banda);
    write(' | Fecha: ', r.fecha.dia, '/', r.fecha.mes);
    write(' | Cant de Canciones: ', r.cant_canciones);
    write(' | Monto entradas: $', r.monto_entradas:0:0, '.');
end;

procedure ModuloA(var a: arbol_recitales);

    procedure GenerarFecha(var f: recFecha);
    begin
        f.dia := random(31) + 1;
        f.mes := random(12) + 1;
    end;

    procedure GenerarRecital(var r: recRecital);
    var
        vBandas: array[0..19] of string = ('Radiohead', 'ZZZ', 'Divididos', 'Airbag', 'Cuarteto de nos', 'Twenty one pilots', 'Imagine Dragons', 'The Strokes', 'Daft Punk', 'Queen', 'Nirvana', 'Foo Fighters', 'Red Hot Chili Peppers', 'Vulfpeck', 'Casiopea', 'No te va gustar', 'Los Piojos', 'Pink Floyd', 'Mild High Club', 'Nafta'); 
    begin
        r.banda := vBandas[random(20)];
        if (r.banda = 'ZZZ') then
            writeln('Carga finalizada.')
        else begin
            GenerarFecha(r.fecha);
            r.cant_canciones := random(31) + 1;
            r.monto_entradas := random(90001) + 10000;
        end;
    end;

    procedure InsertarRecital(var a: arbol_recitales; r: recRecital);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato := r;
            a^.HI := nil;
            a^.HD := nil;
        end
        else
            if (r.monto_entradas > a^.dato.monto_entradas) then // Repetidos a la izq.
                InsertarRecital(a^.HD, r)
            else
                InsertarRecital(a^.HI, r);
    end;

    procedure ImprimirArbol(a: arbol_recitales);
    begin
        if (a <> nil) then begin
            ImprimirArbol(a^.HI);
            ImprimirRecital(a^.dato);
            ImprimirArbol(a^.HD);
        end;
    end;

var
    r: recRecital;
begin
    a := nil;
    GenerarRecital(r);
    while (r.banda <> 'ZZZ') do begin
        InsertarRecital(a, r);
        GenerarRecital(r);
    end;
    ImprimirArbol(a);
    writeln;
    writeln;
    writeln('////////////////////////////////////////////////////////////////');

end;

procedure ModuloB(var L: listaRecitales; a: arbol_recitales);

    procedure AgregarAdelante(var L: listaRecitales; r: recRecital);
    var
        nue: listaRecitales;
    begin
        new(nue);
        nue^.dato := r;
        nue^.sig := L;
        L := nue;
    end;

    procedure RecorrerArbol(var L: listaRecitales; a: arbol_recitales; val1, val2: real);
    begin
        if (a <> nil) then
            if (a^.dato.monto_entradas >= val1) then
                if (a^.dato.monto_entradas <= val2) then begin
                    RecorrerArbol(L, a^.HI, val1, val2);
                    AgregarAdelante(L, a^.dato);
                    RecorrerArbol(L, a^.HD, val1, val2);
                end
                else
                    RecorrerArbol(L, a^.HI, val1, val2)
            else
                RecorrerArbol(L, a^.HD, val1, val2);
    end;

    procedure ImprimirLista(L: listaRecitales);
    begin
        while (L <> nil) do begin
            ImprimirRecital(L^.dato);
            L := L^.sig;
        end;
    end;

var
    val1, val2: real;
begin
    L := nil;
    writeln;
    writeln;
    writeln('----- Generar lista entre dos valores de monto recaudado -----');
    writeln;
    write('Ingrese un valor: ');
    read(val1);
    write('Ingrese otro valor (mayor al anterior): ');
    read(val2);
    RecorrerArbol(L, a, val1, val2);
    ImprimirLista(L);
    writeln;
    writeln;
    writeln('////////////////////////////////////////////////////////////////');
    writeln;
end;

procedure ModuloC(L: listaRecitales);

    function ObtenerCantidadRecitales(L: listaRecitales): integer;
    begin
        if (L <> nil) then begin
            if (L^.dato.cant_canciones > 12) then
                ObtenerCantidadRecitales := 1 + ObtenerCantidadRecitales(L^.sig)
            else
                ObtenerCantidadRecitales := 0;
        end
        else
            ObtenerCantidadRecitales := 0;
    end;

begin
    writeln;
    writeln;
    writeln('----- Recitales en los que hubo más de 12 canciones -----');
    writeln;
    writeln('Cantidad de recitales con más de 12 canciones: ', ObtenerCantidadRecitales(L), '.');
    writeln;
    writeln('////////////////////////////////////////////////////////////////');
    writeln;
end;

var
    a: arbol_recitales;
    L: listaRecitales;
begin
    randomize;
    ModuloA(a);
    ModuloB(L, a);
    ModuloC(L);
end.