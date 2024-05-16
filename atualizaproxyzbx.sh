#!/bin/bash

# Diretório de trabalho
cd /tmp

# Parar o serviço do Zabbix Proxy
systemctl stop zabbix-proxy

# Baixar o pacote do repositório Zabbix
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb

# Desempacotar o pacote
dpkg -i zabbix-release_6.4-1+debian11_all.deb

# Atualizar a lista de fontes
apt-get update

# Instalar apenas a atualização do pacote zabbix-proxy-mysql
apt-get install --only-upgrade -y zabbix-proxy-mysql

# Solicitar a interação do operador para não substituir arquivos de configuração
read -p "Deseja manter os arquivos de configuração da versão anterior? (N/s): " response
if [[ "$response" =~ ^[Nn]$ ]]; then
    # Se a resposta for 'N' ou 'n', forçar a reinstalação do pacote
    apt-get install --only-upgrade -y --reinstall zabbix-proxy-mysql
fi

# Iniciar o serviço do Zabbix Proxy
systemctl start zabbix-proxy

# Limpar o diretório de trabalho removendo o pacote baixado
rm zabbix-release_6.4-1+debian11_all.deb

echo "Tarefa de atualização concluída!"
