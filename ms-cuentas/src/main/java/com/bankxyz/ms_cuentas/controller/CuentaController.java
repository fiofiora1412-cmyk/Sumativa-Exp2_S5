package com.bankxyz.ms_cuentas.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;

import com.bankxyz.ms_cuentas.model.MovimientoCuenta;
import com.bankxyz.ms_cuentas.service.CuentaService;

@RestController
@RequestMapping("/api/cuentas")
public class CuentaController {

    private final CuentaService cuentaService;

    @Value("${mensaje.config.server}")
    private String mensajeConfigServer;

    public CuentaController(CuentaService cuentaService) {
        this.cuentaService = cuentaService;
    }

    @GetMapping("/{cuentaId}/movimientos")
    public List<MovimientoCuenta> obtenerMovimientosPorCuenta(
            @PathVariable Integer cuentaId) {

        return cuentaService.obtenerMovimientosPorCuenta(cuentaId);
    }

    @GetMapping("/config-test")
    public String probarConfiguracion() {
        return mensajeConfigServer;
    }
}