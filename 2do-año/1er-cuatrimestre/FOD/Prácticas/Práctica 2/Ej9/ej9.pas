{9.  Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los  diferentes  clientes.  Se  necesita  obtener  un  reporte  con  las  ventas  organizadas  por cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la empresa.  
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes. 
Nota:  tenga  en  cuenta  que  puede  haber  meses  en  los  que  los  clientes  no  realizaron compras. No es necesario que informe tales meses en el reporte.}

program ej9;

const
    VALOR_ALTO = maxInt;

type

    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recCliente = record
        codCliente: integer;
        nom: string;
        ap: string;
    end;

    recVenta = record
        cliente: recCliente;
        fecha: recFecha;
        monto: real;
    end;

    ventas = file of recVenta;

procedure Leer(var mae: ventas; var v: recVenta);
begin
    if (not EOF(mae)) then
        read(mae, v)
    else
        v.cliente.codCliente := VALOR_ALTO;
end;

procedure ProcesarVentas(var mae: ventas);
var
    v: recVenta;
    codClienteAct, anioActual, mesActual: integer;
    montoAnualCliente, montoMensualCliente, montoTotalEmpresa: real;
begin
    montoTotalEmpresa := 0;

    Leer(mae, v);
    while (v.cliente.codCliente <> VALOR_ALTO) do begin
        codClienteAct := v.cliente.codCliente;

        writeln('Cliente código ', codClienteAct, ': ', v.cliente.nom, ' ', v.cliente.ap, '.');

        while (codClienteAct = v.cliente.codCliente) do begin
            anioActual := v.fecha.anio;
            montoAnualCliente := 0;

            writeln('  Año ', anioActual, ':');

            while (codClienteAct = v.cliente.codCliente) and (anioActual = v.fecha.anio) do begin
                mesActual := v.fecha.mes;
                montoMensualCliente := 0;

                while (codClienteAct = v.cliente.codCliente) and (anioActual = v.fecha.anio) and (mesActual = v.fecha.mes) do begin
                    montoMensualCliente := montoMensualCliente + v.monto;
                    Leer(mae, v);
                end;

                writeln('   Mes ', mesActual:2, ': $', montoMensualCliente:0:2, '.');
                montoAnualCliente := montoAnualCliente + montoMensualCliente;
            end;

            writeln('Total año ', anioActual, ': $', montoAnualCliente:0:2, '.');
            montoTotalEmpresa := montoTotalEmpresa + montoAnualCliente;
        end;

        writeln;
        writeln('-------------------- FIN CLIENTE --------------------');
        writeln;
    end;

    writeln('Monto total obtenido por la empresa: $', montoTotalEmpresa:0:2, '.');
end;

var
    mae: ventas;
begin
    assign(mae, 'maestro.dat');
    reset(mae);

    ProcesarVentas(mae);

    close(mae);
end.
