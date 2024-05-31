package com.bolivariano.microservice.pagoproveedorcnb.bean;

import com.bolivariano.microservice.pagoproveedorcnb.utils.MapAdapter;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.io.Serializable;
import java.util.Date;
import java.util.Map;

//@Data
@XmlRootElement(name = "MessageResponse")
@XmlType(propOrder = {"result", "executionDate", "correlationId"})
@XmlAccessorType(XmlAccessType.FIELD)
public class MessageResponse implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
     *
     */
	@XmlJavaTypeAdapter(MapAdapter.class)
    private Map<String, Object> result;
    @XmlElement(name = "executionDate")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date executionDate;
    @XmlElement(name = "correlationId")
    private String correlationId;
    @XmlTransient
    private String codeSPError;
    @XmlTransient
    private String messageSPError;

    public Map<String, Object> getResult() {
        return result;
    }

    public void setResult(Map<String, Object> result) {
        this.result = result;
    }

    public Date getExecutionDate() {
        return executionDate;
    }

    public void setExecutionDate(Date executionDate) {
        this.executionDate = executionDate;
    }

    public String getCorrelationId() {
        return correlationId;
    }

    public void setCorrelationId(String correlationId) {
        this.correlationId = correlationId;
    }

    public String getCodeSPError() {
        return codeSPError;
    }

    public void setCodeSPError(String codeSPError) {
        this.codeSPError = codeSPError;
    }

    public String getMessageSPError() {
        return messageSPError;
    }

    public void setMessageSPError(String messageSPError) {
        this.messageSPError = messageSPError;
    }
}
