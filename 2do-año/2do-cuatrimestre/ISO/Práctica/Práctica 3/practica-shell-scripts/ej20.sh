#!/bin/bash

pila=()

push() {

	local elemento="$1"
	if [ -z "$elemento" ]; then
		echo "Se debe indicar por parámetro qué elemento agregar."
		return 1
	fi

	pila+=("$1")
	echo "Se agregó '$elemento' a la pila."
	return 0
}

pop() {

	local length=${#pila[@]}

	if [ "$length" -eq 0 ]; then
		echo "Error: la pila está vacía."
		return 1
	fi

	local ult=$((length - 1))
	local valor_ult=${pila[ult]}
	unset pila[ult]
	echo "Se quitó el elemento '$valor_ult'."
}

length() {
	echo ${#pila[@]}
}

print() {

	if [ ${#pila[@]} -eq 0 ]; then
		echo "Pila vacía."
		return 0
	fi

	for i in ${pila[@]}; do
		echo "$i"
		echo ""
	done
}

PS3="Elegí una opción: "

select input in "Push" "Pop" "Length" "Print" "Salir"; do
	case "$input" in
		"Push")
			read -p "Ingresá el valor a agregar: " valor
			push "$valor"
			;;
		"Pop")
			pop
			;;
		"Length")
			length
			;;
		"Print")
			print
			;;
		"Salir")
			echo "Saliendo..."
			break
			;;
		*)
			echo "Opción inválida"
			;;
	esac
	echo ""
done
