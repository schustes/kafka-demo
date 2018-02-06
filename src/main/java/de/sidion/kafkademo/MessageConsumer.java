package de.sidion.kafkademo;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class MessageConsumer {

    @Autowired
    private MessageStore messageStore;

    @KafkaListener(topics = "${kafka-topic}", containerFactory = "kafkaListenerContainerFactory")
    public void listen(ConsumerRecord<Object, String> cr) throws Exception {
        log.info(">>>>>>>" + cr.toString());
        messageStore.put(cr.value());
}

}
