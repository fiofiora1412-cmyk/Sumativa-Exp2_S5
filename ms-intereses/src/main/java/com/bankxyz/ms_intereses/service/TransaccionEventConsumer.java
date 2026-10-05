package com.bankxyz.ms_intereses.service;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import com.bankxyz.ms_intereses.model.TransaccionProcesadaEvent;

@Service
public class TransaccionEventConsumer {

    @KafkaListener(
            topics = "transacciones.procesadas",
            groupId = "ms-intereses"
    )
    public void consumir(TransaccionProcesadaEvent evento) {

        System.out.println(
                "Evento recibido en ms-intereses: "
                + evento.getEventId()
                + " - Transacción: "
                + evento.getTransaccionId()
        );
    }
}