#!/bin/bash

victor=(opcion1 opcion2)

ELEC=$(dialog --title "Terminar ejecucion de procesos" \
 --radiolist "Elige una opción: " 10 60 3 \
 1 "Terminar ejecución del proceso con el PID" off \
 2 "Terminar ejecución del proceso con su nombre" off \
 3>&1 1>&2 2>&3)
	case ${victor[ELEC -1]} in
		"opcion1")
			PROCESO=$(dialog --title "Terminar ejecución" --inputbox "Escribe el ID del proceso que quieres que termine" 8 60 "" 3>&1 1>&2 2>&3)
			kill  ${PROCESO}
			dialog --msgbox "Se ha terminado la ejecución del proceso" 8 60
		;;
		"opcion2")
			PROCESO2=$(dialog --title "Terminar ejecución" --inputbox "Escribe el nombre del proceso que quieres que termine" 8 60 "" 3>&1 1>&2 2>&3)
			pkill -f  ${PROCESO2}
                        dialog --msgbox "Se ha terminado la ejecución del proceso" 8 60

		;;
	esac

