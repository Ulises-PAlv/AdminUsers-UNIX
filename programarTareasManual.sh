#!/bin/bash

#FUNCION AÑADIR A /etc/crontab la tarea
cron_tab () {
  #Si existe pedir cada cuanto tiempo desea repetir la acción
  FECHA=$(dialog --title "Programacion de tareas Manual" --inputbox "Cuando se desea realizar esa acción? <min hora diaMes mes diaSem>: " 8 53 "" 3>&1 1>&2 2>&3)

  #Pedir usuario al cual le hara la tarea
  USER_NAME=$(dialog --inputbox "Usuario al que se ejecutara esa tarea: " 8 53 "" 3>&1 1>&2 2>&3)

 #Agregar tarea a /etc/crontab para ser ejecutada
  echo "${FECHA} ${USER_NAME} ${SCRIPT}" >> /etc/crontab
}

###################################################################################################


#Pedir script o tarea a automatizar
 SCRIPT=$(dialog --title "Programacion de tareas manual" --inputbox "Que tarea deseas automatizar <ruta absoluta o relativa>: " 8 53 "" 3>&1 1>&2 2>&3)

#Forzar la ruta absoluta
SCRIPT=$(readlink -f "${SCRIPT}")

#Checar si existe el script o tarea
if [[ -f "${SCRIPT}" ]]
then
  if [[ -x "${SCRIPT}" ]]
  then

    #Barra de progreso mamalona
    {
    for((i=0; i<=100; i+=10))
    do
      sleep 0.3
      echo $i
    done
    } | dialog --gauge "Buscando..." 6 50 0

    dialog --msgbox "Archivo existente, permiso de ejecucuión dado... continuar" 8 78
    cron_tab
  else
    echo "No tiene permisos de ejecucion"
    dialog --title "Error" --msgbox "No tiene permisos de ejecución... " 8 78
    RESPUESTA=$(dialog --inputbox "Desea asignarle los permisos necesarios (s/n): " 8 53 "" 3>&1 1>&2 2>&3)

    if [[ $RESPUESTA = "s" ]]
    then
      chmod 711 "${SCRIPT}"
      dialog --msgbox "Permisos de ejecución dados... continuar " 8 78
      cron_tab
    else
      sleep 10
    fi
  fi
else
 dialog --title "Error" --msgbox "No existe la tarea..." 8 78
 sleep 5
fi
