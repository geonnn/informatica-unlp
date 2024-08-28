{8. Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
Informática de la UNLP en el año 2020. De cada alumno se lee: nro de inscripción, DNI, apellido,
nombre y año de nacimiento. Una vez leída y almacenada toda la información, calcular e informar:
a. El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.
b. Apellido y nombre de los dos alumnos de mayor edad.}

program Ej8;
const
    CANT_ALUMNOS = 2;
    ANIO_ACTUAL = 2020;
type
    str30 = string[30];
    alumnos = record
        nInsc: integer;
        DNI: integer;
        apellido: str30;
        nombre: str30;
        anioNac: integer;
    end;

    vecAl = array[1..CANT_ALUMNOS] of alumnos;

procedure Leer(var a: alumnos);
begin
    writeln('Ingrese el número de inscripción del alumno: ');
    readln(a.nInsc);
    writeln('Ingrese el DNI del alumno: ');
    readln(a.DNI);
    writeln('Ingrese el apellido del alumno: ');
    readln(a.apellido);
    writeln('Ingrese el nombre del alumno: ');
    readln(a.nombre);
    writeln('Ingrese el año de nacimiento del alumno: ');
    readln(a.anioNac);
end;

procedure DigParesDNI(DNI: integer; var aluDNIPar: integer);
var
    dig, cantDig, cantDigPares, num: integer;
begin
    num := DNI;
    cantDig := 0;
    cantDigPares := 0;
    while (num <> 0) do begin
        dig := num MOD 10;
        cantDig := cantDig + 1;
        if ((dig MOD 2) = 0) then
            cantDigPares := cantDigPares + 1;
        num := num DIV 10;
    end;
    if (cantDigPares = cantDig) then
        aluDNIPar := aluDNIPar + 1;

end;

procedure MaxEdad(anio: integer; apellido, nombre: str30; anioActual: integer; var edadMax1, edadMax2: integer; var apMax1, apMax2, nomMax1, nomMax2: str30);
var
    edad: integer;
begin
    edad := anioActual - anio;
    if (edad > edadMax1) then begin
        edadMax2 := edadMax1;
        apMax2 := apMax1;
        nomMax2 := nomMax1;

        edadMax1 := edad;
        apMax1 := apellido;
        nomMax1 := nombre;
    end
    else begin
        if (edad > edadMax2) then begin
            edadMax2 := edad;
            apMax2 := apellido;
            nomMax2 := nombre;
        end;
    end;
end;

var
    a: alumnos;
    i: integer;
    cantAluDNIPar: integer;
    edadMax1, edadMax2: integer;
    apMax1, apMax2, nomMax1, nomMax2: str30;
begin
    edadMax1 := -1;
    edadMax2 := -1;
    cantAluDNIPar := 0;
    for i := 1 to CANT_ALUMNOS do begin
        Leer(a);
        DigParesDNI(a.DNI, cantAluDNIPar);
        MaxEdad(a.anioNac, a.apellido, a.nombre, ANIO_ACTUAL, edadMax1, edadMax2, apMax1, apMax2, nomMax1, nomMax2);
    end;
    writeln('El porcentaje de alumnos con todos los dígitos pares en su DNI es: ', ((cantAluDNIPar * 100) / CANT_ALUMNOS):0:2, '%.');
    writeln('Los alumnos de mayor edad son: ');
    writeln(apMax1, ', ', nomMax1);
    writeln(apMax2, ', ', nomMax2);
end.