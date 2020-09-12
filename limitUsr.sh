#!/bin/bash

#Funcion que pone limites
 limitar () {
  #Pedir parametro <value>
   VALOR=$(dialog --inputbox "Valor del limite: " 8 53 "" 3>&1 1>&2 2>&3)
  #Añadir a /etc/security/limits.conf lo dado por el usuario
   echo "${2} hard ${1} ${VALOR}" >> /etc/security/limits.conf
}

#Funcion con menu radiolist
 menuLimites () {
   arrayOpc=(opc1 opc2 opc3 opc4 opc5 opc5 opc7)
   USER_NAME=${1}

   RESPUESTA=$(dialog --backtitle "Limites <items>" \
   --radiolist "Elije que limitar: " 15 60 6 \
   1 "Limitar tamaño de archivo central (KB)" off \
   2 "Tamaño maximo de datos (KB)" off \
   3 "Tamaño maximo de archivos (KB)" off \
   4 "Numero maximo de archivos abiertos" off \
   5 "Numero maximo de procesos" off \
   6 "Numero maximo de logeos de usuario" off \
   7 "Tiempo maximo del uso del CPU (min)" off \
   3>&1 1>&2 2>&3)

   case ${arrayOpc[RESPUESTA -1]} in
        "opc1") ITEM="core"
                limitar $ITEM $USER_NAME
         ;;
        "opc2") ITEM="data"
                limitar $ITEM $USER_NAME
         ;;
        "opc3") ITEM="fsize"
                limitar $ITEM $USER_NAME
         ;;
        "opc4") ITEM="nofile"
                limitar $ITEM $USER_NAME
         ;;
        "opc5") ITEM="nproc"
                limitar $ITEM $USER_NAME
         ;;
        "opc6") ITEM="maxlogins"
                limitar $ITEM $USER_NAME
         ;;
        "opc7") ITEM="cpu"
                limitar $ITEM $USER_NAME
         ;;
   esac
}

#Pedir usuario a limitar
 USR=$(dialog --title "Limitar usuario" --inputbox "A que usuario se desea limitar: " 8 53 "todos" 3>&1 1>&2 2>&3)
 if [[ $USR == "todos" ]]
 then
   USR="*"
   menuLimites $USR
 else
   #Verificar que existe usuario
   AUX_USUARIO_EXISTE=$(getent passwd | grep ${USR})
   if [[ "${?}" -ne 0 ]]
   then
     dialog --title "Error" --msgbox "No existe el usuario en el sistema..." 8 40
   else
     menuLimites $USR
   fi
 fi
