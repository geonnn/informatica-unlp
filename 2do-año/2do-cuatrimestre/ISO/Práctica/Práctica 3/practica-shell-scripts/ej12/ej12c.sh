#!/bin/bash

# if [ cantidad de parámetros != 3]
if [ $# -ne 3 ]; then
	echo "Se deben enviar 2 números y un operador por parámetros"
	echo "Formato: ./ej12b.sh a operador b"
	exit 2
fi

echo "a =" $1
echo "b =" $3
echo "operador =" $2
echo "Resultado =" $(expr $1 $2 $3)
echo \*
