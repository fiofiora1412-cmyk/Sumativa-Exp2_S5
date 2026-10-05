package com.bankxyz.bff_mobile.client;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import com.bankxyz.bff_mobile.dto.MovimientoCuentaResponseDTO;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;

@Component
public class CuentaClient {

    private final RestClient restClient;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;

    public CuentaClient(CircuitBreakerFactory<?, ?> circuitBreakerFactory) {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8092")
                .defaultHeaders(headers ->
                        headers.setBasicAuth("admin", "admin123"))
                .build();
        this.circuitBreakerFactory = circuitBreakerFactory;
    }

    public List<MovimientoCuentaResponseDTO> obtenerMovimientosPorCuenta(
            Integer cuentaId) {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("cuentas");

        return circuitBreaker.run(
                () -> restClient.get()
                        .uri("/api/cuentas/{cuentaId}/movimientos", cuentaId)
                        .retrieve()
                        .body(new ParameterizedTypeReference<List<MovimientoCuentaResponseDTO>>() {}),
                throwable -> List.of()
        );
    }
}