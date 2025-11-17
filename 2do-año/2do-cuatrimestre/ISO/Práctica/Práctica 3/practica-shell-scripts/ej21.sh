#!/bin/bash

num=(10 3 5 7 9 3 5 4)
res=1

for n in ${num[@]}; do
	res=$((n * res))
done

echo "resultado: $res"
