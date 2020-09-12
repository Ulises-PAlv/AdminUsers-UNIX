#!/bin/bash

#Funcion que respalde
respaldar () {
  #Definir FECHA
  FECHA=$(date +%y-%b-%d_%H-%M-%S)

  #Crear carpeta de respaldo
  mkdir -p "/home/piwyk/Documents/Backups"
  DIR_BACKUP="/home/piwyk/Documents/Backups"
  chmod 777 "${DIR_BACKUP}"

  #Preguntar si desea excluir algo del respaldo
  RESPUESTA=$(dialog --title "Backup" --inputbox "Desea excluir algo del respaldo? (s/n): " 8 53 "" 3>&1 1>&2 2>&3)

  #Programar respaldo
  if [[ $RESPUESTA == "s" ]]
  then
     EXCLUIR=$(dialog --inputbox "Que archivo(s) deseas excluir: " 8 53 "" 3>&1 1>&2 2>&3)

     tar -cvpJ --exclude="${EXCLUIR}" -f "${DIR_BACKUP}/resp-${FECHA}.tar.gz" ${1} > /var/log/Backup 2>&1
  else
     tar -cvpJ -f "${DIR_BACKUP}/resp-${FECHA}.tar.gz" ${1} > /var/log/Backup 2>&1
  fi

#Barra de progreso mamalona
 {
  for((i=0; i<=100; i+=5))
  do
    sleep 0.3
    echo $i
  done
 } | dialog --gauge "Respaldando..." 6 50 0
}

#Pedir directorio que se desea respaldar
  DIRECTORIO=$(dialog --title "BACKUP" --inputbox "Que directorio se desea respaldar: " 8 53 "" 3>&1 1>&2 2>&3)
  #Forzar la ruta absoluta
  DIRECTORIO=$(readlink -f "${DIRECTORIO}")

#Verificar si existe tal directorio
if [[ -d "${DIRECTORIO}" ]]
then
  respaldar $DIRECTORIO
  dialog --msgbox "El respaldo ha sido exitoso..." 8 78
else
  dialog --title "Error" --msgbox "Este directorio no existe en el sistema" 8 78
fi

