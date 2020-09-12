#!/bin/bash

############################################################################################
## Respalda un directorio
## Cuando un usuario se conecte
########################################################################################################################

#Funcion que respalda y checa si se conecta el usuario
 respaldar () {
  #dialog --msgbox "Esperando a que el usuario se una..." 8 53
  #Cuando entre el usuario saldra del bucle infinito, checara cada 5 segundos
   echo "$1 -- $2 -- $3"
   until who | grep "$1"
   do
     sleep 1
   done

  #Respaldar
   FECHA=$(date +%y-%b-%d_%H-%M-%S)
   tar -cvpJ -f "${3}/resp-${1}-${FECHA}.tar.gz" ${2} > /var/log/BackupsUsrs 

 }

#Pedir usuario al que se checara y se le hara respaldo
 USER_NAME=$(dialog --title "Backup Ini-Usr" --inputbox "A que usuario le desea respaldar un directorio al iniciar sesion: " 8 53 "" 3>&1 1>&2 2>&3)

  #Verificar si existe el usuario
   AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
   if [[ "${?}" -eq 0 ]]
   then
     #Pedir directorio que se desea respaldar
      DIRECTORIO=$(dialog --title "Backup Ini-Usr" --inputbox "Que directorio se desea respaldar: " 8 53 "" 3>&1 1>&2 2>&3)
     #Forzar la ruta absoluta
      DIRECTORIO=$(readlink -f "${DIRECTORIO}")
     #Verificar si existe tal directorio
      if [[ -d "${DIRECTORIO}" ]]
      then
         #Pedir carpeta destino del respaldo
          CARPETA_DESTINO=$(dialog --inputbox "En que carpeta desea guardar el resaldo: " 8 53 "default" 3>&1 1>&2 2>&3)
          #Validaciones
           if [[ $CARPETA_DESTINO == "default" ]]
           then
             mkdir -p "/home/BackupsUsrs"
             chmod 755 "/home/BackupsUsrs"
             CARPETA_DESTINO="/home/BackupsUsrs"
           else
             CARPETA_DESTINO=$(readlink -f "${CARPETA_DESTINO}")
           fi
           if [[ -d "${CARPETA_DESTINO}" ]]
           then
             respaldar $USER_NAME $DIRECTORIO $CARPETA_DESTINO
           else
             RESPUESTA=$(dialog --title "Error" --inputbox "No existe el directorio destino, desea crearlo? (s/n): " 8 53 "" 3>&1 1>&2 2>&3)
             if [[ $RESPUESTA == "s" ]]
             then
               mkdir "${CARPETA_DESTINO}"
               chmod 755 "${CARPETA_DESTINO}"
               dialog --msgbox "Carpeta creada exitosamente" 8 78
               respaldar $USER_NAME $DIRECTORIO $CARPETA_DESTINO
             fi
           fi
      else
        dialog --title "Error" --msgbox "No existe el directorio que se desea respaldar" 8 78
      fi
   else
     dialog --title "Error" --msgbox "No existe el usuario" 8 78
   fi
