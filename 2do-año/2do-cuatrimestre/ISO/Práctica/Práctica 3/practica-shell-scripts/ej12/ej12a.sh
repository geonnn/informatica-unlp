#!/bin/bash

echo "Ingrese dos números:"
read a b
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
