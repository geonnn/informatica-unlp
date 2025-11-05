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
SELECT DISTINCT nombre, apellido, DNI, telefono, direccion
FROM Cliente NATURAL JOIN Factura
WHERE (fecha BETWEEN "2024-01-01" AND "2024-12-31")
```
---
### 3)

```sql
SELECT nombreP, descripcion, precio, stock
FROM Producto
NATURAL JOIN Detalle
NATURAL JOIN Factura
NATURAL JOIN Cliente 
WHERE (DNI = 45789456)
EXCEPT (
	SELECT nombreP, descripcion, precio, stock
	FROM Producto
	NATURAL JOIN Detalle
	NATURAL JOIN Factura
	NATURAL JOIN Cliente
	WHERE apellido = "García"
)
```
---
### 4)

```sql
SELECT nombreP, descripcion, precio, stock
FROM Producto
EXCEPT (
	SELECT nombreP, descripcion, precio, stock
	FROM Producto
	NATURAL JOIN Detalle
	NATURAL JOIN Factura
	NATURAL JOIN Cliente
	WHERE telefono LIKE "221%"
)
ORDER BY nombreP
```
---
### 5)

```sql
SELECT nombreP, descripcion, precio,
	COUNT(d.idProducto) as veces_vendido
FROM Producto p
LEFT JOIN Detalle d ON (p.idProducto = d.idProducto)
GROUP BY p.idProducto, nombreP, descripcion, precio
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
```
---
### 10)

```sql
SELECT nombreP, descripcion, precio,
	COUNT(d.idProducto) as veces_vendido
FROM Producto p
LEFT JOIN Detalle d ON (p.idProducto = d.idProducto)
GROUP BY p.idProducto, nombreP, descripcion, precio
```