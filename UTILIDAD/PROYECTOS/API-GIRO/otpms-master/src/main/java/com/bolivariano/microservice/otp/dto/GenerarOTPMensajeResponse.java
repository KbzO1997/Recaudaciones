package com.bolivariano.microservice.otp.dto;

import java.io.Serializable;

public class GenerarOTPMensajeResponse implements Serializable {
	private static final long serialVersionUID = 1767828492984023845L;

	private Integer codigoRespuesta;
	private String mensaje;
	private String otp;
	
	public GenerarOTPMensajeResponse(Integer codigoRespuesta, String mensaje, String otp) {
		super();
		this.codigoRespuesta = codigoRespuesta;
		this.mensaje = mensaje;
		this.otp = otp;
	}

	public GenerarOTPMensajeResponse() {
		super();
	}

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

	public String getOtp() {
		return otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}

}
