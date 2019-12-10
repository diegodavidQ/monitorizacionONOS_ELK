#! /bin/bash
echo '###############################################'
echo Iniciando instalación de escenario...
echo -e "\n . \n . \n . \n . \n ." 
echo '###############################################'

#ONOS
echo Instalando ONOS...
cd /opt
sudo wget -c http://repo1.maven.org/maven2/org/onosproject/onos-releases/2.1.0/onos-2.1.0.tar.gz
sudo tar xzf onos-2.1.0.tar.gz
sudo mv onos-2.1.0 onos
cd onos

#clean and start onos
#echo Iniciando ONOS...
#sudo /opt/onos/bin/onos-service start
#sudo /opt/onos/bin/onos-service clean

#Mininet
echo -e "\n . \n . \n . \n . \n ." 
echo Instalando Mininet...
cd ~
git clone git://github.com/mininet/mininet
cd mininet
git tag # lista las versiones disponibles
git checkout -b 2.2.2 # o cualquier versión que se desee instalar
cd ..
mininet/util/install.sh -nfv


######################################################
echo -e "\n . \n . \n . \n . \n ." 
echo '###############################################'
echo Instalando Elasticsearch...
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update && sudo apt-get install elasticsearch

echo -e "\n . \n . \n ." 
echo Instalando Logstash...
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install logstash

echo -e "\n . \n . \n ." 
echo Instalando Kibana...
sudo apt-get install kibana=6.6.0
######################################################

echo -e "\n . \n . \n . \n . \n ." 
echo Instalación finalizada.




