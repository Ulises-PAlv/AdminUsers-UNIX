#!/bin/bash

######################################################################
#Este script permite cambiar de contraseña manualmente a un usuario
#Dado el nombre de usuario
######################################################################

#Preguntar por el nombre de usuario
USER_NAME=$(dialog --title "Borrar usuario" --inputbox "Que usuario desea borrar: " 8 53 "" 3>&1 1>&2 2>&3)

#Validar que existe el usuario
AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
if [[ "${?}" -eq 0 ]]
then
	deluser --remove-home $USER_NAME
	else
        dialog --title "Error" --msgbox "No existe este usuario en el sistema, intente otro usuario" 8 78
 
fi



