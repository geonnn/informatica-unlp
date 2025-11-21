#!/bin/bash

if [ $# -eq 0 ]; then
	echo "El script debe recibir al menos un parámetro."
	exit 1
fi

inexistentes=0
for i in $(seq 1 $#); do

	ruta="${!i}"
	# echo "debug: verificando $i: '$ruta'"
	if [ ! -e "$ruta" ]; then
		(( inexistentes++ ))
		continue
	fi

	if [ $(( i % 2 )) -eq 1 ]; then
		if [ -f "$ruta" ]; then
			echo "$ruta es regular file."
		elif [ -d "$ruta" ]; then
			echo "$ruta es directorio."
		else
			echo "$ruta no es regular file ni directorio."
		fi
	fi
done

echo "Rutas inexistentes: $inexistentes"
