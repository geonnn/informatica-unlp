{13. El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De cada usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que participa y cantidad de días desde el último acceso.
a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios de la revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último acceso (orden ascendente).
b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.}

program Ej13;
const
    ROLES = 4;
type
    recUsuarios = record
        email: string;
        rol: 1..ROLES;
        revista: string;
        diasUltAcceso: integer;
    end;
    listaUsuarios = ^nodo;
    nodo = record
        dato: recUsuarios;
        sig: listaUsuarios;
    end;
    vecRol = array[1..ROLES] of integer;

procedure InicializarVector(var vR: vecRol);
var
    i: integer;
begin
    for i := 1 to ROLES do
        vR[i] := 0;
end;

procedure CargarUsuario(var u: recUsuarios);
begin
    readln(u.email);
    if (u.email = '0') then
        writeln('Carga finalizada.')
    else begin
        readln(u.rol);
        readln(u.revista);
        readln(u.diasUltAcceso);
    end;
end;

// Simular lista desordenada de la que ya se dispone.
procedure CargarLista(var L: listaUsuarios);
var
    u: recUsuarios;
    nue: listaUsuarios;
begin
    CargarUsuario(u);
    while (u.email <> '0') do begin
        new(nue);
        nue^.dato := u;
        nue^.sig := L;
        L := nue;
        CargarUsuario(u);
    end;
end;

// Crear lista ordenada para usuarios de la revista económica.
procedure CargarListaREconomica(var LEco: listaUsuarios; L: listaUsuarios);
var
    nue, act, ant: listaUsuarios;
begin
    while (L <> nil) do begin
        if (L^.dato.revista = 'Economica') then begin
            new(nue);
            nue^.dato := L^.dato;
            act := LEco;
            while (act <> nil) and (act^.dato.diasUltAcceso < L^.dato.diasUltAcceso) do begin
                ant := act;
                act := act^.sig;
            end;
            if (act = LEco) then
                LEco := nue
            else
                ant^.sig := nue;
            nue^.sig := act;
        end;
        L := L^.sig;
    end;
end;

procedure ImprimirUsuario(u: recUsuarios);
begin
    writeln('');
    writeln('Email: ', u.email, '.');
    writeln('Rol: ', u.rol, '.');
    writeln('Revista: ', u.revista, '.');
    writeln('Días desde el último acceso: ', u.diasUltAcceso, '.');
end;

procedure ImprimirVector(vR: vecRol);
var
    i: integer;
begin
    for i := 1 to ROLES do begin
        if (vR[i] <> 0) then
            writeln('Rol ', i, ': ', vR[i], '.');
    end;
end;

procedure MaxDiasUltAcceso(var emailMax1, emailMax2: string; var diasMax1, diasMax2: integer; email: string; dias: integer);
begin
    if (dias > diasMax1) then begin
        diasMax2 := diasMax1;
        emailMax2 := emailMax1;
        diasMax1 := dias;
        emailMax1 := email;
    end
    else begin
        if (dias > diasMax2) then begin
            diasMax2 := dias;
            emailMax2 := email;
        end;
    end;
end;

procedure RecorrerLista(var emailMax1, emailMax2: string; var vR: vecRol; L: listaUsuarios; LEco: listaUsuarios);
var
    diasMax1, diasMax2: integer;
begin
    diasMax1 := -maxInt;
    diasMax2 := -maxInt;
    while (L <> nil) do begin
        vR[L^.dato.rol] := vR[L^.dato.rol] + 1;
        MaxDiasUltAcceso(emailMax1, emailMax2, diasMax1, diasMax2, L^.dato.email, L^.dato.diasUltAcceso);
        L := L^.sig;
    end;
    writeln('');
    writeln('Usuarios revista Económica: ');
    while (LEco <> nil) do begin
        ImprimirUsuario(LEco^.dato);
        LEco := LEco^.sig;
    end;
end;


var
    vR: vecRol;
    L, LEco: listaUsuarios;
    emailMax1, emailMax2: string;
begin
    L := nil;
    LEco := nil;
    InicializarVector(vR);

    CargarLista(L);
    CargarListaREconomica(LEco, L);
    RecorrerLista(emailMax1, emailMax2, vR, L, LEco);
    
    writeln('');
    ImprimirVector(vR);
    writeln('');
    writeln('Usuarios que hace más tiempo no ingresan: ');
    writeln(emailMax1);
    writeln(emailMax2);
end.