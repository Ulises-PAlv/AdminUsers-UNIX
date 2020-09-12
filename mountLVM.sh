#!/bin/bash

####################################################################################
## Monta un LVM
###############################################################################

#Preguntar por la particion a hacer LVM
 LVM=$(dialog --title "Mount LVM" --inputbox "Que particion se desea hacer LVM: " 8 53 "" 3>&1 1>&2 2>&3)
 #Checar si existe
  if [[ -b "/dev/${LVM}" ]]
  then
    fdisk "/dev/$LVM"
    echo -e "m\nm" | fdisk "/dev/${LVM}"
    #echo -e "p" | fdisk "/dev/${LVM}" > aux.txt
#cat "aux.txt"
  else
    dialog --title "Error" --msgbox "Esa particion no existe" 6 50
  fi
