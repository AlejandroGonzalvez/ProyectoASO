#!/bin/bash
Jugando=0
Intentos=0
NumRandom=$(($RANDOM % 100))
#Mostrar el menu
while [[ $jugando -eq 0 ]]; do
echo "1.Jugar"
echo "2.Salir"
read opcion
case $opcion in
  1)
    while [[ $Jugando -eq 0 ]]; do
    echo "Intente adivinar un numero generado de forma random entre el 1 y el 100"
    echo "Introduzca el numero"
    read guess
    (($Intentos++))
    if [ $guess -e $NumRandom ]; then
      echo "Felicidades lo has conseguido en $Intentos intentos"
      $Jugando=1 
    elif [ $guess -gt $numRandom ]; then
      echo "Es un numero menor vuelve a intentarlo"
    else
      echo "Es un numero menor vuelve a intentarlo"
    fi
    done
  ;;
  2)
    echo "Gracias por jugar. ¡Hasta pronto!"
    $Jugando=1 
  ;;
  *)
    echo "Opción no válida. Por favor, selecciona 1 o 2."
  ;;
  esac
  done
