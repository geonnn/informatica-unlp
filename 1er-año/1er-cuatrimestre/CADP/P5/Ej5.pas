{5. De acuerdo a los valores de la tabla que indica la cantidad de bytes que ocupa la representación interna de cada tipo de dato en Pascal, calcular el tamaño de memoria en los puntos señalados a partir de(I), suponiendo que las variables del programa ya están declaradas y se cuenta con 400.000 bytes libres. Justificar mediante prueba de escritorio.}



Program Alocacion_Dinamica;
Type 
    TEmpleado = Record
        sucursal: char;
        apellido: string[25];
        correoElectrónico: string[40];
        sueldo: real;
    End;
    Str50 = string[50];

Var 
    alguien: TEmpleado;
    PtrEmpleado: ^TEmpleado;
Begin
{Suponer que en este punto se cuenta con 400.000 bytes de memoria disponible (I)}
    Readln( alguien.apellido );
{Pensar si la lectura anterior ha hecho variar la cantidad de memoria (II)}
    // No. Los campos del registro se encuentran en memoria estática y ya habían reservado su espacio.

    New( PtrEmpleado );
{¿Cuánta memoria disponible hay ahora? (III)}
    // Se crea una nueva dirección de memoria a la que apunta el puntero PtrEmpleado. Este puntero apunta al registro TEmpleado. Entonces se reservan en memoria dinámica: 1 + 26 + 41 + 4 = 72 bytes.

    Readln( PtrEmpleado^.Sucursal, PtrEmpleado^.apellido );
    Readln( PtrEmpleado^.correoElectrónico, PtrEmpleado^.sueldo );
{¿Cuánta memoria disponible hay ahora? (IV)}
    // La misma que antes. 400.000 - 72 bytes.

    Dispose( PtrEmpleado );
{¿Cuánta memoria disponible hay ahora? (V)}
    // 400.000 bytes.
End.
