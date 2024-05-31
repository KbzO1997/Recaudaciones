package com.bolivariano.microservice.pagoproveedorcnb.model;



import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class SybaseScript implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 3636164459057895503L;
    private String id;
    private String version;
    private String transaction;
    private String script;
    private Map<String, List<StoredProcedure.Parameter>> parameters;
    private int cantidadParametrosIn;
    private int cantidadParametrosOut;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getTransaction() {
        return transaction;
    }

    public void setTransaction(String transaction) {
        this.transaction = transaction;
    }

    public String getScript() {
        return script;
    }

    public void setScript(String script) {
        this.script = script;
    }

    public Map<String, List<StoredProcedure.Parameter>> getParameters() {
        return parameters;
    }

    public void setParameters(Map<String, List<StoredProcedure.Parameter>> parameters) {
        this.parameters = parameters;
    }

    public int getCantidadParametrosIn() {
        return cantidadParametrosIn;
    }

    public void setCantidadParametrosIn(int cantidadParametrosIn) {
        this.cantidadParametrosIn = cantidadParametrosIn;
    }

    public int getCantidadParametrosOut() {
        return cantidadParametrosOut;
    }

    public void setCantidadParametrosOut(int cantidadParametrosOut) {
        this.cantidadParametrosOut = cantidadParametrosOut;
    }

	@Override
	public String toString() {
		return "SybaseScript [id=" + id + ", version=" + version + ", transaction=" + transaction + ", script=" + script
				+ ", parameters=" + parameters + ", cantidadParametrosIn=" + cantidadParametrosIn
				+ ", cantidadParametrosOut=" + cantidadParametrosOut + "]";
	}
    
    
}
