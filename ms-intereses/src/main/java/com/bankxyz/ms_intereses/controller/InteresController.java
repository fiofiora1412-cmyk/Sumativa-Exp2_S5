package com.bankxyz.ms_intereses.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bankxyz.ms_intereses.model.Interes;
import com.bankxyz.ms_intereses.service.InteresService;

@RestController
@RequestMapping("/api/intereses")
public class InteresController {

    private final InteresService interesService;

    public InteresController(InteresService interesService) {
        this.interesService = interesService;
    }

    @GetMapping("/{cuentaId}")
    public List<Interes> obtenerPorCuentaId(
            @PathVariable Integer cuentaId) {

        return interesService.obtenerPorCuentaId(cuentaId);
    }
}