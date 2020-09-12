#!/bin/bash

#Preguntar si quiere limpiar al instante tmp o de forma segura
RESPUESTA=$(dialog --title "Clean tmp" --inputbox "Desea limipar tmp instantaneamente o de manera segura? <0/1 respectivamente>: " 8 53 "" 3>&1 1>&2 2>&3)

if [[ $RESPUESTA -eq 0 ]]
then
  RESPUESTA=$(dialog --title "Clean tmp" --inputbox "Seguro(a) que no lo quiere forzar el borrado de archivos temporales? Puede quedar colgado los programas que este usando o perder información... continuar (s/n):  " 8 53 "" 3>&1 1>&2 2>&3)
  if [[ $RESPUESTA = "s" ]]
  then
    rm -vfr /tmp/* >/dev/null 2>&1 && rm -vfr /var/tmp/* >/dev/null 2>&1
    dialog --msgbox "Archivos temporales eliminados..." 8 78
  else
    exit 0
  fi
else
  #Checar si existe el archivo .service
  if [[ -f /lib/systemd/system/custom-shutdownCLEAN.service ]]
  then
    systemctl daemon-reload
    systemctl enable custom-shutdownCLEAN.service
    systemctl start custom-shutdownCLEAN.service
    dialog --msgbox "Los archivos temporales seran eliminados al apagar el sistema..." 8 78
  else
    RESPUESTA=$(dialog --title "Error" --inputbox "No existe el servicio requerido, desea crearlo? (s/n): " 8 53 "" 3>&1 1>&2 2>&3)
    if [[ $RESPUESTA = "s" ]]
    then
      source custom-shutdownTXT.sh
      systemctl daemon-reload
      systemctl enable custom-shutdownCLEAN.service
      systemctl start custom-shutdownCLEAN.service
      dialog --msgbox "Los archivos temporales seran eliminados al apagar el sistema..." 8 78
    fi
  fi
fi

