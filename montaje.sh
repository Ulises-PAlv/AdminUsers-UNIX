#!/bin/bash

#Preguntar por la particion
PARTICION=$(dialog --title "PARTICION" --inputbox "Escribe el nombre de la particion: " 8 53 "" 3>&1 1>&2 2>&3)

 #Si existe...
	if [[ -b "/dev/${PARTICION}" ]]
	then
	 #Preguntar la ruta donde quiere la particion
	 RUTA=$(dialog --inputbox "Donde quieres crear el montaje: " 8 53 "" 3>&1 1>&2 2>&3)
	 if [[ -d "${RUTA}" ]]
	 then
	 mkdir "${RUTA}"/Montaje
	 #sistema de arcivos
	 SISTEMAARCHIVOS=$(dialog --title "SISTEMA DE ARCHIVOS"	--inputbox "Escribe el sistema de archivos: " 8 53 "" 3>&1 1>&2 2>&3)
	 #Dame las opciones
	 OPCIONES=$(dialog --inputbox "Escribe las opciones: " 8 53 "" 3>&1 1>&2 2>&3)
	 mount -t "${SISTEMAARCHIVOS}" -o "${OPCIONES}" /dev/"${PARTICION}" "${RUTA}"/Montaje
	 		if [[ ${?} -eq 0 ]]
	 	 	then 
	  	 	#Crear montaje
	 	 	 echo /dev/"${PARTICION}"	"${RUTA}"/Montaje	"${SISTEMAARCHIVOS}"	"${OPCIONES}"	0	0 >> /etc/fstab
			 dialog --title "Exito" --msgbox "Operacion exitosa" 0 0
			else
			dialog --title "Error" --msgbox "Hubo un error mocos " 0 0
			fi
	  else
	 	 echo "No encontre la carpeta para guardar la particion"
	 	 fi
	else
	  echo "No encontre la particion"
	  echo "/dev/${PARTICION}"
	fi


