package de.sidion.kafkademo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class MessageProducer {
    @Value ("${kafka-topic}")
    private String topic;

    @Autowired
    private KafkaTemplate<String, String> template;

    public void send(String msg) {
        this.template.send(topic, msg);
    }

}
