package com.bankxyz.ms_cuentas.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bankxyz.ms_cuentas.model.TransaccionProcesadaEvent;

@Repository
public class EventoTransaccionRepository {

    private final JdbcTemplate jdbcTemplate;

    public EventoTransaccionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public boolean existePorEventId(String eventId) {

        String sql = """
                SELECT COUNT(*)
                FROM eventos_transaccion_procesados
                WHERE event_id = ?
                """;

        Integer cantidad = jdbcTemplate.queryForObject(
                sql,
                Integer.class,
                eventId
        );

        return cantidad != null && cantidad > 0;
    }

    public void guardar(TransaccionProcesadaEvent evento) {

        String sql = """
                INSERT INTO eventos_transaccion_procesados
                (
                    event_id,
                    transaccion_id,
                    fecha,
                    monto,
                    tipo,
                    es_anomalia,
                    motivo_anomalia
                )
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        jdbcTemplate.update(
                sql,
                evento.getEventId(),
                evento.getTransaccionId(),
                evento.getFecha(),
                evento.getMonto(),
                evento.getTipo(),
                evento.getEsAnomalia(),
                evento.getMotivoAnomalia()
        );
    }
}