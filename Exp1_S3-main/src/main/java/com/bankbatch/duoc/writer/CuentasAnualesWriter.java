package com.bankbatch.duoc.writer;

import java.sql.PreparedStatement;
import java.sql.Types;

import org.springframework.batch.infrastructure.item.Chunk;
import org.springframework.batch.infrastructure.item.ItemWriter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.bankbatch.duoc.model.CuentaAnual;

@Component
public class CuentasAnualesWriter implements ItemWriter<CuentaAnual> {

    private final JdbcTemplate jdbcTemplate;

    public CuentasAnualesWriter(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void write(Chunk<? extends CuentaAnual> chunk) {

        String sql = """
                INSERT INTO estados_cuenta (
                    cuenta_id,
                    fecha,
                    transaccion,
                    monto,
                    descripcion
                )
                VALUES (?, ?, ?, ?, ?)
                """;

        for (CuentaAnual item : chunk.getItems()) {

            jdbcTemplate.update(
                    sql,
                    (PreparedStatement ps) -> {

                        // cuenta_id
                        if (item.getCuentaId() == null) {
                            ps.setNull(1, Types.INTEGER);
                        } else {
                            ps.setInt(1, item.getCuentaId());
                        }

                        // fecha
                        if (item.getFecha() == null) {
                            ps.setNull(2, Types.DATE);
                        } else {
                            ps.setDate(
                                    2,
                                    java.sql.Date.valueOf(item.getFecha())
                            );
                        }

                        // transaccion
                        if (item.getTransaccion() == null) {
                            ps.setNull(3, Types.VARCHAR);
                        } else {
                            ps.setString(3, item.getTransaccion());
                        }

                        // monto
                        if (item.getMonto() == null) {
                            ps.setNull(4, Types.NUMERIC);
                        } else {
                            ps.setBigDecimal(4, item.getMonto());
                        }

                        // descripcion
                        if (item.getDescripcion() == null
                                || item.getDescripcion().isBlank()) {

                            ps.setNull(5, Types.VARCHAR);

                        } else {

                            ps.setString(5, item.getDescripcion());
                        }
                    }
            );
        }
    }
}