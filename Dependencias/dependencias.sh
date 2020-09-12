apt-get update
apt-get upgrade -y

apt-get install at
systemctl enable --now atd.service

apt-get install smartmontools

apt-get install dialog
