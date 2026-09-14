package com.bankxyz.bff_atm.dto;

import java.util.List;

public class CuentaResumenAtmDTO {

    private Integer cuentaId;
    private List<MovimientoAtmDTO> movimientos;
    private List<InteresAtmDTO> interesesProcesados;

    public CuentaResumenAtmDTO() {
    }

    public CuentaResumenAtmDTO(Integer cuentaId,
                               List<MovimientoAtmDTO> movimientos,
                               List<InteresAtmDTO> interesesProcesados) {
        this.cuentaId = cuentaId;
        this.movimientos = movimientos;
        this.interesesProcesados = interesesProcesados;
    }

    public Integer getCuentaId() {
        return cuentaId;
    }

    public void setCuentaId(Integer cuentaId) {
        this.cuentaId = cuentaId;
    }

    public List<MovimientoAtmDTO> getMovimientos() {
        return movimientos;
    }

    public void setMovimientos(List<MovimientoAtmDTO> movimientos) {
        this.movimientos = movimientos;
    }

    public List<InteresAtmDTO> getInteresesProcesados() {
        return interesesProcesados;
    }

    public void setInteresesProcesados(List<InteresAtmDTO> interesesProcesados) {
        this.interesesProcesados = interesesProcesados;
    }
}