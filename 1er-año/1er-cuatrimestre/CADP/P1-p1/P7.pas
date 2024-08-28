{7. Realizar un programa que lea el código, el precio actual y el nuevo precio de los productos de un almacén.
La lectura finaliza al ingresar el producto con el código 32767, el cual debe procesarse. Para cada producto
leído, el programa deberá indicar si el nuevo precio del producto supera en un 10% al precio anterior.
Por ejemplo:
○ Si se ingresa el código 10382, con precio actual 40 y nuevo precio 44, deberá imprimir:
El aumento de precio del producto 10382 no supera el 10%
○ Si se ingresa el código 32767, con precio actual 30 y nuevo precio 33,01, deberá imprimir:
El aumento de precio del producto 32767 es superior al 10%”}

program P7;
var
    prAct, prNuevo, porcAum: real;
    codigo: integer;
    
begin

    codigo := 0;

    while (codigo <> 32767) do
        begin
        
            writeln ('Ingrese el código del producto: ');
            read (codigo);
            
            writeln ('Ingrese el precio actual del producto: ');
            read (prAct);
            
            writeln ('Ingrese el nuevo precio del producto: ');
            read (prNuevo);
            
            porcAum := ((prNuevo - prAct) * 100) / prAct;
            
            if (porcAum > 10) then
                writeln ('El aumento de precio del producto ', codigo, ' supera el 10% ', '(', porcAum:0:2, '%', ').')
            else
                writeln ('El aumento de precio del producto ', codigo, ' no supera el 10% ', '(', porcAum:0:2, '%', ').')
        end;
end.