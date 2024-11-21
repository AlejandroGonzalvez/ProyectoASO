#!/bin/bash

# Función para el juego de adivinar el número
jugar() {
    numero_secreto=$(( RANDOM % 100 + 1 ))
    intentos=0

    echo "¡Bienvenido al juego de adivinar el número!"
    echo "Estoy pensando en un número entre 1 y 100. ¿Puedes adivinarlo?"

    while true; do
        read -p "Introduce tu intento: " intento
        ((intentos++))

        # Validar que la entrada sea un número
        if ! [[ "$intento" =~ ^[0-9]+$ ]]; then
            echo "Por favor, introduce un número válido."
            continue
        fi

        # Comparar el intento con el número secreto
        if (( intento < numero_secreto )); then
            echo "El número es mayor. Inténtalo de nuevo."
        elif (( intento > numero_secreto )); then
            echo "El número es menor. Inténtalo de nuevo."
        else
            echo "¡Felicidades! Has adivinado el número."
            echo "Lo lograste en $intentos intentos."
            break
        fi
    done
}

# Menú principal
while true; do
    echo "--------------------------"
    echo "       MENÚ PRINCIPAL     "
    echo "--------------------------"
    echo "1. Jugar"
    echo "2. Salir"
    echo "--------------------------"
    read -p "Selecciona una opción (1 o 2): " opcion

    case $opcion in
        1)
            jugar
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
