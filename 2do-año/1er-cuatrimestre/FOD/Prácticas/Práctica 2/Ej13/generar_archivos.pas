program generarDatosMail;

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

var
  mae: maestro;
  det: detalle;
  rLog: recLog;
  rDet: recDiario;

begin
  // Crear archivo maestro con 5 usuarios
  assign(mae, 'var\\log\\logmail.dat');
  rewrite(mae);

  rLog.nro_usuario := 1;
  rLog.nombreUsuario := 'jdoe';
  rLog.nombre := 'John';
  rLog.apellido := 'Doe';
  rLog.cantEmailEnviados := 3;
  write(mae, rLog);

  rLog.nro_usuario := 2;
  rLog.nombreUsuario := 'asmith';
  rLog.nombre := 'Alice';
  rLog.apellido := 'Smith';
  rLog.cantEmailEnviados := 5;
  write(mae, rLog);

  rLog.nro_usuario := 3;
  rLog.nombreUsuario := 'bwayne';
  rLog.nombre := 'Bruce';
  rLog.apellido := 'Wayne';
  rLog.cantEmailEnviados := 0;
  write(mae, rLog);

  rLog.nro_usuario := 4;
  rLog.nombreUsuario := 'ckent';
  rLog.nombre := 'Clark';
  rLog.apellido := 'Kent';
  rLog.cantEmailEnviados := 2;
  write(mae, rLog);

  rLog.nro_usuario := 5;
  rLog.nombreUsuario := 'dprince';
  rLog.nombre := 'Diana';
  rLog.apellido := 'Prince';
  rLog.cantEmailEnviados := 1;
  write(mae, rLog);

  close(mae);

  // Crear archivo detalle con correos enviados hoy
  assign(det, 'detalle.dat');
  rewrite(det);

  // Usuario 1 envió 2 mensajes
  rDet.nro_usuario := 1;
  rDet.cuentaDestino := 1001;
  rDet.cuerpoMensaje := 'Hola, ¿cómo estás?';
  write(det, rDet);
  rDet.cuentaDestino := 1002;
  rDet.cuerpoMensaje := 'Recordatorio de la reunión.';
  write(det, rDet);

  // Usuario 3 envió 1 mensaje
  rDet.nro_usuario := 3;
  rDet.cuentaDestino := 2001;
  rDet.cuerpoMensaje := '¡Buenos días!';
  write(det, rDet);

  // Usuario 4 envió 3 mensajes
  rDet.nro_usuario := 4;
  rDet.cuentaDestino := 3001;
  rDet.cuerpoMensaje := 'Informe semanal.';
  write(det, rDet);
  rDet.cuentaDestino := 3002;
  rDet.cuerpoMensaje := 'Agenda del día.';
  write(det, rDet);
  rDet.cuentaDestino := 3003;
  rDet.cuerpoMensaje := 'Recordatorio de pago.';
  write(det, rDet);

  close(det);

  writeln('Archivos maestro y detalle generados con éxito.');
end.
