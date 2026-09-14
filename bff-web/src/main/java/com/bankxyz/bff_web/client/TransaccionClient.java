package com.bankxyz.bff_web.client;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

@Component
public class TransaccionClient {

    private final RestClient restClient;

    public TransaccionClient() {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8091")
                .build();
    }

    public List<Object> obtenerTransacciones() {

        return restClient.get()
                .uri("/api/transacciones")
                .retrieve()
                .body(List.class);
    }
}