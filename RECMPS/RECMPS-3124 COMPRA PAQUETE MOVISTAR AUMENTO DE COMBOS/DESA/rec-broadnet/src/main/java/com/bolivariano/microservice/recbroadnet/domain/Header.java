package com.bolivariano.microservice.recbroadnet.domain;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Header {

    protected String id;
    protected String refCompany;
    protected String refService;
    protected String keyValue;
    protected String channels;
    protected String refMsgLabel;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRefCompany() {
        return refCompany;
    }

    public void setRefCompany(String refCompany) {
        this.refCompany = refCompany;
    }

    public String getRefService() {
        return refService;
    }

    public void setRefService(String refService) {
        this.refService = refService;
    }

    public String getRefMsgLabel() {
        return refMsgLabel;
    }

    public void setRefMsgLabel(String refMsgLabel) {
        this.refMsgLabel = refMsgLabel;
    }

    public String getKeyValue() {
        return keyValue;
    }

    public void setKeyValue(String keyValue) {
        this.keyValue = keyValue;
    }

    public String getChannels() {
        return channels;
    }

    public void setChannels(String channels) {
        this.channels = channels;
    }


}
