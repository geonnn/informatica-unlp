{TEMA 1-CADP 2024
29/6/2024
Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con todas las compras, sin ningún orden en particular. De cada compra se conoce código, mes, año (entre 2014 y 2024), monto y el DNI del cliente. Un cliente puede haber realizado más de una compra.
Realizar un programa lea de teclado un año y luego:
a. Almacene en otra estructura de datos las compras realizadas en el año leído. Esta estructura debe quedar ordenada por DNI del cliente.
b. Una vez almacenada la información, procese los datos del inciso a. e informe:
1. Para cada cliente, el monto total facturado entre todas sus compras.
2. Los dos meses con menor facturación.
3. COMPLETO: La cantidad de compras con código múltiplo de 10.}

program parcial;
type
    rangoMeses = 1..12;
    rangoAnios = 2014..2024;
    recCompras = record
        cod: integer;
        mes: rangoMeses;
        anio: rangoAnios;
        monto: real;
        dni: Int64;
    end;

    listaCompras = ^nodo; // Se dispone.
    nodo = record;
        dato: recCompras;
        sig: listaCompras;
    end;

    listaOrdenada = ^nodo;
    vecMontoMeses = array[rangoMeses] of real;

procedure InsertarOrdenado(c: recCompras; var LO: listaOrdenada);
var
    nue, ant, act: listaOrdenada;
begin
    new(nue);
    nue^.dato := c;
    act := LO;
    while (act <> nil) and (act^.dato.dni < c.dni) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = nil) then
        LO := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

function Cumple(anioInput: rangoAnios, anioAlmacenado: rangoAnios): boolean;
begin
    Cumple := (anioInput = anioAlmacenado);
end;

procedure RecorrerListaCompras(anio: rangoAnios; L: listaCompras; var LO: listaOrdenada);
var
begin
    while (L <> nil) do begin
        if (Cumple(anio, L^.dato.anio)) then
            InsertarOrdenado(L^.dato, LO);
        L := L^.sig;
    end;
end;

procedure MinMeses(vMM: vecMontoMeses; var mesMin1, mesMin2: rangoMeses; var montoMin1, montoMin2: real);
var
    i: integer;
begin
    for i := 1 to 12 do begin
        if (vMM[i] < montoMin1) then begin
            montoMin2 := montoMin1;
            mesMin2 := mesMin1;
            montoMin1 := vMM[i];
            mesMin1 := i;
        end
        else begin
            if (vMM[i] < montoMin2) then begin
                montoMin2 := vMM[i];
                mesMin2 := i;
            end;
        end;
    end;
end;

procedure InicializarVMM(var vMM: vecMontoMeses);
var
    i: integer;
begin
    for i := 1 to 12 do
        vMM[i] := 0;
end;

procedure CargarVMM(monto: real; mes: rangoMeses; var vMM: vecMontoMeses);
begin
    vMM[mes] := vMM[mes] + monto;
end;

function CumpleMult10(cod: integer): boolean;
begin
    CumpleMult10 := ((cod MOD 10) = 0);
end;

procedure RecorrerListaOrdenada(LO: listaOrdenada; var vMM: vecMontoMeses; var comprasCodMult10: integer;);
var
    dniActual: Int64;
    montoCliente: real;
begin
    while (LO <> nil) do begin
        montoCliente := 0;
        dniActual := LO^.dato.dni;
        while (LO <> nil) and (LO^.dato.dni = dniActual) do begin
            montoCliente := montoCliente + LO^.dato.monto;
            CargarVMM(LO^.dato.monto, LO^.dato.mes, vMM);
            if (CumpleMult10(LO^.dato.cod)) then
                comprasCodMult10 := comprasCodMult10 + 1;
            LO := LO^.sig;
        end;
        writeln('Cliente DNI ', dniActual, '. Monto: $', montoCliente, '.'); // Inciso b1.
    end;
end;

// Programa principal
var
    L: listaCompras;
    LO: listaOrdenada;
    vMM: vecMontoMeses;
    anio: rangoAnios; // 2014..2024
    mesMin1, mesMin2: rangoMeses; // 1..12
    montoMin1, montoMin2: real;
    comprasCodMult10: integer;
begin
    L := nil;
    CargarListaCompras(L); // Se dispone.

    LO := nil;
    InicializarVMM(vMM);
    montoMin1 := maxInt;
    comprasCodMult10 := 0;

    read(anio);
    RecorrerListaCompras(anio, L, LO); // Inciso a.

    RecorrerListaOrdenada(LO, vMM, comprasCodMult10);
    MinMeses(vMM, mesMin1, mesMin2, montoMin1, montoMin2);
    writeln('Meses con menor facturación: ', mesMin1, ' y ', mesMin2, '.'); // Inciso b2.
    writeln('Compras con código múltiplo de 10: ', comprasCodMult10, '.'); // Inciso b3.
end.