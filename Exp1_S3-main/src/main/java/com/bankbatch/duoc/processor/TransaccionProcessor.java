package com.bankbatch.duoc.processor;

import com.bankbatch.duoc.model.Transaccion;
import com.bankbatch.duoc.model.TransaccionProcesada;

import org.springframework.batch.infrastructure.item.ItemProcessor;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

@Component
public class TransaccionProcessor
        implements ItemProcessor<Transaccion, TransaccionProcesada> {

    private static final DateTimeFormatter[] FORMATOS_FECHA = {
            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
            DateTimeFormatter.ofPattern("dd/MM/yyyy"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd")
    };

    @Override
    public TransaccionProcesada process(Transaccion transaccion) {

        List<String> anomalías = new ArrayList<>();

        LocalDate fecha = convertirFecha(
                transaccion.getFecha(),
                anomalías
        );

        BigDecimal monto = convertirMonto(
                transaccion.getMonto(),
                anomalías
        );

        String tipo = normalizarTipo(transaccion.getTipo());

        if (!tipo.equals("credito") && !tipo.equals("debito")) {
            anomalías.add(
                    "Tipo de transacción no válido: " + tipo
            );
        }

        if (monto != null) {

            if (monto.compareTo(BigDecimal.ZERO) < 0) {
                anomalías.add("Monto negativo");
            }

            if (monto.compareTo(BigDecimal.ZERO) == 0) {
                anomalías.add("Monto igual a cero");
            }
        }

        boolean esAnomalia = !anomalías.isEmpty();

        String motivoAnomalia = esAnomalia
                ? String.join("; ", anomalías)
                : null;

        return new TransaccionProcesada(
                transaccion.getId(),
                fecha,
                monto,
                tipo,
                esAnomalia,
                motivoAnomalia
        );
    }

    private LocalDate convertirFecha(
            String valor,
            List<String> anomalías) {

        if (valor == null || valor.isBlank()) {
            anomalías.add("Fecha vacía");
            return null;
        }

        for (DateTimeFormatter formato : FORMATOS_FECHA) {
            try {
                return LocalDate.parse(valor.trim(), formato);
            } catch (DateTimeParseException ignored) {
                // Intentamos con el siguiente formato.
            }
        }

        anomalías.add(
                "Formato de fecha inválido: " + valor
        );

        return null;
    }

    private BigDecimal convertirMonto(
            String valor,
            List<String> anomalías) {

        if (valor == null || valor.isBlank()) {
            anomalías.add("Monto vacío");
            return null;
        }

        try {
            return new BigDecimal(valor.trim());

        } catch (NumberFormatException e) {

            anomalías.add(
                    "Monto inválido: " + valor
            );

            return null;
        }
    }

    private String normalizarTipo(String valor) {

        if (valor == null || valor.isBlank()) {
            return "desconocido";
        }

        return valor.trim().toLowerCase();
    }
}