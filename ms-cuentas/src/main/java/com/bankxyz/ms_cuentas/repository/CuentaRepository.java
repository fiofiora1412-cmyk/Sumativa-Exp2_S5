package com.bankxyz.ms_cuentas.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bankxyz.ms_cuentas.model.MovimientoCuenta;

@Repository
public class CuentaRepository {

    private final JdbcTemplate jdbcTemplate;

    public CuentaRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<MovimientoCuenta> obtenerMovimientosPorCuenta(Integer cuentaId) {

        String sql = """
                SELECT cuenta_id, fecha, transaccion, monto, descripcion
                FROM estados_cuenta
                WHERE cuenta_id = ?
                ORDER BY fecha DESC
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            MovimientoCuenta movimiento = new MovimientoCuenta();

            movimiento.setCuentaId(rs.getInt("cuenta_id"));
            movimiento.setFecha(rs.getObject("fecha", java.time.LocalDate.class));
            movimiento.setTransaccion(rs.getString("transaccion"));
            movimiento.setMonto(rs.getBigDecimal("monto"));
            movimiento.setDescripcion(rs.getString("descripcion"));

            return movimiento;
        }, cuentaId);
    }

}