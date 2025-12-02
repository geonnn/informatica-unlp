**Banda** = (<u>codigoB</u>, nombreBanda, genero_musical, anio_creacion)
**Integrante** = (<u>DNI</u>, nombre, apellido, dirección, email, fecha_nacimiento, codigoB(fk))
**Escenario** = (<u>nroEscenario</u>, nombre_escenario, ubicación, cubierto, m2, descripción)
**Recital** = (<u>fecha, hora, nroEscenario (fk)</u>, codigoB (fk))
### 1) Listar DNI, nombre, apellido,dirección y email de integrantes nacidos entre 1980 y 1990 y que hayan realizado algún recital durante 2023.

```sql
-- distinct porque un mismo integrante puede haber tocado en dos recitales en 2023 (lo hay).
SELECT DISTINCT i.DNI, i.nombre, i.apellido, i.direccion, i.email
FROM Integrante i
NATURAL JOIN Banda
NATURAL JOIN Recital r
WHERE (i.fecha_nacimiento BETWEEN "1980-01-01" AND "1990-12-31")
    AND (r.fecha BETWEEN "2023-01-01" AND "2023-12-31")
```
---
### 2) Reportar nombre, género musical y año de creación de bandas que hayan realizado recitales durante 2023, pero no hayan tocado durante 2022.

```sql
-- ¿distinct? con/sin el resultado es el mismo. except elimina duplicados, pero distinct podría servir para los duplicados que pasan el filtro del except?
SELECT b.nombreBanda, b.genero_musical, b.anio_creacion
FROM Banda b
NATURAL JOIN Recital r
WHERE (r.fecha BETWEEN "2023-01-01" AND "2023-12-31")

EXCEPT

SELECT b.nombreBanda, b.genero_musical, b.anio_creacion
FROM Banda b
NATURAL JOIN Recital r
WHERE (r.fecha BETWEEN "2022-01-01" AND "2022-12-31")
```
---
### 3) Listar el cronograma de recitales del día 04/12/2023. Se deberá listar nombre de la banda que ejecutará el recital, fecha, hora, y el nombre y ubicación del escenario correspondiente.

```sql
SELECT b.nombreBanda, r.fecha, r.hora, e.nombre_escenario, e.ubicacion
FROM Banda b
NATURAL JOIN Recital r
NATURAL JOIN Escenario e
WHERE r.fecha = "2023-12-04"
```
---
### 4) Listar DNI, nombre, apellido,email de integrantes que hayan tocado en el escenario con nombre ‘Gustavo Cerati’ y en el escenario con nombre ‘Carlos Gardel’.

```sql
SELECT DISTINCT i.DNI, i.nombre, i.apellido, i.email
FROM Integrante i
NATURAL JOIN Banda b
NATURAL JOIN Recital r
NATURAL JOIN Escenario e
WHERE e.nombre_escenario = "Gustavo Cerati"

INTERSECT

SELECT DISTINCT i.DNI, i.nombre, i.apellido, i.email
FROM Integrante i
NATURAL JOIN Banda b
NATURAL JOIN Recital r
NATURAL JOIN Escenario e
WHERE e.nombre_escenario = "Carlos Gardel"
```
---
### 5) Reportar nombre, género musical y año de creación de bandas que tengan más de 5 integrantes.

```sql
SELECT b.nombreBanda, b.genero_musical, b.anio_creacion
FROM Banda b
NATURAL JOIN Integrante i
GROUP BY b.codigoB, b.nombreBanda, b.genero_musical, b.anio_creacion
HAVING COUNT(i.DNI) > 5
```
---
### 6) Listar nombre de escenario, ubicación y descripción de escenarios que solo tuvieron recitales con el género musical rock and roll. Ordenar por nombre de escenario.

```sql
SELECT e.nombre_escenario, e.ubicacion, e.descripcion
FROM Escenario e
NATURAL JOIN Recital
NATURAL JOIN Banda b
WHERE b.genero_musical = "rock and roll"
    AND e.nroEscenario NOT IN (
		SELECT e2.nroEscenario
		FROM Escenario e2
		NATURAL JOIN Recital
		NATURAL JOIN Banda b2
		WHERE b2.genero_musical <> "rock and roll"
)
ORDER BY e.nombre_escenario
```
---
### 7) Listar nombre, género musical y año de creación de bandas que hayan realizado recitales en escenarios cubiertos durante 2023. *// cubierto es true, false según corresponda.*

```sql
SELECT DISTINCT b.nombreBanda, b.genero_musical, b.anio_creacion
FROM Escenario e
NATURAL JOIN Recital r
NATURAL JOIN Banda b
WHERE e.cubierto
    AND (r.fecha BETWEEN "2023-01-01" AND "2023-12-31")
```
---
### 8) Reportar para cada escenario, nombre del escenario y cantidad de recitales durante 2024.

```sql
-- no muestra los escenarios que no tuvieron recitales en 2024:
SELECT e.nombre_escenario, COUNT(r.nroEscenario) as cantidad_de_recitales
FROM Escenario e
NATURAL JOIN Recital r
WHERE (r.fecha BETWEEN "2024-01-01" AND "2024-12-31")
GROUP BY e.nroEscenario, e.nombre_escenario

-- muestra los escenarios que no tuvieron recitales en 2024 poniéndoles 0.
SELECT e.nombre_escenario, COUNT(r.nroEscenario) as cantidad_de_recitales
FROM Escenario e
LEFT JOIN Recital r ON (e.nroEscenario = r.nroEscenario)
	AND (r.fecha BETWEEN "2024-01-01" AND "2024-12-31")
GROUP BY e.nroEscenario, e.nombre_escenario
```
---
### 9) Modificar el nombre de la banda ‘Mempis la Blusera’ a: ‘Memphis la Blusera’.

```sql
UPDATE Banda SET nombreBanda = "Memphis la Blusera"
WHERE nombreBanda = "Mempis la Blusera"
```