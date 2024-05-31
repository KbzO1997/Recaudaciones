package com.bolivariano.microservice.tcrtconsultamediospan.util.enums;

public enum TipoError {

    NO_ENCONTRADO("404"),
    SOLICITUD_INVALIDA("400"),
    SERVICIO_INACCESIBLE("502"),
    FUENTE_DE_DATOS("503"),
    ERROR_INESPERADO("500"),
    LOGICA_NEGOCIO("0004");


    private String value;

    private TipoError(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}