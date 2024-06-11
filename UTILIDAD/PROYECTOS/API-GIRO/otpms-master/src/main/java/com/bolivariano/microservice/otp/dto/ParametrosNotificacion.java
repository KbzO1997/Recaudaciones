package com.bolivariano.microservice.otp.dto;

public class ParametrosNotificacion {

	private String clave;
	private String valor;
	
	
	public ParametrosNotificacion() {
		/*Validacion por sonarq*/
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}
}
