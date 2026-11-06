# Capa de transporte

- Si no hay ninguna aplicación escuchando en el puerto X
	- En TCP responde con: RESET ACK
	- En UDP responde con: Port unreachable.
- Control de flujos: manejo del tamaño de las ventanas. Lo manejan los extremos, no la red. No confundir con control de congestión.

# Capa de enlace

- la estructura de la trama en la que se encapsula el datagrama IP puede cambiar según el tipo de conexión (wi-fi, cableado, etc.)
- entramado (framing): encapsula el datagrama IP + header y trailer.
- se implementa detección de errores. El emisor agrega bits de detección, corrección, checksum, etc. que el receptor utiliza para verificar el datagrama.
- **CRC:** mecanismo que permite calcular R usando un polinomio G. Concatena R a los datos D y envia la trama (D, R). El receptor recibe (D, R) y lo divide por el polinomio G. Si el resultado es distinto a 0 la trama se descarta porque presenta errores.

- **Direcciones MAC:** 48 bits. Broadcast: FF:FF:FF:FF. Una placa de red sólo recibe la trama si la MAC destino es igual a la propia o a la de broadcast.