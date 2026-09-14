package com.bankxyz.bff_atm.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bankxyz.bff_atm.dto.MovimientoAtmDTO;
import com.bankxyz.bff_atm.dto.CuentaResumenAtmDTO;
import com.bankxyz.bff_atm.service.AtmService;

@RestController
@RequestMapping("/api/atm")
public class AtmController {

    private final AtmService atmService;

    public AtmController(AtmService atmService) {
        this.atmService = atmService;
    }

    @GetMapping("/cuentas/{cuentaId}/movimientos")
    public List<MovimientoAtmDTO> obtenerMovimientosPorCuenta(
            @PathVariable Integer cuentaId) {

        return atmService.obtenerMovimientosPorCuenta(cuentaId);
    }

    @GetMapping("/cuentas/{cuentaId}/resumen")
    public CuentaResumenAtmDTO obtenerResumenCuenta(
            @PathVariable Integer cuentaId) {

        return atmService.obtenerResumenCuenta(cuentaId);
    }
}