package com.bankbatch.duoc.model;

import java.math.BigDecimal;

public class Interes {

    private Long cuentaId;
    private String nombre;
    private BigDecimal saldo;
    private Integer edad;
    private String tipo;
    private BigDecimal tasaInteres;
    private BigDecimal interesCalculado;
    private BigDecimal saldoFinal;

    public Interes() {
    }

    public Long getCuentaId() {
        return cuentaId;
    }

    public void setCuentaId(Long cuentaId) {
        this.cuentaId = cuentaId;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public BigDecimal getSaldo() {
        return saldo;
    }

    public void setSaldo(BigDecimal saldo) {
        this.saldo = saldo;
    }

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
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