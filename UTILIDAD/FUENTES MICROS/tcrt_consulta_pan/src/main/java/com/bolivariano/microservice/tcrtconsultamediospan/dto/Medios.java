package com.bolivariano.microservice.tcrtconsultamediospan.dto;

public class Medios {
    private String tipoMedio;
    private String deDescripcion;

    public Medios(String tipoMedio, String deDescripcion) {
        this.tipoMedio = tipoMedio;
        this.deDescripcion = deDescripcion;
    }

    public String getTipoMedio() {
        return tipoMedio;
    }

    public void setTipoMedio(String tipoMedio) {
        this.tipoMedio = tipoMedio;
    }

    public String getDeDescripcion() {
        return deDescripcion;
    }

    public void setDeDescripcion(String deDescripcion) {
        this.deDescripcion = deDescripcion;
    }
}
