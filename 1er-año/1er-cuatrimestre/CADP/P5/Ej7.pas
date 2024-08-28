{7. Se desea almacenar en memoria una secuencia de 2500 nombres de ciudades, cada nombre podrá tener una longitud máxima de 50 caracteres.
a. Definir una estructura de datos estática que permita guardar la información leída. Calcular el tamaño de memoria que requiere la estructura.
b. Dado que un compilador de Pascal típico no permite manejar estructuras de datos estáticas que superen los 64 Kb, pensar en utilizar un vector de punteros a palabras, como se indica en la siguiente estructura:
    
Type Nombre =   String[50];
    Puntero =   ^Nombre;
    ArrPunteros =   array[1..2500] Of Puntero;

Var 
    Punteros:   ArrPunteros;

i) Indicar cuál es el tamaño de la variable Punteros al comenzar el programa.
ii) Escribir un módulo que permita reservar memoria para los 2500 nombres. ¿Cuál es la cantidad de memoria reservada después de ejecutar el módulo? ¿La misma corresponde a memoria estática o dinámica?
iii) Escribir un módulo para leer los nombres y almacenarlos en la estructura de la variable Punteros.}


// a.
{program Ej7a;
type
    str50 = string[50];
    ciudades = array[1..2500] of str50; // Ocupará 51 * 2500 = 127500.

var
    v: ciudades;
begin
    writeln(sizeof(v));
end.}


//b.
program Ej7b;
type
    nombre = string[50];
    puntero = ^nombre;
    arrPunteros = array[1..2500] of puntero; // i. 4 * 2500 = 10000.

// ii. 2500 punteros crean una dirección de memoria que reserva 51 bytes. 2500 * 51 = 127500 bytes de memoria dinámica. + 10000 bytes de memoria estática por el vector de punteros. Total = 137500 bytes.
procedure ReservarMemoria(var vP: arrPunteros);
var
    i: integer;
begin
    for i := 1 to 2500 do
        new(vP[i]);
    // writeln(sizeof(vP[i]^));
end;

// iii.
procedure CargarNombres(vP: arrPunteros);
var
    ciudad: nombre;
    i: integer;
begin
    for i := 1 to 2500 do begin
        readln(ciudad);
        vP[i]^ := ciudad;
    end;
end;

var
    vP: arrPunteros;

begin
    ReservarMemoria(vP);
    CargarNombres(vP);
end.