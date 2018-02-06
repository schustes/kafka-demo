## Kafka Demo with Vagrant and AWS ##

1. Running the SpringBoot app locally:

Prerequisites: cygwin or similar

# Setup Kafka #
- Install Kafka into directory c:/development/kafka
- cd c:/development/kafka
- Start zookeeper: bin/zookeeper-server-start.sh config/zookeeper.properties
- Start kafka: bin/kafka-server-start.sh config/server.properties
- Create Topic (if not existing): bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

# Running the app #
- Start the spring app, e.g. by running gradle bootRun
- For usage with browser GET is used for both posting and reading messages.
  To publish a message: GET http://localhost:8080/kafkademo/messages/producer?data=hello%20world
  To read the contents of the messages received (cleans the list): To publish a message: GET http://localhost:8080/kafkademo/messages/consumer



