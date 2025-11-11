**Técnico** = (<u>codTec</u>, nombre, especialidad) // técnicos
**Repuesto** = (<u>codRep</u>, nombre, stock, precio) // repuestos
**RepuestoReparacion** = (<u>nroReparac (fk), codRep (fk)</u>, cantidad, precio) // repuestos utilizados en reparaciones.
**Reparación** = (<u>nroReparac</u>, codTec (fk), precio_total, fecha) // reparaciones realizadas.
### 1) Listar los repuestos, informando el nombre, stock y precio. Ordenar el resultado por precio.

```sql
SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
ORDER BY r.precio
```
---
### 2) Listar nombre, stock y precio de repuestos que se usaron en reparaciones durante 2023 y que no se usaron en reparaciones del técnico ‘José Gonzalez’.

```sql
SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
INNER JOIN RepuestoReparacion rr ON r.codRep = rr.codRep
INNER JOIN Reparacion rep ON rep.nroReparac = rr.nroReparac
WHERE rep.fecha >= '2023-01-01' AND rep.fecha <= '2023-12-31'

EXCEPT

SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
INNER JOIN RepuestoReparacion rr ON r.codRep = rr.codRep
INNER JOIN Reparacion rep ON rep.nroReparac = rr.nroReparac
INNER JOIN Tecnico t ON t.codTec = rep.codTec
WHERE t.nombre = 'José Gonzalez'
```
---
### 3) Listar el nombre y especialidad de técnicos que no participaron en ninguna reparación. Ordenar por nombre ascendentemente.

```sql
SELECT t.nombre, t.especialidad
FROM Tecnico t
LEFT JOIN Reparacion rep ON t.codTec = rep.codTec
GROUP BY t.codTec, t.nombre, t.especialidad
HAVING COUNT(rep.nroReparac) = 0
ORDER BY nombre
```
---
### 4) Listar el nombre y especialidad de los técnicos que solamente participaron en reparaciones durante 2022.

```sql
SELECT t.nombre, t.especialidad
FROM Tecnico t
NATURAL JOIN Reparacion rep
WHERE rep.fecha BETWEEN '2022-01-01' AND '2022-12-31'

EXCEPT

SELECT t.nombre, t.especialidad
FROM Tecnico t
NATURAL JOIN Reparacion rep
WHERE rep.fecha NOT BETWEEN '2022-01-01' AND '2022-12-31'
```
---
### 5) Listar para cada repuesto nombre, stock y cantidad de técnicos distintos que lo utilizaron. Si un repuesto no participó en alguna reparación igual debe aparecer en dicho listado.

```sql
SELECT r.nombre, r.stock,
	COUNT(DISTINCT t.codTec) AS tecnicos_que_lo_utilizaron 
FROM Repuesto r
LEFT JOIN RepuestoReparacion rr ON rr.codRep = r.codRep
LEFT JOIN Reparacion rep ON rep.nroReparac = rr.nroReparac
LEFT JOIN Tecnico t ON t.codTec = rep.codTec
GROUP BY r.codRep, r.nombre, r.stock
```
---
### 6) Listar nombre y especialidad del técnico con mayor cantidad de reparaciones realizadas y el técnico con menor cantidad de reparaciones.

```sql
SELECT t.nombre, t.especialidad, COUNT(r.nroReparac)
FROM Tecnico t
LEFT JOIN Reparacion r ON r.codTec = t.codTec
GROUP BY t.codTec, t.nombre, t.especialidad
HAVING COUNT(r.nroReparac) >= ALL (
	SELECT COUNT(r.nroReparac)
	FROM Tecnico t
	LEFT JOIN Reparacion r ON r.codTec = t.codTec
	GROUP BY t.codTec
)

UNION

SELECT t.nombre, t.especialidad, COUNT(r.nroReparac)
FROM Tecnico t
LEFT JOIN Reparacion r ON r.codTec = t.codTec
GROUP BY t.codTec, t.nombre, t.especialidad
HAVING COUNT(r.nroReparac) <= ALL (
	SELECT COUNT(r.nroReparac)
	FROM Tecnico t
	LEFT JOIN Reparacion r ON r.codTec = t.codTec
	GROUP BY t.codTec
)
```
---
### 7) Listar nombre, stock y precio de todos los repuestos con stock mayor a 0 y que dicho repuesto no haya estado en reparaciones con un precio total superior a $10000.

```sql
SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
WHERE r.stock > 0

EXCEPT

SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
INNER JOIN RepuestoReparacion rr ON rr.codRep = r.codRep
INNER JOIN Reparacion rep ON rep.nroReparac = rr.nroReparac
WHERE rep.precio_total > 10000
```
---
### 8) Proyectar número, fecha y precio total de aquellas reparaciones donde se utilizó algún repuesto con precio en el momento de la reparación mayor a $10000 y menor a $15000.

```sql
SELECT DISTINCT rep.nroReparac, rep.fecha, rep.precio_total
FROM Reparacion rep
NATURAL JOIN RepuestoReparacion rr
WHERE rr.precio > 10000 AND rr.precio < 15000
```
---
### 9) Listar nombre, stock y precio de repuestos que hayan sido utilizados por todos los técnicos.

```sql
SELECT r.nombre, r.stock, r.precio
FROM Repuesto r
WHERE NOT EXISTS (
	SELECT *
	FROM Tecnico t
	WHERE NOT EXISTS (
		SELECT *
		FROM Reparacion rep
		NATURAL JOIN RepuestoReparacion rr
		WHERE rep.codTec = t.codTec
			AND rr.codRep = r.codRep
	)
)
```
---
### 10) Listar fecha, técnico y precio total de aquellas reparaciones que necesitaron al menos 4 repuestos distintos.

```sql
SELECT rep.fecha, t.nombre, rep.precio_total
FROM Reparacion rep
NATURAL JOIN Tecnico t
NATURAL JOIN RepuestoReparacion rr
GROUP BY rep.nroReparac, rep.fecha, t.nombre, rep.precio_total
HAVING COUNT(DISTINCT rr.codRep) >= 4
```