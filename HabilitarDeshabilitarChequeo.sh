#!/bin/bash
###############################################################################################
#En este scripit lo que hacemos es habilitar o 
#Deshabilitar el chequeo de volumenes segun lo
#que el usuario nos indique
#############################################################################################
Respuesta=$(dialog  --radiolist "Chequeo de Volumenes Elige opcion:" 20 60 8 \
 1 "Habilitar chequeo de volumenes" off \
 2 "Deshabilitar chequeo de volumenes" off \
 3>&1 1>&2 2>&3)

case $Respuesta in
1)  echo "habilitando.."
    cat coments.txt>arch.txt
    awk -f ActivarChequeo.awk  /etc/fstab>>arch.txt
    cat arch.txt>/etc/fstab
    rm arch.txt
   ;;
2) echo "deshabilitar"
   cat coments.txt>arch.txt
   awk -f DesactivarChequeo.awk /etc/fstab>>arch.txt
   cat arch.txt>/etc/fstab
   rm arch.txt

  ;;

esac

