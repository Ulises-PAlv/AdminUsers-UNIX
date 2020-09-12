#!/bin/bash


#Checar si existe /swapfile
 if [[ -b /swapfile ]]
 then
   RESPUESTA=$(dialog --title "Error?" --inputbox "Ya existe una memoria swap desea borrarla para crear una nueva? (s/n): " 8 53 "" 3>&1 1>&2 2>&3)
   if [[ $RESPUESTA == "s" ]]
   then
     #Eliminar swap
      swapoff -v /swapfile
      rm "/swapfile"
   fi
 else
   #Crear swapfile
    TAMANO=$(dialog --title "SWAP" --inputbox "De que tamaño desea crear la swap (GiB): " 8 53 "" 3>&1 1>&2 2>&3)
    TAMANO=$(expr $TAMANO \* 1024)
    TAMANO=$(expr $TAMANO \* 1024)
    dd if=/dev/zero of=/swapfile bs=1024 count="${TAMANO}"
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
    free --human > aux.txt
    dialog --textbox aux.txt 6 40
    rm aux.txt
    dialog --msgbox "Memoria swap creada..." 8 53 "" 3>&1 1>&2 2>&3
 fi
