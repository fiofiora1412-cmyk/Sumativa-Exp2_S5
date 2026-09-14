package com.bankxyz.bff_mobile.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bankxyz.bff_mobile.client.TransaccionClient;
import com.bankxyz.bff_mobile.dto.CuentaMobileDTO;
import com.bankxyz.bff_mobile.dto.InteresResponseDTO;
import com.bankxyz.bff_mobile.dto.MovimientoCuentaResponseDTO;
import com.bankxyz.bff_mobile.dto.MovimientoMobileDTO;
import com.bankxyz.bff_mobile.dto.TransaccionMobileDTO;
import com.bankxyz.bff_mobile.dto.TransaccionResponseDTO;
import com.bankxyz.bff_mobile.client.CuentaClient;
import com.bankxyz.bff_mobile.client.InteresClient;


@Service
public class MobileService {

    private final TransaccionClient transaccionClient;
    private final CuentaClient cuentaClient;
    private final InteresClient interesClient;

    public MobileService(TransaccionClient transaccionClient,
                        CuentaClient cuentaClient,
                        InteresClient interesClient) {

        this.transaccionClient = transaccionClient;
        this.cuentaClient = cuentaClient;
        this.interesClient = interesClient;
    }

    public List<TransaccionMobileDTO> obtenerTransacciones() {

        List<TransaccionResponseDTO> transacciones =
                transaccionClient.obtenerTransacciones();

        return transacciones.stream()
                .map(transaccion -> new TransaccionMobileDTO(
                        transaccion.getTransaccionId(),
                        transaccion.getMonto(),
                        transaccion.getTipo()
                ))
                .toList();
    }

    public CuentaMobileDTO obtenerCuenta(Integer cuentaId) {

        List<InteresResponseDTO> intereses =
                interesClient.obtenerPorCuentaId(cuentaId);

        if (intereses.isEmpty()) {
            return null;
        }

        InteresResponseDTO interes = intereses.get(0);

        cuentaClient.obtenerMovimientosPorCuenta(cuentaId);

        return new CuentaMobileDTO(
                interes.getCuentaId(),
                interes.getNombre(),
                interes.getTipo(),
                interes.getSaldo(),
                interes.getSaldoFinal()
        );
    }

    public List<MovimientoMobileDTO> obtenerMovimientosPorCuenta(Integer cuentaId) {

        List<MovimientoCuentaResponseDTO> movimientos =
                cuentaClient.obtenerMovimientosPorCuenta(cuentaId);

        return movimientos.stream()
                .map(movimiento -> new MovimientoMobileDTO(
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto()
                ))
                .toList();
    }
}