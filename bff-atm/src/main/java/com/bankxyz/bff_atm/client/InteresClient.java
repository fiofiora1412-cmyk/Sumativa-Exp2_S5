package com.bankxyz.bff_atm.client;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import com.bankxyz.bff_atm.dto.InteresResponseDTO;

@Component
public class InteresClient {

    private final RestClient restClient;

    public InteresClient() {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8093")
                .build();
    }

    public List<InteresResponseDTO> obtenerPorCuentaId(Integer cuentaId) {

        return restClient.get()
                .uri("/api/intereses/{cuentaId}", cuentaId)
                .retrieve()
                .body(new ParameterizedTypeReference<List<InteresResponseDTO>>() {});
    }
}