# Monitorización de ONOS con la herramienta ELK

El sistema que se analiza y monitoriza es un controlador SDN. En principio se obtienen los registros generados por el controlador SDN y con la implementación de las
herramientas de ELK se procesa, almacena y visualiza el comportamiento, estadísticas de la red. Este proyecto se considera como una solución para la implementación SDN
con el controlador ONOS que cumplen con el protocolo OpenFlow. Además, se hace uso de la API del controlador ONOS para obtener las estadísticas de la SDN.

## Ficheros

El repositorio consta de tres scripts ejecutables:
* **instalacion_onos_elk.sh** - Intala todas las herramientas usadas para la implementación del escenario, ONOS 2.1.0, Mininet, Elasticsearch, Logstash, Kibana.
* **iniciar_SDN_y_ELK.sh** - Despliega el escenario e inicia la monitorizaciòn de la SDN.
* **exportar_dashboard.sh** - Exporta el dashboard *dashboardONOS.json* a Kibana, ejecutar una sola vez.

Además, de tres ficheros de configuración:
* **dashboardONOS.json** - Dasboard para importar a Kibana, el índex para este dashboard es *statistics_onos2*
* **crear_red_mininet_tree.py** - Script para crear una red sdn con Mininet con el controlador ONOS, es llamado dentro del script **iniciar_SDN_y_ELK.sh**
* **statistic_onos.conf** - Fichero de configuración de Logstash para obtener las estadísticas de la SDN, es utilizado dentro del script **iniciar_SDN_y_ELK.sh**

## Copiar el proyecto dentro de un directorio
```
git clone https://github.com/diegodavidQ/monitorizacionONOS_ELK.git
cd monitorizacionONOS_ELK/
```
## Instalación
Ejecutar el script para instalar las herramientas del escenario:
```
sudo ./instalacion_onos_elk.sh
```
## Despliegue del escenario
Dentro del directorio monitorizacionONOS_ELK ejecutar el script para iniciar la implementaciòn del escenario:
```
sudo ./iniciar_SDN_y_ELK.sh
```
Luego de que se ha iniciado correctamente el escenario, se puede acceder a las interfaces gráficas a través de las siguientes direcciones:
* GUI de ONOS: [http://localhost:8181/onos/ui/login.html](http://localhost:8181/onos/ui/login.html) - El usuario y contraseña por defecto es **onos/rocks**
* GUI de Kibana: [http://localhost:5601](http://localhost:5601)

Para acceder a ONOS mediante la terminal la contraseña es **karaf**

## Exportar el dashboard a Kibana
Es importante tener en cuenta que dentro del fichero **statistic_onos.conf** el índex especificado se llama **statistics_onos2**
Ahora, si no se desean crear visualizaciones individuales y luego agregarlas a un dashboard, se puede hacer uso del dashboard de muestra proporcionado en este proyecto al exportar a Kibana con la ejcuciòn del script:
```
sudo ./exportar_dashboard.sh
```

## Información importante
* El índex usado en el escenario es statistics_onos2, se puede cambiar por otro modificando el fichero *statistic_onos.conf*
* El dashboard que se exporta en este proyecto es válido solamente para el índex *statistics_onos2*



