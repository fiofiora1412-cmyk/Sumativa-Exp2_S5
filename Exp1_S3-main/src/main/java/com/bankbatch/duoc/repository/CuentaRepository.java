package com.bankbatch.duoc.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bankbatch.duoc.model.CuentaAnual;

@Repository
public class CuentaRepository {

    private final JdbcTemplate jdbcTemplate;

    public CuentaRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<CuentaAnual> obtenerMovimientosPorCuenta(Integer cuentaId) {

        String sql = """
                SELECT cuenta_id, fecha, transaccion, monto, descripcion
                FROM estados_cuenta
                WHERE cuenta_id = ?
                ORDER BY fecha DESC
                """;

        return jdbcTemplate.query(
                sql,
                (rs, rowNum) -> {

                    CuentaAnual cuenta = new CuentaAnual();

                    cuenta.setCuentaId(rs.getInt("cuenta_id"));

                    java.sql.Date fecha = rs.getDate("fecha");
                    if (fecha != null) {
                        cuenta.setFecha(fecha.toLocalDate());
                    }

                    cuenta.setTransaccion(rs.getString("transaccion"));
                    cuenta.setMonto(rs.getBigDecimal("monto"));
                    cuenta.setDescripcion(rs.getString("descripcion"));

                    return cuenta;
                },
                cuentaId
        );
    }
}