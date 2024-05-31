package com.bolivariano.microservice.pagoproveedorcnb.bean;


import java.util.Map;

public class CollectorRequest {

	private String opcion;
    private Map<String, String> datos;

    public String getOpcion() {
        return opcion;
    }

    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }

    public Map<String, String> getDatos() {
        return datos;
    }

    public void setDatos(Map<String, String> datos) {
        this.datos = datos;
    }
}
