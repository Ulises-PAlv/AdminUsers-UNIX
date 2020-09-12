#!/bin/bash

#Pedir el nombre del usuario a deshabilitar
 USER_NAME=$(dialog --title "Deshabilitar usuarios" --inputbox "Que usuario se desea deshabilitar: " 8 53 "" 3>&1 1>&2 2>&3)

#Checar si existe el usuario
 AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})

if [[ "${?}" -eq 0 ]]
then
  #Deshabilitarlo si existe
   usermod -L "${USER_NAME}"

  #Programar cuando se volvera a habilitar el usuario (at)
     #Preguntar si dara hora fija o parametros de horas y minutos
      PARAMETRO=$(dialog --title "Deshabilitar usuarios" --inputbox "Desea programar la habilitación del usuario por hora o apartir de ahora en cuanto tiempo habilitarlo? (<0/1> respectivamente): " 8 53 "" 3>&1 1>&2 2>&3)

      case $PARAMETRO in
        0) HORA=$(dialog --inputbox "A que hora desea habilitarlo? (00:00): " 8 53 "" 3>&1 1>&2 2>&3)
           dialog --msgbox "El usuario ${USER_NAME} sera nuevamente habilitado a las ${HORA}" 8 78
           at "${HORA}" <<< "usermod -U ${USER_NAME}"
        ;;
        1) HORA=$(dialog --inputbox "Despues de cuantas horas: " 8 53 "" 3>&1 1>&2 2>&3)
           MINUTOS=$(dialog --inputbox "Despues de cuantos minutos: " 8 53 "" 3>&1 1>&2 2>&3)
           dialog --msgbox "El usuario ${USER_NAME} sera nuevamente habilitado despues de ${HORA} horas y ${MINUTOS} minutos" 8 78
           if [[ $HORA == 0 ]]
           then
              at now "+ ${MINUTOS} minutes" <<< "usermod -U ${USER_NAME}"
           else
              HORA=$(expr $HORA \* 60)
              MINUTOS=$(expr $HORA + $MINUTOS)
              at now "+ ${MINUTOS} minutes" <<< "usermod -U ${USER_NAME}"
           fi
        ;;
      esac
fi
