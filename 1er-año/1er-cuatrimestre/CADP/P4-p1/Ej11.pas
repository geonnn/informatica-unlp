{11. El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales.
Para ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez
finalizada la lectura, el programa debe procesar los datos e informar:
a. Título de la foto más vista (la que posee mayor cantidad de clics).
b. Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
c. Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.}

program Ej11;
const
    cantFotos = 4;
type
    str60 = string[60];
    datosFotos = record
        titulo: str60;
        autor: str60;
        cantMG: integer;
        cantClicks: integer;
        cantCom: integer;
    end;
    vFotos = array[1..cantFotos] of datosFotos;

procedure LeerDatos(var f: datosFotos);
begin
    writeln('Título: ');
    readln(f.titulo);
    writeln('Autor: ');
    readln(f.autor);
    writeln('Cantidad de me gusta: ');
    readln(f.cantMG);
    writeln('Cantidad de clicks: ');
    readln(f.cantClicks);
    writeln('Cantidad de comentarios: ');
    readln(f.cantCom);
end;

procedure MasVista(titulo: str60; clicks: integer; var tMax: str60; var cMax: integer);
begin
    if (clicks > cMax) then begin
        cMax := clicks;
        tMax := titulo;
    end;
end;

procedure MGAV(autor: str60; megusta: integer; var mgTotal: integer);
begin
    if (autor = 'Art Vandelay') then
        mgTotal := mgTotal + megusta;
end;

procedure Comentarios(comentarios: integer; var comTot: integer);
begin
    comTot := comTot + comentarios;
end;

var
    dF: datosFotos;
    vF: vFotos;
    i: integer;
    tituloMax: str60;
    clicksMax, mgAVTot, comTot: integer;
begin
    clicksMax := -1;
    mgAVTot := 0;
    comTot := 0;
    for i := 1 to cantFotos do begin
        LeerDatos(dF);
        vF[i] := dF;
        MasVista(df.titulo, df.cantClicks, tituloMax, clicksMax);
        MGAV(df.autor, df.cantMG, mgAVTot);
        Comentarios(df.cantCom, comTot);
    end;
    writeln('La foto más vista es: ', tituloMax, '.');
    writeln('Art Vandelay tuvo ', mgAVTot, ' likes.');
    writeln('Entre todas las fotos hay ', comTot, ' comentarios.');
end.