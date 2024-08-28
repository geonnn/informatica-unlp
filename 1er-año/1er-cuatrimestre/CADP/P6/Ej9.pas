{9. Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
a. EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o false en caso contrario.
b. Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si existe). Nota: la lista podría no estar ordenada.
c. Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista con todos los elementos de la lista L mayores que A y menores que B.
d. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de manera ascendente.
e. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de manera descendente.}

Program JugamosConListas;
Type 
    lista = ^nodo;
    nodo = record
        num: integer;
        sig: lista;
    End;

Procedure armarNodo(var L: lista; v: integer);
Var 
    aux: lista;
Begin
    new(aux);
    aux^.num := v;
    aux^.sig := L;
    L := aux;
End;

Procedure agregarAtras(var L, ult: lista; v: integer);
Var 
    aux: lista;
Begin
    new(aux);
    aux^.num := v;
    aux^.sig := nil;
    if (L = nil) then
        L := aux
    else
        ult^.sig := aux;
    ult := aux;
End;

Procedure armarNodoOrdenado(var L: lista; v: integer);
Var 
    nue, act, ant: lista;
Begin
    new(nue);
    nue^.num := v;
    act := L;
    ant := L;
    while (act <> nil) and (v > act^.num) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = ant) then begin
        L := nue;
    end
    else
        ant^.sig := nue;
    nue^.sig := act;
End;

function EstaOrdenada(L: lista): boolean;
begin
    EstaOrdenada := true;
    if (L <> NIL) then begin
        while (L^.sig <> nil) and EstaOrdenada do begin
            if (L^.num > L^.sig^.num) then
                EstaOrdenada := false;
            L := L^.sig;
        end;
    end
    else
        writeln('La lista está vacía o tiene un solo elemento.');
end;

// Para lista desordenada.
procedure Eliminar(var L: lista; v: integer);
var
    ant, act: lista;
begin
    ant := L;
    act := L;
    while ((act <> nil) and (act^.num <> v)) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act <> NIL) then begin // La lista no está vacía y encontré el elemento que buscaba para eliminar.
        if (act <> ant) then begin
            ant^.sig := act^.sig;
        end
        else
            L := L^.sig;
        dispose(act);
    end;
end;

// Para lista desordenada. Eliminar todas las ocurrencias.
procedure EliminarTodasLasOcurrencias(var L: lista; v: integer);
var
    ant, act: lista;
begin
    ant := L;
    act := L;
    while ((act <> nil) and (act^.num <> v)) do begin
        if (act <> ant) then begin
            ant^.sig := act^.sig;
        end
        else
            L := L^.sig;
        dispose(act);
        ant := act;
        act := act^.sig;
    end;
end;

// Para lista ordenada.
procedure EliminarOrdenado(var L: lista; v: integer);
var
    ant, act: lista;
begin
    ant := L;
    act := L;
    while ((act <> nil) and (act^.num < v)) do begin
        ant := act;
        act := act^.sig;
    end;
    if ((act <> NIL) and (act^.num = v)) then begin // La lista no está vacía y encontré el elemento que buscaba para eliminar o uno mayor al mismo. Por eso se pregunta también si el dato es igual al valor que se ingresó para eliminar.
        if (act <> ant) then begin
            ant^.sig := act^.sig;
        end
        else
            L := L^.sig;
        dispose(act);
    end;
end;

// Para lista ordenada. Eliminar todas las ocurrencias.
procedure EliminarOrdenadoTodasLasOcurrencias(var L: lista; v: integer);
var
    ant, act: lista;
begin
    ant := L;
    act := L;
    while (act <> nil) do begin
        if (act^.num = v) then begin // La lista no está vacía y encontré el elemento que buscaba para eliminar o uno mayor al mismo. Por eso se pregunta también si el dato es igual al valor que se ingresó para eliminar.
            if (act <> ant) then begin
                ant^.sig := act^.sig;
            end
            else
                L := L^.sig;
            dispose(act);
        end;
        ant := act;
        act := act^.sig;
    end;
end;

procedure imprimirLista(L: lista);
begin
    while (L <> nil) do begin
        writeln(L^.num);
        L := L^.sig;
    end;
end;

procedure incrementarLista(L: lista; X: integer);
begin
    while (L <> nil) do begin
        L^.num := (L^.num + X);
        L := L^.sig;
    end;
end;

Var 
    pri, ult: lista;
    valor: integer;
    X: integer;
Begin
    pri := nil;
    writeln('Ingrese un número');
    read(valor);
    While (valor <> 0) do begin
        // armarNodo(pri, valor);
        // armarNodoOrdenado(pri, valor);
        agregarAtras(pri, ult, valor);
        writeln('Ingrese un número');
        read(valor);
    End;
    imprimirLista(pri); { imprimir lista }
    writeln(EstaOrdenada(pri));
    //writeln('Ingrese un valor para incrementar la lista: ');
    //read(X);
    //incrementarLista(pri, X); { incrementar lista }
    // imprimirLista(pri); { imprimir lista }
End.