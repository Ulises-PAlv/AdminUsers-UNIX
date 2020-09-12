#!/bin/bash

#Ejecutar script consulta.sh siendo la salida un .txt
touch listaUsuarios.txt
source consulta.sh > listaUsuarios.txt

#Mostrar en grafico el archivo de usuarios
dialog --title "CONSULTA USUARIO" --scrollbar --textbox listaUsuarios.txt 50 90

#ELiminar .txt
rm listaUsuarios.txt

