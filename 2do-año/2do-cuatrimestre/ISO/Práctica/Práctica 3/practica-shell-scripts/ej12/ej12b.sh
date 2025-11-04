#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Se deben ingresar 2 números por parámetro"
	exit 2
fi

a=$1
b=$2

echo "a =" $a
echo "b =" $b
echo "Multiplicación:" `expr $a \* $b`
echo "Suma:" `expr $a \+ $b`
echo "Resta:" `expr $a \- $b`

if [ $(expr $a \> $b) -eq 1 ]; then
	mayor=$a
else
	mayor=$b
fi
echo "El mayor es:" $mayor
