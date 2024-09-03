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

Const
    dimF = 15;
    min = 10;
    max = 155;

Type vector = array[1..dimF] Of integer;


Procedure CargarVector(Var v: vector; Var dimL: integer);

Procedure CargarVectorRecursivo(Var v: vector; Var dimL: integer);

Var valor: integer;
Begin
    valor := min + random (max - min + 1);
    If ((valor <> 20) And (dimL < dimF)) Then Begin
        dimL := dimL + 1;
        v[dimL] := valor;
        CargarVectorRecursivo (v, dimL);
    End;
End;

Begin
    dimL := 0;
    CargarVectorRecursivo (v, dimL);
End;

Procedure ImprimirVector(v: vector; dimL: integer);

Var 
    i: integer;
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

Procedure ImprimirVectorRecursivo(v: vector; dimL: integer);
Begin
    if (dimL <> 0) then begin
        ImprimirVectorRecursivo(v, (dimL - 1));
        writeln(v[dimL]);
    end;
End;

Function SumarPares(v: vector; dimL: integer): integer;

Function SumarParesRecursivo(v: vector; pos, dimL: integer): integer;
Begin
    If (pos <= dimL) Then begin
        SumarParesRecursivo := SumarParesRecursivo (v, pos + 1, dimL);
        if ((v[pos] MOD 2) = 0) then
            SumarParesRecursivo := SumarParesRecursivo + v[pos]
    end
    Else
        SumarParesRecursivo := 0
End;

Var
    pos: integer;
Begin
    pos := 1;
    SumarPares := SumarParesRecursivo(v, pos, dimL);
End;

Function Sumar (v: vector; dimL: integer): integer;

Function SumarRecursivo (v: vector; pos, dimL: integer): integer;

Begin
    If (pos <= dimL) Then
        SumarRecursivo := SumarRecursivo (v, pos + 1, dimL) + v[pos]
    Else
        SumarRecursivo := 0
End;

Var
    pos: integer;
Begin
    pos := 1;
    Sumar := SumarRecursivo (v, pos, dimL);
End;

// Function ObtenerMaximo(v: vector; dimL: integer): integer;
// Begin
//     ObtenerMaximo := -999;
//     writeln('Maximo: ', ObtenerMaximo);
//     if (dimL <> 0) then begin
//         ObtenerMaximo := ObtenerMaximo(v, dimL - 1);
//         if (v[dimL] > ObtenerMaximo) then
//             ObtenerMaximo := v[dimL];
//     writeln('Maximo: ', ObtenerMaximo);
//     end;
// End;

Function ObtenerMaximo(v: vector; dimL: integer): integer;
var
    max: integer;
Begin
    if (dimL = 1) then
        ObtenerMaximo := v[dimL]
    else begin
        max := ObtenerMaximo(v, dimL - 1);
        if (v[dimL] > max) then
            ObtenerMaximo := v[dimL]
        else
            ObtenerMaximo := max;
    end;
End;

// Function BuscarValor(v: vector; dimL, valor: integer): boolean;
// Begin
//     BuscarValor := false;
//     if (dimL <> 0) and (BuscarValor = false) then begin
//         if (valor = v[dimL]) then
//             BuscarValor := true
//         else begin
//             BuscarValor := BuscarValor(v, dimL - 1, valor);
//         end;
//     end;
// End;

Function BuscarValor(v: vector; dimL, valor: integer): boolean;
Begin
    if (dimL = 0) then
        BuscarValor := false
    else
        if (v[dimL] = valor) then
            BuscarValor := true
        else
            BuscarValor := BuscarValor(v, dimL - 1, valor);
End;

// Procedure ImprimirDigitos(v: vector; dimL: integer);

// procedure Digitos(num: integer);
// begin
//     if ((num DIV 10) = 0) then
//         write(num, ' ')
//     else begin
//         Digitos(num DIV 10);
//         write(num MOD 10, ' ');
//     end;
// end;

// var
//     num: integer;
// Begin
//     if (dimL <> 0) then begin
//         ImprimirDigitos(v, (dimL - 1));
//         Digitos(v[dimL]);
//         write('| ');
//     end;
// End;

Procedure ImprimirDigitos(v: vector; dimL: integer);

procedure Digitos(num: integer);
begin
    if (num >= 10) then
        Digitos(num div 10);
    write(num MOD 10, ' ');
end;

Begin
    if (dimL <> 0) then begin
        ImprimirDigitos(v, (dimL - 1));
        Digitos(v[dimL]);
        write('| ');
    end;
End;

Var 
    dimL, suma, sumaPares, maximo, valor: integer;
    v: vector;
    encontre: boolean;
Begin
    randomize;
    CargarVector (v, dimL);
    writeln;
    If (dimL = 0) Then writeln ('--- Vector sin elementos ---')
    Else
        Begin
            ImprimirVector (v, dimL);
            writeln('Imprimir vector recursivo: ');
            ImprimirVectorRecursivo (v, dimL);
        End;
    writeln;
    writeln;
    suma := Sumar(v, dimL);
    sumaPares := SumarPares(v, dimL);
    writeln;
    writeln;
    writeln('La suma de los valores del vector es ', suma);
    writeln;
    writeln;
    writeln('La suma de los valores pares del vector es ', sumaPares);
    writeln;
    writeln;
    maximo := ObtenerMaximo(v, dimL);
    writeln;
    writeln;
    writeln('El máximo del vector es ', maximo);
    writeln;
    writeln;
    write ('Ingrese un valor a buscar: ');
    read (valor);
    encontre := BuscarValor(v, dimL, valor);
    writeln;
    writeln;
    If (encontre) Then writeln('El ', valor, ' está en el vector')
    Else writeln('El ', valor, ' NO está en el vector');

    writeln;
    writeln;
    ImprimirDigitos (v, dimL);
End.
