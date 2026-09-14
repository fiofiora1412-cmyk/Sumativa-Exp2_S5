package com.bankxyz.bff_atm.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bankxyz.bff_atm.client.InteresClient;
import com.bankxyz.bff_atm.client.CuentaClient;
import com.bankxyz.bff_atm.dto.CuentaResumenAtmDTO;
import com.bankxyz.bff_atm.dto.InteresAtmDTO;
import com.bankxyz.bff_atm.dto.InteresResponseDTO;
import com.bankxyz.bff_atm.dto.MovimientoAtmDTO;
import com.bankxyz.bff_atm.dto.MovimientoCuentaResponseDTO;


@Service
public class AtmService {

    private final CuentaClient cuentaClient;
    private final InteresClient interesClient;

    public AtmService(CuentaClient cuentaClient,
                  InteresClient interesClient) {
        this.cuentaClient = cuentaClient;
        this.interesClient = interesClient;
        }

    public List<MovimientoAtmDTO> obtenerMovimientosPorCuenta(
            Integer cuentaId) {

        List<MovimientoCuentaResponseDTO> movimientos =
                cuentaClient.obtenerMovimientosPorCuenta(cuentaId);

        return movimientos.stream()
                .map(movimiento -> new MovimientoAtmDTO(
                        movimiento.getFecha(),
                        movimiento.getTransaccion(),
                        movimiento.getMonto()
                ))
                .toList();
    }

    public CuentaResumenAtmDTO obtenerResumenCuenta(Integer cuentaId) {

        List<MovimientoCuentaResponseDTO> movimientos =
                cuentaClient.obtenerMovimientosPorCuenta(cuentaId);
        List<MovimientoAtmDTO> movimientosAtm =
                movimientos.stream()
                        .limit(5)
                        .map(movimiento -> new MovimientoAtmDTO(
                                movimiento.getFecha(),
                                movimiento.getTransaccion(),
                                movimiento.getMonto()
                        ))
                        .toList();
        List<InteresResponseDTO> intereses =
                interesClient.obtenerPorCuentaId(cuentaId);

        List<InteresAtmDTO> interesesAtm =
                intereses.stream()
                        .filter(interes -> interes.getInteresCalculado() != null
                                && interes.getInteresCalculado().compareTo(BigDecimal.ZERO) != 0)        
                        .map(interes -> new InteresAtmDTO(
                                interes.getTipo(),
                                interes.getSaldo(),
                                interes.getTasaInteres(),
                                interes.getInteresCalculado(),
                                interes.getSaldoFinal()
                        ))
                        .toList();
        return new CuentaResumenAtmDTO(cuentaId, movimientosAtm, interesesAtm);
    }
}