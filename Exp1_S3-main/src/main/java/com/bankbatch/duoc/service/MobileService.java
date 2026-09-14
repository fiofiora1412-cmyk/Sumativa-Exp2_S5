package com.bankbatch.duoc.service;

import java.util.List;

import com.bankbatch.duoc.dto.mobile.MobileTransaccionDTO;
import com.bankbatch.duoc.model.TransaccionProcesada;
import com.bankbatch.duoc.repository.TransaccionRepository;

import org.springframework.stereotype.Service;

@Service
public class MobileService {

    private final TransaccionRepository transaccionRepository;

    public MobileService(TransaccionRepository transaccionRepository) {
        this.transaccionRepository = transaccionRepository;
    }

    public List<MobileTransaccionDTO> obtenerTransacciones() {

        List<TransaccionProcesada> transacciones =
                transaccionRepository.obtenerTodas();

        return transacciones.stream()
                .map(transaccion -> new MobileTransaccionDTO(
                        transaccion.getTransaccionId(),
                        transaccion.getFecha(),
                        transaccion.getMonto(),
                        transaccion.getTipo()
                ))
                .toList();
    }
}