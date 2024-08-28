{14. El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
CÓDIGO ROL DEL DESARROLLADOR VALOR/HORA (USD)
1 Analista Funcional 35,20
2 Programador 27,45
3 Administrador de bases de datos 31,03
4 Arquitecto de software 44,28
5 Administrador de redes y seguridad 39,87
Nota: los valores/hora se incluyen a modo de ejemplo
Realizar un programa que procese la información de los desarrolladores que participaron en los 1000 proyectos de software más activos durante el año 2017. De cada participante se conoce su país de residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto -1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
a. El monto total invertido en desarrolladores con residencia en Argentina.
b. La cantidad total de horas trabajadas por Administradores de bases de datos.
c. El código del proyecto con menor monto invertido.
d. La cantidad de Arquitectos de software de cada proyecto.}

program Ej14;
const
    PROYECTOS = 1000;
    ROLES = 5;

    AF = 35.20;
    P = 27.45;
    ABD = 31.03;
    ASW = 44.28;
    ARSG = 39.87;
type
    str50 = string[50];
    desarrollador = record
        codProyecto: -1..PROYECTOS;
        nomProyecto: str50;
        pais: str50;
        rol: 1..ROLES;
        cantHoras: real;
    end;

    vMontoProyectos = array[1..PROYECTOS] of real;
    vASWProyectos = array[1..PROYECTOS] of integer;
    vRoles = array[1..ROLES] of integer;
    vValorHora = array[1..ROLES] of real;

   {Creo que en vez de hacer 4 vectores también se podría hacer con 2 registros y 2 vectores así:
    
    recProyectos = record
        montoTotal: real;
        ArqSWpProy: integer;
    end;

    recRoles = record
        rol: 1..ROLES;
        valorHora: real;
    end;

    vProyectos = array[1..PROYECTOS] of recProyectos;
    vRoles = array[1..ROLES] of recRoles;}
    

procedure VectorValorHora(var vVH: vValorHora);
begin
    vVH[1] := AF;
    vVH[2] := P;
    vVH[3] := ABD;
    vVH[4] := ASW;
    vVH[5] := ARSG;
end;

procedure Inicializar(var vR: vRoles; var vM: vMontoProyectos; var vASWP: vASWProyectos);
var
    i: integer;
begin
    for i := 1 to ROLES do
        vR[i] := 0;
    for i := 1 to PROYECTOS do begin
        vM[i] := 0;
        vASWP[i] := 0;
    end;
end;

procedure LeerDesarrollador(var d: desarrollador);
begin
    writeln('Ingrese el código de proyecto: ');
    readln(d.codProyecto);
    if (d.codProyecto = -1) then begin
        writeln('Carga finalizada.');
    end
    else begin
        writeln('Ingrese el nombre del proyecto: ');
        readln(d.nomProyecto);
        writeln('Ingrese el país de residencia del desarrollador: ');
        readln(d.pais);
        writeln('Ingrese el rol del desarrollador: ');
        readln(d.rol);
        writeln('Ingrese la cantidad de horas trabajadas por el desarrollador: ');
        readln(d.cantHoras);
        writeln('');
        writeln('');
    end;
end;

procedure DevsArgentina(var montoTArg: real; pais: str50; rol: integer; horas: real; vVH: vValorHora);
begin
    if (pais = 'Argentina') then
        montoTArg := montoTArg + (vVH[rol] * horas);
end;

procedure ABDHoras(var hsTotalesABD: real; rol: integer; cantHoras: real);
begin
    if (rol = 3) then
        hsTotalesABD := hsTotalesABD + cantHoras;
end;

procedure ArqSW(var vASWP: vASWProyectos; rol: integer; codProy: integer);
begin
    if (rol = 4) then
        vASWP[codProy] := vASWP[codProy] + 1;
end;

procedure MontoProyecto(var vM: vMontoProyectos; codProy: integer; rol: integer; horas: real; vVH: vValorHora);
begin
    vM[codProy] := vM[codProy] + (vVH[rol] * horas);
end;

procedure ProyectoMontoMin(var montoProyMin: real; var codProyMin: integer; vM: vMontoProyectos; codProy: integer);
var
    i: integer;
begin
    for i := 1 to PROYECTOS do begin
        if (vM[i] < montoProyMin) then begin
            montoProyMin := vM[i];
            codProyMin := codProy;
        end;
    end;
end;

var
    d: desarrollador;
    vVH: vValorHora;
    vR: vRoles;
    vM: vMontoProyectos;
    vASWP: vASWProyectos;
    i: integer;
    montoTotalArg: real;
    hsTotalesABD: real;
    montoProy, montoProyMin: real;
    codProyMin: integer;
begin
    // Inicializar variables y vectores.
    montoTotalArg := 0;
    montoProyMin := maxInt;
    VectorValorHora(vVH);
    Inicializar(vR, vM, vASWP);

    // Desarrollo del programa principal.
    LeerDesarrollador(d);
    while (d.codProyecto <> -1) do begin
        DevsArgentina(montoTotalArg, d.pais, d.rol, d.cantHoras, vVH);
        ABDHoras(hsTotalesABD, d.rol, d.cantHoras);
        MontoProyecto(vM, d.codProyecto, d.rol, d.cantHoras, vVH);
        ProyectoMontoMin(montoProyMin, codProyMin, vM, d.codProyecto);
        ArqSW(vASWP, d.rol, d.codProyecto);
        LeerDesarrollador(d);
    end;

    writeln('El monto total invertido en desarrolladores de Argentina es ', montoTotalArg:0:2, 'USD.');
    writeln('Los Administradores de Bases de Datos trabajaron un total de ', hsTotalesABD:0:2, ' horas.');
    writeln('El código de proyecto con menor monto invertido es el código ', codProyMin, '.');
    for i := 1 to PROYECTOS do
        if (vASWP[i] <> 0) then
            writeln('En el proyecto código ', i,' trabajaron ', vASWP[i], ' Arquitectos de software.');
    writeln('');
end.