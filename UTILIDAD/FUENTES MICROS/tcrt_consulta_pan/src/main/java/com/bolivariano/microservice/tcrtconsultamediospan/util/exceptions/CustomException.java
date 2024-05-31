package com.bolivariano.microservice.tcrtconsultamediospan.util.exceptions;

import com.bolivariano.microservice.tcrtconsultamediospan.util.enums.DictionaryResponses;
import com.bolivariano.microservice.tcrtconsultamediospan.util.enums.TipoError;

public class CustomException extends Exception {
    private static final long serialVersionUID = 1L;
    private final String mensajeUsuario;
    private final String messageSistema;
    private final int codigoError;

    private final TipoError error;

    public String getMensajeUsuario() {
        return mensajeUsuario;
    }

    public String getMensajeSistema() {
        return messageSistema;
    }

    public TipoError getError() {
        return error;
    }


    public int getCodigoError() {
        return codigoError;
    }

    public CustomException(int code, String messageNegocio, String messageUsuario) {
        this.codigoError = code;
        this.messageSistema = messageUsuario;
        this.mensajeUsuario = messageNegocio;
        this.error = TipoError.SOLICITUD_INVALIDA;
    }
    public CustomException(int code, String messageNegocio, String messageUsuario,TipoError error) {
        this.codigoError = code;
        this.messageSistema = messageNegocio;
        this.mensajeUsuario = messageUsuario;
        this.error = error;
    }
    public CustomException(DictionaryResponses status, TipoError error) {
        this.codigoError = status.getCode();
        this.messageSistema = status.getMessage();
        this.mensajeUsuario = status.getMessage();
        this.error = error;
    }
    public CustomException(DictionaryResponses status) {
        this.codigoError = status.getCode();
        this.messageSistema = this.getMessage();
        this.mensajeUsuario = status.getMessage();
        this.error = TipoError.SOLICITUD_INVALIDA;

    }
    public CustomException(DictionaryResponses status,String mensajeUser,TipoError error) {
        this.codigoError = status.getCode();
        this.messageSistema = status.getMessage();
        this.mensajeUsuario = mensajeUser;
        this.error = error;
    }
    public CustomException(DictionaryResponses status,String mensajeUser) {
        this.codigoError = status.getCode();
        this.messageSistema = status.getMessage();
        this.mensajeUsuario = mensajeUser;
        this.error = TipoError.SOLICITUD_INVALIDA;
    }

}

