package com.bolivariano.microservice.otp.dto;

public class MediosEnvio {

	private String celular;
	private String correo;

	public MediosEnvio() {

	}

	public MediosEnvio(String celular, String correo) {
		super();
		this.celular = celular;
		this.correo = correo;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

}
