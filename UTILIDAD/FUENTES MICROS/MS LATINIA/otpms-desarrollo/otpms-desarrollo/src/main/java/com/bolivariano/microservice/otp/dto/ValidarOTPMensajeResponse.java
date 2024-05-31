package com.bolivariano.microservice.otp.dto;

import java.io.Serializable;

public class ValidarOTPMensajeResponse implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4403995852021790353L;
	
	private Integer codigoRespuesta;
	private String mensaje;
	private String mensajeSistema;

	public Integer getCodigoRespuesta() {
		return codigoRespuesta;
	}

	public void setCodigoRespuesta(Integer codigoRespuesta) {
		this.codigoRespuesta = codigoRespuesta;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public ValidarOTPMensajeResponse(Integer codigoRespuesta, String mensaje) {
		super();
		this.codigoRespuesta = codigoRespuesta;
		this.mensaje = mensaje;
	}

	public ValidarOTPMensajeResponse() {
		super();
	}

	public String getMensajeSistema() {
		return mensajeSistema;
	}

	public void setMensajeSistema(String mensajeSistema) {
		this.mensajeSistema = mensajeSistema;
	}
}
