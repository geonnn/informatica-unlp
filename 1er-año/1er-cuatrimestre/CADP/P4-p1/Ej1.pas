{1. Dado el siguiente programa:
a. ¿Qué valores toma la variable numeros al finalizar el primer bloque for?
b. Al terminar el programa, ¿con qué valores finaliza la variable números?
c. Si se desea cambiar la línea 11 por la sentencia:
for i:=1 to 9 do
¿Cómo debe modificarse el código para que la variable números contenga los mismos valores que
en 1.b?
d. Qué valores están contenidos en la variable numeros si la líneas 11 y 12 se reemplazan por:
for i:=1 to 9 do
numeros[i+1] := numeros[i];}

Program sumador;

Type 
    vnums = array [1..10] Of integer;

Var 
    numeros: vnums;
    i: integer;
Begin
    For i := 1 To 10 Do {primer bloque for}
        numeros[i] := i;
    For i := 1 To 9 Do {segundo bloque for}
        numeros[i] := numeros[i] + numeros [i-1];
    
    writeln(numeros[1]);
End.