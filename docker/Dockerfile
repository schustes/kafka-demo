FROM spotify/kafka
MAINTAINER Stephan

ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
           
RUN mkdir -p /opt/kafka-demo

#COPY kafka_2.12-1.0.0.tar.gz /opt
#COPY runkafka.sh /opt
COPY kafka-demo.jar /opt/kafka-demo/kafka-demo.jar

RUN chmod 755 /opt/kafka-demo/kafka-demo.jar
#RUN chmod 755 /opt/runkafka.sh
#RUN /opt/runkafka.sh

EXPOSE 9100
ENTRYPOINT exec ls -all /opt/ && java -jar -Xmx1024m -Xms2048m /opt/kafka-demo/kafka-demo.jar
