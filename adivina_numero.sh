#!/bin/bash
Intentos=0
NumRandom=$(($RANDOM % 100 +1))
#Mostrar el menu
while true; do
echo "1.Jugar"
echo "2.Salir"
read opcion
    case $opcion in
      1)
        while true; do
        echo "Intente adivinar un numero generado de forma random entre el 1 y el 100"
        echo "Introduzca el numero"
        read guess
        ((Intentos++))
        if (( guess < NumRandom )); then
            echo "Es un número mayor. Inténtalo de nuevo."
        elif (( guess > NumRandom )); then
            echo "Es un número menor. Inténtalo de nuevo."
        else
            echo "¡Felicidades! Has adivinado el número."
            echo "Lo lograste en $Intentos intentos."
            break
        fi
        done
      ;;
      2)
        echo "Gracias por jugar. ¡Hasta pronto!"
        exit 0 
      ;;
      *)
        echo "Opción no válida. Por favor, selecciona 1 o 2."
      ;;
      esac
done
