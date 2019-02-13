#!/bin/bash
#
# variaveis
AMARELO="\033[1;33m"
VERDE="\033[0;32m"
FIMCOR="\033[0m"

#Remova os caracteres espúrios de CR. Você pode fazer isso com o seguinte comando
# sed -i -e 's/\r$//' <nome do arquivo>

echo -e "$AMARELO Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração $FIMCOR"
export DEBIAN_FRONTEND="noninteractive"
sleep 2
echo -e "$VERDE Exportanção feita com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Adicionando o Repositório Universal do Apt, aguarde...$FIMCOR"
sleep 2
add-apt-repository universe
add-apt-repository multiverse
sleep 2
echo -e "$VERDE Repositórios adicionado sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Atualizando as listas do Apt, aguarde...$FIMCOR "
sleep 2
apt update
sleep 2
echo -e "$VERDE Lista atualizadas com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Atualizando o sistema, aguarde...$FIMCOR"
sleep 2
apt -y upgrade
sleep 2
echo -e "$VERDE Sistema atualizado com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Removendo software desnecessários, aguarde...$FIMCOR"
sleep 2
apt -y autoremove
sleep 2
echo -e "$VERDE Remoção de software desnecessário feito com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Instalando Squid3, Aguarde...$FIMCOR"
sleep 2 
apt -y install squid3
sleep 2
echo -e "$VERDE Instalação do Squid3 feita com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Backup do aquivo do squid $FIMCOR"
sleep 2
mv -v /etc/squid/squid.conf /etc/squid/squid.conf.old 
sleep 2
echo -e "$VERDE Backup feita com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Copiando o aquivo squid.conf pré configura para /etc/squid/ $FIMCOR"
cp -v conf/squid.conf /etc/squid/squid.conf 
sleep 2
echo -e "$VERDE Copia realizada com sucesso !!!$FIMCOR"
sleep 1

echo
echo -e "$AMARELO Editando o arquivo squid.conf, Pressione ENTER pra continuar...$FIMCOR"
read
sleep 2
vim /etc/squid/squid.conf


echo
echo -e "$AMARELO Atribuindo as permissões necessarias para o funcionamento do squid3 $FIMCOR"
sleep 2
chown -R proxy.proxy /var/log/squid/ 
chown -R proxy:proxy /var/spool/squid
echo -e "$VERDE Permissões atribuidas com sucesso $FIMCOR"
sleep 2

echo
echo -e "$AMARELO Desativando o Serviço do Squid3$FIMCOR"
systemctl stop squid.service
echo -e "$VERDE Serviço Desativado com Sucesso !!!$FIMCOR"
echo
echo -e "$AMARELO Criando Cache do squid $FIMCOR"
sleep 2
squid -z
sleep 2
echo -e "$VERDE Cache criado com sucesso !!!$FIMCOR"
sleep 1

clear
echo -e "$AMARELO Inicializando os Serviço do squid3 $FIMCOR"
sleep 2
systemctl start squid.service
systemctl status squid.service