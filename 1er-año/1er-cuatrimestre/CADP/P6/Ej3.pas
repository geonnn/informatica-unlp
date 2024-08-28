{3. Utilizando el programa del ejercicio 1, realizar los siguientes cambios:
a. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que fueron ingresados (agregar atrás).
b. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que fueron ingresados, manteniendo un puntero al último ingresado.}

Program JugamosConListas;
Type 
    lista = ^nodo;
    nodo = record
        num: integer;
        sig: lista;
    End;

// Original:    
{Procedure armarNodo(var L: lista; v: integer);
Var 
    aux: lista;
Begin
    new(aux);
    aux^.num := v;
    aux^.sig := L;
    L := aux;
End;}

// Agregar atrás.
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
    valor, X: integer;
Begin
    pri := nil;
    writeln('Ingrese un número');
    read(valor);
    While (valor <> 0) do begin
        agregarAtras(pri, ult, valor);
        writeln('Ingrese un número');
        read(valor);
    End;
    imprimirLista(pri); { imprimir lista }
    writeln('Ingrese un valor para incrementar la lista: ');
    read(X);
    incrementarLista(pri, X); { incrementar lista }
    imprimirLista(pri); { imprimir lista }
End.
