{12. En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular; 4. irregular), su masa (medida en kg) y la distancia en pársecs (pc) medida desde la Tierra. La Unión Astronómica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo Local. Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:
a. La cantidad de galaxias de cada tipo.
b. La masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el
porcentaje que esto representa respecto a la masa de todas las galaxias.
c. La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
d. El nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.}

program Ej12;
const
    GrL = 5;
    TIPOS = 4;
type
    str30 = string[30];
    vTipo = array[1..4] of integer;
    galaxias = record
        nombre: str30;
        tipo: 1..TIPOS;
        masa: extended;
        dpc: extended;
    end;
    vGalaxias = array[1..GrL] of galaxias;

procedure Leer(var g: galaxias);
begin
    writeln('Ingrese el nombre de la galaxia: ');
    readln(g.nombre);
    writeln('Ingrese un número del 1 al 4 para el tipo de galaxia: ');
    writeln('1. Elíptica; 2. Espiral; 3. Lenticular; 4. Irregular');
    readln(g.tipo);
    writeln('Ingrese la masa en kg de la galaxia: ');
    readln(g.masa);
    writeln('Ingrese la distancia en pársecs desde la Tierra a la galaxia: ');
    readln(g.dpc);
end;

procedure Inicializar(var v: vTipo);
var
    i: integer;
begin
    for i := 1 to TIPOS do
        v[i] := 0;
end;

procedure SumarTipo(var v: vTipo; tipo: integer);
begin
    v[tipo] := v[tipo] + 1;
end;

procedure Masa(nombre: str30; var masaVLAT, masaTotal: extended; masa: extended);
begin
    masaTotal := masaTotal + masa;
    if (nombre = 'Via Lactea') or (nombre = 'Andromeda') or (nombre = 'Triangulo') then // FPC NO RECONOCE STRINGS CON TILDES. 
        masaVLAT := masaVLAT + masa;
end;

procedure MasaMax(var nMax1, nMax2: str30; var mMax1, mMax2: extended; nombre: str30; masa: extended);
begin
    if (masa > mMax1) then begin
        mMax2 := mMax1;
        nMax2 := nMax1;

        mMax1 := masa;
        nMax1 := nombre;
    end
    else begin
        if (masa > mMax2) then begin
            mMax2 := masa;
            nMax2 := nombre;
        end;
    end;
end;

procedure MasaMin(var nMin1, nMin2: str30; var mMin1, mMin2: extended; nombre: str30; masa: extended);
begin
    if (masa < mMin1) then begin
        mMin2 := mMin1;
        nMin2 := nMin1;
        
        mMin1 := masa;
        nMin1 := nombre;
    end
    else begin
        if (masa < mMin2) then begin
            mMin2 := masa;
            nMin2 := nombre;
        end;
    end;
end;

procedure NoIrr1000pc(var cant: integer; tipo: integer; dist: extended);
begin
    if (tipo <> 4) and (dist < 1000) then
        cant := cant + 1;
end;

var
    g: galaxias;
    vG: vGalaxias;
    vT: vTipo;
    i: integer;
    mVLAT, mTotal: extended;
    nomMax1, nomMax2: str30;
    masaMax1, masaMax2: extended;
    nomMin1, nomMin2: str30;
    masaMin1, masaMin2: extended;
    cantGalNoIrr: integer;
    porcentaje: extended;
begin
    masaMax1 := -999;
    masaMax2 := -999;
    masaMin1 := maxInt;
    masaMin2 := maxInt;
    mVLAT := 0;
    mTotal := 0;
    cantGalNoIrr := 0;
    Inicializar(vT);
    for i := 1 to GrL do begin
        Leer(g);
        vG[i] := g;
        SumarTipo(vT, g.tipo);
        Masa(g.nombre, mVLAT, mTotal, g.masa);
        MasaMax(nomMax1, nomMax2, masaMax1, masaMax2, g.nombre, g.masa);
        MasaMin(nomMin1, nomMin2, masaMin1, masaMin2, g.nombre, g.masa);
        NoIrr1000pc(cantGalNoIrr, g.tipo, g.dpc);
    end;
    // Inciso a.
    writeln('Hay ', vT[1], ' galaxias elípticas.');
    writeln('Hay ', vT[2], ' galaxias espirales.');
    writeln('Hay ', vT[3], ' galaxias lenticulares.');
    writeln('Hay ', vT[4], ' galaxias irregulares.');
    
    // Inciso b.
    porcentaje := (mVLAT * 100) / mTotal;
    writeln('El porcentaje de masa de la Vía Láctea, Andrómeda y Triángulo es de un ', (porcentaje):0:2, '% del total de masa de las galaxias.');

    // Inciso c.
    writeln(cantGalNoIrr, ' galaxias no irregulares se encuentran a menos de 1000pc.');
    
    // Inciso d.
    writeln('Las dos galaxias con mayor masa son: ', nomMax1, ' y ', nomMax2, '.');
    writeln('Las dos galaxias con menor masa son: ', nomMin1, ' y ', nomMin2, '.');
end.