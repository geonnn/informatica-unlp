{8. Realizar un programa que lea tres caracteres, e informe si los tres eran letras vocales o si al menos uno de
ellos no lo era. Por ejemplo:
○ Si se leen los caracteres “a e o”, deberá informar: Los tres son vocales
○ Si se leen los caracteres “z a g”, deberá informar: Al menos un carácter no era vocal}

program P8;
var
    i, esV: integer;
    in1: char;

begin
    esV := 0;
    for i := 1 to 3 do begin
        writeln('Ingrese un carácter: ');
        readln(in1);
            if (in1 = 'a') or (in1 = 'e') or (in1 = 'i') or (in1 = 'o') or (in1 = 'u') then
                esV := esV + 1
    end;
    if (esV = 3) then
        writeln('Los tres caracteres son vocales.')
    else
        writeln('Al menos un carácter no era vocal.')
end.