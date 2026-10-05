package com.bankxyz.bff_atm.client;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import com.bankxyz.bff_atm.dto.InteresResponseDTO;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;

@Component
public class InteresClient {

    private final RestClient restClient;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;

    public InteresClient(CircuitBreakerFactory<?, ?> circuitBreakerFactory) {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8093")
                .defaultHeaders(headers ->
                        headers.setBasicAuth("admin", "admin123"))
                .build();
        this.circuitBreakerFactory = circuitBreakerFactory;
    }

    public List<InteresResponseDTO> obtenerPorCuentaId(Integer cuentaId) {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("intereses");

        return circuitBreaker.run(
                () -> restClient.get()
                        .uri("/api/intereses/{cuentaId}", cuentaId)
                        .retrieve()
                        .body(new ParameterizedTypeReference<List<InteresResponseDTO>>() {}),
                throwable -> List.of()
        );
    }
}