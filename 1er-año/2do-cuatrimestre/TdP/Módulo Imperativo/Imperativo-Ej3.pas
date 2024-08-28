{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, del vector obtenido en el punto c).}

program Ej3;
type
	recPelicula = record
		codPel: integer;
		codGen: 1..8;
		pjeProm: real;
	end;
	
	listaPeliculas = ^nodo;
	nodo = record;
		dato: recPelicula;
		sig: listaPeliculas;
	end;
	
	recPunteros = record
		L: listaPeliculas;
		ult: listaPeliculas;
	end;

vecGeneros = array[1..8] of recPunteros;

procedure LeerPelicula(var p: recPelicula);
begin
	writeln('Ingrese codigo de peli: ')
	readln(codPel);
	if (codPel = -1) then
		writeln('Carga finalizada.');
	else
		begin
			writeln('Codigo de genero: ');
			readln(codGen);
			writeln('Puntaje promedio: ');
			readln(pjeProm);
		end;
end;

procedure AgregarAtras(L: listaPeliculas; var ult: listaPeliculas; p: recPelicula);
var
	nue: listaPeliculas;
begin
	new(nue);
	nue^.dato := p;
	nue^.sig := nil;
	if (L = nil) then begin
		L := nue;
		ult := nue;
	end;
	else begin
		ult^.sig := nue;
		ult := nue;
	end;
end;

procedure CargarLista(v: vector);
begin
	LeerPelicula(p);
	AgregarAtras(v[p.codGen].L, v[p.codGen].ult, p);
end;

procedure InicializarVector(var v: vecGeneros);
var
	i: integer;
begin
	for i := 1 to 8 do
		v[i].L := nil
end;

var
	L, ult: listaPeliculas;
	v: vecGeneros;
begin
	InicializarVector(v);
	CargarLista (v);
end;
