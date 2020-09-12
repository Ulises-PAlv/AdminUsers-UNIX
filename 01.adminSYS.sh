#!/bin/bash

###############################################################################################################################################
## Script base
## Contiene el Menu principal
###############################################################################################################################################

#INTRO
 dialog --infobox "                    __^__              __^__ \n         ( ___ )------------------------------------( ___ ) \n          | / |                                      | \ | \n          | / |       ADMINISTRADOR DE SISTEMAS      | \ | \n          |___|                                      |___| \n         (_____)------------------------------------(_____) " 10 75; sleep 5

#Datos del proyecto y equipo
 dialog --title "Datos de PROYECTO" --infobox "Proyecto de Administrador de Sistemas \n Equipo_1 conformado por: \n Ulises Alvirde Bonilla \n Jesus Salvador Diosdado \n Juan Carlos Alvares Flores \n Jose Israel Castañeda Piña" 10 90; sleep 3

#Menu principal de funciones extendidas del administrador de sistemas
 #Vector de opciones
  arrayOpcionesMenu=(opcion1 opcion2 opcion3 opcion4 opcion5 opcion6 opcion7)
  SALIR=0

 while [ $SALIR -eq 0 ]
 do
   MENU_PRINCIPAL=$(dialog --backtitle "Ing. Payasos SA de CV" \
   --title "ADMINISTRACION DE SISTEMAS" --radiolist "Escoja una opcion:" 15 60 7 \
   1 "Administracion de usuarios" off \
   2 "Programacion de tareas" off \
   3 "Tareas de mantenimiento y niveles de arranques" off \
   4 "Tareas sobre usuarios en sesion" off \
   5 "Procesos" off \
   6 "LVM y Gestion de unidades de almacenamiento" off \
   7 "Salir del programa" on \
   3>&1 1>&2 2>&3)

#Switch opciones
  case ${arrayOpcionesMenu[MENU_PRINCIPAL -1]} in
      "opcion1")
          source submenu-1.sh
       ;;
      "opcion2")
          source submenu-2.sh
       ;;
      "opcion3")
          source submenu-3.sh
       ;;
      "opcion4")
          source submenu-4.sh
       ;;
      "opcion5")
          source submenu-5.sh
       ;;
      "opcion6")
          source submenu-6.sh
       ;;
      "opcion7")
          SALIR=1
  esac
 done
