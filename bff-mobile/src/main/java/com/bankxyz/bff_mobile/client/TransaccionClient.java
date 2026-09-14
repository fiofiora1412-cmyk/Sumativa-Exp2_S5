package com.bankxyz.bff_mobile.client;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import com.bankxyz.bff_mobile.dto.TransaccionResponseDTO;

@Component
public class TransaccionClient {

    private final RestClient restClient;

    public TransaccionClient() {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8091")
                .build();
    }

    public List<TransaccionResponseDTO> obtenerTransacciones() {

        return restClient.get()
                .uri("/api/transacciones")
                .retrieve()
                .body(new ParameterizedTypeReference<List<TransaccionResponseDTO>>() {});
    }
}