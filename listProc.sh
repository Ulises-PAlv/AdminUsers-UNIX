#!/bin/bash

#Elegir opción
vec=(op1 op2)

elec=$(dialog --title "Conocer lod PID" \
 --radiolist "Escoge una opción: " 10 60 3 \
 1 "Lista de PID" off \
 2 "Conocer el PID de un proceso" off \
 3>&1 1>&2 2>&3)

	case ${vec[elec -1]} in
		"op1")
		ps -e > listaProc.txt
		dialog --title "Lista de procesos: " --scrollbar --textbox listaProc.txt 20 60
		rm listaProc.txt
		;;
		"op2")
		proc=$(dialog --title "Conocer PID del padre y de los hijos" --inputbox "¿De que proceso deseas saber los PID's?" 8 40 "" 3>&1 1>&2 2>&3)
		pidof $proc > pidof.txt
		dialog --title "PID's: " --textbox pidof.txt 8 53
		rm pidof.txt
		;;
	esac
