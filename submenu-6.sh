#!/bin/bash

##############################################################################################################################################
## Submenu FUNCION 6
##############################################################################################################################################

 arraySubmenu=(opcion1 opcion2 opcion3 opcion4 opcion5 opcionSalir)
 VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
 subRes=$(dialog --backtitle "LVM y Gestion de unidades de almacenamiento" \
 --radiolist "Escoja un opcion:" 13 60 8 \
 1 "Montar LVM" off \
 2 "Opciones sobre LVM" off \
 3 "Estado de disco" off \
 4 "Formatear una unidad" off \
 5 "Montar memoria swap" off \
 6 "Volver al Menu principal" on \
 3>&1 1>&2 2>&3)

  case ${arraySubmenu[subRes -1]} in
       "opcion1")
          source monitoreoIni-TermUSR.sh
       ;;
       "opcion2")
          source ArranqueMonoUsuario.sh
       ;;
       "opcion3")
          source estadoDiscos.sh
       ;;
       "opcion4")
          source tiemposSesiones.sh
       ;;
       "opcion5")
          source mountSwap.sh
       ;;
       "opcionSalir")
          VOLVER_MENU_PRINCIPAL=1
       ;;
  esac
done

