package com.bolivariano.microservice.trcmverifycard.core;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TimeoutConfig {
    @Value("${timeout.db_tarjeta_bb.sp.pa_tcd_ctarjeta_cre:3000}")
    private Integer existeProducto;

    public Integer getExisteProducto() {
        return existeProducto;
    }
}
