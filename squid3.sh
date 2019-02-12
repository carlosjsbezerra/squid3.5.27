#!/bin/bash
#
# variaveis
vermelho="\033[0;31m"
amarelo="\033[1;33m"
verde="\033[0;32m"
fimcor="\033[0m"
#Remova os caracteres espúrios de CR. Você pode fazer isso com o seguinte comando
# sed -i -e 's/\r$//' <nome do arquivo>

echo -e "$marelo Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração $fimcor"
sleep 5
export DEBIAN_FRONTEND="noninteractive"
sleep 5
echo
# opção do comando echo: -e (enable interpretation of backslash escapes)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n"
sleep 5

#

echo -e "$amarelo Aguarde, esse processo demora um pouco dependendo do seu Link de Internet....$fimcor\n"
sleep 5
#
echo -e "$amarelo Adicionando o Repositório Universal do Apt, aguarde...$fimcor"
	# opção do comando: &>> (redirecionar a entrada padrão)
	add-apt-repository universe
echo -e "$verde Repositório adicionado com sucesso!!!, continuando com o script...$fimcor"
sleep 5
echo
#
echo -e "$amarelo Adicionando o Repositório Multiversão do Apt, aguarde... $fimcor"
	# opção do comando: &>> (redirecionar a entrada padrão)
	add-apt-repository multiverse
echo -e "$verde Repositório adicionado com sucesso!!!, continuando com o script...$fimcor"
sleep 5
echo
#
echo -e "$amarelo Atualizando as listas do Apt, aguarde...$fimcor"
	#opção do comando: &>> (redirecionar a entrada padrão)
	sleep 5
	apt update
	clear
echo -e "$verde Listas atualizadas com sucesso!!!, continuando com o script...$fimcor"
sleep 5
echo
#
echo -e "$amarelo Atualizando o sistema, aguarde...$fimcor"
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes)
	sleep 5
	apt -y upgrade
	clear
echo -e "$verde Sistema atualizado com sucesso!!!, continuando com o script...$verde"
sleep 5
echo
#
echo -e "$vermelho Removendo software desnecessários, aguarde...$fimcor"
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes)
	sleep 5
	apt -y autoremove 
echo -e "$verde Software removidos com sucesso!!!, continuando com o script...$verde"
sleep 5
clear
#
echo -e "$amarelo Instalando o SQUID3, aguarde...$fimcor"
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes), \ (bar left) quedra de linha na opção do apt
	sleep 5
	apt -y install squid3
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando cp: -v (verbose)
	# opção do comando mv: -v (verbose)
	clear
	echo -e "$amarelo Movendo o aquivo squid.conf para squid.conf.olg $fimcor"
	mv -v /etc/squid/squid.conf /etc/squid/squid.conf.old 
	echo -e "$amarelo Copiando a arquivo conf/squid.conf para /etc/squid/ $fimcor"
	cp -v conf/squid.conf /etc/squid/squid.conf 
	sleep 5
	echo -e "$vermelho Editando o arquivo de configuração do SQUID.CONF, pressione <Enter> para continuar...$fimcor"
		read
		sleep 3
		vim /etc/squid/squid.conf
	echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
echo -e "Atualização do SQUID3.CONF feita com sucesso!!!, continuando com o script..."
sleep 5
clear
#
echo -e "Permissão ao usuário Proxy nas pastas do squid"
sleep 5
chown -R proxy.proxy /var/log/squid/ 
chown -R proxy:proxy /var/spool/squid
echo -e "Criando spool do squid"
sleep 5
/etc/init.d/squid stop
squid -z
/etc/init.d/squid restart 

echo -e "Instalação do squid3 feita com Sucesso!!!, recomendado reinicializar o servidor no final da instalação."
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=`date +%T`
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n"
read
exit 1
