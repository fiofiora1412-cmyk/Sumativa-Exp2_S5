package com.bankxyz.ms_intereses.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bankxyz.ms_intereses.model.Interes;
import com.bankxyz.ms_intereses.repository.InteresRepository;

@RestController
@RequestMapping("/api/intereses")
public class InteresController {

    private final InteresRepository interesRepository;

    public InteresController(InteresRepository interesRepository) {
        this.interesRepository = interesRepository;
    }

    @GetMapping("/{cuentaId}")
    public List<Interes> obtenerPorCuentaId(
            @PathVariable Integer cuentaId) {

        return interesRepository.obtenerPorCuentaId(cuentaId);
    }
}