package com.bankxyz.bff_mobile.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.bankxyz.bff_mobile.dto.TransaccionMobileDTO;
import com.bankxyz.bff_mobile.service.MobileService;
import com.bankxyz.bff_mobile.dto.CuentaMobileDTO;
import com.bankxyz.bff_mobile.dto.MovimientoMobileDTO;


@RestController
@RequestMapping("/api/mobile")
public class MobileController {

    private final MobileService mobileService;

    public MobileController(MobileService mobileService) {
        this.mobileService = mobileService;
    }

    @GetMapping("/transacciones")
    public List<TransaccionMobileDTO> obtenerTransacciones() {
        return mobileService.obtenerTransacciones();
    }

    @GetMapping("/cuentas/{cuentaId}")
    public CuentaMobileDTO obtenerCuenta(@PathVariable Integer cuentaId) {
        return mobileService.obtenerCuenta(cuentaId);
    }

    @GetMapping("/cuentas/{cuentaId}/movimientos")
    public List<MovimientoMobileDTO> obtenerMovimientosPorCuenta(
            @PathVariable Integer cuentaId) {

        return mobileService.obtenerMovimientosPorCuenta(cuentaId);
    }
}