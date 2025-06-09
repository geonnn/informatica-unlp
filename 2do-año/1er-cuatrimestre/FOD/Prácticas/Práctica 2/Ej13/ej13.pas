{13. Suponga que usted es administrador de un servidor de correo electrónico. En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) que se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el servidor de correo genera un archivo con la siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.

    a. Realice el procedimiento necesario para actualizar la información del log en un día particular. Defina las estructuras de datos que utilice su procedimiento.

    b. Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:

        nro_usuarioX..............cantidadMensajesEnviados
        .............
        nro_usuarioX+n...........cantidadMensajesEnviados
    
    Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en el sistema. Considere la implementación de esta opción de las siguientes maneras:

    i- Como un procedimiento separado del punto a).
    ii- En el mismo procedimiento de actualización del punto a). Qué cambios se requieren en el procedimiento del punto a) para realizar el informe en el mismo recorrido?}

program ej13;

const
    VALOR_ALTO = maxInt;

type

    recLog = record
        nro_usuario: integer;
        nombreUsuario: string;
        nombre: string;
        apellido: string;
        cantEmailEnviados: integer;
    end;

    recDiario = record
        nro_usuario: integer;
        cuentaDestino: integer;
        cuerpoMensaje: string;
    end;

    maestro = file of recLog;
    detalle = file of recDiario;

procedure Leer(var det: detalle; var d: recDiario);
begin
    if (not EOF(det)) then
        read(det, d)
    else
        d.nro_usuario := VALOR_ALTO;
end;

procedure ProcesarDetDiario(var mae: maestro; var det: detalle);
var
    d: recDiario;
    recM: recLog;
    cantEmailsUsuario: integer;
begin
    Leer(det, d);
    // Verificar fin de archivo de detalle con valor alto.
    while (d.nro_usuario <> VALOR_ALTO) do begin
        read(mae, recM);
        // Todo lo que está en el detalle existe en el maestro y los dos archivos están ordenados por usuario. Se recorre el maestro hasta encontrar el primer usuario leído en el detalle.
        while (recM.nro_usuario <> d.nro_usuario) do
            read(mae, recM);
        
        // Mientras se siga con el mismo usuario, se acumulan los emails.
        cantEmailsUsuario := 0;
        while (recM.nro_usuario = d.nro_usuario) do begin
            cantEmailsUsuario := cantEmailsUsuario + 1;
            Leer(det, d);
        end;

        // Actualizar maestro
        recM.cantEmailEnviados := recM.cantEmailEnviados + cantEmailsUsuario;
        seek(mae, FilePos(mae)-1);
        write(mae, recM);
    end;
end;

procedure GenerarListado(var mae: maestro);
var
    archivo_txt: Text;
    recM: recLog;
begin
    assign(archivo_txt, 'listado.txt');
    rewrite(archivo_txt);

    while (not EOF(mae)) do begin
        read(mae, recM);

        writeln(archivo_txt, 'Usuario n ', recM.nro_usuario, ': ', recM.cantEmailEnviados, ' emails enviados.');
    end;

    close(archivo_txt);
end;

procedure ProcesarDetDiarioYListar(var mae: maestro; var det: detalle);
var
    d: recDiario;
    recM: recLog;
    cantEmailsUsuario: integer;
    archivo_txt: Text;
begin
    assign(archivo_txt, 'listado.txt');
    rewrite(archivo_txt);

    // Para actualizar y listar en el mismo proceso hay que recorrer completamente el maestro en vez del detalle como en el otro proceso.
    Leer(det, d);
    while (not EOF(mae)) do begin
        read(mae, recM);
        // Si el usuario en el maestro coincide con el usuario que se leyó del detalle se actualiza el maestro. Un usuario que se lee del detalle eventualmente siempre va a coincidir con el mismo que se lee del archivo maestro.
        if (recM.nro_usuario = d.nro_usuario) then begin
            cantEmailsUsuario := 0;
            // Mientras se siga con el mismo usuario, se acumulan los emails.
            while (recM.nro_usuario = d.nro_usuario) do begin
                cantEmailsUsuario := cantEmailsUsuario + 1;
                Leer(det, d);
            end;
            // Actualizar maestro
            recM.cantEmailEnviados := recM.cantEmailEnviados + cantEmailsUsuario;
            seek(mae, FilePos(mae)-1);
            write(mae, recM);
        end;
        // Se escribe el usuario en el txt, haya sido actualizado o no.
        writeln(archivo_txt, 'Usuario n ', recM.nro_usuario, ': ', recM.cantEmailEnviados, ' emails enviados.');
    end;
    close(archivo_txt);
end;

var
    mae: maestro;
    det: detalle;
begin
    assign(mae, 'var\\log\\logmail.dat');
    assign(det, 'detalle.dat');

    reset(mae);
    reset(det);

    // i)
    ProcesarDetDiario(mae, det);
    GenerarListado(mae);

    reset(mae);
    reset(det);
    // ii)
    ProcesarDetDiarioYListar(mae, det);

    close(mae);
    close(det);
end.