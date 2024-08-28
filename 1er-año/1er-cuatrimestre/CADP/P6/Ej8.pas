{8. Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la lista queden ordenados de manera ascendente (insertar ordenado).}

Program JugamosConListas;
Type 
    lista = ^nodo;
    nodo = record
        num: integer;
        sig: lista;
    End;

// Original.    
{Procedure armarNodo(var L: lista; v: integer);
Var 
    aux: lista;
Begin
    new(aux);
    aux^.num := v;
    aux^.sig := L;
    L := aux;
End;}

Procedure armarNodo(var L: lista; v: integer);
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
    pri: lista;
    valor: integer;
    X: integer;
Begin
    pri := nil;
    writeln('Ingrese un número');
    read(valor);
    While (valor <> 0) do begin
        armarNodo(pri, valor);
        writeln('Ingrese un número');
        read(valor);
    End;
    imprimirLista(pri); { imprimir lista }
    writeln('Ingrese un valor para incrementar la lista: ');
    read(X);
    incrementarLista(pri, X); { incrementar lista }
    imprimirLista(pri); { imprimir lista }
End.
