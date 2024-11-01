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
		echo "dn: uid="$nombre",ou=usuarios,dc=alexServer,dc=Local" >> /home/alejandro/ASOProyecto/UsuariosScript.ldif
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
