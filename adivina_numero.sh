#!/bin/bash
# Leer el uidNumber del archivo externo
uidNumber=$(<"$uid_file")
#Mostrar el menu
echo "1.Jugar"
echo "2.Salir"
read opcion
case $opcion in
  1)
    Jugando= 0
    Intentos= 0
    NumRandom= $(($RANDOM % 100))
    while ($jugando e 0); do
    echo "Intente adivinar un numero generado de forma random entre el 1 y el 100"
    echo "Introduzca el numero"
    read guess
    ($Intentos++)
    if ($guess e $NumRandom) then
      echo "Felicidades lo has conseguido en $Intentos intentos"
  ;;
  2)
    echo "Adios, vuelva pronto"
  ;;
  *)
    echo "Opcion invalida saliendo del juego"
  ;;
