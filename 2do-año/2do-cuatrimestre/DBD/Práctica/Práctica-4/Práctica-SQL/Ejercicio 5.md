**Agencia** = (<u>razon_social</u>, dirección, telef, email)
**Ciudad** = (<u>codigo_postal</u>, nombreCiudad, anioCreacion)
**Cliente** = (<u>dni</u>, nombre, apellido, telefono, direccion)
**Viaje** = (<u>fecha, hora, dni (fk)</u>, cpOrigen(fk), cpDestino(fk), razon_social(fk), descripcion)
### 1) Listar razón social, dirección y teléfono de agencias que realizaron viajes desde la ciudad de ‘La Plata’ (ciudad origen) y que el cliente tenga apellido ‘Roma’. Ordenar por razón social y luego por teléfono.

```sql
SELECT DISTINCT a.razon_social, a.direccion, a.telef
FROM Agencia a
NATURAL JOIN Viaje v
INNER JOIN Ciudad cd ON cd.codigo_postal = v.cpOrigen
INNER JOIN Cliente c ON v.dni = c.dni 
WHERE cd.nombreCiudad = 'La Plata' AND c.apellido = 'Roma'
ORDER BY a.razon_social, a.telef
```
---
### 2) Listar fecha, hora, datos personales del cliente, nombres de ciudades origen y destino de viajes realizados en enero de 2019 donde la descripción del viaje contenga el String ‘demorado’.

```sql
SELECT v.fecha, v.hora,
	c.dni, c.nombre, c.apellido, c.telefono, c.direccion,
	cdOrig.nombreCiudad AS origen,
	cdDest.nombreCiudad AS destino
FROM Viaje v
NATURAL JOIN Cliente c
INNER JOIN Ciudad cdOrig ON cdOrig.codigo_postal = v.cpOrigen
INNER JOIN Ciudad cdDest ON cdDest.codigo_postal = v.cpDestino
WHERE (v.fecha >= '2019-01-01' AND v.fecha <= '2019-01-31')
	AND (v.descripcion LIKE '%demorado%')
```
---
### 3) Reportar información de agencias que realizaron viajes durante 2019 o que tengan dirección de mail que termine con ‘\@jmail.com’.

```sql
SELECT a.razon_social, a.direccion, a.telef, a.email
FROM Agencia a
NATURAL JOIN Viaje v
WHERE v.fecha >= '2019-01-01' AND v.fecha <= '2019-12-31'

UNION

SELECT a.razon_social, a.direccion, a.telef, a.email
FROM Agencia a
WHERE a.email LIKE '%@jmail.com'
```
---
### 4) Listar datos personales de clientes que viajaron solo con destino a la ciudad de ‘Coronel Brandsen’.

```sql
SELECT c.dni, c.nombre, c.apellido, c.telefono, c.direccion
FROM Cliente c
NATURAL JOIN Viaje v
INNER JOIN Ciudad dest ON dest.codigo_postal = v.cpDestino
WHERE dest.nombreCiudad = 'Coronel Brandsen'

EXCEPT

SELECT c.dni, c.nombre, c.apellido, c.telefono, c.direccion
FROM Cliente c
NATURAL JOIN Viaje v
INNER JOIN Ciudad dest ON dest.codigo_postal = v.cpDestino
WHERE dest.nombreCiudad <> 'Coronel Brandsen'
```
---
### 5) Informar cantidad de viajes de la agencia con razón social ‘TAXI Y’ realizados a ‘Villa Elisa’.

```sql
SELECT COUNT(*)
FROM Agencia a
NATURAL JOIN Viaje v
INNER JOIN Ciudad dest ON dest.codigo_postal = v.cpDestino
WHERE a.razon_social = 'TAXI Y' AND dest.nombreCiudad = 'Villa Elisa'
```
---
### 6) Listar nombre, apellido, dirección y teléfono de clientes que viajaron con todas las agencias.

```sql
SELECT c.nombre, c.apellido, c.direccion, c.telefono
FROM Cliente c
WHERE NOT EXISTS (
	SELECT *
	FROM Agencia a
	WHERE NOT EXISTS (
		SELECT *
		FROM Viaje v
		WHERE v.dni = c.dni
		AND v.razon_social = a.razon_social  
	)
)
```
---
### 7) Modificar el cliente con DNI 38495444 actualizando el teléfono a ‘221-4400897’.
```sql
UPDATE Cliente SET telefono = '221-4400897'
WHERE DNI = 38495444
```
---
### 8) Listar razón social, dirección y teléfono de la/s agencias que tengan mayor cantidad de viajes

```sql
SELECT a.razon_social, a.direccion, a.telef
FROM Agencia a
NATURAL JOIN Viaje v
GROUP BY a.razon_social, a.direccion, a.telef
HAVING COUNT(v.razon_social) >= ALL (
	SELECT COUNT(v.razon_social)
	FROM Agencia a
	NATURAL JOIN Viaje v
	GROUP BY v.razon_social
)
```
---
### 9) Reportar nombre, apellido, dirección y teléfono de clientes con al menos 5 viajes.

```sql
SELECT c.nombre, c.apellido, c.direccion, c.telefono
FROM Cliente c
NATURAL JOIN Viaje v
GROUP BY c.dni, d.nombre, c.apellido, c.direccion, c.telefono
HAVING COUNT(*) >= 5
```
---
### 10) Borrar al cliente con DNI 40325692.

```sql
DELETE
FROM Viaje
WHERE dni = 40325692

DELETE
FROM Cliente
WHERE dni = 40325692
```