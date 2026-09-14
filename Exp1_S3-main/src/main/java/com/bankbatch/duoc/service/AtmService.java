package com.bankbatch.duoc.service;

import java.util.List;

import com.bankbatch.duoc.dto.atm.AtmMovimientoDTO;
import com.bankbatch.duoc.model.CuentaAnual;
import com.bankbatch.duoc.repository.CuentaRepository;

import org.springframework.stereotype.Service;

@Service
public class AtmService {

    private final CuentaRepository cuentaRepository;

    public AtmService(CuentaRepository cuentaRepository) {
        this.cuentaRepository = cuentaRepository;
    }

    public List<AtmMovimientoDTO> obtenerMovimientosPorCuenta(Integer cuentaId) {

        List<CuentaAnual> movimientos =
                cuentaRepository.obtenerMovimientosPorCuenta(cuentaId);

        return movimientos.stream()
                .map(movimiento -> new AtmMovimientoDTO(
                        movimiento.getCuentaId(),
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto()
                ))
                .toList();
    }
}