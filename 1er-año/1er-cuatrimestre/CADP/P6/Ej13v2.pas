{13. El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De cada usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que participa y cantidad de días desde el último acceso.
a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios de la revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último acceso (orden ascendente).
b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.}

program Ej13;
const
    USUARIOS = 10; // Asigno 10 usuarios para pruebas.
    ROLES = 4;
type
    recUsuarios = record
        email: string;
        rol: 1..ROLES;
        revista: string;
        diasUltAcceso: integer;
    end;

    recUsuariosEco = record
        email: string;
        diasUltAcceso: integer;
    end;
    listaUsuariosEco = ^nodo;
    nodo = record
        dato: recUsuariosEco;
        sig: listaUsuariosEco;
    end;
    vecRol = array[1..ROLES] of integer;

    vecUsuarios = array[1..USUARIOS] of recUsuarios; // Se dispone.

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
    readln(u.rol);
    readln(u.revista);
    readln(u.diasUltAcceso);
end;

procedure CargarVector(var vU: vecUsuarios); // Se dispone.
var
    u: recUsuarios;
    i: integer;
begin
    for i := 1 to USUARIOS do begin
        CargarUsuario(u);
        vU[i] := u;
    end;
end;

// Crear lista ordenada para usuarios de la revista económica.
procedure CargarListaREconomica(var LEco: listaUsuariosEco; email: string; dias: integer);
var
    nue, act, ant: listaUsuariosEco;
begin
    new(nue);
    nue^.dato.email := email; nue^.dato.diasUltAcceso := dias;
    act := LEco;
    while (act <> nil) and (act^.dato.diasUltAcceso < dias) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = LEco) then
        LEco := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure CargarLista(var LEco: listaUsuariosEco; vU: vecUsuarios);
var
    i: integer;
begin
    for i := 1 to USUARIOS do begin
        if (vU[i].revista = 'Economica') then
            CargarListaREconomica(LEco, vU[i].email, vU[i].diasUltAcceso);
    end;
end;

procedure ImprimirUsuario(u: recUsuariosEco);
begin
    writeln('');
    writeln('Email: ', u.email, '.');
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

procedure RecorrerVector(var emailMax1, emailMax2: string; var vR: vecRol; vU: vecUsuarios);
var
    i: integer;
    diasMax1, diasMax2: integer;
begin
    diasMax1 := -maxInt;
    for i := 1 to USUARIOS do begin
        vR[vU[i].rol] := vR[vU[i].rol] + 1;
        MaxDiasUltAcceso(emailMax1, emailMax2, diasMax1, diasMax2, vU[i].email, vU[i].diasUltAcceso);
    end;
end;

procedure RecorrerLista(LEco: listaUsuariosEco);
begin
    writeln('');
    writeln('Usuarios revista Económica: ');
    while (LEco <> nil) do begin
        ImprimirUsuario(LEco^.dato);
        LEco := LEco^.sig;
    end;
end;

var
    vU: vecUsuarios;
    vR: vecRol;
    LEco: listaUsuariosEco;
    emailMax1, emailMax2: string;
begin
    LEco := nil;
    InicializarVector(vR);

    CargarVector(vU);
    CargarLista(LEco, vU);
    RecorrerVector(emailMax1, emailMax2, vR, vU);
    RecorrerLista(LEco);
    
    writeln('');
    ImprimirVector(vR);
    writeln('');
    writeln('Usuarios que hace más tiempo no ingresan: ');
    writeln(emailMax1);
    writeln(emailMax2);
end.