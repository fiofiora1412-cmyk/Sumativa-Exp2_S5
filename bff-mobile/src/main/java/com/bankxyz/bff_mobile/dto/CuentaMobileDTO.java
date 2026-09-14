package com.bankxyz.bff_mobile.dto;

import java.math.BigDecimal;

public class CuentaMobileDTO {

    private Integer cuentaId;
    private String nombre;
    private String tipo;
    private BigDecimal saldoInicial;
    private BigDecimal saldoFinal;

    public CuentaMobileDTO() {
    }

    public CuentaMobileDTO(Integer cuentaId, String nombre, String tipo,
                           BigDecimal saldoInicial, BigDecimal saldoFinal) {
        this.cuentaId = cuentaId;
        this.nombre = nombre;
        this.tipo = tipo;
        this.saldoInicial = saldoInicial;
        this.saldoFinal = saldoFinal;
    }

    public Integer getCuentaId() {
        return cuentaId;
    }

    public void setCuentaId(Integer cuentaId) {
        this.cuentaId = cuentaId;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public BigDecimal getSaldoInicial() {
        return saldoInicial;
    }

    public void setSaldoInicial(BigDecimal saldoInicial) {
        this.saldoInicial = saldoInicial;
    }

    public BigDecimal getSaldoFinal() {
        return saldoFinal;
    }

    public void setSaldoFinal(BigDecimal saldoFinal) {
        this.saldoFinal = saldoFinal;
    }
}