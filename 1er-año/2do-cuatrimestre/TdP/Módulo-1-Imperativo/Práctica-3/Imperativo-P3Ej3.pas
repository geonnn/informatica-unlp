{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de Informática y los almacene en una estructura de datos. La información que se lee es legajo, código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program Ej3;

type

    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: 2020..2024;
    end;

    recFinales = record
        legajo: integer;
        codMateria: integer;
        fecha: recFecha;
        nota: real;
    end;
