#!/bin/bash

##############################################################################################################################################
## Submenu FUNCION 3
##############################################################################################################################################

 arraySubmenu=(opcion1 opcion2 opcion3 opcion4 opcion5 opcionSalir)
 VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
 subRes=$(dialog --backtitle "Tareas de mantenimiento y niveles de arranque" \
 --radiolist "Escoja un opcion:" 13 60 5 \
 1 "Habilitar/Inhabilitar chequeo de volumenes" off \
 2 "Arranque en modo mantenimiento" off \
 3 "Arranque Manual (modo)" off \
 4 "Chequeo de Volumenes" off \
 5 "Montaje de Volumenes" off \
 6 "Volver al Menu principal" on \
 3>&1 1>&2 2>&3)

  case ${arraySubmenu[subRes -1]} in
       "opcion1")
          source HabilitarDeshabilitarChequeo.sh
       ;;
       "opcion2")
          source ArranqueMonoUsuario.sh
       ;;
       "opcion3")
          source arranque.sh
       ;;
       "opcion4")
          source tiemposSesiones.sh
       ;;
       "opcion5")
          source montaje.sh
       ;;
       "opcionSalir")
          VOLVER_MENU_PRINCIPAL=1
       ;;
  esac
done

