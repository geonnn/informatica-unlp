{1. Dado el siguiente programa:
a. Indicar qué hace el programa.
b. Indicar cómo queda conformada la lista si se lee la siguiente secuencia de números: 10 21 13 48 0.
c. Implementar un módulo que imprima los números enteros guardados en la lista generada.
d. Implementar un módulo que reciba la lista y un valor, e incremente con ese valor cada dato de la lista.}

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