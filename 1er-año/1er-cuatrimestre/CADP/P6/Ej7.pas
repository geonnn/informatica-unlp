{7. El Programa Horizonte 2020 (H2020) de la Unión Europea ha publicado los criterios para financiar proyectos de investigación avanzada. Para los proyectos de sondas espaciales vistos en el ejercicio anterior, se han determinado los siguientes criterios:
- Sólo se financiarán proyectos cuyo costo de mantenimiento no supere el costo de construcción.
- No se financiarán proyectos espaciales que analicen ondas de radio, ya que esto puede realizarse desde la superficie terrestre con grandes antenas.
A partir de la información disponible de las sondas espaciales (la lista generada en ejercicio 6), implementar un programa que:
a. Invoque un módulo que reciba la información de una sonda espacial, y retorne si cumple o no con los nuevos criterios H2020.
b. Utilizando el módulo desarrollado en a) implemente un módulo que procese la lista de sondas de la ESA y retorne dos listados, uno con los proyectos que cumplen con los nuevos criterios y otro con aquellos que no los cumplen.
c. Invoque a un módulo que reciba una lista de proyectos de sondas espaciales e informe la cantidad y el costo total (construcción y mantenimiento) de los proyectos que no serán financiados por H2020. Para ello, utilice el módulo realizado en b.}

program Ej7;
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
    writeln('');
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

// 7a.
function H2020(s: recSondas): boolean;
begin
    H2020 := (((s.cosMant * s.durMision) <= s.cosConstr) and (s.rngEspEl <> 1));
    // writeln('Evaluating: ', s.nombre, ' - H2020: ', H2020);
end;

// 7b. Se podría hacer en alguno de los recorridos anteriores de todas formas.
procedure RecorridoListaH2020(var LH2020False, LH2020True: listaSondas; L: listaSondas);
var
    nueH2020False, nueH2020True: listaSondas;
begin
    while (L <> nil) do begin
        if (H2020(L^.dato)) then begin
            new(nueH2020True);
            nueH2020True^.dato := L^.dato;
            nueH2020True^.sig := LH2020True;
            LH2020True := nueH2020True;
            // writeln('Adding to H2020True: ', L^.dato.nombre);
        end
        else begin
            new(nueH2020False);
            nueH2020False^.dato := L^.dato;
            nueH2020False^.sig := LH2020False;
            LH2020False := nueH2020False;
            // writeln('Adding to H2020False: ', L^.dato.nombre);
        end;
        L := L^.sig;
    end;
end;

//7c.
procedure CalcularCostoSonda(var costo: real; s: recSondas);
begin
    costo := (s.durMision * s.cosMant) + s.cosConstr;
end;

procedure ProyectosNoFinanciados(var cantProyNoFinanciados: integer; var cosTotalProyNoFinanciados: real; LH2020False: listaSondas);
var
    costoSonda: real;
begin
    while (LH2020False <> nil) do begin
        CalcularCostoSonda(costoSonda, LH2020False^.dato);
        cosTotalProyNoFinanciados := cosTotalProyNoFinanciados + costoSonda;
        cantProyNoFinanciados := cantProyNoFinanciados + 1;
        LH2020False := LH2020False^.sig;
    end;
end;

var
    L: listaSondas;
    vC: vContREE;
    cantSondas, durTotal, cantSondasDurMayorAlPromedio, cantProyNoFinanciados: integer;
    cosConstrTotal, cosTotalProyNoFinanciados: real;
    promCostoConstr, promDur: real;
    nomSondaCostoMax: str30;

    // Ej. 7.
    LH2020True, LH2020False: listaSondas;
begin
    // Inicializar contadores y demás.
    cosConstrTotal := 0;
    durTotal := 0;
    cantSondas := 0;
    cantSondasDurMayorAlPromedio := 0;
    L := nil;
    InicializarVector(vC);
    
    // Ej. 7.
    LH2020False := nil;
    LH2020True := nil;
    cantProyNoFinanciados := 0;
    cosTotalProyNoFinanciados := 0;

    writeln('');
    CargarLista(L);
    Recorrer1(nomSondaCostoMax, cantSondas, durTotal, cosConstrTotal, vC, L);

    // Calcular promedios.
    promDur := durTotal / cantSondas;
    promCostoConstr := cosConstrTotal / cantSondas;

    Recorrer2(cantSondasDurMayorAlPromedio, promDur, promCostoConstr, L);

    RecorridoListaH2020(LH2020False, LH2020True, L);
    ProyectosNoFinanciados(cantProyNoFinanciados, cosTotalProyNoFinanciados, LH2020False);
    // Imprimir.
    writeln('La sonda más costosa es: ', nomSondaCostoMax, '.');
    ImprimirVector(vC);
    writeln(cantSondasDurMayorAlPromedio, ' superan la duración promedio.');
    writeln('');
    writeln('Proyectos no financiados: ');
    writeln('Cantidad: ', cantProyNoFinanciados, '.');
    writeln('Costo total: ', cosTotalProyNoFinanciados:0:2, '.');
end.