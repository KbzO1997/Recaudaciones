package com.bolivariano.microservice.recbroadnet.domain;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Info {

    protected String loginEnterprise;
    protected String refContract;

    public String getLoginEnterprise() {
        return loginEnterprise;
    }

    public void setLoginEnterprise(String loginEnterprise) {
        this.loginEnterprise = loginEnterprise;
    }

    public String getRefContract() {
        return refContract;
    }

    public void setRefContract(String refContract) {
        this.refContract = refContract;
    }
}
