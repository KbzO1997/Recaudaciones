package com.bolivariano.microservice.otp.dto;

import java.util.List;

public class GenerarOTPMensajeRequest {
	private String medioNotificacion;
	private String identificacionCliente;
	private String producto;
	private String celular;
	private String correo;
	private String servicio;
	private List<ParametrosNotificacion> adicionalesNotificacion;
	
	
	public GenerarOTPMensajeRequest() {

	}

	public GenerarOTPMensajeRequest(String medioNotificacion, String identificacionCliente) {
		super();
		this.medioNotificacion = medioNotificacion;
		this.identificacionCliente = identificacionCliente;
	}
	
	public GenerarOTPMensajeRequest(String medioNotificacion, String identificacionCliente, String producto) {
		super();
		this.medioNotificacion = medioNotificacion;
		this.identificacionCliente = identificacionCliente;
		this.producto = producto;
	}
	

	public String getMedioNotificacion() {
		return medioNotificacion;
	}

	public void setMedioNotificacion(String medioNotificacion) {
		this.medioNotificacion = medioNotificacion;
	}

	public String getIdentificacionCliente() {
		return identificacionCliente;
	}

	public void setIdentificacionCliente(String identificacionCliente) {
		this.identificacionCliente = identificacionCliente;
	}

	public String getProducto() {
		return producto;
	}

	public void setProducto(String producto) {
		this.producto = producto;
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

	public String getServicio() {
		return servicio;
	}

	public void setServicio(String servicio) {
		this.servicio = servicio;
	}

	public List<ParametrosNotificacion> getAdicionalesNotificacion() {
		return adicionalesNotificacion;
	}

	public void setAdicionalesNotificacion(List<ParametrosNotificacion> adicionalesNotificacion) {
		this.adicionalesNotificacion = adicionalesNotificacion;
	}
}
