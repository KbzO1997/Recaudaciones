package com.bolivariano.microservice.trcmverifycard.dto.credimatic;

public class CredimaticRes {
    private String codigo;
    private Boolean fallido;
    private String descripcion;
    private Object detalle;
    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Boolean getFallido() {
        return fallido;
    }

    public void setFallido(Boolean fallido) {
        this.fallido = fallido;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Object getDetalle() {
        return detalle;
    }

    public void setDetalle(Object detalle) {
        this.detalle = detalle;
    }
}

