#!/bin/bash

set -e

# Script para actualizar componentes ejecutando git pull en cada carpeta
# Itera sobre componentes.txt y extrae el nombre de la carpeta

while IFS=: read -r componente version; do
    # Elimina espacios en blanco
    componente=$(echo "$componente" | xargs)
    version=$(echo "$version" | xargs)
    
    # Salta líneas vacías
    if [ -z "$componente" ]; then
        continue
    fi
    
    # Verifica si la carpeta existe
    if [ -d "$componente" ]; then
        echo "Actualizando $componente..."
        cd "$componente"
        git pull
        git checkout "$version"
        cd ..
    else
        echo "Advertencia: La carpeta '$componente' no existe"
    fi
done < componentes.txt

echo "Actualización completada"
