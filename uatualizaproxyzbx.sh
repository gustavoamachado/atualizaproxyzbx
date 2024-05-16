#!/bin/bash

# Carregar o perfil global
source /etc/profile

# Diretório de trabalho
cd /tmp

# Parar o serviço do Zabbix Proxy
systemctl stop zabbix-proxy

# Baixar o pacote do repositório Zabbix
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb

# Desempacotar o pacote
dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb

# Atualizar a lista de fontes
apt-get update

# Instalar apenas a atualização do pacote zabbix-proxy-mysql
apt-get install --only-upgrade -y zabbix-proxy-mysql

# Forçar a reinstalação do pacote sem substituir os arquivos de configuração
echo "N" | apt-get install --only-upgrade -y --reinstall zabbix-proxy-mysql

# Iniciar o serviço do Zabbix Proxy
systemctl start zabbix-proxy

# Limpar o diretório de trabalho removendo o pacote baixado
rm zabbix-release_6.4-1+debian11_all.deb

echo "Tarefa de atualização concluída!"
