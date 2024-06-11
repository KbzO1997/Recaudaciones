package com.bolivariano.microservice.otp.exception;

import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeResponse;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeResponse;

public class OTPException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = -6991076445787084951L;
	private final Integer codigoError;
	private final String mensajeSistema;

	public OTPException(Exception e) {
		super(e);
		this.codigoError = 404;
		this.mensajeSistema = "";
		
	}
	
	public OTPException(String message) {
		super(message);
		this.codigoError = 404;
		this.mensajeSistema = "";
	}
	
	public OTPException(String message, Integer codigo, String mensajeSistema) {
		super(message);
		this.codigoError = codigo;
		this.mensajeSistema = mensajeSistema;
	}
	
	public OTPException(String message, Exception e) {
		super(message,e);
		this.codigoError = 404;
		this.mensajeSistema = message;
	}

	public static ValidarOTPMensajeResponse mensajeValidarOTP(Integer codigo, String mensaje, String mensajeSistema) {
		ValidarOTPMensajeResponse validarOTPMensajeResponse = new ValidarOTPMensajeResponse();
		validarOTPMensajeResponse.setCodigoRespuesta(codigo);
		validarOTPMensajeResponse.setMensaje(mensaje);
		validarOTPMensajeResponse.setMensajeSistema(mensajeSistema);
		return validarOTPMensajeResponse;
	}
	
	public static GenerarOTPMensajeResponse mensajeGenerarOTP(Integer codigo, String mensaje, String otp) {
		GenerarOTPMensajeResponse generarOTPMensajeResponse = new GenerarOTPMensajeResponse();
		generarOTPMensajeResponse.setCodigoRespuesta(codigo);
		generarOTPMensajeResponse.setOtp(otp);
		generarOTPMensajeResponse.setMensaje(mensaje);
		return generarOTPMensajeResponse;
	}

	public Integer getCodigoError() {
		return codigoError;
	}
	
	public String getMensajeSistema() {
		return mensajeSistema;
	}
}
