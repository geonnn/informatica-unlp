#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Uso: $0 <extensión>"
	echo "Ejemplo: $0 sh"
	exit 1
fi

ext="$1"
output="reporte.txt"

echo "Usuario	Cantidad" > "$output"
echo "------------------------------" >> "$output"

# find .: busca donde en el current working dir.
# -type f: tipo de archivo regular file.
# -name "*.$ext": que tengan al final de su nombre ".<extensión>".
# -printf "%u\n": imprime el owner de cada archivo.
# sort: ordena.
# uniq -c: cuenta.

# awk: procesa texto.
	# salida después de uniq -c:
	# 10 gonzalo
	# 7 pepe

	# objetivo: 
	# gonzalo 10
	# pepe 7

	# entonces:
	# printf: imprime con formato.
	#"'%-10s %d\n": formato string en columna de 10 espacios, después número.
		# -10s:
			# -: alineado a la izquierda.
			# 10: 10 caracteres de ancho.
			# s: string.
		# %d\n:
			# %d: placeholder para un entero.
			# \n: salto de línea.
	# $2: segundo campo
	# $1: primer campo.
	# $2, $1 los invierte.

find . -type f -name "*.$ext" -printf "%u\n" | sort | uniq -c \
	| awk '{printf "%-10s %d\n", $2, $1}' >> "$output"

echo "Reporte generado en $output"
exit 0
