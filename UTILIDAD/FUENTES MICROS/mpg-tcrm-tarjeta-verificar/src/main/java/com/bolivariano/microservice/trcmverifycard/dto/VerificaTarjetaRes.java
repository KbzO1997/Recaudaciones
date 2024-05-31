package com.bolivariano.microservice.trcmverifycard.dto;

import com.bolivariano.microservice.trcmverifycard.dto.cliente.ClienteRes;

public class VerificaTarjetaRes {
    private Integer consumerId;
    private String accountId;
    private String claveUnica;
    private String tipoTarjeta;
    private TarjetaVal card;
    private ClienteRes datosCliente;

    private Boolean cvvStatus;

    public Boolean getCvvStatus() {
        return cvvStatus;
    }

    public void setCvvStatus(Boolean cvvStatus) {
        this.cvvStatus = cvvStatus;
    }

    public Integer getConsumerId() {
        return consumerId;
    }

    public void setConsumerId(Integer consumerId) {
        this.consumerId = consumerId;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getClaveUnica() {
        return claveUnica;
    }

    public void setClaveUnica(String claveUnica) {
        this.claveUnica = claveUnica;
    }

    public String getTipoTarjeta() {
        return tipoTarjeta;
    }

    public void setTipoTarjeta(String tipoTarjeta) {
        this.tipoTarjeta = tipoTarjeta;
    }

    public TarjetaVal getCard() {
        return card;
    }

    public void setCard(TarjetaVal card) {
        this.card = card;
    }

    public ClienteRes getDatosCliente() {
        return datosCliente;
    }

    public void setDatosCliente(ClienteRes datosCliente) {
        this.datosCliente = datosCliente;
    }
}

