package com.bankxyz.ms_cuentas.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bankxyz.ms_cuentas.model.MovimientoCuenta;
import com.bankxyz.ms_cuentas.repository.CuentaRepository;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class CuentaService {

    private final CuentaRepository cuentaRepository;
    private static final Logger log =
        LoggerFactory.getLogger(CuentaService.class);
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;

    public CuentaService(
            CuentaRepository cuentaRepository,
            CircuitBreakerFactory<?, ?> circuitBreakerFactory) {

        this.cuentaRepository = cuentaRepository;
        this.circuitBreakerFactory = circuitBreakerFactory;
    }

    public List<MovimientoCuenta> obtenerMovimientosPorCuenta(Integer cuentaId) {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("cuentas");

        return circuitBreaker.run(
                () -> cuentaRepository.obtenerMovimientosPorCuenta(cuentaId),
                throwable -> {
            log.error("Error consultando movimientos de la cuenta {}", cuentaId, throwable);
            return List.of();
        }
        );
    }
}