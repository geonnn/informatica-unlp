{Una empresa de ventas de pasajes en colectivo está analizando la información de los viajes realizados a Mar del Plata en el último año. Para ello, se dispone de una estructura de datos con la información de todos los viajes realizados. De cada viaje se conoce el código de viaje, el número de coche (entre 1000 y 2500), el mes en que se realizó el viaje, cantidad de pasajes vendidos y el dni del chofer. La información no se encuentra ordenada pr ningún criterio.
Además la empresa dispone de una estructura de datos con información sobre la capacidad máxima de cada coche

Realizar un programa que procese la información de los viajes e:
A. Informe el número de coche con el cual se realizaron más viajes.
B. Genere una lista con los viajes realizados en el mes 2 por un chofer con dni múltiplo de 10, donde la cantidad de pasajes vendidos no alcanza la capacidad máxima del coche.
C. COMPLETO: Para cada coche, informe el promedio de pasajeros que viajaron entre todos sus viajes.}

program Parcial;
type
    rangoCoches = 1000..1015;
    rangoMeses = 1..12;

    recViajes = record // Se dispone.
        codViaje: integer;
        nroCoche: rangoCoches;
        mesViaje: rangoMeses;
        cantPVendidos: integer;
        dniChofer: Int64;
    end;

    listaViajes = ^nodoV; // Se dispone. Lista de viajes.
    nodoV = record
        dato: recViajes;
        sig: listaViajes;
    end;

    listaViajesMes2 = ^nodoVm2;
    nodoVm2 = record
        dato: recViajes;
        sig: listaViajesMes2;
    end;

    recCoches = record
        viajes: integer;
        pasajeros: integer;
    end;

    vecCapCoches = array[rangoCoches] of integer; // Se dispone.

    vecCoches = array[rangoCoches] of recCoches;
    // vecViajesPCoche = array[rangoCoches] of integer;

procedure InicializarVector(var vC: vecCoches);
var
    i: rangoCoches;
begin
    for i := 1000 to 2500 do begin
        vC[i].viajes := 0;
        vC[i].pasajeros := 0;
    end;
end;

procedure LeerViajes(var v: recViajes);
begin
    readln(v.codViaje);
    readln(v.nroCoche);
    readln(v.mesViaje);
    readln(v.cantPVendidos);
    readln(v.dniChofer);
end;

procedure CargarListaViajes(var LV: listaViajes); // Se dispone.
var
    nue: listaViajes; i: integer;
    v: recViajes;
begin
    LeerViajes(v);
    new(nue);
    nue^.dato := v;
    nue^.sig := LV;
    LV := nue;
end;
procedure CargarVectorCapCoches(var vCC: vecCapCoches); // Se dispone.
var
    i: rangoCoches;
begin
    for i := 1000 to 2500 do
        readln(vCC[i]);
end;

function Cumple(v: recViajes; vCC: vecCapCoches): boolean; // Verifica condiciones inciso B.
begin
    Cumple := (v.mesViaje = 2) and ((v.dniChofer MOD 10) = 0) and (v.cantPVendidos < vCC[v.nroCoche]);
end;

procedure AgregarAdelante(var LVm2: listaViajesMes2; v: recViajes);
var
    nue: listaViajesMes2;
begin
    new(nue);
    nue^.dato := v;
    nue^.sig := LVm2;
    LVm2 := nue;
end;

procedure AcumularVector(var vC: vecCoches; nroCoche, cantPVendidos: integer);
begin
    vC[nroCoche].viajes := vC[nroCoche].viajes + 1;
    vC[nroCoche].pasajeros := vC[nroCoche].pasajeros + cantPVendidos;
end;

procedure RecorrerListaViajes(var vC: vecCoches; var LVm2: listaViajesMes2; vCC: vecCapCoches; LV: listaViajes);
begin
    while (LV <> nil) do begin
        AcumularVector(vC, LV^.dato.nroCoche, LV^.dato.cantPVendidos);
        if (Cumple(LV^.dato, vCC)) then
            AgregarAdelante(LVm2, LV^.dato);
        LV := LV^.sig;
    end;
end;

procedure MaxViajes(var nroCocheVMax, viajesMax: integer; nroCoche, viajes: integer);
begin
    if (viajes > viajesMax) then begin
        viajesMax := viajes;
        nroCocheVMax := nroCoche;
    end;
end;

procedure RecorrerVectorCoches(var nroCocheVMax: integer; vC: vecCoches);
var
    i: integer;
    viajesMax: integer;
begin
    viajesMax := -1;
    for i := 1000 to 2500 do begin
        MaxViajes(nroCocheVMax, viajesMax, i, vC[i].viajes);
        writeln('Promedio de pasajeros por viaje para el coche ', i, ': ', (vC[i].pasajeros / vC[i].viajes):0:2, '.');
    end;
end;

var
    LVm2: listaViajesMes2;
    LV: listaViajes;
    vC: vecCoches;
    vCC: vecCapCoches;
    nroCocheVMax: integer;
begin
    LV := nil; // Se dispone.
    writeln('Cargar capacidad coches: ');
    CargarVectorCapCoches(vCC); // Se dispone.
    writeln('Cargar lista viajes: ');
    CargarListaViajes(LV); // Se dispone.

    LVm2 := nil;
    InicializarVector(vC);
    writeln('Vector coches inicializado');

    writeln('Recorrer lista viajes: ');
    RecorrerListaViajes(vC, LVm2, vCC, LV);
    writeln('Recorrer vector coches: ');
    RecorrerVectorCoches(nroCocheVMax, vC);
end.