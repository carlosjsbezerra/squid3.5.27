#!/bin/bash
#Variável da Data Inicial para calcular o tempo de execução do script
HORAINICIAL=`date +%T`
#
#Variável para validar o ambiente, verificando se o usuário e "root", versão do ubuntu e kernel
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
#
#Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração
export DEBIAN_FRONTEND="noninteractive"
#
#Verificando se o usuário e Root, Distribuição e >=18.04 e o kernel >=4.15 
#[ ] = teste de expressão, && = operador lógico AND, == comparação de strig, exit 1 = A maioria dos erros comuns na execução
clear
if [ "$USUARIO" == "0"] && [ "$UBUNTU" == "18.4" ] && [ "$KERNEL" == "4.15" ]
then
	echo -e "O usuário e Root, continuando com o script..."
	echo -e "Distribuição e >=18.04.x, continuando com o script..."
	echo -e "Kernel e >=4.15, continuando com o script..."
	sleep 5
else
	echo -e "Usuário não e Root ($USUARIO) ou Distribuição não e >=18.04.x ($UBUNTU) ou kernel não e >=4.15 ($KERNEL)"
	echo -e "Caso você não tenha executado o script com o comando: sudo -i"
	echo -e "Execute novamente o script para verificar o ambiente."
	exit 1
fi
