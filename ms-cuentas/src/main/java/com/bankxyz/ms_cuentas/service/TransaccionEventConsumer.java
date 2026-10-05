package com.bankxyz.ms_cuentas.service;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import com.bankxyz.ms_cuentas.model.TransaccionProcesadaEvent;
import com.bankxyz.ms_cuentas.repository.EventoTransaccionRepository;

@Service
public class TransaccionEventConsumer {

    private final EventoTransaccionRepository eventoTransaccionRepository;

    public TransaccionEventConsumer(
            EventoTransaccionRepository eventoTransaccionRepository) {

        this.eventoTransaccionRepository = eventoTransaccionRepository;
    }

    @KafkaListener(
            topics = "transacciones.procesadas",
            groupId = "ms-cuentas"
    )
    public void consumir(TransaccionProcesadaEvent evento) {

        if (eventoTransaccionRepository.existePorEventId(evento.getEventId())) {

            System.out.println(
                    "Evento duplicado ignorado en ms-cuentas: "
                    + evento.getEventId()
            );

            return;
        }

        eventoTransaccionRepository.guardar(evento);

        System.out.println(
                "Evento procesado y guardado en ms-cuentas: "
                + evento.getEventId()
                + " - Transacción: "
                + evento.getTransaccionId()
        );
    }
}