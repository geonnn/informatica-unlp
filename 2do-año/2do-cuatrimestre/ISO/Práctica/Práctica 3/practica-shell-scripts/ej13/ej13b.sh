#!/bin/bash

select accion in "Listar" "DondeEstoy" "QuienEsta" "Salir"
do
	case $accion in
		"Listar")
			ls .
			;;
		"DondeEstoy")
			pwd
			;;
		"QuienEsta")
			who -a
			;;
		"Salir")
			exit 0
			;;
	esac
done
