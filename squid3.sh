#!/bin/bash
#
#Remova os caracteres espúrios de CR. Você pode fazer isso com o seguinte comando
# sed -i -e 's/\r$//' <nome do arquivo>

export DEBIAN_FRONTEND="noninteractive"
add-apt-repository universe
add-apt-repository multiverse
apt update
apt -y upgrade
apt -y autoremove 
apt -y install squid3
mv -v /etc/squid/squid.conf /etc/squid/squid.conf.old 
cp -v conf/squid.conf /etc/squid/squid.conf 
vim /etc/squid/squid.conf
chown -R proxy.proxy /var/log/squid/ 
chown -R proxy:proxy /var/spool/squid
sleep 5
systemclt stop squid.service
squid -z
systemclt start squid.service