#! /bin/bash
echo '###############################################'
echo Iniciando entorno sdn ONOS...
echo -e "\n . \n . \n . \n . \n ." 
echo '###############################################'

#1
#clean and start onos
echo Iniciando ONOS...
#sudo /opt/onos/bin/onos-service start
#sudo /opt/onos/bin/onos-service clean

gnome-terminal --tab --title="Inicio de ONOS" --command "bash -c 'echo Iniciando ONOS...; sudo /opt/onos/bin/onos-service clean; $SHELL'" --tab --title="Login ONOS" --command "bash -c 'sleep 50;sudo ssh -p 8101 karaf@127.0.0.1; karaf; $SHELL'"

#--tab --title="GUI de ONOS" --command "bash -c 'echo GUI de ONOS...; sleep 20; /usr/bin/firefox http://localhost:8181/onos/ui/login.html &'"

#abrir GUI de ONOS, usuario por defecto (no root)
echo -e "\n . \n . \n . \n . \n ." 
echo GUI de ONOS...;sleep 60; /usr/bin/firefox http://localhost:8181/onos/ui/login.html &


#2
echo '###############################################'
echo Iniciando mininet y creando red...
echo -e "\n . \n . \n . \n . \n ." 
echo '###############################################'

echo Iniciando mininet...

sleep 15;
#gnome-terminal --tab --title="Inicio de mininet" --command "bash -c 'echo Iniciando mininet...; sudo mn -c; sleep 3; sudo mn --topo tree,2,2 --controller remote,ip=127.0.0.1; $SHELL'" 
#crear red desde un script de python topología tree,2,2
gnome-terminal --tab --title="Inicio de mininet" --command "bash -c 'echo Iniciando mininet...; sudo mn -c; sleep 3; sudo python configuraciones/crear_red_mininet_tree.py; $SHELL'"


#3
echo '###############################################'
echo Iniciando entorno de monitorización ELK...
echo -e "\n . \n . \n . \n . \n ." 
echo '###############################################'

#ejecuta elasticsearch y logstash en un terminal
gnome-terminal --tab --title="Inicio de Elasticsearch" --command "bash -c 'echo Iniciando Elasticsearch...; echo -e \"\n . \n .\" ;sleep 5; systemctl restart elasticsearch.service;'" --tab --title="Inicio de Logstash" --command "bash -c ' echo Iniciando Logstash...; echo -e \"\n . \n .\" ; systemctl restart logstash.service; sleep 10; copiar_conf_Logstash; iniciar_conf_logstash'" --tab --title="Inicio de Kibana" --command "bash -c 'echo Iniciando kibana; echo ...........; systemctl restart kibana.service'"

echo -e "\n . \n . \n . \n . \n ." 
echo GUI de kibana...;sleep 20; /usr/bin/firefox localhost:5601 &

#mostrar direcciones para las interfaces gráficas de ONOS y Kibana
echo '###############################################'
echo Interfaces gráficas...
echo -e " "
echo Interfaz gráfica de ONOS:
echo http://localhost:8181/onos/ui/login.html
echo -e " "
echo Interfaz gráfica de Kibana:
echo http://localhost:5601
echo '###############################################'



#funciones
#copiar fichero de configuracion de Logstash
copiar_conf_Logstash() {
if [ ! -f configuraciones/statistic_onos.conf];
then
echo El fichero statistic_onos.conf no está en el presente en el directorio configuraciones
else
	if [ -f /etc/logstash/conf.d/statistic_onos.conf ];
	then
	echo El fichero de configuración de Logstash ya existe
	else
	sudo cp configuraciones/statistic_onos.conf /etc/logstash/conf.d
	echo Fichero de configuración de Logstash creado
	fi
fi
}

iniciar_conf_logstash(){
echo '##################'
echo Enviar configuración de red ONOS a ELK...
echo -e "\n . \n ." 
echo '##################'
gnome-terminal --tab --title="Logstash" --command "bash -c 'cd /usr/share/logstash/bin; sudo ./logstash -f /etc/logstash/conf.d/statistic_onos.conf'" 
}





