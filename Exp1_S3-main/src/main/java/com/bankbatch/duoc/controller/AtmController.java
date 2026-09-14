package com.bankbatch.duoc.controller;

import java.util.List;

import com.bankbatch.duoc.dto.atm.AtmMovimientoDTO;
import com.bankbatch.duoc.service.AtmService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/atm")
public class AtmController {

    private final AtmService atmService;

    public AtmController(AtmService atmService) {
        this.atmService = atmService;
    }

    @GetMapping("/cuentas/{cuentaId}/movimientos")
    public List<AtmMovimientoDTO> obtenerMovimientos(
            @PathVariable Integer cuentaId) {

        return atmService.obtenerMovimientosPorCuenta(cuentaId);
    }
}