package com.bankxyz.bff_mobile.dto;

import java.math.BigDecimal;

public class TransaccionMobileDTO {

    private Integer id;
    private BigDecimal monto;
    private String tipo;

    public TransaccionMobileDTO() {
    }

    public TransaccionMobileDTO(Integer id, BigDecimal monto, String tipo) {
        this.id = id;
        this.monto = monto;
        this.tipo = tipo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
}