#!/bin/bash

######################################################################
#Este script permite cambiar de contraseña manualmente a un usuario
#Dado el nombre de usuario
######################################################################

#Preguntar por el nombre de usuario
USER_NAME=$(dialog --title "Contraseñas" --inputbox "A que usuario se le desea cambiar la contraseña: " 8 53 "" 3>&1 1>&2 2>&3)

#Validar que existe el usuario
 AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
if [[ "${?}" -eq 0 ]]
then
  #Si existe, cambiar de contraseña
   PASSWORD=$(dialog --title "Contraseña" --passwordbox "Nueva contraseña: " 8 53 "" 3>&1 1>&2 2>&3)
  #Asignarle la contraseña al usuario
   echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}
else
  dialog --title "Error" --msgbox "No existe este usuario en el sistema, intente otro usuario" 8 78
fi

