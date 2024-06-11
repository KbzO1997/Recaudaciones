package com.bolivariano.microservice.otp.dto;

public class ValidarOTPMensajeRequest {
	private String otp;
	private String identificacionCliente;

	public ValidarOTPMensajeRequest() {
		super();
	}

	public ValidarOTPMensajeRequest(String otp, String identificacionCliente) {
		super();
		this.otp = otp;
		this.identificacionCliente = identificacionCliente;
	}

	public String getOtp() {
		return otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}

	public String getIdentificacionCliente() {
		return identificacionCliente;
	}

	public void setIdentificacionCliente(String identificacionCliente) {
		this.identificacionCliente = identificacionCliente;
	}

}
