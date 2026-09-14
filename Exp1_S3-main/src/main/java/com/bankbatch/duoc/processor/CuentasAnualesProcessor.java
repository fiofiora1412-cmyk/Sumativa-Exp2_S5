package com.bankbatch.duoc.processor;

import org.springframework.batch.infrastructure.item.ItemProcessor;
import org.springframework.stereotype.Component;

import com.bankbatch.duoc.model.CuentaAnual;

@Component
public class CuentasAnualesProcessor implements ItemProcessor<CuentaAnual, CuentaAnual> {

    @Override
    public CuentaAnual process(CuentaAnual cuenta) {

        if (cuenta == null) {
            return null;
        }

        // Normalizar transacción
        if (cuenta.getTransaccion() != null) {
            cuenta.setTransaccion(
                    cuenta.getTransaccion()
                            .trim()
                            .toLowerCase()
            );
        }

        // Normalizar descripción
        if (cuenta.getDescripcion() != null) {
            cuenta.setDescripcion(
                    cuenta.getDescripcion().trim()
            );
        }

        return cuenta;
    }
}