package com.bolivariano.microservice.pagoproveedorcnb.domain;

import java.io.Serializable;

public class InParameter implements Serializable {

    private String name;
    private Object data;

    public InParameter(String name, Object data) {
        this.name = name;
        this.data = data;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getName() {
        return name;
    }

    public Object getData() {
        return data;
    }
}
