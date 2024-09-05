{2.Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores leídos y retorne la cantidad solicitada.

Consigna anterior:
Escribir un programa que:
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
		  writeln ('Numero: ', a^.dato.numero, ' | Nombre: ', a^.dato.nombre, ' | Edad: ', a^.dato.edad);
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
		  writeln ('Numero: ', a^.dato.numero, ' | Nombre: ', a^.dato.nombre, ' | Edad: ', a^.dato.edad);
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
          writeln ('Numero de socio con más edad: ', maxNum);
          writeln;
  end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarNumeroSocioMasGrande(a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

    procedure actualizarMaximo(var maxValor: integer; nuevoValor: integer);
    begin
	  if (nuevoValor >= maxValor) then
		  maxValor := nuevoValor
    end;

	procedure NumeroMayor(a: arbol; var maxSocio: integer);
	begin
	  if (a <> nil) then begin
		  actualizarMaximo(maxSocio, a^.dato.numero);
		  NumeroMayor(a^.hi, maxSocio);
		  NumeroMayor(a^.hd, maxSocio);
	  end; 
  end;

var maxSocio: integer;
begin
  writeln;
  writeln ('----- Informar Numero de Socio más grande ----->');
  writeln;
  maxSocio := -1;
  NumeroMayor(a, maxSocio);
  if (maxSocio = -1) then
    writeln ('Arbol sin elementos')
  else begin
          writeln;
          writeln ('Numero de socio más grande: ', maxSocio);
          writeln;
  end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

// No tiene mucho sentido la consigna, considerando que el árbol está ordenado por número de socio, el que tenga el num más chico siempre va a ser el primero. De todas formas, lo dejo resuelto como si fuera hacer un mínimo. Puede aplicarse para buscar el mínimo de edad.
procedure InformarSocioNumeroMasChico(a: arbol);
    
    procedure ActualizarMinimo(var minSocio, edadMinSocio: integer; var nomMinSocio: cadena15; nuevoSocio, nuevoEdad: integer; nuevoNombre: cadena15);
    begin
        //if (nuevoSocio < minSocio) then begin
        if (nuevoEdad < edadMinSocio) then begin // Busca el socio más chico (edad).
            minSocio := nuevoSocio;
            edadMinSocio := nuevoEdad;
            nomMinSocio := nuevoNombre;
        end;
    end;

    procedure NumeroMenor(a: arbol; var minSocio, edadMinSocio: integer; var nomMinSocio: cadena15);
    begin
        if (a <> nil) then begin
            ActualizarMinimo(minSocio, edadMinSocio, nomMinSocio, a^.dato.numero, a^.dato.edad, a^.dato.nombre);
            NumeroMenor(a^.HI, minSocio, edadMinSocio, nomMinSocio);
            NumeroMenor(a^.HD, minSocio, edadMinSocio, nomMinSocio);
        end;
    end;

var
    minSocio, edadMinSocio: integer;
    nomMinSocio: cadena15;
begin
  writeln;
  writeln ('----- Informar datos del socio con número mas chico ----->');
  writeln;
  //minSocio := maxInt;
  edadMinSocio := maxInt;
  NumeroMenor(a, minSocio, edadMinSocio, nomMinSocio);
  if (minSocio = maxInt) then
    writeln ('Arbol sin elementos')
  else begin
        writeln;
        writeln ('Numero: ', minSocio, ' | Nombre: ', nomMinSocio, ' | Edad: ', edadMinSocio);
        writeln;
  end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarExistenciaNumeroSocio(a: arbol);
  
  function BuscarSocio(a: arbol; num: integer): boolean;
  begin
    if (a <> nil) then begin
      if (a^.dato.numero = num) then
        BuscarSocio := true
      else
        BuscarSocio := BuscarSocio(a^.HI, num) or BuscarSocio(a^.HD, num);
    end
    else
      BuscarSocio := false; // CASO BASE: a = nil.
  end;

var
  num: integer;
begin
  writeln;
  writeln ('<----- Buscar número de socio ----->');
  writeln;
  write('Ingrese número de socio para buscar: ');
  read(num);
  writeln;
    if (BuscarSocio(a, num)) then
      writeln('El socio ', num, ' forma parte del club.')
    else
      writeln('El socio ', num, ' NO forma parte del club.');
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

procedure InformarSociosEntreValores(a: arbol);

  function ContarSocios(a: arbol; num1, num2: integer): integer;
  begin
    if (a <> nil) then begin
      if (a^.dato.numero > num1) and (a^.dato.numero < num2) then
        ContarSocios := 1
      else
        ContarSocios := 0;
      ContarSocios := ContarSocios + ContarSocios(a^.HI, num1, num2) + ContarSocios(a^.HD, num1, num2);
    end
    else
      ContarSocios := 0; // CASO BASE: a = nil.
  end;

var
  numero1, numero2, cantidadSocios: integer;
begin
  writeln;
  writeln ('<----- Buscar cantidad de socios entre valores ----->');
  writeln;
  write('Ingrese primer número de socio: ');
  read(numero1);
  write('Ingrese segundo número de socio (mayor al primero): ');
  read(numero2);
  writeln;
  cantidadSocios := ContarSocios(a, numero1, numero2);
  if (cantidadSocios = 0) then
      writeln('No hay números de socio comprendidos entre el rango ingresado.')
    else
      writeln('En el rango ingresado existen ', cantidadSocios, ' socios.');
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
  //------- Práctica 4 Ej.2 ---------------
  InformarNumeroSocioMasGrande(a);
  InformarSocioNumeroMasChico(a);
  InformarExistenciaNumeroSocio(a);
  InformarSociosEntreValores(a);
End.