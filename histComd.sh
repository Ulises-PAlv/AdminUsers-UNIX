#!/bin/bash

hist () {
	menu=(op1 op2)
        opcion=$(dialog --title "¿Que deseas hacer? " \
        --radiolist "Escoge una opción: " 10 70 2 \
1 "Mostrar todo el historial de los comandos ejecutados" off \
2 "Mosrar un comando en especifico, especifique cual" off \
3>&1 1>&2 2>&3)

  case ${menu[opcion -1]} in
        "op1")
               # history > HistorialComandos-${USER_NAME}.txt
		cat "/home/${USER_NAME}/.bash_history" > "/home/Historial/HistorialComandos-${USER_NAME}.txt"
                chmod 755 "/home/Historial/HistorialComandos-${USER_NAME}.txt"
                dialog --msgbox "Historial guardado en el archivo: HistorialComandos-${USER_NAME}.txt" 8 80
        ;;
        "op2")
                OP2=$(dialog --title "Mostrar comando en específico" --inputbox "Que comando desea buscar en el historial de ${USER_NAME}" 8 58 "" 3>&1 1>&2 2>&3)
                #history | grep $OP2 > /home/Historial/HistorialComandos-${USER_NAME}.txt
		cat "/home/${USER_NAME}/.bash_history" | grep "$OP2" > "/home/Historial/HistorialComandos-${USER_NAME}.txt"
                chmod 755 "/home/Historial/HistorialComandos-${USER_NAME}.txt"
                dialog --title "Comandos ejecutados por ese usuario" --scrollbar --textbox /home/Historial/HistorialComandos-${USER_NAME}.txt 40 90
        ;;
    esac
}

#Pide un usuario
USER_NAME=$(dialog --title "Historial de comandos" --inputbox "Que usuario desea checar su historial de comandos: " 8 80 "" 3>&1 1>&2 2>&3)

#Cheketecheke usuario
 AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
 if [[ "${?}" -eq 0 ]]
 	then
	if [[ -f "/home/Historial/HistorialComandos-${USER_NAME}.txt" ]]
   		then
    		 hist
   	else
     		mkdir -p "/home/Historial/"
     		touch "/home/Historial/HistorialComandos-${USER_NAME}.txt"
	    	hist
   fi
 else
	dialog --title "Error" --msgbox "No existe este usuario en el sistema, intente intente otro usuario" 8 80
fi

