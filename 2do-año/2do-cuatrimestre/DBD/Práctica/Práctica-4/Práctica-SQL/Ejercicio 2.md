**Localidad** = (<u>codigoPostal</u>, nombreL, descripcion, nroHabitantes)
**Arbol** = (<u>nroArbol</u>, especie, anios, calle, nro, codigoPostal(fk))
**Podador** = (<u>DNI</u>, nombre, apellido, telefono, fnac, codigoPostalVive(fk))
**Poda** = (<u>codPoda</u>, fecha, DNI(fk), nroArbol(fk))
### 1) Listar especie, años, calle, nro y localidad de árboles podados por el podador ‘Juan Perez’ y por el podador ‘Jose Garcia’.

```sql
-- distinct porque un mismo árbol puede haber sido podado varias veces por los dos podadores.
SELECT DISTINCT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l
NATURAL JOIN Arbol a
NATURAL JOIN Poda
NATURAL JOIN Podador p
WHERE (p.nombre = "Juan" AND p.apellido = "Pérez")

INTERSECT

SELECT DISTINCT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l
NATURAL JOIN Arbol a
NATURAL JOIN Poda
NATURAL JOIN Podador p
WHERE (p.nombre = "José") AND (p.apellido = "García")

```
---
### 2) Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos podadores que tengan podas realizadas durante 2023.

```sql
-- distinct porque un podador puede haber podado el mismo árbol varias veces en 2023 (de hecho, los hay).
SELECT DISTINCT p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
FROM Localidad l
INNER JOIN Podador p ON (p.codigoPostalVive = l.codigoPostal)
NATURAL JOIN Poda pd
WHERE (pd.fecha BETWEEN "2023-01-01" AND "2023-12-31")
```
---
### 3) Listar especie, años, calle, nro y localidad de árboles que no fueron podados nunca.

```sql
SELECT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Arbol a
NATURAL JOIN Localidad l

EXCEPT

-- podría ir un distinct acá para sacar una tupla por cada árbol que fue podado, optimizando la consulta, pero el resultado es el mismo.
SELECT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l
NATURAL JOIN Arbol a
NATURAL JOIN Poda
```
---
### 4) Reportar especie, años, calle, nro y localidad de árboles que fueron podados durante 2022 y no fueron podados durante 2023.

```sql
SELECT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l
NATURAL JOIN Arbol a
NATURAL JOIN Poda pd
WHERE pd.fecha BETWEEN "2022-01-01" AND "2022-12-31"

EXCEPT

SELECT a.especie, a.anios, a.calle, a.nro, l.nombreL
FROM Localidad l
NATURAL JOIN Arbol a
NATURAL JOIN Poda pd
WHERE pd.fecha BETWEEN "2023-01-01" AND "2023-12-31"
```
---
### 5) Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos podadores con apellido terminado con el string ‘ata’ y que tengan al menos una poda durante 2024. Ordenar por apellido y nombre.

```sql
SELECT DISTINCT p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
FROM Podador p
INNER JOIN Localidad l ON (p.codigoPostalVive = l.codigoPostal)
NATURAL JOIN Poda pd
WHERE (p.apellido LIKE "%ata") AND
    (pd.fecha BETWEEN "2024-01-01" AND "2024-12-31")
ORDER BY p.apellido, p.nombre
```
---
### 6) Listar DNI, apellido, nombre, teléfono y fecha de nacimiento de podadores que sólo podaron árboles de especie ‘Conífera’.

```sql
SELECT DISTINCT p.DNI, p.apellido, p.nombre, p.telefono, p.fnac
FROM Podador p
NATURAL JOIN Poda pd
NATURAL JOIN Arbol a
WHERE a.especie = "Conífera"

EXCEPT

SELECT DISTINCT p.DNI, p.apellido, p.nombre, p.telefono, p.fnac
FROM Podador p
NATURAL JOIN Poda pd
NATURAL JOIN Arbol a
WHERE a.especie <> "Conífera"
```
---
### 7) Listar especies de árboles que se encuentren en la localidad de ‘La Plata’ y también en la localidad de ‘Salta’.

```sql
SELECT DISTINCT a.especie
FROM Arbol a
NATURAL JOIN Localidad l
WHERE l.nombreL = "La Plata"

INTERSECT

SELECT DISTINCT a.especie
FROM Arbol a
NATURAL JOIN Localidad l
WHERE l.nombreL = "Salta"
```
---
### 8) Eliminar el podador con DNI 22234566.

```sql
DELETE
FROM Podador p
WHERE p.DNI = 22234566
```
---
### 9) Reportar nombre, descripción y cantidad de habitantes de localidades que tengan menos de 5 árboles.

```sql
SELECT l.nombreL, l.descripcion, l.nroHabitantes
FROM Localidad l
NATURAL JOIN Arbol a
GROUP BY l.codigoPostal, l.nombreL, l.descripcion, l.nroHabitantes
HAVING COUNT(a.nroArbol) < 5
```