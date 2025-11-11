**Persona** = (<u>DNI</u>, Apellido, Nombre, Fecha_Nacimiento, Estado_Civil, Genero)
**Alumno** = (<u>DNI (fk)</u>, Legajo, Anio_Ingreso)
**Profesor** = (<u>DNI (fk)</u>, Matricula, Nro_Expediente)
**Titulo** = (<u>Cod_Titulo</u>, Nombre, Descripcion)
**Titulo-Profesor** = (<u>Cod_Titulo (fk), DNI (fk)</u>, Fecha)
**Curso** = (<u>Cod_Curso</u>, Nombre, Descripcion, Fecha_Creacion, Duracion)
**Alumno-Curso** = (<u>DNI (fk), Cod_Curso (fk), Anio</u>, Desempenio, Calificacion)
**Profesor-Curso** = (<u>DNI (fk), Cod_Curso (fk), Fecha_Desde</u>, Fecha_Hasta?)
### 1) Listar DNI, legajo y apellido y nombre de todos los alumnos que tengan año de ingreso inferior a 2014.

```sql
SELECT a.DNI, a.Legajo, p.Apellido, p.Nombre
FROM Persona p
NATURAL JOIN Alumno a
WHERE a.Anio_Ingreso < "2014-01-01"
```
---
### 2) Listar DNI, matrícula, apellido y nombre de los profesores que dictan cursos que tengan más de 100 horas de duración. Ordenar por DNI.

```sql
SELECT DISTINCT pr.DNI, pr.Matricula, p.Apellido, p.Nombre
FROM Persona p
NATURAL JOIN Profesor pr
NATURAL JOIN Profesor_Curso pc
INNER JOIN Curso c ON c.Cod_Curso = pc.Cod_Curso
WHERE c.Duracion > 100
ORDER BY pr.DNI
```
---
### 3) Listar el DNI, Apellido, Nombre, Género y Fecha de nacimiento de los alumnos inscriptos al curso con nombre “Diseño de Bases de Datos” en 2023.

```sql
SELECT a.DNI, p.Apellido, p.Nombre, p.Genero, p.Fecha_Nacimiento
FROM Alumno a
NATURAL JOIN Persona p
NATURAL JOIN Alumno_Curso ac
INNER JOIN Curso c ON c.Cod_Curso = ac.Cod_Curso
WHERE c.Nombre = 'Diseño de Bases de Datos' AND ac.Anio = 2023
```
---
### 4) Listar el DNI, Apellido, Nombre y Calificación de aquellos alumnos que obtuvieron una calificación superior a 8 en algún curso que dicta el profesor “Juan Garcia”. Dicho listado deberá estar ordenado por Apellido y nombre.

```sql
SELECT a.DNI, p.Apellido, p.Nombre, ac.Calificacion
FROM Alumno a
NATURAL JOIN Persona p
NATURAL JOIN Alumno_Curso ac
INNER JOIN Curso c ON c.Cod_Curso = ac.Cod_Curso
INNER JOIN Profesor_Curso pc ON pc.Cod_Curso = c.Cod_Curso
INNER JOIN Profesor pr ON pc.DNI = pr.DNI
INNER JOIN Persona per_pr ON pr.DNI = per_pr.DNI
WHERE ac.Calificacion > 8 AND per_pr.Nombre = 'Juan' AND per_pr.Apellido = 'García'
ORDER BY p.Apellido, p.Nombre
```
---
### 5) Listar el DNI, Apellido, Nombre y Matrícula de aquellos profesores que posean más de 3 títulos. Dicho listado deberá estar ordenado por Apellido y Nombre.

```sql
SELECT p.DNI, p.Apellido, p.Nombre, pr.Matricula
FROM Profesor pr
NATURAL JOIN Persona p
NATURAL JOIN Titulo_Profesor tp
GROUP BY p.DNI, p.Apellido, p.Nombre, pr.Matricula
HAVING COUNT(tp.Cod_Titulo) > 3
ORDER BY p.Apellido, p.Nombre
```
---
### 6) Listar el DNI, Apellido, Nombre, Cantidad de horas y Promedio de horas que dicta cada profesor. La cantidad de horas se calcula como la suma de la duración de todos los cursos que dicta.

