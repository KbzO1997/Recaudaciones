package com.bolivariano.microservice.trcmverifycard.dto.tarjetacre;

import com.bolivariano.microservice.trcmverifycard.dto.TarjetaBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
public class TarjetaCreditoRes extends TarjetaBase {
    private String tipoIdentificacion;
    private String identificacion;

    public String getTipoIdentificacion() {
        return tipoIdentificacion;
    }

    public void setTipoIdentificacion(String tipoIdentificacion) {
        this.tipoIdentificacion = tipoIdentificacion;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
}
