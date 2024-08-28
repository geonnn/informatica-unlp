{5.Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee: marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La información se ingresa ordenada por marca.
Se pide calcular e informar:
a.El precio promedio por marca.
b.Marca y modelo del auto más caro.}

program Ej5;
type
    recAuto = record
        marca: string;
        modelo: string;
        precio: real;
    end;

procedure LeerAuto(var a: recAuto);
begin
    writeln('');
    writeln('Ingrese la marca del auto: ');
    readln(a.marca);
    if (a.marca = 'ZZZ') then
        writeln('Carga finalizada.')
    else begin
        writeln('Ingrese el modelo del auto: ');
        readln(a.modelo);
        writeln('Ingrese el precio del auto: ');
        readln(a.precio);
    end;
end;

procedure Max(var precioMax: real; var marcaMax, modeloMax: string; a: recAuto);
begin
    if (a.precio > precioMax) then begin
        precioMax := a.precio;
        marcaMax := a.marca;
        modeloMax := a.modelo;
    end;
end;

var
    a: recAuto;
    marcaAct, marcaMax, modeloMax: string;
    precioTot, precioMax: real;
    cantAct: integer;
begin
    LeerAuto(a);
    precioMax := -maxInt;
    while (a.marca <> 'ZZZ') do begin
        marcaAct := a.marca;
        precioTot := 0;
        cantAct := 0;
        while (a.marca <> 'ZZZ') and (marcaAct = a.marca) do begin
            precioTot := precioTot + a.precio;
            cantAct := cantAct + 1;
            Max(precioMax, marcaMax, modeloMax, a);
            LeerAuto(a);
        end;
        writeln('Precio promedio marca ', marcaAct, ': ', (precioTot / cantAct):0:2, '.');
    end;
    writeln('El auto más caro es un ', marcaMax, ' ', modeloMax, '.');
end.