{2. Dado el siguiente programa, complete las líneas indicadas, considerando que:
a. El módulo cargarVector debe leer números reales y almacenarlos en el vector que se pasa como
parámetro. Al finalizar, debe retornar el vector y su dimensión lógica. La lectura finaliza cuando se ingresa el valor 0 (que no debe procesarse) o cuando el vector está completo.
b. El módulo modificarVectorySumar debe devolver el vector con todos sus elementos incrementados
con el valor n y también debe devolver la suma de todos los elementos del vector.}


Program Vectores;

Const 
    cant_datos = 150;

Type 
    vdatos = array[1..cant_datos] Of real;

Procedure cargarVector(Var v: vdatos; Var dimL: integer; num: real);
Begin
    dimL := dimL + 1;
    v[dimL] := num; { completar }
End;

Procedure modificarVectorySumar(Var v: vdatos; dimL: integer; n: real; Var suma: real);
Var 
    i: integer; { completar }
Begin
    { completar }
    for i := dimL downto 1 do begin
        v[i] := v[i] + n;
        suma := suma + v[i];
    end;
    
End;

{ programa principal }

Var 
    datos: vdatos;
    i, dim: integer;
    num, sumaTotal: real;
Begin
    dim := 0;
    sumaTotal := 0;

    { completar }
    readln(num);
    while (num <> 0) and (dim < cant_datos) do begin
        cargarVector(datos, dim, num);
        read(num);
    end;
    writeln('Ingrese un valor a sumar');
    readln(num);
    modificarVectorySumar(datos, dim, num, sumaTotal);{completar}
    writeln('La suma de los valores es: ', sumaTotal:0:2);
    writeln('Se procesaron: ',dim, ' números')
End.

