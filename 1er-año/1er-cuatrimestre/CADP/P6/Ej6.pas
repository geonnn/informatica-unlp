{6. La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la misión (cantidad de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y rango del espectro electromagnético sobre el que realizará estudios. Dicho rango se divide en 7 categorías: 1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma.
Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura finaliza al ingresar la sonda llamada “GAIA”, que debe procesarse.
Una vez finalizada la lectura, informar:
a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible}

program Ej6;
type
    str30 = string[30];
    recSondas = record
        nombre: str30;
        durMision: integer;
        cosConstr: real;
        cosMant: real;
        rngEspEl: 1..7;
    end;
    listaSondas = ^nodo;
    nodo = record
        dato: recSondas;
        sig: listaSondas;
    end;
    vContREE = array[1..7] of integer;


// Vector contador para contar la cantidad de sondas por cada categoría de espectro.
procedure InicializarVector(var vC: vContREE);
var
    i: integer;
begin
    for i := 1 to 7 do
        vC[i] := 0;
end;

procedure CargarSonda(var s: recSondas);
begin
    writeln('Ingrese el nombre de la sonda: ');
    readln(s.nombre);
    writeln('Ingrese la duración estimada de misión en meses: ');
    readln(s.durMision);
    writeln('Ingrese el costo de construcción: ');
    readln(s.cosConstr);
    writeln('Ingrese el costo mensual de mantenimiento: ');
    readln(s.cosMant);
    writeln('Ingrese el rango del espectro electromagnético: ');
    readln(s.rngEspEl);
end;

procedure CargarLista(var L: listaSondas);
var
    s: recSondas;
    nue: listaSondas;
begin
    repeat
        CargarSonda(s);
        new(nue);
        nue^.dato := s;
        nue^.sig := L;
        L := nue;
    until (s.nombre = 'GAIA');
end;

// Calcular sonda más costosa.
procedure SondaValorMax(var sondaCostoMax: real; var nomSondaCostoMax: str30; s: recSondas);
var
    valorSonda: real;
begin
    valorSonda := s.cosMant * s.durMision; // Costo de mantenimiento por cantidad de meses activa.
    valorSonda := valorSonda + s.cosConstr; // Lo anterior más costo de construcción.
    if (valorSonda > sondaCostoMax) then begin 
        sondaCostoMax := valorSonda;
        nomSondaCostoMax := s.nombre;
    end;
end;

// Primer reccorrido de la lista. Calcular cantidad de sondas y datos totales para después poder sacar promedios.
procedure Recorrer1(var nomSondaCostoMax: str30; var cantSondas, durTotal: integer; var cosConstrTotal: real; var vC: vContREE; L: listaSondas);
var
    sondaCostoMax: real;
begin
    sondaCostoMax := -maxInt;
    while (L <> nil) do begin
        SondaValorMax(sondaCostoMax, nomSondaCostoMax, L^.dato);
        vC[L^.dato.rngEspEl] := vC[L^.dato.rngEspEl] + 1;
        durTotal := durTotal + L^.dato.durMision;
        cosConstrTotal := cosConstrTotal + L^.dato.cosConstr;
        cantSondas := cantSondas + 1;
        L := L^.sig;
    end;
end;

// Segundo recorrido de la lista.
procedure Recorrer2(var cantSondasDurMayorAlPromedio: integer; promDur, promCostoConstr: real; L: listaSondas);
begin
    while (L <> nil) do begin
        if (L^.dato.durMision > promDur) then
            cantSondasDurMayorAlPromedio := cantSondasDurMayorAlPromedio + 1;
        if (L^.dato.cosConstr > promCostoConstr) then
            writeln('Costo de construcción mayor al promedio: ', L^.dato.nombre, '.');
        L := L^.sig;
    end;
end;

procedure ImprimirVector(vC: vContREE);
var
    i: integer;
begin
    for i := 1 to 7 do begin
        if (vC[i] <> 0) then
            writeln('Espectro electromagnético ', i, ': ', vC[i], ' sondas.');
    end;
end;

var
    L: listaSondas;
    vC: vContREE;
    cantSondas, durTotal, cantSondasDurMayorAlPromedio: integer;
    cosConstrTotal: real;
    promCostoConstr, promDur: real;
    nomSondaCostoMax: str30;
begin
    // Inicializar contadores y demás.
    cosConstrTotal := 0;
    durTotal := 0;
    cantSondas := 0;
    cantSondasDurMayorAlPromedio := 0;
    L := nil;
    InicializarVector(vC);

    CargarLista(L);
    Recorrer1(nomSondaCostoMax, cantSondas, durTotal, cosConstrTotal, vC, L);

    // Calcular promedios.
    promDur := durTotal / cantSondas;
    promCostoConstr := cosConstrTotal / cantSondas;

    Recorrer2(cantSondasDurMayorAlPromedio, promDur, promCostoConstr, L);

    // Imprimir.
    writeln('La sonda más costosa es: ', nomSondaCostoMax, '.');
    ImprimirVector(vC);
    writeln(cantSondasDurMayorAlPromedio, ' superan la duración promedio.');
end.