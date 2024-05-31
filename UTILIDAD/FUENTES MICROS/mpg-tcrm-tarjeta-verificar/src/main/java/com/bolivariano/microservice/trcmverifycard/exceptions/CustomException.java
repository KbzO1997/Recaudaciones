package com.bolivariano.microservice.trcmverifycard.exceptions;


public class CustomException extends Exception {
    private static final long serialVersionUID = 1L;
    private final String mensajeUsuario;
    private final String messageSistema;
    private final int codigoError;

    public String getMensajeUsuario() {
        return mensajeUsuario;
    }

    public String getMensajeSistema() {
        return messageSistema;
    }

    public int getCodigoError() {
        return codigoError;
    }

    public CustomException(int code, String messageNegocio, String messageUsuario) {
        this.codigoError = code;
        this.messageSistema = messageUsuario;
        this.mensajeUsuario = messageNegocio;
    }
}