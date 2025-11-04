#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Se debe ingresar un nombre de archivo por parámetro"
	exit 2
fi

# parámetros entre comillas por si tiene espacios.
# -print: devuelve la ruta del archivo.
# -quit: retorna el primer resultado y corta la ejecución.
archivo=$(find . -name "$1" -print -quit)

# -e: exists.
# -d: es directorio.
# -f: es regular file.
if [ -e "$archivo" ]; then

	if [ -d "$archivo" ]; then
		echo "$archivo es de tipo directorio."
	else
		echo "$archivo es regular file."
	fi
else
	echo "El archivo no existe."
	echo "Creando directorio $(pwd)/$1/"
	mkdir $(pwd)/$1
fi
