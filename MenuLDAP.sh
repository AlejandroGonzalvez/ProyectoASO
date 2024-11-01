#!/bin/bash
#Mostrar el menu
echo "Pulse 1 si quiere crear una nueva entrada en el directorio LDAP"
echo "Pulse 2 si quiere modificar una entrada en el directorio LDAP"
echo "Pulse 3 si quiere eliminar una entrada en el directorio LDAP"
read opcion
case $opcion in
	#Codigo para crear un nuevo usuario LDAP
	1)
		#Leer las opciones necesarias para crear el usuario
		read -p "Por favor, ingresa tu nombre: " nombre
		read -p "Por favor, ingresa tu apellido: " apellido
		read -p "Por favor, ingresa tus iniciales: " iniciales
		read -s -p "Por favor, ingresa tu contraseña: " contrasena
  		echo  # Annade el salto de linea
		echo "dn: uid="$nombre",ou=usuarios,dc=alexServer,dc=Local" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "objectClass:inetOrgPerson" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "objectClass: posixAccount" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "objectClass: shadowAccount" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "uid: "$nombre >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "sn: "$apellido >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "givenName: "$nombre >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "cn: "$nombre >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "cn: " >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "gidNumber: 10000" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "userPassword: "$contrasena >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "gecos: "$nombre >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "loginShell: /bin/bash" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "homeDirectory:/home/"$nombre >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowExpire: -1" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowFlag: 0" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowWarning: 7" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowMin: 8" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowMax: 999999" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "shadowLastChange: 10877" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "mail: "$nombre"@AlexServer.com" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "o:AlexServer" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo "initials: "$iniciales >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
		echo >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
	;;
	#Codigo para modificar un usuario LDAP
	2)
	;;
	#Codigo para eliminar un usuario LDAP
	3)
	;;
	#Codigo de error si el usuario introduce algo inesperado
	*)
		echo "Entrada invalida, por favor reinicie el script y introduzca el numero 1, 2 o 3"
	;;
esac
