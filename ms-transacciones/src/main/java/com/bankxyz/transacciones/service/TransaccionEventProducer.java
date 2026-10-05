package com.bankxyz.transacciones.service;

import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import com.bankxyz.transacciones.model.TransaccionProcesadaEvent;

@Service
public class TransaccionEventProducer {

    private static final String TOPIC = "transacciones.procesadas";

    private final KafkaTemplate<String, TransaccionProcesadaEvent> kafkaTemplate;

    public TransaccionEventProducer(
            KafkaTemplate<String, TransaccionProcesadaEvent> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publicar(TransaccionProcesadaEvent evento) {
        kafkaTemplate.send(
                TOPIC,
                evento.getTransaccionId().toString(),
                evento
        );
    }
}