{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente.
    ii. Informar los datos de los socios en orden decreciente.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.
}

Program ImperativoClase3;

type 
    rangoEdad = 12..100;
    cadena15 = string [15];
    socio = record
        numero: integer;
        nombre: cadena15;
        edad: rangoEdad;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: socio;
        HI: arbol;
        HD: arbol;
    end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

Procedure CargarSocio (var s: socio);
var vNombres: array[0..9] of string = ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 

begin
  s.numero := random(51) * 100;
  // s.numero := 0; // Forzar 0 para pruebas.
  If (s.numero <> 0) then begin
      s.nombre:= vNombres[random(10)];
      s.edad:= 12 + random (79);
  end;
end;  

Procedure InsertarElemento (var a: arbol; elem: socio);
Begin
  if (a = nil) then begin
    new(a);
    a^.dato:= elem; 
    a^.HI:= nil; 
    a^.HD:= nil;
  end
  else
    if (elem.numero < a^.dato.numero) then
      InsertarElemento(a^.HI, elem)
    else
      InsertarElemento(a^.HD, elem); 
End;

var unSocio: socio;  
Begin
  writeln;
  writeln ('<----- Ingreso de socios y armado del arbol ----->');
  writeln;
  a:= nil;
  CargarSocio (unSocio);
  while (unSocio.numero <> 0) do begin
    InsertarElemento (a, unSocio);
    CargarSocio (unSocio);
  end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		  InformarDatosSociosOrdenCreciente (a^.HI);
		  writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		  InformarDatosSociosOrdenCreciente (a^.HD);
	  end;		
  end;

Begin
  writeln;
  writeln ('<----- Socios en orden creciente por numero de socio ----->');
  writeln;
  InformarDatosSociosOrdenCreciente (a);
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarSociosOrdenDecreciente(a: arbol);

  procedure InformarDatosSociosOrdenDecreciente(a: arbol);
  begin
    if (a <> nil) then begin
      InformarDatosSociosOrdenDecreciente(a^.HD);
		  writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
      InformarDatosSociosOrdenDecreciente(a^.HI);
    end;
  end;

Begin
  writeln;
  writeln ('<----- Socios en orden decreciente por numero de socio ----->');
  writeln;
  InformarDatosSociosOrdenDecreciente(a);
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarExistenciaNombreSocio(a: arbol);
  
  function BuscarSocio(a: arbol; nom: cadena15): boolean;
  begin
    if (a <> nil) then begin
      if (a^.dato.nombre = nom) then
        BuscarSocio := true
      else
        BuscarSocio := BuscarSocio(a^.HI, nom) or BuscarSocio(a^.HD, nom);
    end
    else
      BuscarSocio := false; // CASO BASE: a = nil.
  end;

var
  nom: cadena15;
begin
  writeln;
  writeln ('<----- Buscar socio ----->');
  writeln;
  write('Ingrese nombre de socio para buscar: ');
  read(nom);
  writeln;
    if (BuscarSocio(a, nom)) then
      writeln('El socio ', nom, ' forma parte del club.')
    else
      writeln('El socio ', nom, ' NO forma parte del club.');
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarCantidadSocios(a: arbol);

  function ContarSocios(a: arbol): integer;
  begin
    if (a <> nil) then
      ContarSocios := ContarSocios(a^.HI) + ContarSocios(a^.HD) + 1
    else
      ContarSocios := 0; // Caso base. a = nil: la función devuelve 0, no hay socio para sumar.
  end;

begin
  writeln;
  writeln ('<----- Cantidad de socios ----->');
  writeln;
  writeln('Cantidad de socios: ', ContarSocios(a));
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarPromedioDeEdad(a: arbol); // La cantidad de socios para dividir el total de las edades se podría sacar del módulo anterior pero voy a hacer que este módulo directamente imprima el promedio como dice el ejercicio.

  procedure Promedio(a: arbol; var totalEdad, cant: integer);
  begin
    if (a <> nil) then begin
      Promedio(a^.HI, totalEdad, cant);
      totalEdad := totalEdad + a^.dato.edad;
      cant := cant + 1;
      Promedio(a^.HD, totalEdad, cant);
    end;
    // Caso base. a = nil: no hay que hacer nada.
  end;

var
  totalEdad: integer;
  cant: integer;
begin
  cant := 0;
  totalEdad := 0;
  writeln;
  writeln ('<----- Promedio de edad de los socios ----->');
  writeln;
  Promedio(a, totalEdad, cant);
  if (cant > 0) then
    writeln('Promedio: ', (totalEdad / cant):0:2)
  else
    writeln('Árbol sin elementos.');
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

  procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
  begin
	  if (nuevoValor >= maxValor) then begin
		  maxValor := nuevoValor;
		  maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	  if (a <> nil) then begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	  end; 
  end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) then
    writeln ('Arbol sin elementos')
  else begin
          writeln;
          writeln ('Numero de socio con mas edad: ', maxNum);
          writeln;
  end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
    if (a = nil) then
      AumentarEdad:= 0
    else begin
      resto:= a^.dato.edad mod 2;
      if (resto = 1) then
        a^.dato.edad:= a^.dato.edad + 1;
      AumentarEdad := resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
    end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

var a: arbol;
Begin
  randomize;
  GenerarArbol(a);
  InformarSociosOrdenCreciente(a);
  InformarSociosOrdenDecreciente (a);
  InformarNumeroSocioConMasEdad(a);
  AumentarEdadNumeroImpar(a);
  InformarExistenciaNombreSocio(a);
  InformarCantidadSocios(a);
  InformarPromedioDeEdad(a);   
End.