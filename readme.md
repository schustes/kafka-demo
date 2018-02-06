# Kafka Demo mit Vagrant und AWS #


## Demo app lokal testen ##

#### Kafka Setup ####
- Kafka in Verzeichnis c:/development/kafka (oder analog) installieren
- cd c:/development/kafka 
- zookeeper starten: bin/zookeeper-server-start.sh config/zookeeper.properties
- kafka starten: bin/kafka-server-start.sh config/server.properties
- Ein Topic anlegen (falls es noch nicht existiert): bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

#### Anwendung lokal testen ####
- z.B. über ./gradle bootRun
- Im Browser kann man über GET Nachrichten posten und lesen.
  Veröffentlichen: GET http://localhost:8080/kafkademo/messages/producer?data=hello%20world
  Empfangene Nachrichten lesen (löscht Puffer):GET http://localhost:8080/kafkademo/messages/consumer
  
## Mit Vagrant auf die AWS pushen ##

Vagrant installieren: https://www.vagrantup.com/downloads.html
- Das vagrant file liegt im Root Verzeichnis. Es müssen die Credentials korrekt gesetzt werden.
- vagrant ...
- Testen: http://....
 


