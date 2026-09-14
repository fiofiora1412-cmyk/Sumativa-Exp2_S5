package com.bankbatch.duoc.controller;

import java.util.List;

import com.bankbatch.duoc.dto.mobile.MobileTransaccionDTO;
import com.bankbatch.duoc.service.MobileService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/mobile")
public class MobileController {

    private final MobileService mobileService;

    public MobileController(MobileService mobileService) {
        this.mobileService = mobileService;
    }

    @GetMapping("/transacciones")
    public List<MobileTransaccionDTO> obtenerTransacciones() {
        return mobileService.obtenerTransacciones();
    }
}