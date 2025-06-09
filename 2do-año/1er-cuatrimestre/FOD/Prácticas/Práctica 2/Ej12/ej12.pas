{12.  La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día, idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año, mes, día e idUsuario. Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato mostrado a continuación:

Año : --- 
    Mes:-- 1 
        día:-- 1 
            idUsuario 1   Tiempo Total de acceso en el dia 1 mes 1  
            --------                      
            idUsuario N    Tiempo total de acceso en el dia 1 mes 1  
        Tiempo total acceso dia 1 mes 1     
        ------------- 
        día N 
            idUsuario 1   Tiempo Total de acceso en el dia N mes 1  
            --------                      
            idUsuario N    Tiempo total de acceso en el dia N mes 1  
        Tiempo total acceso dia N mes 1 
    Total tiempo de acceso mes 1 
    ------
    Mes 12 
        día 1 
            idUsuario 1   Tiempo Total de acceso en el dia 1 mes 12  
            --------                      
            idUsuario N    Tiempo total de acceso en el dia 1 mes 12  
        Tiempo total acceso dia 1 mes 12    
        -------------
        día N
            idUsuario 1   Tiempo Total de acceso en el dia N mes 12  
            --------                      
            idUsuario N    Tiempo total de acceso en el dia N mes 12  
        Tiempo total acceso dia N mes 12
    Tiempo total acceso mes 12
Tiempo total acceso año

Se deberá tener en cuenta las siguientes aclaraciones: 
●  El año sobre el cual realizará el informe de accesos debe leerse desde el teclado. 
●  El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no encontrado”. 
●  Debe definir las estructuras de datos necesarias.  
●  El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria.}

program ej12;

const
    VALOR_ALTO = maxInt;

type
    recFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

    recAcceso = record
        fecha: recFecha;
        idUsuario: integer;
        tiempoAcceso: real;
    end;

    maestro = file of recAcceso;

procedure Leer(var mae: maestro; var a: recAcceso);
begin
    if (not EOF(mae)) then
        read(mae, a)
    else
        a.fecha.anio := VALOR_ALTO;
end;

procedure ProcesarAccesos(var mae: maestro; anioInput: integer);
var
    a: recAcceso;
    mesAct, diaAct, idAct: integer;
    tiempoTotalAnio, tiempoTotalMes, tiempoTotalDia, tiempoUsuario: real;
    encontrado: boolean;

begin
    encontrado := false;
    tiempoTotalAnio := 0;

    Leer(mae, a);
    while (a.fecha.anio <> VALOR_ALTO) do begin

        while (anioInput > a.fecha.anio) do
            Leer(mae, a);

        // sale del último while porque se encontró el año o porque no existe, entonces:
        if (a.fecha.anio = anioInput) then
            encontrado := true
        else
            break;

        writeln('Año ', anioInput, ': ');
        while (anioInput = a.fecha.anio) do begin
            mesAct := a.fecha.mes;
            tiempoTotalMes := 0;

            writeln('    Mes ', mesAct, ': ');

            while (anioInput = a.fecha.anio) and (mesAct = a.fecha.mes) do begin
                diaAct := a.fecha.dia;
                tiempoTotalDia := 0;

                writeln('        Día ', diaAct, ': ');

                while (anioInput = a.fecha.anio) and
                      (mesAct = a.fecha.mes) and
                      (diaAct = a.fecha.dia) do begin

                    idAct := a.idUsuario;
                    tiempoUsuario := 0;
                
                    while (anioInput = a.fecha.anio) and
                          (mesAct = a.fecha.mes) and
                          (diaAct = a.fecha.dia) and
                          (idAct = a.idUsuario) do begin

                        tiempoUsuario := tiempoUsuario + a.tiempoAcceso;
                        Leer(mae, a);
                    end;

                    tiempoTotalDia := tiempoTotalDia + tiempoUsuario;

                    write('            idUsuario ', idAct, ' | ');
                    writeln('T de acceso: ', tiempoUsuario:0:2);

                end;

                tiempoTotalMes := tiempoTotalMes + tiempoTotalDia;

                writeln('        T de acceso dia ', diaAct, ': ', tiempoTotalDia:0:2);

            end;

            tiempoTotalAnio := tiempoTotalAnio + tiempoTotalMes;

            writeln('    T de acceso mes ', mesAct, ': ', tiempoTotalMes:0:2);
        end;

        writeln('    T de acceso año ', anioInput, ': ', tiempoTotalAnio:0:2);

    end;
    if (not encontrado) then
        writeln('Año no encontrado.');
end;

var
    mae: maestro;
    anioInput: integer;
begin
    assign(mae, 'maestro.dat');
    reset(mae);

    writeln('Ingrese año sobre el cual realizar el informe: ');
    readln(anioInput);

    ProcesarAccesos(mae, anioInput);

    close(mae);
end.