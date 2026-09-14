package com.bankxyz.bff_mobile.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class MovimientoMobileDTO {

    private LocalDate fecha;
    private String transaccion;
    private BigDecimal monto;

    public MovimientoMobileDTO() {
    }

    public MovimientoMobileDTO(LocalDate fecha, String transaccion,
                               BigDecimal monto) {
        this.fecha = fecha;
        this.transaccion = transaccion;
        this.monto = monto;
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