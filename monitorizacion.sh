#!/bin/bash
#Identificar los cinco procesos que mas memoria consumen
ps aux --sort=-%mem | head -n 6 | tail -n 5
#Identificar los cinco procesos que mas CPU concumen
ps aux --sort=-%cpu | head -n 6 | tail -n 5

# Porcentaje límite de espacio libre
THRESHOLD=10

# Obtener información sobre el uso de las particiones
df -h | awk 'NR>1 {print $1, $5, $6}' | while read -r line; do
    PARTITION=$(echo $line | awk '{print $1}')      # Nombre de la partición
    USAGE=$(echo $line | awk '{print $2}' | tr -d '%')  # Porcentaje de uso (sin el símbolo '%')
    MOUNTPOINT=$(echo $line | awk '{print $3}')     # Punto de montaje

    # Verificar si el uso excede el umbral
    if [ "$USAGE" -ge $((100 - THRESHOLD)) ]; then
        echo "Advertencia: La partición $PARTITION montada en $MOUNTPOINT tiene menos del $THRESHOLD% de espacio libre ($USAGE% usado)."
    fi
done
