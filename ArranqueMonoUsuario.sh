#!/bin/bash

###########################################################################################################################################################################################
#En este script permite arrancar en mono usario en el 
#tiempo que el usario que lo invoco decida, ademas de que
#avisa a todos los usarios logeados para que no los tome por sorpresa
##################################################################################################


Tiempo=$(dialog --title "Arrancar en modo Monousuario (mantenimento)" --inputbox  "¿En cuanto tiempo en minutos arrancara el equipo en monousario?: " 8 53 3>&1 1>&2 2>&3) 

if [ $Tiempo -eq 0 ]
then 
    dialog --title "Error" --msgbox "No puedes arrancar de forma inmediata en monousario, se tiene que dar un tiempo para que los usuarios logeados se enteren y se preparen para el arranque en monousuario" 8 78
    exit 1
fi

dialog --title "Arrancar en modo Monousuario (mantenimento)" --yesno "¿Estas seguro en arrancar en monousuario? " 12 58

resp=$?

case $resp in
0)

 if [ $Tiempo -eq 1 ]
 then
     echo "root inicio el arranque en monousuario para mantenimiento, tienes 1 minuto para guardar tus cosas antes de arrancar en monousuario" | wall
else
    echo "root inicio el arranque en monousuario para mantenimento, tienes $Tiempo minutos para guardar tus cosas antes de arrancar en Monousuario" | wall 
fi
    at now "+ ${Tiempo} minutes" <<< "init 1" 

   ;;
esac
