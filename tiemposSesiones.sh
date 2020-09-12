#!/bin/bash

###############################################################################################################################################
## Checa el tiempo en sesion de los usuarios
## Lo pone en un txt
###############################################################################################################################################

#Preguntar por si desea checar el tiempo en sesion
 RESPUESTA=$(dialog --title "Tiempos de Sesion" --inputbox "Desea checar el tiempo de sesion de un usuario en especifico o todos los usuarios <0/1 respectivamente>: " 8 53 ""  3>&1 1>&2 2>&3)

 if [[ $RESPUESTA -eq 0 ]]
 then
   #Preguntar por usuario a consultar
    USER_NAME=$(dialog --inputbox "Que usuario desea consultar: " 8 53 "" 3>&1 1>&2 2>&3)
    #Validar que existe el usuario
     AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
     if [[ "${?}" -eq 0 ]]
     then
       #Crear archivo que se mostrara
        touch "consultarTiempo.txt"
        chmod 755 "consultarTiempo.txt"
        #Imprimirlo en TUI
         ac -p "${USER_NAME}" > "consultarTiempo.txt"
         dialog --title "Tiempo de hoy en sistema" --textbox consultarTiempo.txt 8 45
     else
       dialog --title "Error" --msgbox "No existe este usuario en el sistema..." 8 40
     fi
 else
   #Crear archivo que se mostrara
    touch "consultarTiempo.txt"
    chmod 755 "consultarTiempo.txt"
   #Imprimirlo en TUI
    ac -pd > "consultarTiempo.txt"
    dialog --title "Historial de tiempo en sistema de los Usrs" --scrollbar --textbox consultarTiempo.txt 30 80
 fi

#Eliminar archivo auxiliar
 rm "consultarTiempo.txt"
