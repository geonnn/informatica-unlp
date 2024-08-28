{TEMA 2-CADP 2024
29/6/2024
Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con todas las compras realizadas, sin ningún orden en particular. De cada compra se conoce: código, año (entre 1980 y 2024), monto y DNI del cliente. Un cliente puede haber realizado más
de una compra.
Realizar un programa procese la información de las compras y:
a. Almacene en otra estructura de datos las compras realizadas entre los años 2010 y 2020. Esta estructura debe quedar ordenada por el DNI del cliente.
b. Una vez almacenada la estructura del inciso a, procesar estos datos e informar:
1. El año con menor facturación.
2. Los dos DNI de los clientes que realizaron mayor cantidad de compras.
3. COMPLETO: El monto total facturado de compras con código múltiplo de 10.}

program parcial;
const
    c_anioMax = 2024;
type
    rangoAnios = 1980..c_anioMax;
    recCompra = record
        codigo: integer;
        anio: rangoAnios;
        monto: real;
        dni: integer;
    end;

    listaCompras = ^nodo;
    nodo = record
        dato: recCompra;
        sig: listaCompras;
    end;

    vecAnios = array[2010..2020] of real;

function Cumple(anio: rangoAnios): boolean;
begin
    Cumple := (anio >= 2010) and (anio <= 2020); // (2010 =< anio >= 2020)
end;

procedure InsertarOrdenado(c: recCompra; var LN: listaCompras);
var
    act, ant, nue: listaCompras; 
begin
    new(nue);
    nue^.dato := c;
    act := LN;
    while (act <> nil) and (c.dni < act^.dato.dni) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = nil) then
        LN := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure CargarListaNueva(LC: listaCompras; var LN: listaCompras);
var
begin
    while (LC <> nil) do begin
        if (Cumple(LC^.dato.anio)) then
            InsertarOrdenado(LC^.dato, LN);
        LC := LC^.sig;
    end;
end;

procedure InicializarVA(var vA: vecAnios);
var
    i: integer;
begin
    for i := 2010 to 2020 do
        vA[i] := 0;
end;

procedure CargarVA(monto: real; anio: integer; var vA: vecAnios);
begin
    vA[anio] := vA[anio] + monto;
end;

procedure MaxMonto(var maxDni1, maxDni2: integer; var maxCompras1, maxCompras2: integer; dni, cantComprasCliente: integer);
begin
    if (cantComprasCliente > maxCompras1) then begin
        maxCompras2 := maxCompras1;
        maxDni2 := maxDni1;
        maxCompras1 := cantComprasCliente;
        maxDni1 := dni;
    end
    else begin
        if (cantComprasCliente > maxCompras2) then begin
            maxCompras2 := cantComprasCliente;
            maxDni2 := dni;
        end;
    end;
end;

function CumpleMult10(codigo: integer): boolean;
begin
    CumpleMult10 := ((codigo MOD 10) = 0);
end;

procedure AnioMin(var anioMin: integer: var montoAnioMin: real; anio: integer; monto: real);
begin
    if (monto < montoAnioMin) then
        montoAnioMin := monto;
        anioMin := anio;
    end;
end;

procedure RecorrerVA(vA: vecAnios, var anioMin);
var
    i: integer;
begin
    for i := 2010 to 2020 do begin
        AnioMin(anioMin, montoAnioMin, i, vA[i]);
end;

procedure RecorrerListaNueva(LN: listaCompras; var vA: vecAnios; var maxDni1, maxDni2: integer; var maxCompras1, maxCompras2: integer);
var
    dniActual: integer;
    cantComprasCliente: integer;
begin

    while (LN <> nil) do begin
        CargarVA(LN^.dato.monto, LN^.dato.anio, vA); // vA[LN^.dato.anio] := vA[LN^.dato.anio] + LN^.dato.monto;
        dniActual := LN^.dato.dni; 
        cantComprasCliente := 0;
        while (LN <> nil) and (dniActual = LN^.dato.dni) do begin // Corte de control.
            cantComprasCliente := cantComprasCliente + 1; // b.
            if CumpleMult10(LN^.dato.codigo) then // c.
                montoMultiplo10 := montoMultiplo10 + LN^.dato.monto;
        end;
        MaxMonto(maxDni1, maxDni2, maxCompras1, maxCompras2, LN^.dato.dni, cantComprasCliente);
        LN := LN^.sig;
    end;
end;

// programa principal.
var
    LC: listaCompras;
    LN: listaCompras;
    vA: vecAnios;
    maxDni1, maxDni2: integer;
    maxCompras1, maxCompras2, integer;
    montoMultiplo10: real;
    anioMin: integer;
    montoAnioMin: real;
begin
    LC := nil;
    CargarListaCompras(LC); // Se dispone.

    LN := nil;
    montoMultiplo10 := 0;
    montoAnioMin := maxInt;
    maxCompras1 := -1;
    CargarListaNueva(LC, LN); // Inciso a.
    InicializarVA(vA);

    RecorrerListaNueva(LN, vA, maxDni1, maxDni2, maxCompras1, maxCompras2);
    RecorrerVA(vA, anioMin, montoAnioMin);
    writeln('El año con menor facturación es: ', anioMin);
    writeln('DNIs de los clientes con mayor cantidad de compras: ', maxDni1, ' y ', maxDni2);
    writeln('Monto compras con código múltiplo de 10: ', comprasCodMult10);
end.