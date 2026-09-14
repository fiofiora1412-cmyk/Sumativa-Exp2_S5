package com.bankxyz.ms_cuentas.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bankxyz.ms_cuentas.model.MovimientoCuenta;
import com.bankxyz.ms_cuentas.repository.CuentaRepository;

@RestController
@RequestMapping("/api/cuentas")
public class CuentaController {

    private final CuentaRepository cuentaRepository;

    public CuentaController(CuentaRepository cuentaRepository) {
        this.cuentaRepository = cuentaRepository;
    }

    @GetMapping("/{cuentaId}/movimientos")
    public List<MovimientoCuenta> obtenerMovimientosPorCuenta(
            @PathVariable Integer cuentaId) {

        return cuentaRepository.obtenerMovimientosPorCuenta(cuentaId);
    }
}