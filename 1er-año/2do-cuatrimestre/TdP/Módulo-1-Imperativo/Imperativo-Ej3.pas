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
	nodo = record
		dato: recPelicula;
		sig: listaPeliculas;
	end;
	
	recListas = record
		L: listaPeliculas;
		ult: listaPeliculas;
	end;

	recPje = record
		codPel: integer;
		pjePromMax: real;
	end;

vecListas = array[1..8] of recListas;
vecPjeMax = array[1..8] of recPje;

procedure LeerPelicula(var p: recPelicula);
begin
	writeln('Ingrese codigo de pelicula: ');
	readln(p.codPel);
	if (p.codPel = -1) then
		writeln('Carga finalizada.')
	else
		begin
			writeln('Codigo de genero: ');
			readln(p.codGen);
			writeln('Puntaje promedio: ');
			readln(p.pjeProm);
		end;
end;

procedure AgregarAtras(var L, ult: listaPeliculas; p: recPelicula);
var
	nue: listaPeliculas;
begin
	new(nue);
	nue^.dato := p;
	nue^.sig := nil;
	if (L = nil) then begin
		L := nue;
		ult := nue;
	end
	else begin
		ult^.sig := nue;
		ult := nue;
	end;
end;

procedure CargarLista(var vL: vecListas); // Carga las películas al final de la lista en su respectiva posición en el vector según su género.
var
	p: recPelicula;
begin
	while (p.codPel <> -1) do begin
		LeerPelicula(p);
		AgregarAtras(vL[p.codGen].L, vL[p.codGen].ult, p);
	end;
end;

procedure InicializarVectorListas(var vL: vecListas);
var
	i: integer;
begin
	for i := 1 to 8 do
		vL[i].L := nil
	// no hace falta inicializar ult en nil porque se sobreescribe en cualquier caso.
end;

procedure InicializarVectorPMax(var vPM: vecPjeMax);
var
	i: integer;
begin
	for i := 1 to 8 do
		vPM[i].pjePromMax := -1
end;

procedure PjeMaximo(codPel: integer; pjeProm: real; var codPelMax: integer; var pjePromMax: real);
begin
	if (pjeProm > pjePromMax) then begin
		pjePromMax := pjeProm;
		codPelMax := codPel;
	end;
end;

procedure RecorrerLista(L: listaPeliculas; var codPelMax: integer; var pjePromMax: real);
begin
	while (L <> nil) do begin
		PjeMaximo(L^.dato.codPel, L^.dato.pjeProm, codPelMax, pjePromMax);
		L := L^.sig;
	end;
end;

procedure CargarVPM(var vPM: vecPjeMax; i: integer; codPelMax: integer; pjePromMax: real);
begin
	vPM[i].codPel := codPelMax;
	vPM[i].pjePromMax := pjePromMax;
end;

procedure RecorrerVectorListas(vL: vecListas; var vPM: vecPjeMax);
var
	i: integer;
	codPelMax: integer;
	pjePromMax: real;
begin
	pjePromMax := -1;
	for i := 1 to 8 do begin
		RecorrerLista(vL[i].L, codPelMax, pjePromMax);
		CargarVPM(vPM, i, codPelMax, pjePromMax)
	end;
end;

var
	vL: vecListas;
	vPM: vecPjeMax;
begin
	InicializarVectorListas(vL);
	InicializarVectorPMax(vPM);
	CargarLista(vL);
	RecorrerVectorListas(vL, vPM);
end.