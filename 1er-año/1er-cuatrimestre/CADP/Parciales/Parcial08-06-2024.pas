{TEMA 2-CADP 2024
08/06/2024
Un fabricante de dispositivos electrónicos desea procesar información de los repuestos que compró. De cada repuesto conoce su código, precio, código de marca (entre 1 y 130) y nombre del país del que proviene. El fabricante dispone de una estructura de datos con la información de los repuestos, ordenados por nombre de pais.
Realizar un programa que:
a. Lea el código y el nombre de las 130 marcas con las que trabaja, y las almacene en una estructura de datos. La información se ingresa sin ningún orden en particular.
b. Una vez completada la carga, procese la información de los repuestos e informe:
1. La cantidad de países a los que se le compró más de 100 repuestos.
2. Para cada marca, nombre de la marca y el precio del producto más barato.
3. COMPLETO: La cantidad de repuestos que no poseen ningún cero en su código.
Implemente el programa principal que invoque a los módulos de los incisos a y b, e imprima los resultados.}

program Parcial;
const
    c_MaxMarca = 130;
type
    rangoMarca = 1..c_MaxMarca;
    str60 = string[60];
    recRepuestos = record
        codRep: integer;
        precio: real;
        codMarca: rangoMarca;
        pais: str60;
    end;

    listaRepuestos = ^nodo;
    nodo = record
        dato: recRepuestos;
        sig: listaRepuestos;
    end;

    recMarca = record
        nomM: str60;
        precioMin: real;
    end;

    vecMarca = array[rangoMarca] of recMarca;

procedure Mins(var vM: vecMarca; precio: real; cod: rangoMarca);
begin
    if (precio < vM[cod].precioMin) then
        vM[cod].precioMin := precio;
end;

function CumpleZ(cod: integer): boolean;
begin
    CumpleZ := true;
    while (cod <> 0) and CumpleZ do begin
        CumpleZ := (cod MOD 10) <> 0;
        cod := cod DIV 10;
    end;
end;

procedure CargarVectorMarca(var vM: vecMarca);
var
    codM, i: rangoMarca;
    nom: str60;
begin
    for i := 1 to c_MaxMarca do begin
        readln(codM);
        readln(nom);
        vM[codM].nomM := nom;
        vM[i].precioMin := maxInt;
    end;
end;

procedure RecorrerLista(var vM: vecMarca; var cantRepsNZ, cantPaises100R: integer; LR: listaRepuestos);
var
    cantRep: integer;
    paisAct: str60;
begin
    while (LR <> nil) do begin
        cantRep := 0;
        paisAct := LR^.dato.pais;
        while ((LR <> nil) and (paisAct = LR^.dato.pais)) do begin
            cantRep := cantRep + 1;
            Mins(vM, LR^.dato.precio, LR^.dato.codMarca);
            if (CumpleZ(LR^.dato.codRep)) then
                cantRepsNZ := cantRepsNZ + 1;
            LR := LR^.sig;
        end;
        if (cantRep > 100) then
            cantPaises100R := cantPaises100R + 1;
    end;
end;

procedure ImprimirVector(vM: vecMarca);
var
    i: rangoMarca;
begin
    for i:= 1 to c_MaxMarca do begin
        writeln(vM[i].nomM);
        writeln(vM[i].precioMin:0:2);
    end;
end;

procedure LeerRepuesto(var r: recRepuestos); // No considerar.
begin
    readln(r.codRep);
    if (r.codRep = -1) then
        writeln('Cf.')
    else begin
        readln(r.precio);
        readln(r.codMarca);
        readln(r.pais);
    end;
end;

procedure InsertarOrdenado(r: recRepuestos; var LR: listaRepuestos); // No considerar.
var
    act, ant, nue: listaRepuestos;
begin
    new(nue);
    nue^.dato := r;
    act := LR;
    while (act <> nil) and (LR^.dato.pais < r.pais) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = LR) then
        LR := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure CargarListaRepuestos(var LR: listaRepuestos); // No considerar. Se dispone.
var
    r: recRepuestos;
begin
    LeerRepuesto(r);
    while (r.codRep <> -1) do begin
        LeerRepuesto(r);
        InsertarOrdenado(r, LR);
    end;
end;

var
    LR: listaRepuestos;
    vM: vecMarca;
    cantPaises100R, cantRepsNZ: integer;
begin
    cantPaises100R := 0;
    cantRepsNZ := 0;
    LR := nil;
    CargarListaRepuestos(LR); // Se dispone.
    CargarVectorMarca(vM);

    RecorrerLista(vM, cantRepsNZ, cantPaises100R, LR);
    writeln('cantPaises100R: ', cantPaises100R);
    ImprimirVector(vM);
    writeln('cantRepsNZ: ', cantRepsNZ);
end.