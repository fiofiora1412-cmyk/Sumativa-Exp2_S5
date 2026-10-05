package com.bankxyz.transacciones.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;
import org.springframework.stereotype.Service;

import com.bankxyz.transacciones.model.TransaccionProcesada;
import com.bankxyz.transacciones.repository.TransaccionRepository;
import com.bankxyz.transacciones.model.TransaccionProcesadaEvent;

@Service
public class TransaccionService {

    private final TransaccionRepository transaccionRepository;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;
    private final TransaccionEventProducer transaccionEventProducer;

    private static final Logger log =
            LoggerFactory.getLogger(TransaccionService.class);

    public TransaccionService(
                TransaccionRepository transaccionRepository,
                CircuitBreakerFactory<?, ?> circuitBreakerFactory,
                TransaccionEventProducer transaccionEventProducer) {
        this.transaccionRepository = transaccionRepository;
        this.circuitBreakerFactory = circuitBreakerFactory;
        this.transaccionEventProducer = transaccionEventProducer;
        }

    public List<TransaccionProcesada> obtenerTodas() {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        return circuitBreaker.run(
                () -> transaccionRepository.obtenerTodas(),
                throwable -> {
                    log.error("Error consultando todas las transacciones", throwable);
                    return List.of();
                }
        );
    }

    public TransaccionProcesada obtenerPorId(Integer id) {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        return circuitBreaker.run(
                () -> transaccionRepository.obtenerPorId(id),
                throwable -> {
                    log.error(
                            "Error consultando la transacción {}",
                            id,
                            throwable
                    );
                    return null;
                }
        );
    }

    public List<TransaccionProcesada> obtenerAnomalias() {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        return circuitBreaker.run(
                () -> transaccionRepository.obtenerAnomalias(),
                throwable -> {
                    log.error("Error consultando las transacciones anómalas", throwable);
                    return List.of();
                }
        );
    }

    public void publicarEvento(Integer id) {
        TransaccionProcesada transaccion = obtenerPorId(id);

        if (transaccion == null) {
                throw new IllegalArgumentException(
                        "No existe la transacción con id " + id
                );
        }

        TransaccionProcesadaEvent evento = new TransaccionProcesadaEvent(
                java.util.UUID.randomUUID().toString(),
                transaccion.getTransaccionId(),
                transaccion.getFecha(),
                transaccion.getMonto(),
                transaccion.getTipo(),
                transaccion.getEsAnomalia(),
                transaccion.getMotivoAnomalia()
        );

        transaccionEventProducer.publicar(evento);
        }

    
}