package com.bankbatch.duoc.writer;

import java.sql.PreparedStatement;

import org.springframework.batch.infrastructure.item.Chunk;
import org.springframework.batch.infrastructure.item.ItemWriter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.bankbatch.duoc.model.Interes;

@Component
public class InteresesWriter implements ItemWriter<Interes> {

    private final JdbcTemplate jdbcTemplate;

    public InteresesWriter(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void write(Chunk<? extends Interes> chunk) {

        String sql = """
                INSERT INTO intereses_procesados (
                    cuenta_id,
                    nombre,
                    saldo_inicial,
                    edad,
                    tipo,
                    tasa_interes,
                    interes_calculado,
                    saldo_final
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        for (Interes item : chunk.getItems()) {

            jdbcTemplate.update(
                    sql,
                    (PreparedStatement ps) -> {
                        ps.setLong(1, item.getCuentaId());
                        ps.setString(2, item.getNombre());
                        ps.setBigDecimal(3, item.getSaldo());
                        ps.setObject(4, item.getEdad(), java.sql.Types.INTEGER);
                        ps.setString(5, item.getTipo());
                        ps.setBigDecimal(6, item.getTasaInteres());
                        ps.setBigDecimal(7, item.getInteresCalculado());
                        ps.setBigDecimal(8, item.getSaldoFinal());
                    }
            );
        }
    }
}