package com.bankbatch.duoc.service;

import java.util.List;
import com.bankbatch.duoc.repository.CuentaRepository;
import com.bankbatch.duoc.dto.web.WebTransaccionDTO;
import com.bankbatch.duoc.model.TransaccionProcesada;
import com.bankbatch.duoc.repository.TransaccionRepository;
import com.bankbatch.duoc.dto.web.WebMovimientoDTO;
import com.bankbatch.duoc.model.CuentaAnual;

import org.springframework.stereotype.Service;

@Service
public class WebService {

    private final TransaccionRepository transaccionRepository;
    private final CuentaRepository cuentaRepository;

    public WebService(TransaccionRepository transaccionRepository,
                      CuentaRepository cuentaRepository) {
        this.transaccionRepository = transaccionRepository;
        this.cuentaRepository = cuentaRepository;
    }

    public List<WebTransaccionDTO> obtenerTransacciones() {

        List<TransaccionProcesada> transacciones =
                transaccionRepository.obtenerTodas();

        return transacciones.stream()
                .map(transaccion -> new WebTransaccionDTO(
                        transaccion.getTransaccionId(),
                        transaccion.getFecha(),
                        transaccion.getMonto(),
                        transaccion.getTipo(),
                        transaccion.isEsAnomalia(),
                        transaccion.getMotivoAnomalia()
                ))
                .toList();
    }

    public List<WebMovimientoDTO> obtenerMovimientosPorCuenta(Integer cuentaId) {

        List<CuentaAnual> movimientos =
                cuentaRepository.obtenerMovimientosPorCuenta(cuentaId);

        return movimientos.stream()
                .map(movimiento -> new WebMovimientoDTO(
                        movimiento.getCuentaId(),
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto(),
                        movimiento.getDescripcion()
                ))
                .toList();
    }
}