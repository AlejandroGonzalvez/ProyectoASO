#!/bin/bash
#Actualizar el sistema
apt -y update && apt -y upgrade
#Obtener los parametros del servidor en este caso AlexServer.Local
Servidor="ldap://10.0.2.20/"
BaseServidor="dc=AlexServer,dc=Local"
AdminServer="cn=admin,$BaseServidor"
ContrasenaServidor="123"
echo "ldap-auth-config ldap-auth-config/ldap-server string $Servidor" | sudo debconf-set-selections
echo "ldap-auth-config ldap-auth-config/base-dn string $BaseServidor" | sudo debconf-set-selections
echo "ldap-auth-config ldap-auth-config/bind-dn string $AdminServer" | sudo debconf-set-selections
echo "ldap-auth-config ldap-auth-config/bindpw password $ContrasenaServidor" | sudo debconf-set-selections
echo "ldap-auth-config ldap-auth-config/ldap-version select 3" | sudo debconf-set-selections
#Tras configurar los parametros por defecto de ldap-auth-config al instalar los paquetes del ldap no requeriran intervencion del usuario
DEBIAN_FRONTEND=noninteractive apt-get install -y libnss-ldap libpam-ldap ldap-utils
#Configuracion del Equipo cliente
sudo sed -i 's/files systemd sss/files ldap/g' /etc/nsswitch.conf
echo "session optional  pam_mkhomedir.so  skel=/etc/skel  umask=077" >> /etc/pam.d/common-session
