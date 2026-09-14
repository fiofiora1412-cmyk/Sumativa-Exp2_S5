package com.bankbatch.duoc.repository;

import java.util.List;

import com.bankbatch.duoc.model.TransaccionProcesada;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TransaccionRepository {

    private final JdbcTemplate jdbcTemplate;

    public TransaccionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<TransaccionProcesada> obtenerTodas() {

        String sql = """
            SELECT
                transaccion_id,
                fecha,
                monto,
                tipo,
                es_anomalia,
                motivo_anomalia
            FROM transacciones_procesadas
            ORDER BY fecha DESC, transaccion_id DESC
            """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            TransaccionProcesada transaccion = new TransaccionProcesada();

            transaccion.setTransaccionId(rs.getInt("transaccion_id"));
            java.sql.Date fecha = rs.getDate("fecha");

            if (fecha != null) {
                transaccion.setFecha(fecha.toLocalDate());
            }
            transaccion.setMonto(rs.getBigDecimal("monto"));
            transaccion.setTipo(rs.getString("tipo"));
            transaccion.setEsAnomalia(rs.getBoolean("es_anomalia"));
            transaccion.setMotivoAnomalia(rs.getString("motivo_anomalia"));

            return transaccion;
        });
        
    }
}

