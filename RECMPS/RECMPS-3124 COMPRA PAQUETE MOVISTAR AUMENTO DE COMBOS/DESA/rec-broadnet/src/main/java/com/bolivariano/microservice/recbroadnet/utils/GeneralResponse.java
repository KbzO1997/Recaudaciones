package com.bolivariano.microservice.recbroadnet.utils;

import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeSalidaConsultarDeuda;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeSalidaEjecutarPago;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeSalidaProcesar;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GeneralResponse {

	public MensajeSalidaProcesar generateResponse(MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago) {
		MensajeSalidaProcesar mensajeSalidaProcesar = new MensajeSalidaProcesar();
		mensajeSalidaProcesar.setCodigo("0");
		mensajeSalidaProcesar.setEstado("OK");
		mensajeSalidaProcesar.setMensajeUsuario("PROCESO EJECUTADO");
		mensajeSalidaProcesar.setMensajeSalidaEjecutarPago(mensajeSalidaEjecutarPago);
		return mensajeSalidaProcesar;
	}	

	public MensajeSalidaProcesar generateResponse(MensajeSalidaConsultarDeuda mensajeSalidaConsultarDeuda) {
		MensajeSalidaProcesar mensajeSalidaProcesar = new MensajeSalidaProcesar();
		mensajeSalidaProcesar.setCodigo("0");
		mensajeSalidaProcesar.setEstado("OK");
		mensajeSalidaProcesar.setMensajeUsuario("CONSULTA EJECUTADO");
		mensajeSalidaProcesar.setMensajeSalidaConsultarDeuda(mensajeSalidaConsultarDeuda);
		return mensajeSalidaProcesar;
	}
	
	public MensajeSalidaProcesar generateResponseError(String codigo, String message) {
		MensajeSalidaProcesar mensajeSalidaProcesar = new MensajeSalidaProcesar();
		mensajeSalidaProcesar.setCodigo(codigo != null?codigo:"300");
		mensajeSalidaProcesar.setEstado("ERROR");
		mensajeSalidaProcesar.setMensajeUsuario(message);		
		return mensajeSalidaProcesar;
	}

}
