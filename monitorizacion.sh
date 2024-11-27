#!/bin/bash
#Crear un documento donde se guarde to da la informacion
	touch moni.txt
#Revisar los procesos que mas memoria consumen
	#Identificar los cinco procesos que mas memoria consumen
 	echo "Cinco procesos que mas memoria consumen" >> moni.txt
	ps aux --sort=-%mem | head -n 6 | tail -n 5 >> moni.txt
	#Identificar los cinco procesos que mas CPU concumen
 	echo "Cinco procesos que mas CPU consumen" >> moni.txt
	ps aux --sort=-%cpu | head -n 6 | tail -n 5 >> moni.txt
#Revisar que ninguna particion tenga menos de un 10% de espacio libre
	# Porcentaje límite de espacio libre
	Limite=10

	# Obtener información sobre el uso de las particiones
	df -h | awk 'NR>1 {print $1, $5, $6}' | while read -r line; do #primero saca informacion de las particiones despues el awk saca el nombre de la particion ($1), el uso ($5) y su ubicaion ($6)
		Particion=$(echo $line | awk '{print $1}')      # Nombre de la partición
		Uso=$(echo $line | awk '{print $2}' | tr -d '%')  # Porcentaje de uso (sin '%')
		Ubicacion=$(echo $line | awk '{print $3}')     # Ubicaion de  la particion

		# Verificar si el uso excede el umbral
		if [ "$Uso" -ge $((100 - Limite)) ]; then
			echo "Advertencia: La partición $Particion montada en $Ubicacion tiene menos del $Limite% de espacio libre ($USAGE% usado)." >> moni.txt
		fi
	done
#Revisar los archivos syslog y dmesg para detectar errores y eventos criticos
	#Con el --level dmesg solo mostrara los mensajes de error el + le indica que incluya tambientodos los mensajes de un nivel superior a error em este caso eventos critucos, emergencias y alertas
	echo "Mensajes de el dmesg" >> moni.txt
 	dmesg --level=err+ >> moni.txt
	#El grep filtrara los mensajes con la palabra error del syslog
 	echo "Mensajes de error del syslog" >> moni.txt
  	grep "error" /var/log/syslog >> moni.txt
   	grep "crit" /var/log/syslog >> moni.txt
