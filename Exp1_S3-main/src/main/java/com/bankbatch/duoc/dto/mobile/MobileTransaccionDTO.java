package com.bankbatch.duoc.dto.mobile;

import java.math.BigDecimal;
import java.time.LocalDate;

public class MobileTransaccionDTO {

    private Integer id;
    private LocalDate fecha;
    private BigDecimal monto;
    private String tipo;

    public MobileTransaccionDTO() {
    }

    public MobileTransaccionDTO(
            Integer id,
            LocalDate fecha,
            BigDecimal monto,
            String tipo) {

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
}