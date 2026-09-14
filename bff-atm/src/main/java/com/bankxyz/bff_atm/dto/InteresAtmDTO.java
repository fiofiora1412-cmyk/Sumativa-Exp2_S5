package com.bankxyz.bff_atm.dto;

import java.math.BigDecimal;

public class InteresAtmDTO {

    private String tipo;
    private BigDecimal saldoInicial;
    private BigDecimal tasaInteres;
    private BigDecimal interesCalculado;
    private BigDecimal saldoFinal;

    public InteresAtmDTO() {
    }

    public InteresAtmDTO(String tipo,
                         BigDecimal saldoInicial,
                         BigDecimal tasaInteres,
                         BigDecimal interesCalculado,
                         BigDecimal saldoFinal) {
        this.tipo = tipo;
        this.saldoInicial = saldoInicial;
        this.tasaInteres = tasaInteres;
        this.interesCalculado = interesCalculado;
        this.saldoFinal = saldoFinal;
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

    public BigDecimal getTasaInteres() {
        return tasaInteres;
    }

    public void setTasaInteres(BigDecimal tasaInteres) {
        this.tasaInteres = tasaInteres;
    }

    public BigDecimal getInteresCalculado() {
        return interesCalculado;
    }

    public void setInteresCalculado(BigDecimal interesCalculado) {
        this.interesCalculado = interesCalculado;
    }

    public BigDecimal getSaldoFinal() {
        return saldoFinal;
    }

    public void setSaldoFinal(BigDecimal saldoFinal) {
        this.saldoFinal = saldoFinal;
    }
}