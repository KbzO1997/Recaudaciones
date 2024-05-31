package com.bolivariano.microservice.trcmverifycard.dto;

public class TarjetaVal {
    private Boolean lostOrStolen;
    private Boolean expired;
    private Boolean invalid;
    private Boolean fraudSuspect;

    public Boolean getLostOrStolen() {
        return lostOrStolen;
    }

    public void setLostOrStolen(Boolean lostOrStolen) {
        this.lostOrStolen = lostOrStolen;
    }

    public Boolean getExpired() {
        return expired;
    }

    public void setExpired(Boolean expired) {
        this.expired = expired;
    }

    public Boolean getInvalid() {
        return invalid;
    }

    public void setInvalid(Boolean invalid) {
        this.invalid = invalid;
    }

    public Boolean getFraudSuspect() {
        return fraudSuspect;
    }

    public void setFraudSuspect(Boolean fraudeSuspect) {
        this.fraudSuspect = fraudeSuspect;
    }
}
