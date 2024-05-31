package com.bolivariano.microservice.pagoproveedorcnb.utils;

import java.util.Map;

public class LogTiempo {
	private String proceso;
	private String objeto;
	private int tiempo;
	private String fecha;
	private Map<String, Object> params;
	private String error;

	public LogTiempo() {

	}

	public LogTiempo(String proceso, String objeto, int tiempo, Map<String, Object> params) {

	}

	public LogTiempo(String proceso, String objeto, int tiempo, Map<String, Object> params, String error) {

	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public static LogTiempo createIntance() {

		return new LogTiempo();
	}

	public String getProceso() {
		return proceso;
	}

	public void setProceso(String proceso) {
		this.proceso = proceso;
	}

	public String getObjeto() {
		return objeto;
	}

	public void setObjeto(String objeto) {
		this.objeto = objeto;
	}

	public int getTiempo() {
		return tiempo;
	}

	public void setTiempo(int tiempo) {
		this.tiempo = tiempo;
	}

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	@Override
	public String toString() {
		StringBuilder paramString = new StringBuilder();
		
		if (params != null) {
			paramString.append("{");

			for (Map.Entry<String, Object> entry : params.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				paramString.append(String.format(" \"%s\" : \"%s\" ,", key, value));
				
			}
			paramString.append("}");
		}

		return "LogTiempo{" + "\"proceso\":\"" + proceso + '\"' + ", \"objeto\":\"" + objeto + '\"'
				+ ", \"fechaInicio\":\"" + fecha + '\"' + ", \"tiempo\":" + tiempo + ", \"params\":" + paramString
				+ ", \"error\":\"" + error + '\"' + '}';
	}
}
