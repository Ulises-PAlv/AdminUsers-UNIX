#!/bin/bash

case $# in
  0) echo "Sintaxis: ./crearARchivo.sh <nombre> <extension>"
     exit 1
  ;;
esac

touch "${1}.${2}"
chmod 755 "${1}.${2}"
echo "Archivo creado..."
