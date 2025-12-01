### 1)

```sql
SELECT nombre, apellido, DNI, telefono, direccion
FROM Cliente
WHERE apellido LIKE "Pe%"
ORDER BY DNI
```
---
### 2)

```sql
SELECT c.nombre, c.apellido, c.DNI, c.telefono, c.direccion
FROM Cliente c
NATURAL JOIN Factura f
WHERE f.fecha BETWEEN "2024-01-01" AND "2024-12-31"

EXCEPT (
	SELECT c2.nombre, c2.apellido, c2.DNI, c2.telefono, c2.direccion
	FROM Cliente c2
	NATURAL JOIN Factura f2
	WHERE f2.fecha < "2024-01-01" AND f2.fecha > "2024-12-31"
)
```
---
### 3)

```sql
SELECT p.nombreP, p.descripcion, p.precio, p.stock
FROM Producto p
NATURAL JOIN Detalle
NATURAL JOIN Factura
NATURAL JOIN Cliente c
WHERE c.DNI = 45789456

EXCEPT (
	SELECT p2.nombreP, p2.descripcion, p2.precio, p2.stock
	FROM Producto p2
	NATURAL JOIN Detalle
	NATURAL JOIN Factura
	NATURAL JOIN Cliente c2
	WHERE c2.apellido = "García"
)
```
---
### 4)

```sql
SELECT p.nombreP, p.descripcion, p.precio, p.stock
FROM Producto p
WHERE p.idProducto NOT IN (
    SELECT p2.idProducto
    FROM Producto p2
    NATURAL JOIN Detalle
    NATURAL JOIN Factura
    NATURAL JOIN Cliente c
    WHERE c.telefono LIKE "221%"
)
ORDER BY p.nombreP
```
---
### 5)

```sql
SELECT p.nombreP, p.descripcion, p.precio, COUNT(d.idProducto) AS veces_vendido
FROM Producto p
LEFT JOIN Detalle d ON p.idProducto = d.idProducto
GROUP BY p.idProducto, p.nombreP, p.descripcion, p.precio
```
---
### 6)

```sql
SELECT nombre, apellido, DNI, telefono, direccion
FROM Cliente c
NATURAL JOIN Factura
NATURAL JOIN Detalle
NATURAL JOIN Producto
WHERE 
	c.idCliente IN (
        SELECT f.idCliente
        FROM Factura f
        NATURAL JOIN Detalle d
        NATURAL JOIN Producto p
        WHERE p.nombreP = "prod1"
    )

    AND c.idCliente IN (
        SELECT f.idCliente
        FROM Factura f
        NATURAL JOIN Detalle d
        NATURAL JOIN Producto p
        WHERE p.nombreP = "prod2"
    )
EXCEPT (
	SELECT nombre, apellido, DNI, telefono, direccion
	FROM Cliente
	NATURAL JOIN Factura
	NATURAL JOIN Detalle
	NATURAL JOIN Producto
	WHERE nombreP = "prod3"
)

-- otra opción:

SELECT nombre, apellido, DNI, telefono, direccion
FROM Cliente c
NATURAL JOIN Factura
NATURAL JOIN Detalle
NATURAL JOIN Producto p
WHERE p.nombreP = "prod1"
INTERSECT (
        SELECT nombre, apellido, DNI, telefono, direccion
        FROM Cliente c
        NATURAL JOIN Factura
        NATURAL JOIN Detalle
        NATURAL JOIN Producto p
        WHERE p.nombreP = "prod2"
)
EXCEPT (
    SELECT nombre, apellido, DNI, telefono, direccion
    FROM Cliente
    NATURAL JOIN Factura
    NATURAL JOIN Detalle
    NATURAL JOIN Producto
    WHERE nombreP = "prod3"
)

-- otra opción:

SELECT c.nombre, c.apellido, c.DNI, c.telefono, c.direccion
FROM Cliente c
WHERE c.idCliente IN (
	SELECT DISTINCT c2.idCliente
	FROM Cliente c2
	NATURAL JOIN Factura
	NATURAL JOIN Detalle
	NATURAL JOIN Producto p
	WHERE p.nombreP = "prod1"
) 
AND c.idCliente IN (
	SELECT DISTINCT c3.idCliente
	FROM Cliente c3
	NATURAL JOIN Factura
	NATURAL JOIN Detalle
	NATURAL JOIN Producto p2
	WHERE p2.nombreP = "prod2"
)
AND c.idCliente NOT IN (
	SELECT DISTINCT c4.idCliente
	FROM Cliente c4
	NATURAL JOIN Factura
	NATURAL JOIN Detalle
	NATURAL JOIN Producto p3
	WHERE p3.nombreP = "prod3"
)
```
---
### 7)

```sql
SELECT DISTINCT f.nroTicket, f.total, f.fecha, f.hora, c.DNI
FROM Cliente c
NATURAL JOIN Factura f
NATURAL JOIN Detalle
NATURAL JOIN Producto p
WHERE (f.fecha BETWEEN "2023-01-01" AND "2023-12-31")
	OR (p.nombreP = "prod38")
```
---
### 8)

```sql
INSERT INTO Cliente (
    idCliente,
    nombre,
    apellido,
    DNI,
    direccion,
    telefono
)
VALUES (
    500002,
    "Jorge Luis",
    "Castor",
    40578999,
    "11 entre 500 y 501 nro:2587",
    "221-4400789"
)
```
---
### 9)

```sql
SELECT f.nroTicket, f.total, f.fecha, f.hora
FROM Cliente c
NATURAL JOIN Factura f
WHERE c.nombre = "Jorge" AND c.apellido = "Pérez"
EXCEPT (
	SELECT f.nroTicket, f.total, f.fecha, f.hora
	FROM Cliente c
	NATURAL JOIN Factura f
	NATURAL JOIN Detalle
	NATURAL JOIN Producto p
	WHERE (c.nombre = "Jorge" AND c.apellido = "Pérez")
	    AND p.nombreP = "Z"
)

-- otra opción:

SELECT DISTINCT f.nroTicket, f.total, f.fecha, f.hora
FROM Factura f
NATURAL JOIN Cliente c
WHERE c.nombre = "Jorge" AND c.apellido = "Pérez"
    AND f.nroTicket NOT IN (
		SELECT f2.nroTicket
		FROM Factura f2
		NATURAL JOIN Cliente c2
		NATURAL JOIN Detalle
		NATURAL JOIN Producto p
		WHERE c2.nombre = "Jorge" AND c.apellido = "Pérez"
		    AND p.nombreP = "Z"
	)
```
---
### 10)

```sql
SELECT c.DNI, c.apellido, c.nombre
FROM Cliente c
NATURAL JOIN Factura f
GROUP BY c.idCliente, c.DNI, c.apellido, c.nombre
HAVING SUM(f.total) > 100000
```