program parcial;
const
    c_maxPaises = 200;
type
    recRepuesto = record
        codigo: integer;
        pais: integer;
        precio: real;
    end;

    listaRepuestos = ^nodo;
    nodo = record
        dato: recRepuesto;
        sig: listaRepuestos;
    end;

    recPaises = record
        cantRepuestos = integer;
        maxRepuesto = real;
    end;

    vecPaises = array[1..c_maxPaises] of string; // Se dispone.

    vecPaisesRepuestos = array[1..c_maxPaises] of recPaises;

function TieneTresCeros(codigo: integer): boolean;
var
    count: integer;
begin
    TieneTresCeros := false;
    count := 0;
    while (codigo <> 0) and not TieneTresCeros do
    begin
        if ((codigo MOD 10) = 0) then
            count := count + 1;
        codigo := codigo DIV 10;
        TieneTresCeros := (count >= 3);
    end;
end;

procedure InsertarOrdenado(c: recRepuesto; var LR: listaRepuestos);
var
    act, ant, nue: listaRepuestos;
begin
    new(nue);
    nue^.dato := c;
    act := LR;
    ant := LR;
    while (act <> nil) and (c.codigo > act^.dato.codigo) do
    begin
        ant := act;
        act := act^.sig;
    end;
    if (act = LR) then
        LR := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure CargarListaRepuestos(var LR: listaRepuestos);
var
    c: recRepuesto;
begin
    writeln('Ingrese codigo, pais (1 a 200) y precio. Ingrese codigo -1 para finalizar.');
    readln(c.codigo);
    while (c.codigo <> -1) do
    begin
        readln(c.pais, c.precio);
        InsertarOrdenado(c, LR);
        readln(c.codigo);
    end;
end;

procedure InicializarVecPR(var vPR: vecPaisesRepuestos);
var
    i: integer;
begin
    for i := 1 to c_maxPaises do begin
        vPR[i].cantRepuestos := 0; // Contadores.
        vPR[i].maxRepuesto := -999; // Máximos.
    end;
end;

procedure RepuestoMax(var vPR: vecPaisesRepuestos; precio: real; pais: integer);
begin
    if (precio > vPR[pais].maxRepuesto) then
        vPR[pais].maxRepuesto := precio;
end;

procedure RecorrerListaRepuestos(LR: listaRepuestos; var vPR: vecPaisesRepuestos; var totalRepuestos: integer; var repuestosTresCeros: integer);
begin
    totalRepuestos := 0;
    repuestosTresCeros := 0;
    while (LR <> nil) do
    begin
        vPR[LR^.dato.pais].cantRepuestos := vPR[LR^.dato.pais].cantRepuestos + 1;
        totalRepuestos := totalRepuestos + 1;
        if (TieneTresCeros(LR^.dato.codigo)) then
            repuestosTresCeros := repuestosTresCeros + 1;
        RepuestoMax(vPR, LR^.dato.precio, LR^.dato.pais);
        LR := LR^.sig;
    end;
end;

function CalcularPromedio(totalRepuestos: integer): real;
begin
    CalcularPromedio := totalRepuestos / c_maxPaises;
end;


procedure RecorrerVector(vP: vecPaises; vPR: vecPaisesRepuestos; promedio: real; var cantPaisesCondicionB1: integer);
var
    i: integer;
begin
    for i := 1 to c_maxPaises do begin
        if (vPR[i].cantRepuestos < promedio) then
            cantPaisesCondicionB1 := cantPaisesCondicionB1 + 1;
        writeln('País ', vP[i], '. Repuesto más caro: ', vPR[i].maxRepuesto); // Inciso b2.
    end;
end;

// programa principal.
var
    LR: listaRepuestos;
    vP: vecPaises;
    vPR: vecPaisesRepuestos;
    totalRepuestos: integer;
    repuestosTresCeros: integer;
    cantPaisesCondicionB1: integer;
    promedio: real;
begin
    CargarVectorPaises(vP); // Se dispone.

    LR := nil;
    cantPaisesCondicionB1 := 0;
    CargarListaRepuestos(LR);
    
    InicializarVecPR(vPR);

    RecorrerListaRepuestos(LR, vPR, totalRepuestos, repuestosTresCeros);
    promedio := CalcularPromedio(totalRepuestos);
    RecorrerVector(vP, vPR, promedio, cantPaisesCondicionB1);
    writeln('Inciso b1: ', cantPaisesCondicionB1);
    writeln('Cantidad de repuestos comprados con al menos 3 ceros en su codigo: ', repuestosTresCeros); // Inciso b3.
end.