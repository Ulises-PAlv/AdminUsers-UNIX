#!/bin/bash

##############################################################################################################################################
## Submenu FUNCION 1
##############################################################################################################################################

 arraySubmenu=(opcion1 opcion2 opcion3 opcion4 opcion5 opcion6 opcion7 opcion8 opcion9 opcion10 opcionSalir)
 VOLVER_MENU_PRINCIPAL=0

while [ $VOLVER_MENU_PRINCIPAL -eq 0 ]
do
 subRes=$(dialog --backtitle "Administracion de usuarios" \
 --radiolist "Escoja un opcion:" 13 60 5 \
 1 "Alta masiva de usuarios" off \
 2 "Alta manual de usuarios" off \
 3 "Cambio masivo de contraseña" off \
 4 "Cambio manual de contraseña" off \
 5 "Consultar usuarios" off \
 6 "Limitar usuarios" off \
 7 "Eliminar usuario de manera manual" off\
 8 "Eliminacion masiva de usuarios" off \
 9 "Creacion de usuarios con contraseñas Seguras" off \
 10 "Consultar historial de usuarios" off \
 11 "Volver al menu principal" on \
 3>&1 1>&2 2>&3)

  case ${arraySubmenu[subRes -1]} in
       "opcion1")
          source altaUsr-byTXT.sh
       ;;
       "opcion2")
          source agregarUsuario.sh
       ;;
       "opcion3")
          source chPasswd-byTXT.sh
       ;;
       "opcion4")
          source cambiarContraseña.sh
       ;;
       "opcion5")
          source consultarUsuarios.sh
       ;;
       "opcion6")
          source limitUsr.sh
       ;;
       "opcion7")
          source borrarUsuarioM.sh
       ;;
       "opcion8")
          source borrarUsuTXT.sh
       ;;
       "opcion9")
          source nuevoUsr-SP.sh
       ;;
       "opcion10")
          source histComd.sh
       ;;

       "opcionSalir")
          VOLVER_MENU_PRINCIPAL=1
       ;;
  esac
done
