#!/bin/bash
Jugando=0
Intentos=0
NumRandom=$(($RANDOM % 100))
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
        if [ guess < NumRandom ]; then
            echo "Es un numero mayor vuelve a intentarlo"
        elif [ guess > NumRandom ]; then
            echo "Es un numero menor vuelve a intentarlo"
        else
            echo "¡Felicidades! Has adivinado el número."
            echo "Lo lograste en $intentos intentos."
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
