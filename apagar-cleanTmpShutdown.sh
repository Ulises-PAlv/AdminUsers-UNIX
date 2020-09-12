#!/bin/bash

#Checar si existe primero
if [[ -f /lib/systemd/system/custom-shutdownCLEAN.service ]]
then
  read -p "Desea desactivar el borrado de archivos temporales automatico? (s/n): " RESPUESTA
  if [[ $RESPUESTA = "s" ]]
  then
    sudo systemctl disable custom-shutdownCLEAN.service
    sudo systemctl stop custom-shutdownCLEAN.service
  else
    exit 0
  fi
fi
