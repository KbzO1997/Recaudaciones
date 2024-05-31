package com.bolivariano.microservice.pagoproveedorcnb.bean;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import javax.xml.bind.annotation.*;

@XmlRootElement(name = "MicrosreResponse")
@XmlType(propOrder = {"code", "message","status" ,"data"})
@XmlAccessorType(XmlAccessType.FIELD)
//@Data
@JsonInclude(Include.NON_NULL)
public class MicroSreResponse {
    @XmlElement(name = "code")
    private String code;
    @XmlElement(name = "message")
    private String message;
    @XmlElement(name = "status")
    private String status;
    @XmlElements({
            @XmlElement(name = "data", type = MessageResponse.class)
    })
    private Object data;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}