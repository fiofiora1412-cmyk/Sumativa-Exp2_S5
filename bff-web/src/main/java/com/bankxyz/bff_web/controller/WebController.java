package com.bankxyz.bff_web.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bankxyz.bff_web.dto.CuentaWebDTO;
import com.bankxyz.bff_web.dto.MovimientoWebDTO;
import com.bankxyz.bff_web.service.WebService;


@RestController
@RequestMapping("/api/web")
public class WebController {

    private final WebService webService;

    public WebController(WebService webService) {
        this.webService = webService;
    }

    @GetMapping("/transacciones")
    public List<Object> obtenerTransacciones() {
        return webService.obtenerTransacciones();
    }

    @GetMapping("/cuentas/{cuentaId}")
    public CuentaWebDTO obtenerCuenta(@PathVariable Integer cuentaId) {
        return webService.obtenerCuenta(cuentaId);
    }

    @GetMapping("/cuentas/{cuentaId}/movimientos")
    public List<MovimientoWebDTO> obtenerMovimientosPorCuenta(
            @PathVariable Integer cuentaId) {

        return webService.obtenerMovimientosPorCuenta(cuentaId);
    }
}