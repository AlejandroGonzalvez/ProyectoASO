#!/bin/bash
# Leer el uidNumber del archivo externo
uidNumber=$(<"$uid_file")
#Mostrar el menu
echo "1.Jugar"
echo "2.Salir"
read opcion
case $opcion in
  1)
    
  ;;
  2)
    echo "Adios, vuelva pronto"
  ;;
  *)
    echo "Opcion invalida saliendo del juego"
  ;;
