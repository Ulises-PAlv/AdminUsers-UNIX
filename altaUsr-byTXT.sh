#!/bin/bash

######################################################################################################################################
# Con un archivo extension "txt" podras cambiar las contraseñas
# El archivo debera tener una sintaxis asi para su buen funcionamiento:
# <usuario>:<nueva contraseña>
######################################################################################################################################

#Funcion que comprueba existencia de usuario
comprobarExistencia () {

 AUX_USUARIO_EXISTE=$(getent passwd | grep ${1})
 if [[ "${?}" -eq 0 ]]
 then
   return $((1))
 else
   return $((0))
 fi

}

#Funcion que hace el cambio de contraseñas
agregarUsuarios () {

  #Pedir archivo de texto
  ARCHIVO_CAMBIO=$(dialog --title "ARCHIVO DE CAMBIO" --inputbox "Escriba la direccion del archivo del cual se realizara la alta de usuarios  (ruta absoluta o relativa): " 8 53 "" 3>&1 1>&2 2>&3)

  #Forzar la ruta absoluta
  ARCHIVO_CAMBIO=$(readlink -f "${ARCHIVO_CAMBIO}")

  #Comprobar que exista el archivo
  if [[ -f "${ARCHIVO_CAMBIO}" ]]
  then
    IFS=$'\n'
    USUARIOS=$(cat ${ARCHIVO_CAMBIO})
    for i in $USUARIOS
    do
      USR=$(echo $i | awk -F: '{print $1}')
      comprobarExistencia $USR
      if [[ $? -eq 0 ]]
      then
        useradd $USR
        PASSWORD=$(echo $i | awk -F: '{print $2}')
         echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USR}
      fi
    done
  else
    dialog --title "Error" --msgbox "Este archivo no existe en el sistema..." 8 78
  fi
}

#Mensaje de sintaxis
 dialog --title "SINTAXIS" --yesno "La sintaxis que debera tener el documento para tener un buen resultado a la hora de agregar a los usuarios es: <usuario>:<contraseña> \n                Desea continuar? " 8 53

# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
RESPUESTA=$?
case $RESPUESTA in
   0) agregarUsuarios
   ;;
   1) source submenu-1.sh
   ;;
   255) exit 0
   ;;
esac

