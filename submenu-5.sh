#!/bin/bash

##############################################################################################################################################
## Submenu FUNCION 5
##############################################################################################################################################

 arraySubmenu=(opcion1 opcion2 opcion3 opcion4 opcionSalir)
 VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
 subRes=$(dialog --backtitle "Procesos" \
 --radiolist "Escoja un opcion:" 13 60 5 \
 1 "Consultar lista de procesos" off \
 2 "Matar proceso" off \
 3 "Estado de un proceso" off \
 4 "Cambiar orden de prioridad de un proceso" off \
 6 "Volver al Menu principal" on \
 3>&1 1>&2 2>&3)

  case ${arraySubmenu[subRes -1]} in
       "opcion1")
          source listProc.sh
       ;;
       "opcion2")
          source killProc.sh
       ;;
       "opcion3")
          source arranque.sh
       ;;
       "opcion4")
          source tiemposSesiones.sh
       ;;
       "opcionSalir")
          VOLVER_MENU_PRINCIPAL=1
       ;;
  esac
done

