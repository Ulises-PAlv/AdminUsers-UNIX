#!/bin/bash

#Preguntar por un username
 USER_NAME=$(dialog --title "USERNAME" --inputbox "Esrcibe el nombre de usuario: " 8 53 "" 3>&1 1>&2 2>&3)

#Preguntar por el nombre de la persona o algun comantario a añadir
 COMMENT=$(dialog --inputbox "Nombre completo o comentario sobre esta cuenta: " 8 53 "" 3>&1 1>&2 2>&3)

#Preguntar por la contraseña
 PASSWORD=$(dialog --passwordbox "Contraseña para la cuenta de ${USER_NAME}: " 8 53 "" 3>&1 1>&2 2>&3)

#Crear el usuario
 useradd -c "${COMMENT}" -m ${USER_NAME}
  #SI existe...
    if [[ "${?}" -eq 0 ]]
    then
      #Asignarle la contraseña
      echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}
    fi

#Forzar a que cambie su contraseña al iniciar sesion
#passwd -e ${USER_NAME}

