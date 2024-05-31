package com.bolivariano.microservice.trcmverifycard.utils;

import java.util.Map;

public class LogTiempo {
    private String proceso;
    private int tiempo;
    private String fecha;
    private Map<String, Object> params;
    private String error;

    public LogTiempo() {

    }

    public LogTiempo(String proceso, int tiempo, Map<String, Object> params) {
        //Lógica de LogTiempo (comentario por sonar)
    }

    public LogTiempo(String proceso, int tiempo, Map<String, Object> params, String error) {
        //Lógica de LogTiempo (comentario por sonar)
    }

    public static LogTiempo createIntance() {

        return new LogTiempo();
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getProceso() {
        return proceso;
    }

    public void setProceso(String proceso) {
        this.proceso = proceso;
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
        var paramString = new StringBuilder();

        if (params != null) {
            paramString.append("{");

            for (Map.Entry<String, Object> entry : params.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                paramString.append(String.format(" \"%s\" : \"%s\" ,", key, value));

            }
            paramString.append("}");
        }

        return "LogTiempo {" + "\"proceso\":\"" + proceso + '\"'
                + ", \"fechaInicio\":\"" + fecha + '\"' + ", \"tiempo\":" + tiempo + ", \"params\":" + paramString
                + '}';
    }

}