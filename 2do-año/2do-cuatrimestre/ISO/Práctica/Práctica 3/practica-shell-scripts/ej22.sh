#!/bin/bash

numeros=(1 2 3 4 5 6 7 8 9 10)
echo "Imprimir pares: "
for n in ${numeros[@]}; do

	if [ $(( $n % 2 )) -eq 0 ]; then
		echo "$n"
	else
		(( impares+=$n ))
	fi

done
echo "Count impares: $impares"
