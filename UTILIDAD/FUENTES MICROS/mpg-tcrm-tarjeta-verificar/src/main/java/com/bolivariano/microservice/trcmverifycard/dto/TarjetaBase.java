package com.bolivariano.microservice.trcmverifycard.dto;

public abstract class TarjetaBase {
    private Integer codigoMis;
    private String numeroCuenta;
    private String numeroTarjeta;
    private Boolean expirado;
    private Boolean fraude;
    private Boolean robo;
    private Boolean invalido;

    public Integer getCodigoMis() {
        return codigoMis;
    }

    public void setCodigoMis(Integer codigoMis) {
        this.codigoMis = codigoMis;
    }

    public String getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public String getNumeroTarjeta() {
        return numeroTarjeta;
    }

    public void setNumeroTarjeta(String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }

    public Boolean getExpirado() {
        return expirado;
    }

    public void setExpirado(Boolean expirado) {
        this.expirado = expirado;
    }

    public Boolean getFraude() {
        return fraude;
    }

    public void setFraude(Boolean fraude) {
        this.fraude = fraude;
    }

    public Boolean getRobo() {
        return robo;
    }

    public void setRobo(Boolean robo) {
        this.robo = robo;
    }

    public Boolean getInvalido() {
        return invalido;
    }

    public void setInvalido(Boolean invalido) {
        this.invalido = invalido;
    }
}
