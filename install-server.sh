#!/bin/bash

datainicial=`date +%s`

USER="agiuscloud"
EMAIL="edison@agiuscloud.com"

echo "# Alteracao de Fuso Horario (Date)"
echo "America/Sao_Paulo" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

echo "# Instalacao de EasyEngine"
echo -e "[user]\n\tname = $USER\n\temail = $EMAIL" > ~/.gitconfig
wget -qO eac rt.cx/ee
bash eac

echo "# Instalacao de Servidores"
/usr/local/bin/ee stack install --nginxmainline
/usr/local/bin/ee stack install --php 
/usr/local/bin/ee stack install --mysql
/usr/local/bin/ee stack install --utils
/usr/local/bin/ee stack install --phpmyadmin
/usr/local/bin/ee stack install --phpredisadmin
/usr/local/bin/ee stack install --postfix
/usr/local/bin/ee stack install --wpcli
/usr/local/bin/ee stack install --hhvm
/usr/local/bin/ee stack install --redis      

echo "# Restart servicos"
service hhvm restart
ee stack restart
