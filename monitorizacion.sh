#!/bin/bash
#Identificar los cinco procesos que mas memoria concumen
ps aux --sort=-%mem | head -n 6 | tail -n 5
#Identificar los cinco procesos que mas CPU concumen
ps aux --sort=-%cpu | head -n 6 | tail -n 5
#Comprobar que ninguna particion del sistema tenga menos de un 10% de espacio libre
df -hP | tail -n +2 | while read -r linea; do
    # Obtener el porcentaje de uso de la partición
    particion=$(echo $linea | awk '{print $1}')#Se saca el nombre de la particion para usarlo en el mensaje de aviso
    uso=$(echo $linea | awk '{print $5}' | sed 's/%//g') #Para obtener el uso se usa el awk para scarl el procentaje y el sed para elimunar el % para que se pueda comparar en el if
    
    # Comparar el uso con el umbral
    if [ "$uso" -ge 90 ]; then
        # Si el uso es mayor o igual que 90% enviar un aviso
        echo "¡Alerta! La partición $particion tiene menos del 10% de espacio disponible."
    fi
done