```sql
SELECT p.DNI, p.Apellido, p.Nombre,
    SUM(c.Duracion) as cant_horas,
    AVG(c.Duracion) as promedio
FROM Profesor pr
NATURAL JOIN Persona p
NATURAL JOIN Profesor_Curso pc
INNER JOIN Curso c ON c.Cod_Curso = pc.Cod_Curso
GROUP BY p.DNI, p.Apellido, p.Nombre
```
---
### 7) Listar Nombre y Descripción del curso que posea más alumnos inscriptos y del que posea menos alumnos inscriptos durante 2024.

```sql
-- Primera parte - cursos que poseen más inscriptos:
SELECT c.Nombre, c.Descripcion
FROM Curso c
NATURAL JOIN Alumno_Curso ac
WHERE ac.Anio = 2024
GROUP BY c.Cod_Curso, c.Nombre, c.Descripcion -- group by para usar el count
HAVING COUNT(ac.DNI) >= ALL (
    SELECT COUNT(DNI)
    FROM Alumno_Curso
    WHERE Anio = 2024
    GROUP BY Cod_Curso
)
-- En la primera parte, COUNT(ac.DNI) >= ALL (Subconsulta) garantiza que solo se seleccionan los grupos cuyo conteo sea igual o superior al conteo de todos los demás grupos, identificando así el máximo.

UNION

-- Segunda parte - cursos que poseen menos inscriptos:
SELECT c.Nombre, c.Descripcion
FROM Curso c
NATURAL JOIN Alumno_Curso ac
WHERE ac.Anio = 2024
GROUP BY c.Cod_Curso, c.Nombre, c.Descripcion
HAVING COUNT(ac.DNI) <= ALL (
    SELECT COUNT(DNI)
    FROM Alumno_Curso
    WHERE Anio = 2024
    GROUP BY Cod_Curso
)
-- En la segunda parte, COUNT(ac.DNI) <= ALL (Subconsulta) identifica los grupos cuyo conteo sea igual o inferior al conteo de todos los demás grupos, identificando el mínimo.
```
---
### 8) Listar el DNI, Apellido, Nombre y Legajo de alumnos que realizaron cursos con nombre conteniendo el string ‘BD’ durante 2022 pero no realizaron ningún curso durante 2023.

```sql
SELECT a.DNI, p.Apellido, p.Nombre, a.Legajo
FROM Persona p
NATURAL JOIN Alumno a
NATURAL JOIN Alumno_Curso ac
INNER JOIN Curso c ON ac.Cod_Curso = c.Cod_Curso
WHERE (ac.Anio = 2022) AND (c.Nombre LIKE '%BD%')

EXCEPT

SELECT a.DNI, p.Apellido, p.Nombre, a.Legajo
FROM Persona p
NATURAL JOIN Alumno a
NATURAL JOIN Alumno_Curso ac
INNER JOIN Curso c ON ac.Cod_Curso = c.Cod_Curso
WHERE ac.Anio = 2023
```
---
### 9) Agregar un profesor con los datos que prefiera y agregarle el título con código: 25.

```sql
INSERT INTO Persona (
	DNI,
	Apellido,
	Nombre,
	Fecha_Nacimiento,
	Estado_Civil,
	Genero
)
VALUES (
	11222333,
	'Gómez',
	'Raúl',
	'1983-09-12',
	'Casado',
	'M'
)

INSERT INTO Profesor (
	DNI,
	Matricula,
	Nro_Expediente
)
VALUES (
	11222333,
	'MAT-400',
	5004
)

INSERT INTO Titulo_Profesor (
	Cod_Titulo,
	DNI,
	Fecha
)
VALUES (
	25,
	11222333,
	'2007-12-17'
)
```
---
### 10) Modificar el estado civil del alumno cuyo legajo es ‘2020/09’, el nuevo estado civil es divorciado.

```sql
UPDATE Persona p
INNER JOIN Alumno a ON p.DNI = a.DNI -- NATURAL JOIN no funciona en UPDATE
SET p.Estado_Civil = 'Divorciado'
WHERE a.Legajo = '2020/09' 

-- otra opción:

UPDATE Persona
SET Estado_Civil = 'Divorciado'
WHERE DNI IN (
	SELECT DNI
	FROM Alumno
	WHERE Legajo = '2020/09'
)
```
---
### 11) Dar de baja el alumno con DNI 30568989. Realizar todas las bajas necesarias para no dejar el conjunto de relaciones en un estado inconsistente.

```sql
DELETE
FROM Alumno_Curso
WHERE DNI = 30568989

DELETE
FROM Alumno
WHERE DNI = 30568989

DELETE
FROM Persona
WHERE DNI = 30568989
```