package com.bankxyz.ms_intereses.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;
import org.springframework.stereotype.Service;

import com.bankxyz.ms_intereses.model.Interes;
import com.bankxyz.ms_intereses.repository.InteresRepository;

@Service
public class InteresService {

    private final InteresRepository interesRepository;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;

    private static final Logger log =
            LoggerFactory.getLogger(InteresService.class);

    public InteresService(
            InteresRepository interesRepository,
            CircuitBreakerFactory<?, ?> circuitBreakerFactory) {

        this.interesRepository = interesRepository;
        this.circuitBreakerFactory = circuitBreakerFactory;
    }

    public List<Interes> obtenerPorCuentaId(Integer cuentaId) {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("intereses");

        return circuitBreaker.run(
                () -> interesRepository.obtenerPorCuentaId(cuentaId),
                throwable -> {
                    log.error(
                            "Error consultando intereses de la cuenta {}",
                            cuentaId,
                            throwable
                    );
                    return List.of();
                }
        );
    }
}