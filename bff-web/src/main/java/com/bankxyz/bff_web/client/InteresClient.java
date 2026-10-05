package com.bankxyz.bff_web.client;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import org.springframework.core.ParameterizedTypeReference;

import com.bankxyz.bff_web.dto.InteresResponseDTO;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;

@Component
public class InteresClient {

    private final RestClient restClient;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;
    private final OAuth2AuthorizedClientService authorizedClientService;

    public InteresClient(
            @LoadBalanced RestClient.Builder restClientBuilder,
            CircuitBreakerFactory<?, ?> circuitBreakerFactory,
            OAuth2AuthorizedClientService authorizedClientService) {

        this.restClient = restClientBuilder
                .baseUrl("http://MS-INTERESES")
                .build();

        this.circuitBreakerFactory = circuitBreakerFactory;
        this.authorizedClientService = authorizedClientService;
    }

    public List<InteresResponseDTO> obtenerPorCuentaId(Integer cuentaId) {

        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        OAuth2AuthorizedClient authorizedClient =
                authorizedClientService.loadAuthorizedClient(
                        "bank-client",
                        authentication.getName()
                );

        String accessToken =
                authorizedClient.getAccessToken().getTokenValue();

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("intereses");

        return circuitBreaker.run(
                () -> restClient.get()
                        .uri("/api/intereses/{cuentaId}", cuentaId)
                        .headers(headers ->
                                headers.setBearerAuth(accessToken)
                        )
                        .retrieve()
                        .body(new ParameterizedTypeReference<List<InteresResponseDTO>>() {}),
                throwable -> List.of()
        );
    }
}