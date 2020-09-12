#!/bin/bash

#######################################################################################################################################
## Pedir informe a cerca de un usuario en especifico o todos
## Acerca de los programas o aplicaciones ejecutadas
#######################################################################################################################################

 #Preguntar por usuario a consultar
  USER_NAME=$(dialog --inputbox "Que usuario desea checar: " 8 53 "" 3>&1 1>&2 2>&3)
  #Validar que existe el usuario
   AUX_USUARIO_EXISTE=$(getent passwd | grep ${USER_NAME})
   if [[ "${?}" -eq 0 ]]
   then
    #Crear archivo a mostrar
     touch "monitoreoX.txt"
     chmod 755 "monitoreoX.txt"
    #Imprimirlo en TUI
     cat "/home/${USER_NAME}/.bash_history" | grep " ./" > "monitoreoX.txt"
     dialog --title "Programas ejecutados" --scrollbar --textbox monitoreoX.txt 20 62
   else
     dialog --title "Error" --msgbox "No existe este usuario en el sistema..." 8 40
   fi

#ELiminar txt auxiliar
 rm "monitoreoX.txt"
