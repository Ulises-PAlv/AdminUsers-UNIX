#!/bin/bash

#############################################################################################################################################
## Submenu 2
############################################################################################################################################

arrayOpcion=(opcion1 opcion2 opcion3 opcion4 opcionSalir)
VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
  subRes=$(dialog --backtitle "Programacion de Tareas" \
  --radiolist "Escoja un opcion:" 13 60 5 \
  1 "Programacion de tareas manual" off \
  2 "Respaldo programado" off \
  3 "Borrado de temporales programado" off \
  4 "Inhabilitacion de usuarios por periodo de tiempo" off \
  5 "Volver al Menu Principal" on \
  3>&1 1>&2 2>&3)

  case ${arrayOpcion[subRes -1]} in
        "opcion1")
           source programarTareasManual.sh
        ;;
        "opcion2")
           source backup.sh
        ;;
        "opcion3")
           source cleanTMP.sh
        ;;
        "opcion4")
           source deshabilitarUsr.sh
        ;;
        "opcionSalir")
           VOLVER_MENU_PRINCIPAL=1
        ;;
  esac
done
