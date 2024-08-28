{6. Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.), cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con 0 cores (que no debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa importadora e informe:
● Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.
● Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
● Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de al menos 2 Ghz.}

program Ej6;
type
    recProces = record
        marca = string;
        linea = string;
        nucleos = integer;
        clk = real;
        tamTransistores = integer;
    end;

procedure LeerProce(var p: recProces);
begin
    writeln('Ingrese cantidad de núcleos del procesador: ');
    readln(p.nucleos);
    if (p.nucleos = 0) then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese la marca del procesador: ');
        readln(p.marca);
        writeln('Ingrese la línea del procesador: ');
        readln(p.linea);
        writeln('Ingrese la velocidad de reloj del procesador: ');
        readln(p.clk);
        writeln('Ingrese el tamaño de los transistores del procesador (nm): ');
        readln(p.tamTransistores);
    end;
end;