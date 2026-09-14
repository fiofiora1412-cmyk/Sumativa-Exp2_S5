package com.bankxyz.bff_web.dto;

import java.math.BigDecimal;

import java.util.List;

public class CuentaWebDTO {

    private Integer cuentaId;
    private String nombre;
    private String tipo;
    private BigDecimal saldoInicial;
    private BigDecimal interesCalculado;
    private BigDecimal saldoFinal;
    private List<MovimientoWebDTO> movimientos;

    public CuentaWebDTO() {
    }

    public CuentaWebDTO(Integer cuentaId, String nombre, String tipo,
                        BigDecimal saldoInicial,
                        BigDecimal interesCalculado,
                        BigDecimal saldoFinal,
                        List<MovimientoWebDTO> movimientos) {
        this.cuentaId = cuentaId;
        this.nombre = nombre;
        this.tipo = tipo;
        this.saldoInicial = saldoInicial;
        this.interesCalculado = interesCalculado;
        this.saldoFinal = saldoFinal;
        this.movimientos = movimientos;
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

    public List<MovimientoWebDTO> getMovimientos() {
        return movimientos;
    }

    public void setMovimientos(List<MovimientoWebDTO> movimientos) {
        this.movimientos = movimientos;
    }

    
}