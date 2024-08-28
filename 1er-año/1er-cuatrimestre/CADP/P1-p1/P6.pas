{6. Realizar un programa que lea el número de legajo y el promedio de cada alumno de la facultad. La lectura
finaliza cuando se ingresa el legajo -1, que no debe procesarse. Por ejemplo: se lee la siguiente secuencia:
33423
8.40
19003
6.43
-1
En el ejemplo anterior, se leyó el legajo 33422, cuyo promedio fue 8.40, luego se leyó el legajo 19003, cuyo
promedio fue 6.43, y finalmente el legajo -1 (para el cual no es necesario leer un promedio).
Al finalizar la lectura, informar:
a. La cantidad de alumnos leída (en el ejemplo anterior, se debería informar 2).
b. La cantidad de alumnos cuyo promedio supera 6.5 (en el ejemplo anterior, se debería informar 1).
c. El porcentaje de alumnos destacados (alumnos con promedio mayor a 8.5) cuyo legajo sean menor
al valor 2500 (en el ejemplo anterior, se debería informar 0%).}

program P6;
var
    promedio, promReq, promDest, porcAlDest: real;
    legajo, cantAl, alPromReq, alPromDest: integer;
    
begin
    cantAl := 0;
    alPromReq := 0;
    alPromDest := 0;
    promReq := 6.50;
    promDest := 8.50;
    
    {Lee el primer legajo ingresado.
    Es necesario hacer este a parte para que se evalúe incialmente
    la condición y se reevalúe cuando se vuelve a ingresar
    el legajo dentro del while.}
    writeln ('Ingrese el legajo: ');
    read (legajo);
    
    while (legajo <> -1) do
        begin
            writeln ('Ingrese el promedio: ');
            read (promedio);
            
            cantAl := cantAl + 1;
            
            if (promedio > promReq) then
                alPromReq := alPromReq + 1;
                
            if (promedio > promDest) and (legajo < 2500) then
                alPromDest := alPromDest + 1;
                
            writeln ('Ingrese el legajo: ');
            read (legajo);
        end;
        
    {Porcentaje de alumnos con promedio destacado.}
    porcAlDest := (alPromDest * 100) / cantAl;
        
    writeln ('Se ingresaron ', cantAl, ' alumnos.');
    writeln (alPromReq, ' alumnos superan el promedio ', promReq:0:2, '.');
    writeln ('Un ', porcAlDest:0:2, '%', ' de los alumnos tienen promedio destacado (mayor a 8.50).');
end.