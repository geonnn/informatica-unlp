{8. Un local de ropa desea analizar las ventas realizadas en el último mes. Para ello se lee por cada día del mes,
los montos de las ventas realizadas. La lectura de montos para cada día finaliza cuando se lee el monto 0. Se
asume un mes de 31 días. Informar la cantidad de ventas por cada día, y el monto total acumulado en ventas
de todo el mes.
a. Modifique el ejercicio anterior para que además informe el día en el que se realizó la mayor cantidad
de ventas.}

program Ej8;
const
    DIAS_MES = 31;
var
    i: integer;
    cantVentas, valorVenta, totalVentasMes: integer;
    maxVentas, diaMaxVentas: integer;

begin

    totalVentasMes := 0;
    maxVentas := -1;

    // Loop principal. Se repite 31 veces para 31 días del mes. 
    for i := 1 to DIAS_MES do begin

        // Inicializar contador en 0.
        cantVentas := 0; // Adentro del loop porque este contador cuenta las ventas en un mismo día.

        // Texto para indicar qué ingresar por consola.
        writeln('///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
        writeln('Día ', i, '.');
        writeln('---------------------------------------------------------------------------------------------------------------------------------------');
        writeln('Ingrese el monto de la venta: ');
        readln(valorVenta);

        // Se lee la primera entrada afuera y la próxima al final del while. De esta manera no se procesa el 0 como una venta más.
        // Finaliza cuando se ingresa 0, indicando que ya no hay más ventas para registrar en el respectivo día.
        while (valorVenta <> 0) do begin
            cantVentas := cantVentas + 1;
            writeln('Ingrese el monto de la venta: ');
            readln(valorVenta);
        end;

        totalVentasMes := totalVentasMes + cantVentas;

        // If para establecer el día máximo de ventas.
        if (cantVentas > maxVentas) then begin
            maxVentas := cantVentas;
            diaMaxVentas := i;
        end;

        writeln('///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
        writeln('En el día ', i, ' se han efectuado ', cantVentas, ' ventas.');
        writeln('///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
    end;
    writeln('///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
    writeln('La totalidad de ventas de este mes es de ', totalVentasMes, ' ventas.' );
    writeln('El día ', diaMaxVentas, ' fue el día con mayor cantidad de ventas, con ', maxVentas, ' ventas.' );

end.