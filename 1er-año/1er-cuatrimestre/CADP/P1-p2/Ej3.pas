{3. Realizar un programa que lea desde teclado la información de alumnos ingresantes a la carrera Analista en
TIC. De cada alumno se lee nombre y nota obtenida en el módulo EPA (la nota es un número entre 1 y 10).
La lectura finaliza cuando se lee el nombre “Zidane Zinedine“, que debe procesarse. Al finalizar la lectura
informar:
● La cantidad de alumnos aprobados (nota 8 o mayor).
● La cantidad de alumnos que obtuvieron un 7 como nota.}

program Ej3;
type
    notas = 1..10; {Esto no funciona, o por lo menos no como quiero que funcione. En la variable nota se pueden ingresar números por fuera de este rango sin que de error.}
var
    nombre: string;
    nota: notas;
    nota8, nota7: integer;
begin
    nota7 := 0;
    nota8 := 0;
    repeat
        writeln('Ingrese nombre del alumno: ');
        read(nombre);
        writeln('Ingrese nota obtenida en EPA: ');
        read(nota);
        if (nota >= 8) then
            nota8 := nota8 + 1;
        if (nota = 7) then
            nota7 := nota7 + 1;
    until (nombre = 'Zinedine Zidane');
    writeln(nota8, ' alumnos sacaron 8 o más.');
    writeln(nota7, ' alumnos sacaron exactamente 7.');
end.