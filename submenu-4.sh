#!/bin/bash

##############################################################################################################################################
## Submenu FUNCION 4
##############################################################################################################################################

 arraySubmenu=(opcion1 opcion2 opcion3 opcion4 opcionSalir)
 VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
 subRes=$(dialog --backtitle "Tareas sobre usuarios en sesion" \
 --radiolist "Escoja un opcion:" 13 60 5 \
 1 "Monitorear inicios y terminos de sesion" off \
 2 "Respaldar carpeta al iniciar sesion un usuario" off \
 3 "Monitoreo de apps ejecutadas por el usuario" off \
 4 "Tiempos de sesion" off \
 5 "Volver al menu principal" off \
 3>&1 1>&2 2>&3)

  case ${arraySubmenu[subRes -1]} in
       "opcion1")
          source monitoreoIni-TermUSR.sh
       ;;
       "opcion2")
          source backupIniSesion.sh
       ;;
       "opcion3")
          source monitoreoAppX.sh
       ;;
       "opcion4")
          source tiemposSesiones.sh
       ;;
       "opcionSalir")
          VOLVER_MENU_PRINCIPAL=1
       ;;
  esac
done

