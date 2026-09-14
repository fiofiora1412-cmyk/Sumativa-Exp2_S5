package com.bankxyz.bff_web.client;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import org.springframework.core.ParameterizedTypeReference;

import com.bankxyz.bff_web.dto.MovimientoCuentaResponseDTO;

@Component
public class CuentaClient {

    private final RestClient restClient;

    public CuentaClient() {
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:8092")
                .build();
    }

    public List<MovimientoCuentaResponseDTO> obtenerMovimientosPorCuenta(Integer cuentaId) {

        return restClient.get()
                .uri("/api/cuentas/{cuentaId}/movimientos", cuentaId)
                .retrieve()
                .body(new ParameterizedTypeReference<List<MovimientoCuentaResponseDTO>>() {});
    }
}