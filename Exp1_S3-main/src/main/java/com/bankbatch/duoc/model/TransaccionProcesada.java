package com.bankbatch.duoc.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class TransaccionProcesada {

    private Integer transaccionId;
    private LocalDate fecha;
    private BigDecimal monto;
    private String tipo;
    private boolean esAnomalia;
    private String motivoAnomalia;

    public TransaccionProcesada() {
    }

    public TransaccionProcesada(
            Integer transaccionId,
            LocalDate fecha,
            BigDecimal monto,
            String tipo,
            boolean esAnomalia,
            String motivoAnomalia) {

        this.transaccionId = transaccionId;
        this.fecha = fecha;
        this.monto = monto;
        this.tipo = tipo;
        this.esAnomalia = esAnomalia;
        this.motivoAnomalia = motivoAnomalia;
    }

    public Integer getTransaccionId() {
        return transaccionId;
    }

    public void setTransaccionId(Integer transaccionId) {
        this.transaccionId = transaccionId;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public boolean isEsAnomalia() {
        return esAnomalia;
    }

    public void setEsAnomalia(boolean esAnomalia) {
        this.esAnomalia = esAnomalia;
    }

    public String getMotivoAnomalia() {
        return motivoAnomalia;
    }

    public void setMotivoAnomalia(String motivoAnomalia) {
        this.motivoAnomalia = motivoAnomalia;
    }
}