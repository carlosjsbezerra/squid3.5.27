#!/bin/bash
#
# variaveis
AMARELO="\033[1;33m"
FIMCOR="\033[0m"

#Remova os caracteres espúrios de CR. Você pode fazer isso com o seguinte comando
# sed -i -e 's/\r$//' <nome do arquivo>

echo -e "$AMARELO Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração $FIMCOR\n"
sleep 5
export DEBIAN_FRONTEND="noninteractive"

echo -e "$AMARELO Adicionando o Repositório Universal do Apt, aguarde...$FIMCOR\n"
sleep 5
add-apt-repository universe
sleep 2
add-apt-repository multiverse


echo -e "$AMARELO Atualizando as listas do Apt, aguarde...$FIMCOR\n"
sleep 5
apt update

echo -e "$AMARELO Atualizando o sistema, aguarde...$FIMCOR\n"
sleep 5
apt -y upgrade

echo -e "$AMARELO Removendo software desnecessários, aguarde...$FIMCOR\n"
sleep 5
apt -y autoremove

echo -e "$AMARELO Instalando Squid3, Aguarde...$FIMCOR\n"
sleep 5 
apt -y install squid3

echo -e "$AMARELO Backup do aquivo do squid $FIMCOR\n"
sleep 5
mv -v /etc/squid/squid.conf /etc/squid/squid.conf.old 

echo -e "$AMARELO Copiando o aquivo squid.conf pré configura para /etc/squid/ $FIMCOR\n"
cp -v conf/squid.conf /etc/squid/squid.conf 

echo -e "$AMARELO Editando o arquivo squid.conf, Pressione ENTER pra continuar...$FIMCOR\n"
vim /etc/squid/squid.conf

echo -e "$AMARELO Atribuindo as permissões necessarias para o funcionamento do squid3 $FIMCOR"
chown -R proxy.proxy /var/log/squid/ 
chown -R proxy:proxy /var/spool/squid
sleep 5
echo -e "$AMARELO Permissões atribuidas com sucesso $FIMCOR"


systemctl stop squid.service
echo -e "$AMARELO Criando Cache do squid $FIMCOR"
sleep 5
squid -z
clear

echo -e "$AMARELO Inicializando os Serviço do squid3 $FIMCOR"
sleep 5
systemctl start squid.service
