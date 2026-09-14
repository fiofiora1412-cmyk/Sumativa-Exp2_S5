package com.bankxyz.bff_web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bankxyz.bff_web.client.CuentaClient;
import com.bankxyz.bff_web.client.InteresClient;
import com.bankxyz.bff_web.client.TransaccionClient;
import com.bankxyz.bff_web.dto.CuentaWebDTO;
import com.bankxyz.bff_web.dto.InteresResponseDTO;
import com.bankxyz.bff_web.dto.MovimientoCuentaResponseDTO;
import com.bankxyz.bff_web.dto.MovimientoWebDTO;


@Service
public class WebService {

    private final CuentaClient cuentaClient;
    private final InteresClient interesClient;
    private final TransaccionClient transaccionClient;

    public WebService(CuentaClient cuentaClient,
                      InteresClient interesClient,
                      TransaccionClient transaccionClient) {

        this.cuentaClient = cuentaClient;
        this.interesClient = interesClient;
        this.transaccionClient = transaccionClient;
    }

    public CuentaWebDTO obtenerCuenta(Integer cuentaId) {

        List<InteresResponseDTO> intereses =
                interesClient.obtenerPorCuentaId(cuentaId);

        if (intereses.isEmpty()) {
            return null;
        }

        InteresResponseDTO interes = intereses.get(0);

        List<MovimientoCuentaResponseDTO> movimientos =
                cuentaClient.obtenerMovimientosPorCuenta(cuentaId);

        List<MovimientoWebDTO> movimientosWeb = movimientos.stream()
                .map(movimiento -> new MovimientoWebDTO(
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto(),
                        movimiento.getDescripcion()
                ))
                .toList();

        return new CuentaWebDTO(
                interes.getCuentaId(),
                interes.getNombre(),
                interes.getTipo(),
                interes.getSaldo(),
                interes.getInteresCalculado(),
                interes.getSaldoFinal(),
                movimientosWeb
        );
    }

    public List<Object> obtenerTransacciones() {
        return transaccionClient.obtenerTransacciones();
    }

    public List<MovimientoWebDTO> obtenerMovimientosPorCuenta(Integer cuentaId) {

        List<MovimientoCuentaResponseDTO> movimientos =
                cuentaClient.obtenerMovimientosPorCuenta(cuentaId);

        return movimientos.stream()
                .map(movimiento -> new MovimientoWebDTO(
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto(),
                        movimiento.getDescripcion()
                ))
                .toList();
    }

}