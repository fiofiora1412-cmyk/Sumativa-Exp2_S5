package com.bankxyz.bff_web.client;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.CircuitBreakerFactory;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.core.ParameterizedTypeReference;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;

@Component
public class TransaccionClient {

    private final RestClient restClient;
    private final CircuitBreakerFactory<?, ?> circuitBreakerFactory;
    private final OAuth2AuthorizedClientService authorizedClientService;

    public TransaccionClient(
            @LoadBalanced RestClient.Builder restClientBuilder,
            CircuitBreakerFactory<?, ?> circuitBreakerFactory,
            OAuth2AuthorizedClientService authorizedClientService) {

        this.restClient = restClientBuilder
                .baseUrl("http://MS-TRANSACCIONES")
                .build();

        this.circuitBreakerFactory = circuitBreakerFactory;
        this.authorizedClientService = authorizedClientService;
    }

    public List<Object> obtenerTransacciones() {

        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        OAuth2AuthorizedClient authorizedClient =
                authorizedClientService.loadAuthorizedClient(
                        "bank-client",
                        authentication.getName()
                );

        String accessToken =
                authorizedClient.getAccessToken().getTokenValue();
                System.out.println("TOKEN: " + accessToken);
                System.out.println("ACCESS TOKEN:");
                System.out.println(accessToken);

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        return circuitBreaker.run(
                () -> restClient.get()
                        .uri("/api/transacciones")
                        .headers(headers ->
                                headers.setBearerAuth(accessToken)
                        )
                        .retrieve()
                        .body(new ParameterizedTypeReference<List<Object>>() {}),
                throwable -> {
                    throwable.printStackTrace();
                    return List.of();
                }
        );
    }

    public void publicarEvento(Integer id) {

        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        OAuth2AuthorizedClient authorizedClient =
                authorizedClientService.loadAuthorizedClient(
                        "bank-client",
                        authentication.getName()
                );

        String accessToken =
                authorizedClient.getAccessToken().getTokenValue();

        System.out.println("ACCESS TOKEN PUBLICAR EVENTO:");
        System.out.println(accessToken);

        CircuitBreaker circuitBreaker =
                circuitBreakerFactory.create("transacciones");

        circuitBreaker.run(
                () -> {

                        System.out.println("==== ENVIANDO A MS-TRANSACCIONES ====");

                        restClient.post()
                                .uri("/api/transacciones/{id}/publicar-evento", id)
                                .headers(headers ->
                                        headers.setBearerAuth(accessToken)
                                )
                                .retrieve()
                                .toBodilessEntity();

                        System.out.println("==== EVENTO ENVIADO OK ====");

                        return null;
                },
                throwable -> {
                        System.out.println("==== ERROR CIRCUIT BREAKER ====");
                        throwable.printStackTrace();
                        return null;
                }
                );
        }
}