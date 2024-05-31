package com.bolivariano.microservice.tcrtconsultamediospan.dto;

import java.util.Objects;

import com.bolivariano.microservice.tcrtconsultamediospan.util.enums.DictionaryResponses;
import com.bolivariano.microservice.tcrtconsultamediospan.util.exceptions.CustomException;
import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;


@JsonInclude(Include.NON_NULL)
public class MensajeSalida {

    @JsonProperty("codigoError")
    private int codigoError;

    @JsonProperty("estado")
    private String estado;

    @JsonProperty("mensajeSistema")
    private String mensajeSistema;

    @JsonProperty("mensajeUsuario")
    private String mensajeUsuario;

    @JsonIgnore
    private HttpStatus salida;

    public void exceptionMessage(DictionaryResponses dictionary) {
        this.setCodigoError(dictionary.getCode());
        this.setMensajeUsuario(dictionary.getMessage());
        this.setMensajeSistema(dictionary.getMessage());
    }
    public void exceptionMessage(CustomException e) {
        this.setCodigoError(e.getCodigoError());
        this.setMensajeUsuario(e.getMensajeUsuario());
        this.setMensajeSistema(e.getMensajeSistema());
    }
    public void setMessage(int code, String user, String system) {
        this.setCodigoError(code);
        this.setMensajeUsuario(user);
        this.setMensajeSistema(system);
    }

    public HttpStatus getSalida() {
        return salida;
    }

    public void setSalida(HttpStatus salida) {
        this.salida = salida;
    }

    public MensajeSalida codigoError(int codigoError) {
        this.codigoError = codigoError;
        return this;
    }

    /**
     * Get codigoError
     * @return codigoError
     */

    //@Schema(name = "codigoError", required = false)
    public int getCodigoError() {
        return codigoError;
    }

    public void setCodigoError(int codigoError) {
        this.codigoError = codigoError;
    }


    public MensajeSalida estado(String estado) {
        this.estado = estado;
        return this;
    }

    /**
     * Get estado
     * @return estado
     */

    //@Schema(name = "estado", required = false)
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public MensajeSalida mensajeSistema(String mensajeSistema) {
        this.mensajeSistema = mensajeSistema;
        return this;
    }

    /**
     * Get mensajeSistema
     * @return mensajeSistema
     */

    //@Schema(name = "mensajeSistema", required = false)
    public String getMensajeSistema() {
        return mensajeSistema;
    }

    public void setMensajeSistema(String mensajeSistema) {
        this.mensajeSistema = mensajeSistema;
    }

    public MensajeSalida mensajeUsuario(String mensajeUsuario) {
        this.mensajeUsuario = mensajeUsuario;
        return this;
    }

    /**
     * Get mensajeUsuario
     * @return mensajeUsuario
     */

    //@Schema(name = "mensajeUsuario", required = false)
    public String getMensajeUsuario() {
        return mensajeUsuario;
    }

    public void setMensajeUsuario(String mensajeUsuario) {
        this.mensajeUsuario = mensajeUsuario;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        MensajeSalida mensajeSalida = (MensajeSalida) o;
        return Objects.equals(this.codigoError, mensajeSalida.codigoError) &&
                Objects.equals(this.estado, mensajeSalida.estado) &&
                Objects.equals(this.mensajeSistema, mensajeSalida.mensajeSistema) &&
                Objects.equals(this.mensajeUsuario, mensajeSalida.mensajeUsuario) ;

    }

    @Override
    public int hashCode() {
        return Objects.hash(codigoError, estado, mensajeSistema, mensajeUsuario);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class MensajeSalida {\n");
        sb.append("    codigoError: ").append(toIndentedString(codigoError)).append("\n");
        sb.append("    estado: ").append(toIndentedString(estado)).append("\n");
        sb.append("    mensajeSistema: ").append(toIndentedString(mensajeSistema)).append("\n");
        sb.append("    mensajeUsuario: ").append(toIndentedString(mensajeUsuario)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
     * Convert the given object to string with each line indented by 4 spaces
     * (except the first line).
     */
    private String toIndentedString(Object o) {
        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n    ");
    }
}


