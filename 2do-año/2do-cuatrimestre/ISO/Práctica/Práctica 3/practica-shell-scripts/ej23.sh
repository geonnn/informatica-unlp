#!/bin/bash

v1=(1 2 3 4 5 6 7 8 9 10)
v2=(11 12 13 14 15 16 17 18 19 20)

size=$(( ${#v1[@]} - 1 ))
for n in $(seq 0 $size); do
	res=$(( v1[n] + v2[n] ))
	echo "La suma de los elementos en la posición $n de los vectores es $res"
done
