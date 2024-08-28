{8. Dado el siguiente programa:
a. La función analizarLetra fue declarada como un submódulo dentro del procedimiento leer, pero esto
puede traer problemas en el código del programa principal.
i) ¿Qué clase de problema encuentra?
ii) ¿Cómo se puede resolver el problema para que el programa compile y funcione correctamente?
b. La función analizarLetra parece incompleta, ya que no cubre algunos valores posibles de la variable
letra.
i) ¿De qué valores se trata?
ii) ¿Qué sucede en nuestro programa si se ingresa uno de estos valores?
iii) ¿Cómo se puede resolver este problema?}

program anidamientos;
procedure leer;
var
    letra: char;

    function analizarLetra: boolean;
    begin
        if (letra >= 'a') and (letra <= 'z') then
            analizarLetra := true;
        else
        if (letra >= 'A') and (letra <= 'Z') then
            analizarletra := false;
    end; { fin de la funcion analizarLetra }

begin
    readln(letra);
    if (analizarLetra) then
        writeln('Se trata de una minúscula')
    else
        writeln('Se trata de una mayúscula');
end; { fin del procedure leer}

var
    ok: boolean;
begin { programa principal }
    leer;
    ok := analizarLetra;
    if ok then
        writeln('Gracias, vuelva prontosss');
end.