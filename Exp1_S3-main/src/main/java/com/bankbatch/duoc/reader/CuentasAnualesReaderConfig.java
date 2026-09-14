package com.bankbatch.duoc.reader;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import com.bankbatch.duoc.model.CuentaAnual;

import org.springframework.batch.infrastructure.item.ItemReader;
import org.springframework.batch.infrastructure.item.file.builder.FlatFileItemReaderBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class CuentasAnualesReaderConfig {

    private static final DateTimeFormatter[] FORMATOS_FECHA = {
            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
            DateTimeFormatter.ofPattern("dd/MM/yyyy"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd"),
            DateTimeFormatter.ofPattern("yyyy-MM-dd")
    };

    @Bean
    public ItemReader<CuentaAnual> cuentasAnualesReader() {

        return new FlatFileItemReaderBuilder<CuentaAnual>()
                .name("cuentasAnualesReader")
                .resource(new ClassPathResource("cuentas_anuales.csv"))
                .linesToSkip(1)
                .delimited()
                .names("cuentaId", "fecha", "transaccion", "monto", "descripcion")
                .fieldSetMapper(fieldSet -> {

                    CuentaAnual cuenta = new CuentaAnual();

                    // =========================
                    // CUENTA ID
                    // =========================

                    String cuentaIdTexto = fieldSet.readString("cuentaId");

                    cuenta.setCuentaId(
                            convertirInteger(cuentaIdTexto)
                    );

                    // =========================
                    // FECHA
                    // =========================

                    String fechaTexto = fieldSet.readString("fecha");

                    if (fechaTexto != null && !fechaTexto.isBlank()) {
                        cuenta.setFecha(
                                convertirFecha(fechaTexto.trim())
                        );
                    }

                    // =========================
                    // TRANSACCION
                    // =========================

                    String transaccion = fieldSet.readString("transaccion");

                    if (transaccion != null && !transaccion.isBlank()) {
                        cuenta.setTransaccion(
                                transaccion.trim()
                        );
                    }

                    // =========================
                    // MONTO
                    // =========================

                    String montoTexto = fieldSet.readString("monto");

                    cuenta.setMonto(
                            convertirBigDecimal(montoTexto)
                    );

                    // =========================
                    // DESCRIPCION
                    // =========================

                    String descripcion = fieldSet.readString("descripcion");

                    if (descripcion != null && !descripcion.isBlank()) {
                        cuenta.setDescripcion(
                                descripcion.trim()
                        );
                    }

                    return cuenta;
                })
                .build();
    }

    // =====================================================
    // CONVERSION SEGURA DE CUENTA ID
    // =====================================================

    private Integer convertirInteger(String valor) {

        if (valor == null || valor.isBlank()) {
            return null;
        }

        try {
            return Integer.valueOf(valor.trim());

        } catch (NumberFormatException e) {
            return null;
        }
    }

    // =====================================================
    // CONVERSION SEGURA DE MONTO
    // =====================================================

    private BigDecimal convertirBigDecimal(String valor) {

        if (valor == null || valor.isBlank()) {
            return null;
        }

        try {
            return new BigDecimal(valor.trim());

        } catch (NumberFormatException e) {
            return null;
        }
    }

    // =====================================================
    // CONVERSION DE FECHAS
    // =====================================================

    private LocalDate convertirFecha(String fecha) {

        for (DateTimeFormatter formato : FORMATOS_FECHA) {

            try {
                return LocalDate.parse(fecha, formato);

            } catch (DateTimeParseException e) {
                // Intentar con el siguiente formato
            }
        }

        return null;
    }
}