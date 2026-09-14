package com.bankbatch.duoc.dto.atm;

import java.math.BigDecimal;
import java.time.LocalDate;

public class AtmMovimientoDTO {

    private Integer cuentaId;
    private LocalDate fecha;
    private String transaccion;
    private BigDecimal monto;

    public AtmMovimientoDTO() {
    }

    public AtmMovimientoDTO(
            Integer cuentaId,
            LocalDate fecha,
            String transaccion,
            BigDecimal monto) {

        this.cuentaId = cuentaId;
        this.fecha = fecha;
        this.transaccion = transaccion;
        this.monto = monto;
    }

    public Integer getCuentaId() {
        return cuentaId;
    }

    public void setCuentaId(Integer cuentaId) {
        this.cuentaId = cuentaId;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getTransaccion() {
        return transaccion;
    }

    public void setTransaccion(String transaccion) {
        this.transaccion = transaccion;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }
}