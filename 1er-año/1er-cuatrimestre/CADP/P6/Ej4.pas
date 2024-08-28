{4. Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
a. Máximo: recibe la lista como parámetro y retorna el elemento de valor máximo.
b. Mínimo: recibe la lista como parámetro y retorna el elemento de valor mínimo.
c. Múltiplos: recibe como parámetros la lista L y un valor entero A, y retorna la cantidad de elementos de la lista que son múltiplos de A.}

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

function Maximo(L: lista): integer;
begin
    Maximo := -maxInt;
    while (L <> nil) do begin
        if (L^.num > Maximo) then
            Maximo := L^.num;
        L := L^.sig;
    end;
end;

function Minimo(L: lista): integer;
begin
    Minimo := maxInt;
    while (L <> nil) do begin
        if (L^.num < Minimo) then
            Minimo := L^.num;
        L := L^.sig;
    end;
end;

function Multiplos(L: lista; A: integer): integer;
begin
    Multiplos := 0;
    while (L <> nil) do begin
        if ((L^.num MOD A) = 0) then
            Multiplos := Multiplos + 1;
        L := L^.sig;
    end;
end;

Var
    pri, ult: lista;
    valor, X: integer;
    valorMax, valorMin: integer;
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
    writeln('');
    writeln('Valor mínimo: ', Minimo(pri));
    writeln('Valor máximo: ', Maximo(pri));
    writeln('Ingrese un número para evaluar si hay múltiplos del mismo: ');
    readln(X);
    writeln('Cantidad de múltiplos: ', Multiplos(pri, X));
    writeln('');
    writeln('Ingrese un valor para incrementar la lista: ');
    read(X);
    incrementarLista(pri, X); { incrementar lista }
    imprimirLista(pri); { imprimir lista }
End.