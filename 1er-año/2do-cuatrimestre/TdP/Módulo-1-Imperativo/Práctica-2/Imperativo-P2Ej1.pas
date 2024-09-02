{1.- Descargar el programa ImperativoEjercicioClase2.pas que contiene parte del código del siguiente enunciado a resolver. Implementar lo indicado en el código.
Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de a lo sumo 15 números enteros “random” mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con el valor 20.
b. Un módulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un módulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
e. Un módulo recursivo que reciba el vector generado en a) y devuelva el máximo valor del vector.
f. Un módulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
g. Un módulo que reciba el vector generado en a) e imprima, para cada número contenido en el vector, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 142, se debe imprimir 1 4 2.}

Program Clase2MI;

Const dimF = 15;
    min = 10;
    max = 155;

Type vector =   array [1..dimF] Of integer;


Procedure CargarVector (Var v: vector; Var dimL: integer);

Procedure CargarVectorRecursivo (Var v: vector; Var dimL: integer);

Var valor:   integer;
Begin
    valor := min + random (max - min + 1);
    If ((valor <> 20) And (dimL < dimF))
        Then
        Begin
            dimL := dimL + 1;
            v[dimL] := valor;
            CargarVectorRecursivo (v, dimL);
        End;
End;

Begin
    dimL := 0;
    CargarVectorRecursivo (v, dimL);
End;

Procedure ImprimirVector (v: vector; dimL: integer);

Var 
    i:   integer;
Begin
    For i:= 1 To dimL Do
        write ('----');
    writeln;
    write (' ');
    For i:= 1 To dimL Do
        Begin
            write(v[i], ' | ');
        End;
    writeln;
    For i:= 1 To dimL Do
        write ('----');
    writeln;
    writeln;
End;

Procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
Begin
     {-- Completar --}
End;

Function Sumar (v: vector; dimL: integer):   integer;

Function SumarRecursivo (v: vector; pos, dimL: integer):   integer;

Begin
    If (pos <= dimL)
        Then SumarRecursivo := SumarRecursivo (v, pos + 1, dimL) + v[pos]
    Else SumarRecursivo := 0
End;

Var pos:   integer;
Begin
    pos := 1;
    Sumar := SumarRecursivo (v, pos, dimL);
End;

Function  ObtenerMaximo (v: vector; dimL: integer):   integer;
Begin
  {-- Completar --}
End;

Function  BuscarValor (v: vector; dimL, valor: integer):   boolean;
Begin
  {-- Completar --}
End;

Procedure ImprimirDigitos (v: vector; dimL: integer);
Begin
     {-- Completar --}
End;

Var dimL, suma, maximo, valor:   integer;
    v:   vector;
    encontre:   boolean;
Begin
    CargarVector (v, dimL);
    writeln;
    If (dimL = 0) Then writeln ('--- Vector sin elementos ---')
    Else
        Begin
            ImprimirVector (v, dimL);
                     {  ImprimirVectorRecursivo (v, dimL);}
        End;
    writeln;
    writeln;
    suma := Sumar(v, dimL);
    writeln;
    writeln;
    writeln('La suma de los valores del vector es ', suma);
    writeln;
    writeln;
    maximo := ObtenerMaximo(v, dimL);
    writeln;
    writeln;
    writeln('El maximo del vector es ', maximo);
    writeln;
    writeln;
    write ('Ingrese un valor a buscar: ');
    read (valor);
    encontre := BuscarValor(v, dimL, valor);
    writeln;
    writeln;
    If (encontre) Then writeln('El ', valor, ' esta en el vector')
    Else writeln('El ', valor, ' no esta en el vector');

    writeln;
    writeln;
    ImprimirDigitos (v, dimL);
End.
