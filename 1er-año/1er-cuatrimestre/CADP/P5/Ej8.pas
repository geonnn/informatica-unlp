Program memoria;
Type 
    datos = array [1..20] Of integer;
    punt = ^datos;

Procedure procesarDatos(v: datos; Var v2: datos);
Var 
    i: integer;
Begin
    For i := 1 To 20 Do
        v2[21 - i] := v[i];
End;

Var 
    vect: datos;
    pvect: punt;
    i: integer;
Begin
    For i := 1 To 20 Do
        vect[i] := i;
    new(pvect);
    For i:= 20 Downto 1 Do
        pvect^[i] := 0;
    procesarDatos(pvect^, vect);
    writeln('fin');
End.

{8. Analice el siguiente programa: 

Responda:
¿cuánta memoria en total ocupa el programa al ejecutarse? Considere tanto variables estáticas como dinámicas, parámetros y variables locales de los módulos.
a. Hasta la sentencia de la línea 18.
    vect = 20 * 2 = 40 bytes.
    pvect = 4 bytes.
    i = 2 bytes.
    Total = 46 bytes.

b. Hasta la sentencia de la línea 20.
    Igual que antes.

c. Hasta la sentencia de la línea 23.
    + new(pvect) = 20 * 2 = 40 bytes.
    Total = 86 bytes.

d. Hasta la sentencia de la línea 11.
    var i (local del proceso) = 2 bytes.
    Pero hasta que no se escriba el proceso en el programa principal supongo que la memoria no se reserva así que:
    Total = 0 bytes.

e. Hasta la sentencia de la línea 25.
    + var i (local del proceso) = 2 bytes.
    Total = 88 bytes.
}