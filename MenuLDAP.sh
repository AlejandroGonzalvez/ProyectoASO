#!/bin/bash
# Leer el uidNumber del archivo externo
uid_file="/home/alejandro/ASOProyecto/uidNumber.txt"
uidNumber=$(<"$uid_file")
#Mostrar el menu
echo "Pulse 1 si quiere crear una nueva entrada en el directorio LDAP"
echo "Pulse 2 si quiere modificar una entrada en el directorio LDAP"
echo "Pulse 3 si quiere eliminar una entrada en el directorio LDAP"
read opcion
case $opcion in
	#Codigo para crear un nuevo usuario LDAP
	1)
		#Leer las opciones necesarias para crear el usuario
		ldif_file="/home/alejandro/ASOProyecto/UsuariosScript.ldif"
		read -p "Por favor, ingresa tu nombre: " nombre
		read -p "Por favor, ingresa tu apellido: " apellido
		read -p "Por favor, ingresa tus iniciales: " iniciales
		read -s -p "Por favor, ingresa tu contraseña: " contrasena
  		echo  # Annade el salto de linea
		echo "dn: uid="$nombre",ou=usuarios,dc=alexServer,dc=Local" >> $ldif_file
		echo "objectClass:inetOrgPerson" >> $ldif_file
		echo "objectClass: posixAccount" >> $ldif_file
		echo "objectClass: shadowAccount" >> $ldif_file
		echo "uid: "$nombre >> $ldif_file
		echo "sn: "$apellido >> $ldif_file
		echo "givenName: "$nombre >> $ldif_file
		echo "cn: "$nombre >> $ldif_file
		echo "uidNumber: "$uidNumber >> $ldif_file
		echo "gidNumber: 10000" >> $ldif_file
		echo "userPassword: "$contrasena >> $ldif_file
		echo "gecos: "$nombre >> $ldif_file
		echo "loginShell: /bin/bash" >> $ldif_file
		echo "homeDirectory:/home/"$nombre >> $ldif_file
		echo "shadowExpire: -1" >> /$ldif_file
		echo "shadowFlag: 0" >> $ldif_file
		echo "shadowWarning: 7" >> $ldif_file
		echo "shadowMin: 8" >> $ldif_file
		echo "shadowMax: 999999" >> $ldif_file
		echo "shadowLastChange: 10877" >> $ldif_file
		echo "mail: "$nombre"@AlexServer.com" >> $ldif_file
		echo "o:AlexServer" >> $ldif_file
		echo "initials: "$iniciales >> $ldif_file
		echo >> $ldif_file
		#Guardar el usuario en unsegundo archivo para tener la informacion
		cat $ldif_file >> UsuariosLDAP.txt
		#Icrementar el uidNumber
		((uidNumber++))
		#Guardar el uidNumber incrementado
		echo "$uidNumber" > "$uid_file"
		#Anadir el usuario al registro LDAP
		ldapadd -x -D "cn=admin,dc=AlexServer,dc=Local" -W -f UsuariosScript.ldif
		#Limpiar el archivo ldif
		: > "$ldif_file"
	;;
	#Codigo para modificar un usuario LDAP
	2)
		#Pedir el usuario a modificar, el campo a modificar y a que se modificara
		ldif_file="/home/alejandro/ASOProyecto/Modificacion.ldif"
		read -p "Introduzaca el nombre del usuario que desea modifcar: " nombre
		read -p "Introduzca el campo a modificar (cn, sn, mail...etc): " campo
		read -p "Introduzca el campo modificado: " nuevoCampo
		echo "dn: uid="$nombre",ou=usuarios,dc=alexServer,dc=Local" >> $ldif_file
		echo "changetype: modify" >> $ldif_file
		echo "replace: "$campo >> $ldif_file
		echo $campo": "$nuevoCampo >> $ldif_file
		#Ejecutar el cambio
		ldapmodify -x -D cn=admin,dc=AlexServer,dc=Local -W -f Modificacion.ldif
		#Limpiar el archivo ldif
		: > "$ldif_file"
	;;
	#Codigo para eliminar un usuario LDAP
	3)
		read -p "Introduzaca el nombre del usuario que desea eliminar: " nombre
		ldapdelete -x -W -D cn=admin,dc=AlexServer,dc=Local uid=$nombre,ou=usuarios,dc=alexServer,dc=Local
	;;
	#Codigo de error si el usuario introduce algo inesperado
	*)
		echo "Entrada invalida, por favor reinicie el script y introduzca el numero 1, 2 o 3"
	;;
esac
