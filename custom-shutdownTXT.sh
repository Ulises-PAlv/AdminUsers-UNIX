#!/bin/bash

############################################################################
#CREA ARCHIVO .service en /lib/systemd/system
############################################################################
touch "/lib/systemd/system/custom-shutdownCLEAN.service"
chmod 711 "/lib/systemd/system/custom-shutdownCLEAN.service"

echo "[Unit]" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "Description=Ejecutar script al apagar o encender " >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "[Service]" >>/lib/systemd/system/custom-shutdownCLEAN.service
echo "Type=oneshot" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "RemainAfterExit=true" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "ExecStart=/bin/true" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "ExecStop=-rm -vfr /tmp/* >/dev/null 2>&1 && rm -vfr /var/tmp/* >/dev/null 2>&1" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "[Install]" >> /lib/systemd/system/custom-shutdownCLEAN.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/custom-shutdownCLEAN.service


