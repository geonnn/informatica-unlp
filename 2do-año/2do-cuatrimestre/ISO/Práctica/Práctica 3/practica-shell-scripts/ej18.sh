#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Se debe ingresar un nombre de usuario a buscar como parámetro"
    exit 1
fi

# grep -w: word. busca coincidencia exacta.
# grep -q: quiet. no da ninguna salida, devuelve 0 si se encontró lo que se buscaba, sino 1.
until who | grep -wq "$1"; do
    echo "Usuario no encontrado"
    echo "Verificando de nuevo en 10 segundos..."
    sleep 10
done

echo ""
echo "Usuario $1 logueado en el sistema."
exit 0