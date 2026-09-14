package com.bankbatch.duoc.controller;

import java.util.List;

import com.bankbatch.duoc.dto.web.WebTransaccionDTO;
import com.bankbatch.duoc.service.WebService;
import com.bankbatch.duoc.dto.web.WebMovimientoDTO;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/web")
public class WebController {

    private final WebService webService;

    public WebController(WebService webService) {
        this.webService = webService;
    }

    @GetMapping("/transacciones")
    public List<WebTransaccionDTO> obtenerTransacciones() {
        return webService.obtenerTransacciones();
    }

    @GetMapping("/cuentas/{cuentaId}/movimientos")
    public List<WebMovimientoDTO> obtenerMovimientos(
            @PathVariable Integer cuentaId) {

        return webService.obtenerMovimientosPorCuenta(cuentaId);
    }
}
