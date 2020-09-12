#!/bin/bash

##############################################################################################################################################
## Monitorea el inicio y termino de sesion del usuario registrado
## Redirigir la salida a un archivo txt
##############################################################################################################################################

#Funcion que hace chequeo
monitoreo () {

  #Chequeo de entrada
      until who | grep "${USER_NAME}"
      do
        sleep 1 
      done

      #Registrar hora de entrada de usuario en txt
       FECHA=$(date +%y-%b-%d_%H-%M-%S)
       echo "ENTRO AL SISTEMA - ${USER_NAME}->${FECHA}" >> "/home/Monitoreo/ini-termSesion-${USER_NAME}.txt"
     #Registrar salida
      while who | grep "${USER_NAME}" > holi.txt
      do
        sleep 1
      done

      FECHA=$(date +%y-%b-%d_%H-%M-%S)
      echo "SALIO DEL SISTEMA - ${USER_NAME}->${FECHA}" >> "/home/Monitoreo/ini-termSesion-${USER_NAME}.txt"


  #Ver reporte
   dialog --title "Ini/Term Sesion" --scrollbar --textbox /home/Monitoreo/ini-termSesion-${USER_NAME}.txt 15 70
rm holi.txt
}

#Pedir nombre de usuario a checar
 USER_NAME=$(dialog --title "Inicio/Termino de sesion" --inputbox "Que usuario desea checar su hora de inicio y termino de sesion: " 8 53 "" 3>&1 1>&2 2>&3)

#Checar que exista el usuario
 AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
 if [[ "${?}" -ne 0 ]]
 then
        dialog --title "Error" --msgbox "No existe este usuario en el sistema, intente intente otro usuario" 8 80
 else
   if [[ -f "/home/Monitoreo/ini-termSesion-${USER_NAME}.txt" ]]
   then
     monitoreo
   else
     mkdir -p "/home/Monitoreo/"
     touch "/home/Monitoreo/ini-termSesion-${USER_NAME}.txt"
     monitoreo
   fi
 fi
