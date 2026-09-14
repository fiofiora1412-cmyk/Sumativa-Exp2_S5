package com.bankxyz.transacciones.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import com.bankxyz.transacciones.model.TransaccionProcesada;
import com.bankxyz.transacciones.repository.TransaccionRepository;

@RestController
@RequestMapping("/api/transacciones")
public class TransaccionController {

    private final TransaccionRepository transaccionRepository;

    public TransaccionController(TransaccionRepository transaccionRepository) {
        this.transaccionRepository = transaccionRepository;
    }

    @GetMapping
    public List<TransaccionProcesada> obtenerTodas() {
        return transaccionRepository.obtenerTodas();
    }

    @GetMapping("/{id}")
    public TransaccionProcesada obtenerPorId(@PathVariable Integer id) {
        return transaccionRepository.obtenerPorId(id);
    }

    @GetMapping("/anomalias")
    public List<TransaccionProcesada> obtenerAnomalias() {
        return transaccionRepository.obtenerAnomalias();
    }
}