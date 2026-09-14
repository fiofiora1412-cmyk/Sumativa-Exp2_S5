package com.bankbatch.duoc.config;

import org.springframework.batch.core.step.skip.SkipPolicy;
import org.springframework.batch.infrastructure.item.file.FlatFileParseException;

public class PoliticaToleranciaFallos implements SkipPolicy {

    private static final int LIMITE_SALTOS = 1000;

    @Override
    public boolean shouldSkip(Throwable t, long skipCount) {

        if (skipCount >= LIMITE_SALTOS) {
            return false;
        }

        if (t instanceof FlatFileParseException) {
            return true;
        }

        if (t instanceof IllegalArgumentException) {
            return true;
        }

        return false;
    }
}