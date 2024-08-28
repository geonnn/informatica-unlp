{12. Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee (medida en GB). La información disponible se encuentra ordenada por versión de Android. Realizar un programa que procese la información disponible de todos los dispositivos e informe:
a. La cantidad de dispositivos para cada versión de Android.
b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
c. El tamaño promedio de las pantallas de todos los dispositivos.}

program Ej12;
type
    recDispositivos = record
        versAndroid: 0..15;
        tamPant: real;
        memRAM: integer;
    end;
    listaDispositivos = ^nodo;
    nodo = record
        dato: recDispositivos;
        sig: listaDispositivos;
    end;
    vecVersAndroid = array[0..15] of integer;

procedure CargarDispositivo(var d: recDispositivos);
begin
    readln(d.versAndroid);
    if (d.versAndroid = 0) then
        writeln('Carga finalizada.')
    else begin
        readln(d.tamPant);
        readln(d.memRAM);
    end;
end;

procedure CargarLista(var L: listaDispositivos);
var
    d: recDispositivos;
    ant, act, nue: listaDispositivos;
begin
    CargarDispositivo(d);
    while (d.versAndroid <> 0) do begin
        new(nue);
        nue^.dato := d;
        ant := L;
        act := L;
        while (act <> nil) and (d.versAndroid > act^.dato.versAndroid) do begin
            ant := act;
            act := act^.sig;
        end;
        if (act = ant) then
            L := nue
        else
            ant^.sig := nue;
        nue^.sig := act;
        CargarDispositivo(d);
    end;
end;

procedure InicializarVector(var vVA: vecVersAndroid);
var
    i: integer;
begin
    for i := 0 to 15 do
        vVA[i] := 0;
end;

procedure ImprimirVector(vVA: vecVersAndroid);
var
    i: integer;
begin
    for i := 0 to 15 do begin
        if (vVA[i] <> 0) then
            writeln('Versión de Android ', i, ': ', vVA[i], ' dispositivos.');
    end;
end;

procedure RecorrerLista(var promTamPant: real; var disp_3GB_5p: integer; var vVA: vecVersAndroid; L: listaDispositivos);
var
    cantDisp: integer;
    totalTamPant: real;
begin
    totalTamPant := 0;
    cantDisp := 0;
    while (L <> nil) do begin
        vVA[L^.dato.versAndroid] := vVA[L^.dato.versAndroid] + 1;
        if (L^.dato.memRAM > 3) and (L^.dato.tamPant <= 5) then
            disp_3GB_5p := disp_3GB_5p + 1;
        totalTamPant := totalTamPant + L^.dato.tamPant;
        cantDisp := cantDisp + 1;
        L := L^.sig;
    end;
    promTamPant := totalTamPant / cantDisp;
end;

var
    promTamPant: real;
    disp_3GB_5p: integer;
    vVA: vecVersAndroid;
    L: listaDispositivos;
begin
    disp_3GB_5p := 0;
    L := nil;
    InicializarVector(vVA);

    CargarLista(L);
    RecorrerLista(promTamPant, disp_3GB_5p, vVA, L);

    writeln('');
    ImprimirVector(vVA);
    writeln('Más de 3GB RAM y hasta 5" de pantalla: ', disp_3GB_5p, '.');
    writeln('Promedio de los tamaños de pantalla: ', promTamPant:0:2, '.');
end.