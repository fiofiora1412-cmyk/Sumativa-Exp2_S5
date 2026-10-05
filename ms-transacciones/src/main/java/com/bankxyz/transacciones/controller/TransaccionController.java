package com.bankxyz.transacciones.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.bankxyz.transacciones.model.TransaccionProcesada;
import com.bankxyz.transacciones.service.TransaccionService;

@RestController
@RequestMapping("/api/transacciones")
public class TransaccionController {

    private final TransaccionService transaccionService;

    public TransaccionController(TransaccionService transaccionService) {
        this.transaccionService = transaccionService;
    }

    @GetMapping
    public List<TransaccionProcesada> obtenerTodas() {
        return transaccionService.obtenerTodas();
    }

    @GetMapping("/{id}")
    public TransaccionProcesada obtenerPorId(@PathVariable Integer id) {
        return transaccionService.obtenerPorId(id);
    }

    @GetMapping("/anomalias")
    public List<TransaccionProcesada> obtenerAnomalias() {
        return transaccionService.obtenerAnomalias();
    }

    @PostMapping("/{id}/publicar-evento")
    public void publicarEvento(@PathVariable Integer id) {
        transaccionService.publicarEvento(id);
    }
}