{2. Realizar un programa que lea un número real e imprima su valor absoluto. El valor absoluto de un número
X, se escribe |X| y se define como:
|X| = X cuando X es mayor o igual a cero
|X| = -X cuando X es menor a cero}

program P2;
var
    numR: real;
    numI: integer;

begin

    writeln ('Ingrese un número:');
    read (numR);

    if (numR >= 0) then
        writeln ('El valor absoluto del número es |', numR:0:0, '|')
    else
        writeln ('El valor absoluto del número es |', (-1 * numR):0:0, '|')

end.