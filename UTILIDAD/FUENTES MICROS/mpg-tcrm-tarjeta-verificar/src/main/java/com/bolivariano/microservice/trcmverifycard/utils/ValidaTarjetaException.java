package com.bolivariano.microservice.trcmverifycard.utils;

public class ValidaTarjetaException extends RuntimeException{
    public ValidaTarjetaException(String mensaje){
        super(mensaje);
    }
}
