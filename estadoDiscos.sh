#!/bin/bash

#Funcion chequeo salud del disco
 saludDisco () {
  DISCO=$(dialog --inputbox "De que disco quieres saber su estado de salud: " 8 53 "" 3>&1 1>&2 2>&3)

  #Checar parametro
   if [[ $1 -eq 0 ]]
   then
     smartctl -t short /dev/$DISCO
     at now + 7 minutes <<< "smartctl -H /dev/$DISCO > estadoDisco.txt"
     dialog --msgbox "En 7 minutos mostrara la salud del disco en estadoDisco.txt" 8 40
   else
     smartctl -t long /dev/$DISCO
     at now + 3 hours <<< "smartctl -H /dev/$DISCO > estadoDisco.txt"
     dialog --msgbox "En 3 horas mostrara la salud del disco en estadoDisco.txt" 8 40
   fi
}

 arrayOpc=(opc1 opc2 opc3)

 #Menu
  RESPUESTA=$(dialog --title "Estado de los discos" \
  --radiolist "Que desea checar de los discos de almacenamiento: " 10 57 3 \
  1 "Checar espacio en discos" off \
  2 "Revision rapida de salud del disco" on \
  3 "Revision exahustiva de salud del disco" off \
  3>&1 1>&2 2>&3)

 case ${arrayOpc[RESPUESTA -1]} in
      "opc1") df -h > aux.txt
              dialog --title "Espacio en discos" --scrollbar --textbox aux.txt 25 80
              rm aux.txt
       ;;
      "opc2") BANDERA=0
              saludDisco $BANDERA
       ;;
      "opc3") BANDERA=1
              saludDisco $BANDERA
       ;;
 esac

