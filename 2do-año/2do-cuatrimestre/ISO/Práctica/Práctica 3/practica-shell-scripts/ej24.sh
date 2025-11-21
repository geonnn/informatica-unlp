#!/bin/bash

# ¿cómo se podría retornar el arreglo para usarlo por fuera del script?
# primer paréntesis: inicialización de array
# segundo paréntesis: command substitution.
# Da la salida de los usuarios separadas por espacios.
# Quedan dentro de la inicialización de array, así los toma como distintos elementos.
users=($(getent group users | cut -d: -f4 | tr ',' ' '))

if [ -z $1 ]; then
	echo "Uso: ./$0 [parámetro]"
	echo "-b [posición]: Retorna el elemento de la posición n del arreglo si el mismo existe."
	echo "-l: Devuelve la longitud del arreglo."
	echo "-i: Imprime todos los elementos del arreglo."
	exit 1
fi

if [ $1 == "-b" ]; then

	# =~: comparar valor de la izquierda contra una regex.
	# ^[0-9]+$: es una regex
		# ^: indica comienzo de string
		# [0-9]: matchea dígitos del 0 al 9
		# +: indica que los elementos previos deben aparecer al menos una vez
		# $: indica fin del string
	# este if verifica si el parámetro 2 es un número
	if [[ $2 =~ ^[0-9]+$ && $2 -lt ${#users[@]} ]]; then
		echo ${users[$2]}
	else
		echo "Error: el parámetro luego de -b está fuera de rango o no es un número."
		echo "Uso: ./$0 -b [posición]"
		exit 2
	fi
fi

if [ $1 == "-l" ]; then
	echo ${#users[@]}
fi

if [ $1 == "-i" ]; then
	echo ${users[@]}
fi

exit 0
