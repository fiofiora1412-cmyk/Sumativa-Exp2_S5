package com.bankxyz.ms_intereses.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bankxyz.ms_intereses.model.Interes;

@Repository
public class InteresRepository {

    private final JdbcTemplate jdbcTemplate;

    public InteresRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Interes> obtenerPorCuentaId(Integer cuentaId) {

        String sql = """
                SELECT cuenta_id, nombre, saldo_inicial AS saldo, edad, tipo,
                tasa_interes, interes_calculado, saldo_final
                FROM intereses_procesados
                WHERE cuenta_id = ?
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {

            Interes interes = new Interes();

            interes.setCuentaId(rs.getInt("cuenta_id"));
            interes.setNombre(rs.getString("nombre"));
            interes.setSaldo(rs.getBigDecimal("saldo"));
            interes.setEdad(rs.getInt("edad"));
            interes.setTipo(rs.getString("tipo"));
            interes.setTasaInteres(rs.getBigDecimal("tasa_interes"));
            interes.setInteresCalculado(rs.getBigDecimal("interes_calculado"));
            interes.setSaldoFinal(rs.getBigDecimal("saldo_final"));

            return interes;
        }, cuentaId);
    }

}