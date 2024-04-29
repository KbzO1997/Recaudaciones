package com.bolivariano.microservice.recbroadnet.domain;

import java.io.Serializable;

public class MessageProcess implements Serializable {

    
	private static final long serialVersionUID = 1L;

	private String message;

    private String correlationId;

    public MessageProcess(String message) {
        this.message = message;
    }

    public MessageProcess(String message, String correlationId) {
        this.message = message;
        this.correlationId = correlationId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String messageM) {
        this.message = messageM;
    }

    public String getCorrelationId() {
        return correlationId;
    }

    public void setCorrelationId(String correlationIdM) {
        this.correlationId = correlationIdM;
    }
}
