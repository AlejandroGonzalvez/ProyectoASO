#!/bin/bash
# Establecer el nombre del archivo de log
	LOGFILE="/var/log/monitorizacion.log"
#Revisar los procesos que mas memoria consumen
	#Identificar los cinco procesos que mas memoria consumen
 	logger -p local0.info -t MONITORIZACION "Cinco procesos que más memoria consumen:" >> $LOGFILE
	ps aux --sort=-%mem | head -n 6 | tail -n 5 | logger -p local0.info -t MONITORIZACION >> $LOGFILE
	#Identificar los cinco procesos que mas CPU concumen
 	logger -p local0.info -t MONITORIZACION "Cinco procesos que más CPU consumen:" >> $LOGFILE
	ps aux --sort=-%cpu | head -n 6 | tail -n 5 | logger -p local0.info -t MONITORIZACION >> $LOGFILE
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
			logger -p local0.warn -t MONITORIZACION "Advertencia: La partición $Particion montada en $Ubicacion tiene menos del $Limite% de espacio libre ($Uso% usado)." >> $LOGFILE
		fi
	done
#Revisar los archivos syslog y dmesg para detectar errores y eventos criticos
	#Con el --level dmesg solo mostrara los mensajes de error el + le indica que incluya tambientodos los mensajes de un nivel superior a error em este caso eventos critucos, emergencias y alertas
		logger -p local0.err -t MONITORIZACION "Mensajes del dmesg (errores y eventos críticos):" >> $LOGFILE
		dmesg --level=err+ | logger -p local0.err -t MONITORIZACION >> $LOGFILE
	#El grep filtrara los mensajes con la palabra error del syslog
 		logger -p local0.err -t MONITORIZACION "Mensajes de error y críticos del syslog:" >> $LOGFILE
		grep -E "error|crit" /var/log/syslog | logger -p local0.err -t MONITORIZACION >> $LOGFILE
