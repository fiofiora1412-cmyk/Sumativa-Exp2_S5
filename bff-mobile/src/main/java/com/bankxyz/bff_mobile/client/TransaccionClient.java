package com.bankxyz.bff_mobile.client;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import com.bankxyz.bff_mobile.dto.TransaccionResponseDTO;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;

@Component
public class TransaccionClient {

    private final RestClient restClient;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;

    public TransaccionClient(CircuitBreakerFactory<?, ?> circuitBreakerFactory) {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8091")
                .defaultHeaders(headers ->
                        headers.setBasicAuth("admin", "admin123"))
                .build();

        this.circuitBreakerFactory = circuitBreakerFactory;
    }

    public List<TransaccionResponseDTO> obtenerTransacciones() {

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        return circuitBreaker.run(
                () -> restClient.get()
                        .uri("/api/transacciones")
                        .retrieve()
                        .body(new ParameterizedTypeReference<List<TransaccionResponseDTO>>() {}),
                throwable -> List.of()
        );
    }
}