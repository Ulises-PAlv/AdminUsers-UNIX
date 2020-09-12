#!/bin/bash

#Preguntar por un username
USER_NAME=$(dialog --title "USERNAME" --inputbox "Esrcibe el nombre de usuario: " 8 53 "" 3>&1 1>&2 2>&3)

#Preguntar por el nombre de la persona o algun comantario a añadir
COMMENT=$(dialog --inputbox "Nombre completo o comentario sobre esta cuenta: " 8 53 "" 3>&1 1>&2 2>&3)

#Crear contraseña segura y aleatoria
CARACTER_RANDOM1=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
CARACTER_RANDOM2=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c20)
PASSWORD="${PASSWORD}${CARACTER_RANDOM1}${CARACTER_RANDOM2}"

#Crear el usuario
useradd -c "${COMMENT}" -m ${USER_NAME}
  #SI existe...
    if [[ "${?}" -eq 0 ]]
    then
      #Asignarle la contraseña
      echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}
      #Checar que existe el txt de contraseñas
       if [[ -f /home/contraseñasSeguras.txt ]]
       then
         echo "${USER_NAME} : ${PASSWORD}" >> /home/contraseñasSeguras.txt
       else
         touch contraseñasSeguras.txt
         echo "${USER_NAME} : ${PASSWORD}" >> /home/contraseñasSeguras.txt
       fi
    fi
