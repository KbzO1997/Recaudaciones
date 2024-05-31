package com.bolivariano.microservice.tcrtconsultamediospan.dto;

public class ClienteResponseData {
    private Integer status;
    private String message;
    private Cliente data;


    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Cliente getData() {
        return data;
    }

    public void setData(Cliente data) {
        this.data = data;
    }
}
