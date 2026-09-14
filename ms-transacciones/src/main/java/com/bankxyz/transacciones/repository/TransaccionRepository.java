package com.bankxyz.transacciones.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bankxyz.transacciones.model.TransaccionProcesada;

@Repository
public class TransaccionRepository {

    private final JdbcTemplate jdbcTemplate;

    public TransaccionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<TransaccionProcesada> obtenerTodas() {

        String sql = """
                SELECT transaccion_id, fecha, monto, tipo, es_anomalia, motivo_anomalia
                FROM transacciones_procesadas
                ORDER BY fecha DESC, transaccion_id DESC
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            TransaccionProcesada transaccion = new TransaccionProcesada();

            transaccion.setTransaccionId(rs.getInt("transaccion_id"));
            transaccion.setFecha(rs.getObject("fecha", java.time.LocalDate.class));
            transaccion.setMonto(rs.getBigDecimal("monto"));
            transaccion.setTipo(rs.getString("tipo"));
            transaccion.setEsAnomalia(rs.getBoolean("es_anomalia"));
            transaccion.setMotivoAnomalia(rs.getString("motivo_anomalia"));

            return transaccion;
        });
    }

    public TransaccionProcesada obtenerPorId(Integer id) {

        String sql = """
                SELECT transaccion_id, fecha, monto, tipo, es_anomalia, motivo_anomalia
                FROM transacciones_procesadas
                WHERE transaccion_id = ?
                LIMIT 1
                """;

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {

            TransaccionProcesada transaccion = new TransaccionProcesada();

            transaccion.setTransaccionId(rs.getInt("transaccion_id"));
            transaccion.setFecha(rs.getObject("fecha", java.time.LocalDate.class));
            transaccion.setMonto(rs.getBigDecimal("monto"));
            transaccion.setTipo(rs.getString("tipo"));
            transaccion.setEsAnomalia(rs.getBoolean("es_anomalia"));
            transaccion.setMotivoAnomalia(rs.getString("motivo_anomalia"));

            return transaccion;
        }, id);
    }

    public List<TransaccionProcesada> obtenerAnomalias() {

        String sql = """
                SELECT transaccion_id, fecha, monto, tipo, es_anomalia, motivo_anomalia
                FROM transacciones_procesadas
                WHERE es_anomalia = true
                ORDER BY fecha DESC, transaccion_id DESC
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            TransaccionProcesada transaccion = new TransaccionProcesada();

            transaccion.setTransaccionId(rs.getInt("transaccion_id"));
            transaccion.setFecha(rs.getObject("fecha", java.time.LocalDate.class));
            transaccion.setMonto(rs.getBigDecimal("monto"));
            transaccion.setTipo(rs.getString("tipo"));
            transaccion.setEsAnomalia(rs.getBoolean("es_anomalia"));
            transaccion.setMotivoAnomalia(rs.getString("motivo_anomalia"));

            return transaccion;
        });
    }


}