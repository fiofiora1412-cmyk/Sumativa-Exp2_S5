package com.bankxyz.ms_intereses.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class TransaccionProcesadaEvent {

    private String eventId;
    private Integer transaccionId;
    private LocalDate fecha;
    private BigDecimal monto;
    private String tipo;
    private Boolean esAnomalia;
    private String motivoAnomalia;

    public TransaccionProcesadaEvent() {
    }

    public TransaccionProcesadaEvent(
            String eventId,
            Integer transaccionId,
            LocalDate fecha,
            BigDecimal monto,
            String tipo,
            Boolean esAnomalia,
            String motivoAnomalia) {

        this.eventId = eventId;
        this.transaccionId = transaccionId;
        this.fecha = fecha;
        this.monto = monto;
        this.tipo = tipo;
        this.esAnomalia = esAnomalia;
        this.motivoAnomalia = motivoAnomalia;
    }

    public String getEventId() {
        return eventId;
    }

    public void setEventId(String eventId) {
        this.eventId = eventId;
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

    public Boolean getEsAnomalia() {
        return esAnomalia;
    }

    public void setEsAnomalia(Boolean esAnomalia) {
        this.esAnomalia = esAnomalia;
    }

    public String getMotivoAnomalia() {
        return motivoAnomalia;
    }

    public void setMotivoAnomalia(String motivoAnomalia) {
        this.motivoAnomalia = motivoAnomalia;
    }
}