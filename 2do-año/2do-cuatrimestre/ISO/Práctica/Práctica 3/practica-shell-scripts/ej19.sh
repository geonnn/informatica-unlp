#!/bin/bash

PS3="Elegí una opción: "
echo "MENU DE COMANDOS"
while true; do
	select input in * "Salir"; do

	    if [ "$input" == "Salir" ]; then
			echo "Saliendo..."
			exit 0
		fi

		if [ -z "$input" ]; then
			echo "Opción inválida."
			continue
		fi

		if [ -d "$input" ]; then
			cd "$input"
			# break para romper el select y volver al while
			# para que se genere el menú de nuevo
			break
		else
			echo "Ejecutando script $input"
			echo "---------------------------"
			bash "$input"
		fi
	done
done
exit 0
