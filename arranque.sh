#!/bin/bash

###############################################################################
## Permite al usuario arrancar desde cualquier runlevel
############################################################################################

 arrayMODE=(rl0 rl1 rl2 rl3 rl4 rl5 rl6)
#Preguntar que modo desea
 MODE=$(dialog --backtitle "RunLevels" \
 --radiolist "Con que modo desea arrancar" 15 50 7 \
 1 "Runlevel 0" on \
 2 "Runlevel 1" off \
 3 "Runlevel 2" off \
 4 "Runlevel 3" off \
 5 "Runlevel 4" off \
 6 "Runlevel 5" off \
 7 "Runlevel 6" off \
 3>&1 1>&2 2>&3)

#Case
	case ${arrayMODE[MODE -1]} in
	rl0)
		sudo wall "El equipo se apagará en 10 seg"
		sleep 10
		init 0
	;;
	rl1)
		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 1
	;;
	rl2)
		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 2
	;;
	rl3)
		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 3
	;;
	rl4)
		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 4
	;;
	rl5)

		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 5
	;;
	rl6)
		sudo wall "El equipo se apagará en 10 seg"
                sleep 10
		init 6
esac

