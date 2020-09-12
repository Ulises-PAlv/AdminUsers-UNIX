#!/bin/bash

######################################################################
#Desplegar los usuarios existentes
#Desplegar el numero de usuario que hay
######################################################################

#Imprimir la cantidad de usuarios que hay
NUM_USUARIOS=$(getent passwd | wc -l)
echo "En el sistema existen ${NUM_USUARIOS} usuarios ..."

echo "Sintaxis: <usuarios>:<UID>:<GID>"
#Imprimir que usuarios existen
#getent passwd | awk -F: '{ print $1 ":" $3 ":" $4}'
getent passwd | awk -F: '{printf "%-20s \t%d \t%15s \n" ,$1,$3,$4}'
