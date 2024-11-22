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
** Se necesita: - vector de maxPrecios de cada país.
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
    codigo: string; // ¡¡¡¡¡el código es un integer!!!!!
    precio: real;
    pais: RangoPaises;
  end;
  ListaRepuestos = ^NodoRepuesto;
  NodoRepuesto = record
    dato: Repuesto;
    siguiente: ListaRepuestos;
  end;

  VectorContador = array[RangoPaises] of integer;
  VectorMaxPrecio = array[RangoPaises] of real;
  VectorNombresPaises = array[RangoPaises] of string;

var
// ¡¡¡NO SE USAN VARIABLES GLOBALES!!! ¡¡¡SEGUNDA CLASE DE CADP!!!
  lista: ListaRepuestos;
  nombresPaises: VectorNombresPaises;

procedure LeerNombresPaises(var nombres: VectorNombresPaises);
var
  i: RangoPaises;
begin
  for i := 1 to MAX_PAISES do
    nombres[i] := 'Pais_' + IntToStr(i); // Simulación de nombres ya cargados en el servidor
end;

procedure CargarRepuestos(var lista: ListaRepuestos);
var
  rep: Repuesto;
begin
  lista := nil;
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
    // Es mejor modularizar y hacer un proceso a parte. "agregarAdelante" p. ej.
    var nuevo: ListaRepuestos;
    new(nuevo);
    nuevo^.dato := rep;
    nuevo^.siguiente := lista;
    lista := nuevo;

    writeln('Ingrese el codigo del siguiente repuesto (-1 para finalizar): ');
    readln(rep.codigo);
  end;
end;

procedure ProcesarRepuestos(lista: ListaRepuestos; var contador: VectorContador;
var maxPrecio: VectorMaxPrecio);
var
  aux: ListaRepuestos;
  sumaTotal: integer;
  cantPaises: integer;
begin
  aux := lista;
  sumaTotal := 0;
  cantPaises := 0; // Esta variable no se usa.

    // ** 2 **
    // inicializar vectores es una tarea totalmente distinta de procesar una lista. Está bien hecho pero va en un módulo a parte afuera.
    // para hacerlo más ordenado y eficiente podés hacer un registro que tenga los dos datos que estás guardando en un vector, en lugar de hacer dos vectores distintos.
  for var i := 1 to MAX_PAISES do
  begin
    contador[i] := 0;
    maxPrecio[i] := 0;
  end;

    // ** 3 **
    // no hace falta usar una variable aux, ya la lista se pasa por valor, así que si usamos ese puntero pasado por parámetro por valor no se modifica el puntero original de la lista.
  while aux <> nil do
  begin
    with aux^.dato do // ¿with? No existe en CADP usar with. Hacelo como lo enseñan porque sino no te van a aprobar.
    begin             // Entiendo que con el with es mucho más legible el código, pero en la cursada no lo usaban. Si te dijeron que estaba bien mandale.
      contador[pais] := contador[pais] + 1;
      if precio > maxPrecio[pais] then
        maxPrecio[pais] := precio;
    // ** 4 **
    // ¿Repuestos con al menos tres ceros en su código?
    end;
    sumaTotal := sumaTotal + 1;
    aux := aux^.siguiente;
  end;

  writeln('Procesamiento completo.');
// La lógica de todo esto está bien. Con el tema de usar varios vectores no creo que haya drama, a veces es más cómodo.
// Pero pasar la lista por valor y después usar una variable local del proceso te lo pueden señalar como un error, por lo menos trabajando con listas.
// Y faltó el punto de los repuestos con al menos tres ceros en su código.
end;

procedure ImprimirResultados(contador: VectorContador; maxPrecio: VectorMaxPrecio; nombres: VectorNombresPaises);
var
  i: RangoPaises;
  paisesBajoProm: integer;
  repuestosCeros: integer;
  promedio: real;
begin
  paisesBajoProm := 0;
  repuestosCeros := 0; // No se usa.

  // Calcular promedio
  // ** 5 **
  var sumaTotal: integer := 0; // Ya tenías la suma total desde antes, en el prceso ProcesarRepuestos.
  for i := 1 to MAX_PAISES do
    sumaTotal := sumaTotal + contador[i];
  promedio := sumaTotal / MAX_PAISES;

  writeln('Promedio de repuestos comprados por país: ', promedio:0:2);

  for i := 1 to MAX_PAISES do
  begin
    if contador[i] > 0 then // No imprime los países que tengan 0 repuestos. Bien eso aunque no lo pidan.
    begin
      writeln('País: ', nombres[i], ' - Repuestos: ', contador[i], ' - Precio Máx.: ', maxPrecio[i]:0:2);
      if contador[i] < promedio then
        paisesBajoProm := paisesBajoProm + 1;
    end;
  end;

  writeln('Cantidad de países con repuestos por debajo del promedio: ', paisesBajoProm);
end;

{ Programa principal }
// falta declarar variables locales al prog. principal.
// no se usan variables globales.
// declarar las variables siembre antes del begin del p. principal.
// var nombresPaises: tipo;
//      lista: listaRepuestos;
// etc.
begin
  LeerNombresPaises(nombresPaises);
  CargarRepuestos(lista);

  var contador: VectorContador;
  var maxPrecio: VectorMaxPrecio;

  ProcesarRepuestos(lista, contador, maxPrecio);
  ImprimirResultados(contador, maxPrecio, nombresPaises);
end.