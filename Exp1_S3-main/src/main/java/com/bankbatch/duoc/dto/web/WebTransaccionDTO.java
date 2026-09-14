package com.bankbatch.duoc.dto.web;

import java.math.BigDecimal;
import java.time.LocalDate;

public class WebTransaccionDTO {

    public void setId(Integer id) {
        this.id = id;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setEsAnomalia(Boolean esAnomalia) {
        this.esAnomalia = esAnomalia;
    }

    public void setMotivoAnomalia(String motivoAnomalia) {
        this.motivoAnomalia = motivoAnomalia;
    }

    public Integer getId() {
        return id;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public String getTipo() {
        return tipo;
    }

    public Boolean getEsAnomalia() {
        return esAnomalia;
    }

    public String getMotivoAnomalia() {
        return motivoAnomalia;
    }

    private Integer id;
    private LocalDate fecha;
    private BigDecimal monto;
    private String tipo;
    private Boolean esAnomalia;
    private String motivoAnomalia;

    public WebTransaccionDTO() {
    }

    public WebTransaccionDTO(
            Integer id,
            LocalDate fecha,
            BigDecimal monto,
            String tipo,
            Boolean esAnomalia,
            String motivoAnomalia) {

        this.id = id;
        this.fecha = fecha;
        this.monto = monto;
        this.tipo = tipo;
        this.esAnomalia = esAnomalia;
        this.motivoAnomalia = motivoAnomalia;
    }

}
    
