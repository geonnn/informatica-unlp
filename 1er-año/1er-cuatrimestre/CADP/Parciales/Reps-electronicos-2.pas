{Un fabricante de dispositivos electrónicos desea procesar información de repuestos que compró. 
El fabricante dispone de una estructura de datos con información de los 200 países de los cuales provienen repuestos, en la que para cada código de país (1..200) se tiene su nombre.
Realizar un programa que:
a. Lea la información de los repuestos comprados y la almacene en una estructura de datos adecuada. De cada repuesto se lee código, precio y código del país del que proviene (entre 1 y 200). 
La lectura finaliza al ingresar el código -1 (que no debe procesarse).
b. Una vez cargada la información, procese la estructura de datos del inciso a e informe:

Cantidad de países para los que la cantidad de repuestos comprados es menor que el promedio de repuestos comprados a todos los países.
** Se necesita: - total de repuestos comprados.
                - total de repuestos comprador por país.
                - total repuestos / max_paises = PROMEDIO.
                - si (cant. repuestos comprados en X país) < PROMEDIO
                      cantPaisesPocosRepuestos += 1.

Para cada país, el nombre del país y el precio del repuesto más caro.
** Se necesita:   - vector de maxPrecios de cada país.
                  - actualizar máximo para cada producto.
                  - imprimir el vector del que ya se disponía (nombres) y el nuevo de maxPrecios.


COMPLETO: La cantidad de repuestos que poseen al menos 3 ceros en su código.
Implemente el programa principal que invoque a los módulos de los incisos a y b, e imprima los resultados.}

program ProcesarRepuestos;

const
  MAX_PAISES = 200;

type
  RangoPaises = 1..MAX_PAISES;
  Repuesto = record
    codigo: integer;
    precio: real;
    pais: RangoPaises;
  end;
  ListaRepuestos = ^NodoRepuesto;
  NodoRepuesto = record
    dato: Repuesto;
    siguiente: ListaRepuestos;
  end;

  recDatosPaises = record
    contador: integer;
    maxPrecio: real;
  end;

  vecDatosPaises = array[RangoPaises] of recDatosPaises;

  VectorNombresPaises = array[RangoPaises] of string;

procedure LeerNombresPaises(var nombres: VectorNombresPaises);
var
  i: RangoPaises;
begin
  for i := 1 to MAX_PAISES do
    nombres[i] := 'Pais_' + IntToStr(i); // Simulación de nombres ya cargados en el servidor
end;

// ** 1 **
procedure agregarAdelante(var L: ListaRepuestos; r: Repuesto)
var
    nuevo: ListaRepuestos;
begin
    new(nuevo);
    nuevo^.dato := r;
    nuevo^.siguiente := L;
    L := nuevo;
end;

procedure CargarRepuestos(var lista: ListaRepuestos);
var
  rep: Repuesto;
begin
  writeln('Ingrese el codigo del repuesto (-1 para finalizar): ');
  readln(rep.codigo);
  while rep.codigo <> '-1' do
  begin
    writeln('Ingrese el precio del repuesto: ');
    readln(rep.precio);
    writeln('Ingrese el codigo del pais de origen (1..200): ');
    readln(rep.pais);
    
    // Agregar a la lista
    // ** 1 **
    agregarAdelante(lista, rep);

    writeln('Ingrese el codigo del siguiente repuesto (-1 para finalizar): ');
    readln(rep.codigo);
  end;
end;

// ** 2 **
procedure inicializarVector(var v: vecDatosPaises);
var
  i: integer;
begin
  for i := 1 to MAX_PAISES do begin
    v[i].contador := 0;
    v[i].maxPrecio := -1;
  end;
end;

// ** 4 **
// Recibe un código y devuelve true si tiene al menos 3 ceros.
// De lo contrario, devuelve false.
// De esta forma la función no funciona para los casos en los que el código empiece con ceros.
// Para cubrir esos casos hay que hacerlo con un string y un bucle for, usando la long. del código, p. ejemplo.
// Pero en CADP quieren que hagas esta función, usando MOD y DIV.
function tresCeros(codigo: integer): boolean;
var
  ceros: integer;
begin
  tresCeros := false;
  ceros := 0;
  while((codigo <> 0) and (ceros < 3)) do begin
    if ((codigo MOD 10) = 0) then // analiza el primer dígito.
      ceros := ceros + 1;
    codigo := codigo DIV 10; // Le borra el dígito ya analizado al código, para volver al loop y analizar el siguiente dígito.
  end;
  tresCeros := (ceros = 3);
end;

procedure ProcesarRepuestos(lista: ListaRepuestos; var vDP: vecDatosPaises; var cantRepsTresCeros, sumaTotal: integer);
begin
  // ** 3 **
  while (lista <> nil) do begin
    vDP[lista^.dato.pais].contador := vDP[lista^.dato.pais].contador + 1; // Suma repuesto por país.
    if (lista^.dato.precio > vDP[lista^.dato.pais].maxPrecio) then
      vDP[lista^.dato.pais].maxPrecio := precio; // Actualiza máximo en X país.
      // ** 4 **
    if(tresCeros(lista^.dato.codigo)) then
      cantRepsTresCeros := cantRepsTresCeros + 1; // Suma 1 si el código del rep. tiene al menos tres ceros.
    sumaTotal := sumaTotal + 1; // Suma total de repuestos.
    lista := lista^.siguiente;
  end;
  writeln('Procesamiento completo.');
end;

procedure ImprimirResultados(vDP: vecDatosPaises; nombres: VectorNombresPaises);
var
  i: RangoPaises;
  paisesBajoProm: integer;
  promedio: real;
begin
  paisesBajoProm := 0;

  // Calcular promedio
  // ** 5 **
  promedio := sumaTotal / MAX_PAISES;

  writeln('Promedio de repuestos comprados por país: ', promedio:0:2);

  for i := 1 to MAX_PAISES do begin
    if (vDP[i].contador > 0) then begin // No imprime los países que tengan 0 repuestos. Bien eso aunque no lo pidan.
                                        // Por las dudas aclaralo con un comentario porque la consigna pide imprimir todos los países.
      writeln('País: ', nombres[i], ' - Repuestos: ', vDP[i].contador, ' - Precio Máx.: ', vDP[i].maxPrecio:0:2);
      if (vDP[i].contador < promedio) then
        paisesBajoProm := paisesBajoProm + 1;
    end;
  end;
  writeln('Cantidad de países con repuestos por debajo del promedio: ', paisesBajoProm);
end;

{ Programa principal }
var
  vDP: vecDatosPaises;
  vNP: VectorNombresPaises;
  lista: ListaRepuestos;
  cantRepsTresCeros, sumaTotal: integer
begin
  lista := nil;
  sumaTotal := 0;
  cantRepsTresCeros := 0;
  inicializarVector(vDP);
  LeerNombresPaises(vNP);
  CargarRepuestos(lista);

  ProcesarRepuestos(lista, vDP, cantRepsTresCeros, sumaTotal);
  ImprimirResultados(vDP, vNP);
  writeln('Cantidad de repuestos con al menos tres ceros en su código: ', cantRepsTresCeros, '.');
end.