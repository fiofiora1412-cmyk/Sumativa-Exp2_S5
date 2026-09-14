package com.bankbatch.duoc.processor;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.springframework.batch.infrastructure.item.ItemProcessor;
import org.springframework.stereotype.Component;

import com.bankbatch.duoc.model.Interes;

@Component
public class InteresesProcessor implements ItemProcessor<Interes, Interes> {

    private static final BigDecimal TASA_AHORRO = new BigDecimal("0.005");
    private static final BigDecimal TASA_PRESTAMO = new BigDecimal("0.010");

    @Override
    public Interes process(Interes interes) {

        // Normalizar tipo
        String tipo = normalizarTipo(interes.getTipo());
        interes.setTipo(tipo);

        // Validar saldo
        if (interes.getSaldo() == null) {
            interes.setSaldo(BigDecimal.ZERO);
        }

        // Validar edad
        if (interes.getEdad() != null) {
            if (interes.getEdad() < 18 || interes.getEdad() > 100) {
                interes.setEdad(null);
            }
        }

        // Determinar tasa según tipo
        BigDecimal tasa;

        if (tipo.equals("ahorro")) {
            tasa = TASA_AHORRO;
        } else if (tipo.equals("prestamo")) {
            tasa = TASA_PRESTAMO;
        } else {
            // Tipo inválido o vacío
            tasa = BigDecimal.ZERO;
        }

        interes.setTasaInteres(tasa);

        // Calcular interés
        BigDecimal interesCalculado =
                interes.getSaldo()
                        .multiply(tasa)
                        .setScale(2, RoundingMode.HALF_UP);

        interes.setInteresCalculado(interesCalculado);

        // Calcular saldo final
        BigDecimal saldoFinal;

        if (tipo.equals("ahorro")) {
            saldoFinal = interes.getSaldo().add(interesCalculado);
        } else if (tipo.equals("prestamo")) {
            saldoFinal = interes.getSaldo().subtract(interesCalculado);
        } else {
            saldoFinal = interes.getSaldo();
        }

        interes.setSaldoFinal(saldoFinal);

        return interes;
    }

    private String normalizarTipo(String valor) {

        if (valor == null || valor.isBlank()) {
            return "desconocido";
        }

        valor = valor.trim().toLowerCase();

        if (valor.equals("ahorro") || valor.equals("prestamo")) {
            return valor;
        }

        return "desconocido";
    }
}