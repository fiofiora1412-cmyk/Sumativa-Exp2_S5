package com.bankbatch.duoc.model;

public class Transaccion {

    private Integer id;
    private String fecha;
    private String monto;
    private String tipo;

    public Transaccion() {
    }

    public Transaccion(Integer id, String fecha, String monto, String tipo) {
        this.id = id;
        this.fecha = fecha;
        this.monto = monto;
        this.tipo = tipo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}